import 'dart:io';
import 'dart:ui' as ui;

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:gramnota/core/app_language_controller.dart';
import 'package:gramnota/core/providers.dart';
import 'package:gramnota/core/shell.dart';
import 'package:gramnota/core/theme.dart';
import 'package:gramnota/core/user_store.dart';
import 'package:gramnota/features/auth/presentation/choose_language_screen.dart';
import 'package:gramnota/features/customers/domain/customer.dart';
import 'package:gramnota/features/filaments/domain/filament_spool.dart';
import 'package:gramnota/features/filaments/presentation/filaments_screen.dart';
import 'package:gramnota/features/orders/domain/print_order.dart';
import 'package:gramnota/features/orders/presentation/dashboard_screen.dart';
import 'package:gramnota/features/orders/presentation/orders_screen.dart';
import 'package:gramnota/features/orders/presentation/quote_pdf.dart';
import 'package:gramnota/features/pricing/domain/price_breakdown.dart';
import 'package:gramnota/features/pricing/domain/price_calculator.dart';
import 'package:gramnota/features/pricing/presentation/calculator_screen.dart';
import 'package:gramnota/features/printers/domain/printer_profile.dart';
import 'package:gramnota/features/settings/domain/workshop_settings.dart';
import 'package:gramnota/l10n/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Opt-in harness, same gate as [onboarding_screenshots_test.dart].
/// `flutter test` skips it.
/// `GRAMNOTA_SCREENSHOTS=1 flutter test test/readme_screenshots_test.dart`
/// writes the README gallery to docs/screenshots/.
void main() {
  final enabled = Platform.environment['GRAMNOTA_SCREENSHOTS'] == '1';
  if (enabled) {
    LiveTestWidgetsFlutterBinding.ensureInitialized();
  }

  testWidgets(
    'readme screenshots',
    (tester) async {
      SharedPreferences.setMockInitialValues({});
      await _loadShotFonts();
      addTearDown(() => tester.binding.setSurfaceSize(null));
      addTearDown(tester.view.resetPhysicalSize);
      addTearDown(tester.view.resetDevicePixelRatio);

      final store = await _seedWorkshop();
      const phone = Size(390, 844);

      await _pumpShell(tester, store: store, size: phone, location: '/home');
      expect(find.byType(NavigationBar), findsOneWidget);
      expect(find.text('October 2026'), findsOneWidget);
      await _save(tester, 'dashboard');

      final router = _routers.last;
      router.go('/orders');
      await _settle(tester);
      expect(find.text('Overdue'), findsWidgets);
      await _save(tester, 'orders');

      router.go('/filaments');
      await _settle(tester);
      expect(find.text('Low'), findsOneWidget);
      await _save(tester, 'filament');

      router.go('/calculator');
      await _settle(tester);
      await _fillCalculator(tester);
      await _save(tester, 'calculator');

      await _pumpShell(
        tester,
        store: store,
        size: phone,
        dark: true,
        location: '/home',
      );
      expect(find.text('October 2026'), findsOneWidget);
      await _save(tester, 'dark');

      await _pumpPlain(
        tester,
        size: const Size(390, 1080),
        child: const ChooseLanguageScreen(),
      );
      expect(find.text('English'), findsOneWidget);
      await _save(tester, 'language');

      final pdf = await tester.runAsync(
        () => buildQuotePdf(
          order: _pdfOrder(),
          settings: _settings,
          customer: _north,
        ),
      );
      final pdfFile = File('docs/screenshots/quote-pdf.pdf');
      await pdfFile.parent.create(recursive: true);
      await pdfFile.writeAsBytes(pdf!, flush: true);
    },
    skip: !enabled,
    timeout: const Timeout(Duration(minutes: 3)),
  );
}

const _settings = WorkshopSettings(
  setupCompleted: true,
  languageCode: 'en',
  currencyCode: 'EUR',
  themeMode: 'light',
  electricityMinorPerKwh: 32,
  laborMinorPerHour: 1800,
  defaultMarkupBasisPoints: 4000,
  vatBasisPoints: 2500,
  defaultFailureBasisPoints: 1000,
  businessName: 'Harbor Prints',
  street: '12 Quay Lane',
  postalCode: '1040',
  city: 'Vienna',
  phone: '+43 1 555 0142',
  email: 'hello@harborprints.example',
  quoteValidityDays: 14,
  defaultLowStockGrams: 100,
);

const _north = Customer(
  id: 'north',
  name: 'North Studio',
  street: '8 Lindenstrasse',
  postalCode: '1010',
  city: 'Vienna',
  country: 'Austria',
  email: 'studio@north.example',
);

const _lumen = Customer(
  id: 'lumen',
  name: 'Lumen Co.',
  city: 'Graz',
  email: 'hello@lumen.example',
);

const _field = Customer(id: 'field', name: 'Field & Co.', city: 'Linz');

Future<UserStore> _seedWorkshop() async {
  final firestore = FakeFirebaseFirestore();
  final store = UserStore(firestore, 'seller');
  await store.saveSettings(_settings);
  await store.savePrinter(
    const PrinterProfile(
      id: 'p1s',
      name: 'Bambu Lab P1S',
      powerWatts: 105,
      purchasePriceMinor: 54900,
      lifetimeHours: 5000,
    ),
  );
  await store.saveFilament(
    const FilamentSpool(
      id: 'pla',
      brand: 'Bambu Lab',
      material: 'PLA Basic',
      colorHex: '#1A1A1A',
      remainingGrams: 820,
      pricePerSpoolMinor: 1990,
      lowStockGrams: 100,
    ),
  );
  await store.saveFilament(
    const FilamentSpool(
      id: 'petg',
      brand: 'Bambu Lab',
      material: 'PETG HF',
      colorHex: '#E4572E',
      remainingGrams: 86,
      pricePerSpoolMinor: 2290,
      lowStockGrams: 100,
    ),
  );
  await store.saveFilament(
    const FilamentSpool(
      id: 'silk',
      brand: 'Polymaker',
      material: 'PLA Silk',
      colorHex: '#C6A15B',
      remainingGrams: 640,
      pricePerSpoolMinor: 2490,
      lowStockGrams: 100,
    ),
  );
  await store.saveCustomer(_north);
  await store.saveCustomer(_lumen);
  await store.saveCustomer(_field);

  final clips = _price(grams: 18, seconds: 45 * 60, quantity: 4);
  final bin = _price(grams: 96, seconds: 3 * 3600 + 10 * 60);
  final lamp = _price(grams: 140, seconds: 7 * 3600);
  final stand = _price(grams: 22, seconds: 70 * 60);
  final keys = _price(grams: 9, seconds: 35 * 60, quantity: 3);

  await store.saveOrder(
    _order(
      id: 'clips',
      number: 38,
      title: 'Cable clips, set of 4',
      status: OrderStatus.paid,
      customerId: 'north',
      breakdown: clips,
      seconds: 45 * 60,
      grams: 18,
      quantity: 4,
      revenueAt: '2026-10-08T15:00:00.000Z',
      updatedAt: '2026-10-08T15:00:00.000Z',
    ),
  );
  await store.saveOrder(
    _order(
      id: 'bin',
      number: 39,
      title: 'Desk bin',
      status: OrderStatus.printed,
      customerId: 'lumen',
      breakdown: bin,
      seconds: 3 * 3600 + 10 * 60,
      grams: 96,
      revenueAt: '2026-10-14T11:00:00.000Z',
      depositMinor: 1000,
      depositAt: '2026-10-03T10:00:00.000Z',
      updatedAt: '2026-10-14T11:00:00.000Z',
    ),
  );
  await store.saveOrder(
    _order(
      id: 'lamp',
      number: 40,
      title: 'Voronoi lamp',
      status: OrderStatus.accepted,
      customerId: 'field',
      breakdown: lamp,
      seconds: 7 * 3600,
      grams: 140,
      depositMinor: 1500,
      depositAt: '2026-10-16T09:00:00.000Z',
      updatedAt: '2026-10-16T09:00:00.000Z',
    ),
  );
  await store.saveOrder(
    _order(
      id: 'stand',
      number: 36,
      title: 'Phone stand',
      status: OrderStatus.sent,
      customerId: 'north',
      breakdown: stand,
      seconds: 70 * 60,
      grams: 22,
      validUntil: '2026-10-01T12:00:00.000Z',
      updatedAt: '2026-10-02T12:00:00.000Z',
    ),
  );
  await store.saveOrder(
    _order(
      id: 'keys',
      number: 41,
      title: 'Keychains',
      status: OrderStatus.quote,
      customerId: 'lumen',
      breakdown: keys,
      seconds: 35 * 60,
      grams: 9,
      quantity: 3,
      updatedAt: '2026-10-19T16:00:00.000Z',
    ),
  );
  return store;
}

PriceBreakdown _price({
  required double grams,
  required int seconds,
  int quantity = 1,
  int pricePerKgMinor = 1990,
}) {
  return const PriceCalculator().calculate(
    PriceInput(
      materials: [MaterialUse(grams: grams, pricePerKgMinor: pricePerKgMinor)],
      powerWatts: 105,
      printTimeSeconds: seconds,
      electricityMinorPerKwh: _settings.electricityMinorPerKwh,
      purchasePriceMinor: 54900,
      lifetimeHours: 5000,
      maintenanceMinorPerHour: 0,
      failureBasisPoints: _settings.defaultFailureBasisPoints,
      prepMinutes: 15,
      postMinutes: 10,
      laborMinorPerHour: _settings.laborMinorPerHour,
      extraMinors: const [],
      markupBasisPoints: _settings.defaultMarkupBasisPoints,
      vatBasisPoints: _settings.vatBasisPoints,
      quantity: quantity,
    ),
  );
}

PrintOrder _order({
  required String id,
  required int number,
  required String title,
  required OrderStatus status,
  required String customerId,
  required PriceBreakdown breakdown,
  required int seconds,
  required double grams,
  String validUntil = '2026-11-15T12:00:00.000Z',
  String revenueAt = '',
  int depositMinor = 0,
  String depositAt = '',
  int quantity = 1,
  String updatedAt = '2026-10-10T12:00:00.000Z',
}) {
  final holds = status == OrderStatus.printed || status == OrderStatus.paid;
  return PrintOrder(
    id: id,
    quoteNumber: number,
    customerId: customerId,
    title: title,
    status: status,
    validUntil: validUntil,
    quantity: quantity,
    printerId: 'p1s',
    printTimeSeconds: seconds,
    filaments: [
      FilamentUsage(
        filamentId: 'pla',
        grams: grams,
        material: 'PLA Basic',
        colorHex: '#1A1A1A',
      ),
    ],
    prepMinutes: 15,
    postMinutes: 10,
    markupBasisPoints: 4000,
    failureBasisPoints: 1000,
    vatBasisPoints: 2500,
    currencyCode: 'EUR',
    breakdown: breakdown,
    stockDeducted: holds,
    depositMinor: depositMinor,
    depositAt: depositAt,
    revenueAt: revenueAt,
    createdAt: '2026-10-01T09:00:00.000Z',
    updatedAt: updatedAt,
  );
}

PrintOrder _pdfOrder() {
  final bin = _price(grams: 42, seconds: 2 * 3600 + 15 * 60);
  final lid = _price(grams: 18, seconds: 55 * 60);
  final lines = [
    QuoteLine(
      id: 'bin-line',
      title: 'Gridfinity bin 2x2',
      quantity: 1,
      printerId: 'p1s',
      printTimeSeconds: 2 * 3600 + 15 * 60,
      filaments: const [
        FilamentUsage(
          filamentId: 'pla',
          grams: 42,
          material: 'PLA Basic',
          colorHex: '#1A1A1A',
        ),
      ],
      prepMinutes: 15,
      postMinutes: 10,
      markupBasisPoints: 4000,
      failureBasisPoints: 1000,
      vatBasisPoints: 2500,
      breakdown: bin,
      sourceProfileTitle: '0.20 mm standard',
    ),
    QuoteLine(
      id: 'lid-line',
      title: 'Matching lid',
      quantity: 1,
      printerId: 'p1s',
      printTimeSeconds: 55 * 60,
      filaments: const [
        FilamentUsage(
          filamentId: 'pla',
          grams: 18,
          material: 'PLA Basic',
          colorHex: '#1A1A1A',
        ),
      ],
      prepMinutes: 15,
      postMinutes: 10,
      markupBasisPoints: 4000,
      failureBasisPoints: 1000,
      vatBasisPoints: 2500,
      breakdown: lid,
      sourceProfileTitle: '0.20 mm standard',
    ),
  ];
  return PrintOrder(
    id: 'pdf',
    quoteNumber: 42,
    customerId: 'north',
    title: 'Workshop bins',
    status: OrderStatus.sent,
    validUntil: '2026-11-03T12:00:00.000Z',
    quantity: 1,
    printerId: 'p1s',
    printTimeSeconds: 0,
    filaments: const [],
    markupBasisPoints: 4000,
    failureBasisPoints: 1000,
    vatBasisPoints: 2500,
    currencyCode: 'EUR',
    quoteLanguage: 'en',
    breakdown: sumBreakdowns([bin, lid]),
    depositMinor: 1000,
    depositAt: '2026-10-18T12:00:00.000Z',
    lines: lines,
    createdAt: '2026-10-18T12:00:00.000Z',
    updatedAt: '2026-10-18T12:00:00.000Z',
  );
}

final _routers = <GoRouter>[];

GoRouter _shellRouter() {
  final router = GoRouter(
    initialLocation: '/home',
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShell(navigationShell: navigationShell);
        },
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/home',
                builder: (_, _) => const DashboardScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/calculator',
                builder: (_, _) => const CalculatorScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(path: '/orders', builder: (_, _) => const OrdersScreen()),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/customers',
                builder: (_, _) => const Scaffold(body: SizedBox.shrink()),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/filaments',
                builder: (_, _) => const FilamentsScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/more',
                builder: (_, _) => const Scaffold(body: SizedBox.shrink()),
              ),
            ],
          ),
        ],
      ),
    ],
  );
  _routers.add(router);
  return router;
}

class _ShotLanguage extends AppLanguageController {
  @override
  Future<String> build() async => 'en';
}

ThemeData _shotTheme({required bool dark}) {
  final base = buildGramnotaTheme(
    brightness: dark ? Brightness.dark : Brightness.light,
  );
  const fallback = ['NotoColorEmoji'];
  TextStyle withFont(TextStyle? style) {
    return (style ?? const TextStyle()).copyWith(
      fontFamily: 'NotoSans',
      fontFamilyFallback: fallback,
    );
  }

  return base.copyWith(
    textTheme: base.textTheme.apply(
      fontFamily: 'NotoSans',
      fontFamilyFallback: fallback,
    ),
    primaryTextTheme: base.primaryTextTheme.apply(
      fontFamily: 'NotoSans',
      fontFamilyFallback: fallback,
    ),
    chipTheme: base.chipTheme.copyWith(
      labelStyle: withFont(base.chipTheme.labelStyle),
    ),
    navigationBarTheme: base.navigationBarTheme.copyWith(
      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        return withFont(
          base.navigationBarTheme.labelTextStyle?.resolve(states),
        );
      }),
    ),
    navigationRailTheme: base.navigationRailTheme.copyWith(
      selectedLabelTextStyle: withFont(
        base.navigationRailTheme.selectedLabelTextStyle,
      ),
      unselectedLabelTextStyle: withFont(
        base.navigationRailTheme.unselectedLabelTextStyle,
      ),
    ),
  );
}

Future<void> _useSurface(WidgetTester tester, Size size) async {
  const pixelRatio = 2.0;
  tester.view.devicePixelRatio = pixelRatio;
  tester.view.physicalSize = Size(
    size.width * pixelRatio,
    size.height * pixelRatio,
  );
  await tester.binding.setSurfaceSize(size);
}

Widget _shotFrame(Widget? child) {
  return DefaultTextStyle(
    style: const TextStyle(
      fontFamily: 'NotoSans',
      fontFamilyFallback: ['NotoColorEmoji'],
      fontSize: 14,
      color: Color(0xFF1A1F1C),
    ),
    child: RepaintBoundary(
      key: const Key('shot'),
      child: child ?? const SizedBox.shrink(),
    ),
  );
}

Future<void> _pumpShell(
  WidgetTester tester, {
  required UserStore store,
  required Size size,
  bool dark = false,
  required String location,
}) async {
  final router = _shellRouter();
  await _useSurface(tester, size);
  await tester.pumpWidget(
    ProviderScope(
      key: UniqueKey(),
      overrides: [
        appLanguageProvider.overrideWith(_ShotLanguage.new),
        userStoreProvider.overrideWithValue(store),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        locale: const Locale('en'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        theme: _shotTheme(dark: false),
        darkTheme: _shotTheme(dark: true),
        themeMode: dark ? ThemeMode.dark : ThemeMode.light,
        routerConfig: router,
        builder: (context, child) => _shotFrame(child),
      ),
    ),
  );
  await _settle(tester);
  if (location != '/home') {
    router.go(location);
    await _settle(tester);
  }
}

Future<void> _pumpPlain(
  WidgetTester tester, {
  required Size size,
  required Widget child,
  bool dark = false,
}) async {
  await _useSurface(tester, size);
  await tester.pumpWidget(
    ProviderScope(
      key: UniqueKey(),
      overrides: [appLanguageProvider.overrideWith(_ShotLanguage.new)],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        locale: const Locale('en'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        theme: _shotTheme(dark: false),
        darkTheme: _shotTheme(dark: true),
        themeMode: dark ? ThemeMode.dark : ThemeMode.light,
        home: _shotFrame(child),
      ),
    ),
  );
  await _settle(tester);
}

Future<void> _settle(WidgetTester tester) async {
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 100));
  try {
    await tester.pumpAndSettle(
      const Duration(milliseconds: 50),
      EnginePhase.sendSemanticsUpdate,
      const Duration(seconds: 8),
    );
  } on FlutterError {
    await tester.pump(const Duration(milliseconds: 300));
  }
}

Future<void> _fillCalculator(WidgetTester tester) async {
  final fields = find.byType(TextField);
  await tester.enterText(fields.at(1), 'Gridfinity bin');
  await tester.pump();
  await tester.tap(find.text('Tap to choose before saving'));
  await _settle(tester);
  await tester.tap(find.text('North Studio').last);
  await _settle(tester);
  await tester.tap(find.byType(DropdownButtonFormField<String>).at(1));
  await _settle(tester);
  await tester.tap(find.text('Bambu Lab PLA Basic').last);
  await _settle(tester);
  await tester.enterText(find.byType(TextField).at(2), '48');
  await tester.enterText(find.byType(TextField).at(3), '2');
  await tester.enterText(find.byType(TextField).at(4), '15');
  await tester.enterText(find.byType(TextField).at(7), '2');
  await _settle(tester);
  final list = find.descendant(
    of: find.byType(CalculatorScreen),
    matching: find.byType(ListView),
  );
  final markup = find.text('Markup %');
  for (var i = 0; i < 14 && markup.evaluate().isEmpty; i++) {
    await tester.drag(list, const Offset(0, -320));
    await tester.pump(const Duration(milliseconds: 50));
  }
  expect(markup, findsOneWidget);
  final dy = tester.getTopLeft(markup).dy;
  if ((dy - 72).abs() > 8) {
    await tester.drag(list, Offset(0, 72 - dy));
    await tester.pump(const Duration(milliseconds: 50));
  }
  FocusManager.instance.primaryFocus?.unfocus();
  await tester.pump(const Duration(milliseconds: 50));
}

Future<void> _loadShotFonts() async {
  Future<ByteData> fileFont(String path) async {
    final bytes = await File(path).readAsBytes();
    return ByteData.view(Uint8List.fromList(bytes).buffer);
  }

  final sans = FontLoader('NotoSans')
    ..addFont(rootBundle.load('assets/fonts/NotoSans-Regular.ttf'))
    ..addFont(rootBundle.load('assets/fonts/NotoSans-Bold.ttf'));
  final emoji = FontLoader('NotoColorEmoji')
    ..addFont(fileFont('/usr/share/fonts/truetype/noto/NotoColorEmoji.ttf'));
  final home = Platform.environment['HOME'] ?? '';
  final icons = FontLoader('MaterialIcons')
    ..addFont(
      fileFont(
        '$home/sdk/flutter/bin/cache/artifacts/material_fonts/MaterialIcons-Regular.otf',
      ),
    );
  await Future.wait([sans.load(), emoji.load(), icons.load()]);
}

Future<void> _save(WidgetTester tester, String name) async {
  final boundary =
      tester.renderObject(find.byKey(const Key('shot')))
          as RenderRepaintBoundary;
  expect(boundary.debugNeedsPaint, isFalse);
  final layer = boundary.debugLayer! as OffsetLayer;
  final image = layer.toImageSync(boundary.paintBounds, pixelRatio: 2);
  final bytes = await tester.runAsync(
    () => image.toByteData(format: ui.ImageByteFormat.png),
  );
  final file = File('docs/screenshots/$name.png');
  await file.parent.create(recursive: true);
  await file.writeAsBytes(bytes!.buffer.asUint8List(), flush: true);
  image.dispose();
}
