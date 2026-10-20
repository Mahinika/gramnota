import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gramnota/core/app_language_controller.dart';
import 'package:gramnota/core/app_theme_controller.dart';
import 'package:gramnota/core/providers.dart';
import 'package:gramnota/core/theme.dart';
import 'package:gramnota/core/theme_mode.dart';
import 'package:gramnota/core/user_store.dart';
import 'package:gramnota/core/workshop_locale_sync.dart';
import 'package:gramnota/features/orders/data/orders_providers.dart';
import 'package:gramnota/features/settings/domain/workshop_settings.dart';
import 'package:gramnota/features/settings/presentation/settings_screen.dart';
import 'package:gramnota/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  test('a stale language snapshot does not undo a saved choice', () async {
    SharedPreferences.setMockInitialValues({languagePreferenceKey: 'sv'});
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final language = container.read(appLanguageProvider.notifier);
    expect(await container.read(appLanguageProvider.future), 'sv');

    const stamp = '2026-10-20T08:00:00.000Z';
    language.expectEcho('en', stamp);
    await language.setLanguage('en');
    await language.applyRemote('sv');
    expect(container.read(appLanguageProvider).asData?.value, 'en');
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString(languagePreferenceKey), 'en');

    await language.applyRemote('en', updatedAt: stamp);
    expect(container.read(appLanguageProvider).asData?.value, 'en');
    await language.applyRemote('sv');
    expect(container.read(appLanguageProvider).asData?.value, 'en');
    expect(prefs.getString(languagePreferenceKey), 'en');

    await language.applyRemote('de', updatedAt: '2026-10-20T09:00:00.000Z');
    expect(container.read(appLanguageProvider).asData?.value, 'de');
    expect(prefs.getString(languagePreferenceKey), 'de');
  });

  test('an older workshop language still replaces the cache', () async {
    SharedPreferences.setMockInitialValues({languagePreferenceKey: 'en'});
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final language = container.read(appLanguageProvider.notifier);
    expect(await container.read(appLanguageProvider.future), 'en');
    await language.applyRemote('sv');
    expect(container.read(appLanguageProvider).asData?.value, 'sv');
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString(languagePreferenceKey), 'sv');
  });

  test('a stale theme snapshot does not undo a saved choice', () async {
    SharedPreferences.setMockInitialValues({themePreferenceKey: 'system'});
    final container = ProviderContainer();
    addTearDown(container.dispose);
    final theme = container.read(appThemeProvider.notifier);
    expect(await container.read(appThemeProvider.future), systemThemeCode);

    const stamp = '2026-10-20T08:00:00.000Z';
    theme.expectEcho('dark', stamp);
    await theme.setTheme('dark');
    await theme.applyRemote('system');
    expect(container.read(appThemeProvider).asData?.value, darkThemeCode);

    await theme.applyRemote('dark', updatedAt: stamp);
    await theme.applyRemote('light');
    expect(container.read(appThemeProvider).asData?.value, darkThemeCode);

    await theme.applyRemote('light', updatedAt: '2026-10-20T09:00:00.000Z');
    expect(container.read(appThemeProvider).asData?.value, lightThemeCode);
  });

  test('a missing settings document does not count as Swedish', () async {
    final store = UserStore(FakeFirebaseFirestore(), 'seller');
    expect(store.settingsDocumentExists, isFalse);
    final language = _Language();
    final theme = _Theme();
    applyRemoteWorkshopLocale(
      store: store,
      settings: const WorkshopSettings(),
      language: language,
      theme: theme,
    );
    expect(language.applied, isNull);
    expect(theme.applied, isNull);

    await store.settingsDoc.set({'languageCode': 'de', 'themeMode': 'dark'});
    final settings = await store.watchSettings().first;
    expect(store.settingsDocumentExists, isTrue);
    expect(settings.languageCode, 'de');
    applyRemoteWorkshopLocale(
      store: store,
      settings: settings,
      language: language,
      theme: theme,
    );
    expect(language.applied, 'de');
    expect(theme.applied, 'dark');
  });

  test('saving settings keeps language, theme, and currency', () async {
    final store = UserStore(FakeFirebaseFirestore(), 'seller');
    await store.settingsDoc.set({
      'languageCode': 'sv',
      'currencyCode': 'SEK',
      'themeMode': 'system',
      'nextQuoteNumber': 8,
    });
    const stamp = '2026-10-20T08:00:00.000Z';
    await store.saveSettings(
      const WorkshopSettings(
        setupCompleted: true,
        languageCode: 'en',
        currencyCode: 'USD',
        themeMode: 'dark',
        languageUpdatedAt: stamp,
        themeUpdatedAt: stamp,
        currencyUpdatedAt: stamp,
        nextQuoteNumber: 1,
      ),
    );
    final saved = (await store.settingsDoc.get()).data()!;
    expect(saved['languageCode'], 'en');
    expect(saved['currencyCode'], 'USD');
    expect(saved['themeMode'], 'dark');
    expect(saved['languageUpdatedAt'], stamp);
    expect(saved['nextQuoteNumber'], 8);
    expect(
      settingsWithoutQuoteCounter(
        const WorkshopSettings(languageCode: 'en', currencyCode: 'USD'),
      ),
      containsPair('languageCode', 'en'),
    );
    expect(
      settingsWithoutQuoteCounter(
        const WorkshopSettings(languageCode: 'en', currencyCode: 'USD'),
      ).containsKey('currencyCode'),
      isTrue,
    );
  });

  test('a stale currency snapshot keeps the currency just saved', () async {
    final store = UserStore(FakeFirebaseFirestore(), 'seller');
    await store.settingsDoc.set({
      'currencyCode': 'SEK',
      'languageCode': 'sv',
    });
    final seen = <String>[];
    final sub = store.watchSettings().listen((settings) {
      seen.add(settings.currencyCode);
    });
    addTearDown(sub.cancel);
    await _until(() => seen.isNotEmpty);
    expect(seen.last, 'SEK');

    const stamp = '2026-10-20T08:00:00.000Z';
    store.expectCurrencyEcho('USD', stamp);
    await store.saveLocalePreferences(
      currencyCode: 'USD',
      currencyUpdatedAt: stamp,
    );
    await _until(() => seen.last == 'USD');

    await store.settingsDoc.set({'currencyCode': 'SEK', 'languageCode': 'sv'});
    await _until(() => seen.length >= 3);
    expect(seen.last, 'USD');

    await store.settingsDoc.set({
      'currencyCode': 'EUR',
      'currencyUpdatedAt': '2026-10-20T09:00:00.000Z',
      'languageCode': 'sv',
    });
    await _until(() => seen.last == 'EUR');
  });

  testWidgets('settings language, theme, and currency survive a stale snapshot', (
    tester,
  ) async {
    SharedPreferences.setMockInitialValues({languagePreferenceKey: 'sv'});
    final firestore = FakeFirebaseFirestore();
    final store = UserStore(firestore, 'seller');
    await store.settingsDoc.set({
      'setupCompleted': true,
      'languageCode': 'sv',
      'currencyCode': 'SEK',
      'themeMode': 'system',
      'electricityMinorPerKwh': 250,
      'laborMinorPerHour': 0,
      'defaultMarkupBasisPoints': 3000,
      'vatBasisPoints': 2500,
      'defaultFailureBasisPoints': 0,
      'quoteValidityDays': 14,
      'defaultLowStockGrams': 100,
      'nextQuoteNumber': 4,
    });
    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [userStoreProvider.overrideWithValue(store)],
        child: const MaterialApp(
          locale: Locale('sv'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: _SettingsHarness(),
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(find.text('Spara'), findsOneWidget);

    await tester.tap(find.byType(DropdownButtonFormField<String>).first);
    await tester.pumpAndSettle();
    await tester.tap(find.text('English').last);
    await tester.pumpAndSettle();

    expect(find.text('Save'), findsOneWidget);
    expect(find.text('Spara'), findsNothing);
    var saved = (await store.settingsDoc.get()).data()!;
    expect(saved['languageCode'], 'en');
    expect(saved['nextQuoteNumber'], 4);
    expect(find.text('English'), findsWidgets);

    final container = tester.container();
    await container
        .read(appLanguageProvider.notifier)
        .applyRemote('sv');
    await tester.pumpAndSettle();
    expect(find.text('Save'), findsOneWidget);
    expect(container.read(appLanguageProvider).asData?.value, 'en');

    await tester.tap(find.byType(DropdownButtonFormField<String>).at(1));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Dark').last);
    await tester.pumpAndSettle();
    saved = (await store.settingsDoc.get()).data()!;
    expect(saved['themeMode'], 'dark');
    expect(container.read(appThemeProvider).asData?.value, darkThemeCode);
    await container.read(appThemeProvider.notifier).applyRemote('system');
    await tester.pumpAndSettle();
    expect(container.read(appThemeProvider).asData?.value, darkThemeCode);

    await tester.tap(find.textContaining('SEK'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField).last, 'USD');
    await tester.pumpAndSettle();
    await tester.tap(find.textContaining('USD').last);
    await tester.pumpAndSettle();
    saved = (await store.settingsDoc.get()).data()!;
    expect(saved['currencyCode'], 'USD');
    expect(find.textContaining('USD'), findsWidgets);

    await store.settingsDoc.set({
      ...saved,
      'currencyCode': 'SEK',
      'currencyUpdatedAt': '',
    });
    await tester.pumpAndSettle();
    expect(find.textContaining('USD'), findsWidgets);
    final shown = container.read(settingsProvider(store)).asData?.value;
    expect(shown?.currencyCode, 'USD');
  });
}

Future<void> _until(bool Function() done) async {
  for (var i = 0; i < 20; i++) {
    if (done()) {
      return;
    }
    await Future<void>.delayed(const Duration(milliseconds: 10));
  }
  fail('condition was not met');
}

class _Language extends AppLanguageController {
  String? applied;

  @override
  Future<String> build() async => 'en';

  @override
  Future<void> applyRemote(String code, {String updatedAt = ''}) async {
    applied = code;
  }
}

class _Theme extends AppThemeController {
  String? applied;

  @override
  Future<String> build() async => 'system';

  @override
  Future<void> applyRemote(String code, {String updatedAt = ''}) async {
    applied = code;
  }
}

class _SettingsHarness extends ConsumerWidget {
  const _SettingsHarness();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(userStoreProvider);
    final themeMode = ref.watch(appThemeProvider).asData?.value ?? 'system';
    final language = ref.watch(appLanguageProvider).asData?.value ?? 'sv';
    if (store != null) {
      ref.listen(settingsProvider(store), (_, next) {
        final settings = next.asData?.value;
        if (settings == null) {
          return;
        }
        applyRemoteWorkshopLocale(
          store: store,
          settings: settings,
          language: ref.read(appLanguageProvider.notifier),
          theme: ref.read(appThemeProvider.notifier),
        );
      });
    }
    return Theme(
      data: themeMode == 'dark'
          ? buildGramnotaTheme(brightness: Brightness.dark)
          : buildGramnotaTheme(),
      child: Localizations.override(
        context: context,
        locale: Locale(language),
        child: const SettingsScreen(),
      ),
    );
  }
}
