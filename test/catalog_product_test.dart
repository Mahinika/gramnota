import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:gramnota/core/providers.dart';
import 'package:gramnota/core/user_store.dart';
import 'package:gramnota/features/catalog/domain/catalog_product.dart';
import 'package:gramnota/features/catalog/presentation/products_screen.dart';
import 'package:gramnota/features/filaments/domain/filament_spool.dart';
import 'package:gramnota/features/orders/domain/print_order.dart';
import 'package:gramnota/features/pricing/domain/live_quote.dart';
import 'package:gramnota/features/pricing/presentation/calculator_screen.dart';
import 'package:gramnota/features/settings/domain/workshop_settings.dart';

void main() {
  test('a product round-trips and is priced from the spool of the moment', () {
    const product = CatalogProduct(
      id: 'stand',
      name: 'Phone stand',
      printerId: 'a1',
      printTimeSeconds: 0,
      filaments: [
        FilamentUsage(filamentId: 'pla', grams: 100, material: 'PLA'),
      ],
      prepMinutes: 0,
      markupBasisPoints: 0,
      failureBasisPoints: 0,
      vatBasisPoints: 0,
      sourceUrl: 'https://example.com/stand',
      notes: 'Grey',
      createdAt: '2026-10-19T00:00:00.000Z',
      updatedAt: '2026-10-19T00:00:00.000Z',
    );
    expect(CatalogProduct.fromJson(product.toJson()), product);

    const settings = WorkshopSettings(
      electricityMinorPerKwh: 0,
      laborMinorPerHour: 0,
      defaultMarkupBasisPoints: 3000,
      vatBasisPoints: 2500,
    );
    final cheap = priceProduct(
      product: product,
      lineId: 'line',
      quantity: 2,
      settings: settings,
      spools: const [
        FilamentSpool(
          id: 'pla',
          brand: 'Prusa',
          material: 'PLA',
          spoolWeightGrams: 1000,
          pricePerSpoolMinor: 20000,
        ),
      ],
      printers: const [],
    );
    expect(cheap.line.quantity, 2);
    expect(cheap.line.markupBasisPoints, 0);
    expect(cheap.line.vatBasisPoints, 0);
    expect(cheap.line.breakdown.materialMinor, 4000);
    expect(cheap.line.sourceUrl, 'https://example.com/stand');

    final dear = priceProduct(
      product: product,
      lineId: 'line-2',
      quantity: 2,
      settings: settings,
      spools: const [
        FilamentSpool(
          id: 'pla',
          brand: 'Prusa',
          material: 'PLA',
          spoolWeightGrams: 1000,
          pricePerSpoolMinor: 50000,
        ),
      ],
      printers: const [],
    );
    expect(dear.line.breakdown.materialMinor, 10000);
    expect(
      dear.line.breakdown.totalMinor,
      isNot(cheap.line.breakdown.totalMinor),
    );
  });

  testWidgets('products can be saved, listed, and added to the calculator', (
    tester,
  ) async {
    final firestore = FakeFirebaseFirestore();
    final store = UserStore(firestore, 'seller');
    await store.saveSettings(
      const WorkshopSettings(
        setupCompleted: true,
        defaultMarkupBasisPoints: 0,
        vatBasisPoints: 0,
        defaultFailureBasisPoints: 0,
        electricityMinorPerKwh: 0,
        laborMinorPerHour: 0,
      ),
    );
    await store.saveFilament(
      const FilamentSpool(
        id: 'pla',
        brand: 'Prusa',
        material: 'PLA',
        spoolWeightGrams: 1000,
        pricePerSpoolMinor: 20000,
      ),
    );
    await store.saveProduct(
      const CatalogProduct(
        id: 'stand',
        name: 'Phone stand',
        printTimeSeconds: 5400,
        filaments: [
          FilamentUsage(filamentId: 'pla', grams: 12, material: 'PLA'),
        ],
        markupBasisPoints: 0,
        failureBasisPoints: 0,
        vatBasisPoints: 0,
      ),
    );

    tester.view.physicalSize = const Size(1200, 2200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final router = GoRouter(
      initialLocation: '/more/products',
      routes: [
        GoRoute(
          path: '/more/products',
          builder: (_, _) => const ProductsScreen(),
          routes: [
            GoRoute(
              path: ':id',
              builder: (_, state) =>
                  ProductEditScreen(id: state.pathParameters['id']!),
            ),
          ],
        ),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [userStoreProvider.overrideWithValue(store)],
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Phone stand'), findsOneWidget);
    expect(find.textContaining('1h 30m'), findsOneWidget);

    await tester.tap(find.byTooltip('New product'));
    await tester.pumpAndSettle();
    await tester.enterText(find.widgetWithText(TextField, 'Name'), 'Hook');
    await tester.enterText(find.widgetWithText(TextField, 'Grams'), '4');
    await tester.tap(find.text('Save product'));
    await tester.pumpAndSettle();
    expect(find.text('Hook'), findsOneWidget);
    final saved = await store.watchProducts().first;
    expect(
      saved.map((item) => item.name),
      containsAll(['Phone stand', 'Hook']),
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [userStoreProvider.overrideWithValue(store)],
        child: const MaterialApp(home: CalculatorScreen()),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Add from catalog'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Phone stand'));
    await tester.pumpAndSettle();
    expect(_field(tester, 'Title'), 'Phone stand');
    expect(_field(tester, 'Hours'), '1');
    expect(_field(tester, 'Minutes'), '30');
    expect(_field(tester, 'Grams'), '12');
    expect(find.textContaining('current spool prices'), findsOneWidget);

    await tester.enterText(find.widgetWithText(TextField, 'Title'), 'Clip');
    await tester.tap(find.text('Save as product'));
    await tester.pumpAndSettle();
    expect(find.textContaining('Saved “Clip”'), findsOneWidget);
    final after = await store.watchProducts().first;
    expect(after.map((item) => item.name), contains('Clip'));
    final clip = after.singleWhere((item) => item.name == 'Clip');
    expect(clip.filaments.single.grams, 12);
    expect(clip.filaments.single.filamentId, 'pla');
  });
}

String _field(WidgetTester tester, String label) {
  final field = tester.widget<TextField>(find.widgetWithText(TextField, label));
  return field.controller?.text ?? '';
}
