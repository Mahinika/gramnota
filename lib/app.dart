import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import 'core/app_language_controller.dart';
import 'core/app_languages.dart';
import 'core/app_theme_controller.dart';
import 'core/providers.dart';
import 'core/theme.dart';
import 'core/theme_mode.dart';
import 'features/orders/data/orders_providers.dart';
import 'features/updates/presentation/update_host.dart';
import 'l10n/app_localizations.dart';
import 'router.dart';

class GramnotaApp extends ConsumerWidget {
  const GramnotaApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(sharedLinkBootstrapProvider);
    final router = ref.watch(routerProvider);
    final language =
        ref.watch(appLanguageProvider).asData?.value ?? defaultLanguageCode;
    final store = ref.watch(userStoreProvider);
    if (store != null) {
      ref.listen(settingsProvider(store), (previous, next) {
        final settings = next.asData?.value;
        if (settings == null) {
          return;
        }
        ref.read(appLanguageProvider.notifier).applyRemote(settings.languageCode);
        ref.read(appThemeProvider.notifier).applyRemote(settings.themeMode);
      });
    }
    final appearance =
        ref.watch(appThemeProvider).asData?.value ?? defaultThemeCode;
    final explicit = localeForLanguageSetting(language);
    return MaterialApp.router(
      onGenerateTitle: (context) => AppLocalizations.of(context).appTitle,
      theme: buildGramnotaTheme(),
      darkTheme: buildGramnotaTheme(brightness: Brightness.dark),
      themeMode: themeModeForSetting(appearance),
      locale: explicit,
      supportedLocales: AppLocalizations.supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      localeResolutionCallback: resolveSupportedLocale,
      routerConfig: router,
      builder: (context, child) {
        Intl.defaultLocale = Localizations.localeOf(context).toString();
        return UpdateHost(
          navigatorKey: router.routerDelegate.navigatorKey,
          child: child ?? const SizedBox.shrink(),
        );
      },
    );
  }
}
