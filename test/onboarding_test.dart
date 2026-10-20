import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:gramnota/core/app_language_controller.dart';
import 'package:gramnota/core/app_languages.dart';
import 'package:gramnota/core/currencies.dart';
import 'package:gramnota/core/language_onboarding.dart';
import 'package:gramnota/core/providers.dart';
import 'package:gramnota/core/theme.dart';
import 'package:gramnota/core/user_store.dart';
import 'package:gramnota/features/auth/presentation/choose_language_screen.dart';
import 'package:gramnota/features/filaments/domain/filament_spool.dart';
import 'package:gramnota/features/printers/domain/printer_profile.dart';
import 'package:gramnota/features/settings/domain/workshop_defaults.dart';
import 'package:gramnota/features/settings/domain/workshop_settings.dart';
import 'package:gramnota/features/settings/presentation/business_profile_tip.dart';
import 'package:gramnota/features/settings/presentation/workshop_setup_screen.dart';
import 'package:gramnota/l10n/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('device locale picks a shipped language, else English', () {
    expect(languageForDeviceLocale(const Locale('sv')), 'sv');
    expect(languageForDeviceLocale(const Locale('en', 'US')), 'en');
    expect(languageForDeviceLocale(const Locale('de', 'DE')), 'de');
    expect(languageForDeviceLocale(const Locale('fr')), 'fr');
    expect(languageForDeviceLocale(const Locale('pl')), 'pl');
    expect(languageForDeviceLocale(const Locale('fi')), 'fi');
    expect(languageForDeviceLocale(const Locale('nb')), 'nb');
    expect(languageForDeviceLocale(const Locale('da')), 'da');
    expect(languageForDeviceLocale(const Locale('nl')), 'nl');
    expect(languageForDeviceLocale(const Locale('es')), 'es');
    expect(languageForDeviceLocale(const Locale('no')), 'nb');
    expect(languageForDeviceLocale(const Locale('nn', 'NO')), 'nb');
    expect(languageForDeviceLocale(const Locale('ja')), 'en');
    expect(languageForDeviceLocale(const Locale('zh', 'CN')), 'en');
    expect(languageForDeviceLocale(null), 'en');
  });

  test('a cached language is kept and a fresh device locale is not Swedish', () async {
    SharedPreferences.setMockInitialValues({languagePreferenceKey: 'sv'});
    final binding = TestWidgetsFlutterBinding.instance;
    binding.platformDispatcher.localeTestValue = const Locale('de', 'DE');
    addTearDown(binding.platformDispatcher.clearLocaleTestValue);
    final cached = ProviderContainer();
    addTearDown(cached.dispose);
    expect(await cached.read(appLanguageProvider.future), 'sv');

    SharedPreferences.setMockInitialValues({});
    final fresh = ProviderContainer();
    addTearDown(fresh.dispose);
    expect(await fresh.read(appLanguageProvider.future), 'de');
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString(languagePreferenceKey), isNull);
  });

  test('currency follows language, and English follows a known region', () {
    expect(currencyForLanguage(languageCode: 'sv', regionCode: 'US'), 'SEK');
    expect(currencyForLanguage(languageCode: 'nb'), 'NOK');
    expect(currencyForLanguage(languageCode: 'no'), 'NOK');
    expect(currencyForLanguage(languageCode: 'nn'), 'NOK');
    expect(currencyForLanguage(languageCode: 'da'), 'DKK');
    expect(currencyForLanguage(languageCode: 'pl'), 'PLN');
    expect(currencyForLanguage(languageCode: 'fi'), 'EUR');
    expect(currencyForLanguage(languageCode: 'de', regionCode: 'US'), 'EUR');
    expect(currencyForLanguage(languageCode: 'fr'), 'EUR');
    expect(currencyForLanguage(languageCode: 'nl'), 'EUR');
    expect(currencyForLanguage(languageCode: 'es'), 'EUR');
    expect(currencyForLanguage(languageCode: 'en', regionCode: 'US'), 'USD');
    expect(currencyForLanguage(languageCode: 'en', regionCode: 'GB'), 'GBP');
    expect(currencyForLanguage(languageCode: 'en', regionCode: 'SE'), 'SEK');
    expect(currencyForLanguage(languageCode: 'en', regionCode: 'DE'), 'EUR');
    expect(currencyForLanguage(languageCode: 'en'), 'EUR');
    expect(currencyForLanguage(languageCode: 'en', regionCode: 'ZZ'), 'EUR');
    expect(currencyForLanguage(languageCode: 'ja', regionCode: 'JP'), 'EUR');
  });

  test('new workshops use 25% VAT only for Swedish', () {
    expect(defaultVatBasisPointsForLanguage('sv'), 2500);
    expect(defaultVatBasisPointsForLanguage('SV'), 2500);
    expect(defaultVatBasisPointsForLanguage('de'), 0);
    expect(defaultVatBasisPointsForLanguage('en'), 0);
    final swedish = newWorkshopSettings(
      languageCode: 'sv',
      currencyCode: 'SEK',
      email: ' seller@example.com ',
    );
    expect(swedish.vatBasisPoints, 2500);
    expect(swedish.defaultMarkupBasisPoints, 3000);
    expect(swedish.defaultFailureBasisPoints, 0);
    expect(swedish.laborMinorPerHour, 0);
    expect(swedish.quoteValidityDays, 14);
    expect(swedish.businessName, isEmpty);
    expect(swedish.email, 'seller@example.com');
    expect(swedish.setupCompleted, isTrue);
    expect(swedish.currencyCode, 'SEK');
    final german = newWorkshopSettings(
      languageCode: 'de',
      currencyCode: 'EUR',
      electricityMinorPerKwh: 250,
    );
    expect(german.vatBasisPoints, 0);
    expect(german.electricityMinorPerKwh, 250);
    expect(german.languageCode, 'de');
    expect(german.currencyCode, 'EUR');
    expect(
      WorkshopSettings.fromJson({'businessName': 'North'}).vatBasisPoints,
      2500,
    );
  });

  test('the language screen is once per device and existing users skip it', () async {
    expect(
      shouldShowLanguageOnboarding(seen: false, hasCachedLanguage: false),
      isTrue,
    );
    expect(
      shouldShowLanguageOnboarding(seen: true, hasCachedLanguage: false),
      isFalse,
    );
    expect(
      shouldShowLanguageOnboarding(seen: false, hasCachedLanguage: true),
      isFalse,
    );

    SharedPreferences.setMockInitialValues({languagePreferenceKey: 'en'});
    final existing = ProviderContainer();
    addTearDown(existing.dispose);
    expect(await existing.read(showLanguageOnboardingProvider.future), isFalse);

    SharedPreferences.setMockInitialValues({languageOnboardingSeenKey: true});
    final seen = ProviderContainer();
    addTearDown(seen.dispose);
    expect(await seen.read(showLanguageOnboardingProvider.future), isFalse);
  });

  testWidgets('the language screen is shown once and switches the UI immediately', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    tester.platformDispatcher.localeTestValue = const Locale('de', 'DE');
    addTearDown(tester.platformDispatcher.clearLocaleTestValue);
    final container = ProviderContainer();
    addTearDown(container.dispose);
    expect(await container.read(appLanguageProvider.future), 'de');
    expect(await container.read(showLanguageOnboardingProvider.future), isTrue);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const _LanguageHost(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Sprache wählen'), findsOneWidget);
    expect(find.text('Deutsch'), findsWidgets);
    expect(find.byIcon(Icons.check_circle), findsOneWidget);
    final before = await SharedPreferences.getInstance();
    expect(before.getString(languagePreferenceKey), isNull);

    await tester.tap(find.text('Svenska'));
    await tester.pumpAndSettle();

    expect(find.text('Välj språk'), findsOneWidget);
    expect(container.read(appLanguageProvider).asData?.value, 'sv');
    expect(
      (await SharedPreferences.getInstance()).getString(languagePreferenceKey),
      isNull,
    );

    await tester.tap(find.text('Fortsätt'));
    await tester.pumpAndSettle();

    expect(find.text('sign-in-next'), findsOneWidget);
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString(languagePreferenceKey), 'sv');
    expect(prefs.getBool(languageOnboardingSeenKey), isTrue);
    expect(container.read(showLanguageOnboardingProvider).asData?.value, isFalse);

    final again = ProviderContainer();
    addTearDown(again.dispose);
    expect(await again.read(showLanguageOnboardingProvider.future), isFalse);
    expect(await again.read(appLanguageProvider.future), 'sv');
  });

  testWidgets('three setup steps save language, currency, and defaults', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({});
    final firestore = FakeFirebaseFirestore();
    final store = UserStore(firestore, 'seller');
    tester.view.physicalSize = const Size(800, 1400);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final router = GoRouter(
      initialLocation: '/workshop-setup',
      routes: [
        GoRoute(
          path: '/workshop-setup',
          builder: (_, _) => const WorkshopSetupScreen(),
        ),
        GoRoute(
          path: '/calculator',
          builder: (_, _) => const Scaffold(body: Text('calculator-ready')),
        ),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          userStoreProvider.overrideWithValue(store),
          appLanguageProvider.overrideWith(_GermanLanguage.new),
        ],
        child: MaterialApp.router(
          locale: const Locale('en'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          theme: buildGramnotaTheme(),
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Step 1 of 3'), findsOneWidget);
    expect(find.text('Step 1 of 9'), findsNothing);

    await tester.enterText(find.byType(TextField).first, 'A1 mini');
    await tester.pumpAndSettle();
    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Bambu Lab A1 mini · 80 W').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    expect(find.text('Step 2 of 3'), findsOneWidget);
    await tester.tap(find.byType(DropdownButtonFormField<String>));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Bambu Lab PLA Basic · Black').last);
    await tester.pumpAndSettle();
    await tester.tap(find.text('Next'));
    await tester.pumpAndSettle();

    expect(find.text('Step 3 of 3'), findsOneWidget);
    await tester.enterText(find.byType(TextField).first, '2.50');
    await tester.tap(find.text('Save and start'));
    await tester.pumpAndSettle();

    expect(find.text('calculator-ready'), findsOneWidget);
    final saved = WorkshopSettings.fromJson(
      (await store.settingsDoc.get()).data()!,
    );
    expect(saved.setupCompleted, isTrue);
    expect(saved.languageCode, 'de');
    expect(saved.currencyCode, 'EUR');
    expect(saved.vatBasisPoints, 0);
    expect(saved.defaultMarkupBasisPoints, 3000);
    expect(saved.defaultFailureBasisPoints, 0);
    expect(saved.laborMinorPerHour, 0);
    expect(saved.electricityMinorPerKwh, 250);
    expect(saved.quoteValidityDays, 14);
    expect(saved.businessName, isEmpty);
    expect(saved.street, isEmpty);
    final printers = await store.printers.get();
    expect(printers.docs, hasLength(1));
    expect(
      PrinterProfile.fromJson(printers.docs.single.data()).name,
      'Bambu Lab A1 mini',
    );
    final spools = await store.filaments.get();
    expect(spools.docs, hasLength(1));
    expect(
      FilamentSpool.fromJson(spools.docs.single.data()).material,
      'PLA Basic',
    );
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString(languagePreferenceKey), 'de');
  });

  testWidgets('skip for now saves defaults without a printer', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final firestore = FakeFirebaseFirestore();
    final store = UserStore(firestore, 'seller');
    final router = GoRouter(
      initialLocation: '/workshop-setup',
      routes: [
        GoRoute(
          path: '/workshop-setup',
          builder: (_, _) => const WorkshopSetupScreen(),
        ),
        GoRoute(
          path: '/calculator',
          builder: (_, _) => const Scaffold(body: Text('calculator-ready')),
        ),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          userStoreProvider.overrideWithValue(store),
          appLanguageProvider.overrideWith(_SwedishLanguage.new),
        ],
        child: MaterialApp.router(
          locale: const Locale('en'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Skip for now'));
    await tester.pumpAndSettle();

    expect(find.text('calculator-ready'), findsOneWidget);
    final saved = WorkshopSettings.fromJson(
      (await store.settingsDoc.get()).data()!,
    );
    expect(saved.languageCode, 'sv');
    expect(saved.currencyCode, 'SEK');
    expect(saved.vatBasisPoints, 2500);
    expect(saved.defaultMarkupBasisPoints, 3000);
    expect(saved.electricityMinorPerKwh, 0);
    expect(saved.laborMinorPerHour, 0);
    expect(saved.businessName, isEmpty);
    expect((await store.printers.get()).docs, isEmpty);
    expect((await store.filaments.get()).docs, isEmpty);
  });

  testWidgets('the PDF tip shows until dismissed', (tester) async {
    SharedPreferences.setMockInitialValues({});
    final firestore = FakeFirebaseFirestore();
    final store = UserStore(firestore, 'seller');
    await store.saveSettings(
      const WorkshopSettings(setupCompleted: true, businessName: ''),
    );
    final router = GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (_, _) => const Scaffold(body: BusinessProfileTip()),
        ),
        GoRoute(
          path: '/more/settings',
          builder: (_, _) => const Scaffold(body: Text('settings-page')),
        ),
      ],
    );
    addTearDown(router.dispose);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [userStoreProvider.overrideWithValue(store)],
        child: MaterialApp.router(
          locale: const Locale('en'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          routerConfig: router,
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.text('Add your business name and address for PDF quotes'),
      findsOneWidget,
    );
    await tester.tap(find.text('Settings'));
    await tester.pumpAndSettle();
    expect(find.text('settings-page'), findsOneWidget);

    router.go('/');
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Close'));
    await tester.pumpAndSettle();
    expect(
      find.text('Add your business name and address for PDF quotes'),
      findsNothing,
    );
    final again = ProviderContainer();
    addTearDown(again.dispose);
    expect(
      await again.read(businessProfileTipDismissedProvider.future),
      isTrue,
    );
  });
}

class _LanguageHost extends ConsumerWidget {
  const _LanguageHost();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final language = ref.watch(appLanguageProvider).asData?.value ?? 'en';
    final show = ref.watch(showLanguageOnboardingProvider).asData?.value ?? false;
    return MaterialApp(
      locale: Locale(language),
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      home: show ? const ChooseLanguageScreen() : const Text('sign-in-next'),
    );
  }
}

class _GermanLanguage extends AppLanguageController {
  @override
  Future<String> build() async => 'de';
}

class _SwedishLanguage extends AppLanguageController {
  @override
  Future<String> build() async => 'sv';
}
