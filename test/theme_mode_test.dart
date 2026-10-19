import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gramnota/core/app_theme_controller.dart';
import 'package:gramnota/core/theme.dart';
import 'package:gramnota/core/theme_mode.dart';
import 'package:gramnota/features/auth/data/desktop_google_sign_in_io.dart';
import 'package:gramnota/features/settings/domain/workshop_settings.dart';
import 'package:gramnota/l10n/app_localizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  test('missing theme follows the device and unknown values do too', () {
    expect(readThemeMode({}, 'themeMode'), systemThemeCode);
    expect(readThemeMode({'themeMode': ''}, 'themeMode'), systemThemeCode);
    expect(readThemeMode({'themeMode': 'nope'}, 'themeMode'), systemThemeCode);
    expect(readThemeMode({'themeMode': 'dark'}, 'themeMode'), darkThemeCode);
    expect(readThemeMode({'themeMode': ' LIGHT '}, 'themeMode'), lightThemeCode);
    expect(themeModeForSetting('dark'), ThemeMode.dark);
    expect(themeModeForSetting('light'), ThemeMode.light);
    expect(themeModeForSetting('system'), ThemeMode.system);
    expect(const WorkshopSettings().themeMode, systemThemeCode);
    final old = WorkshopSettings.fromJson({'businessName': 'Testverkstad'});
    expect(old.themeMode, systemThemeCode);
    expect(old.languageCode, 'sv');
    expect(old.currencyCode, 'SEK');
    final saved = old.copyWith(themeMode: darkThemeCode).toJson();
    expect(WorkshopSettings.fromJson(saved).themeMode, darkThemeCode);
  });

  test('dark surfaces keep WCAG AA contrast', () {
    final dark = buildGramnotaTheme(brightness: Brightness.dark).colorScheme;
    final light = buildGramnotaTheme().colorScheme;
    expect(dark.brightness, Brightness.dark);
    expect(light.primary, gramnotaGreen);
    expect(dark.primary, gramnotaGreen);
    expect(_contrast(dark.onSurface, dark.surface), greaterThanOrEqualTo(4.5));
    expect(
      _contrast(dark.onSurface, dark.surfaceContainerLowest),
      greaterThanOrEqualTo(4.5),
    );
    expect(
      _contrast(dark.onSurfaceVariant, dark.surface),
      greaterThanOrEqualTo(4.5),
    );
    expect(_contrast(dark.onPrimary, dark.primary), greaterThanOrEqualTo(4.5));
    expect(
      _contrast(dark.onPrimaryContainer, dark.primaryContainer),
      greaterThanOrEqualTo(4.5),
    );
    expect(
      _contrast(gramnotaGreenBright, dark.surface),
      greaterThanOrEqualTo(4.5),
    );
    expect(_contrast(dark.error, dark.surface), greaterThanOrEqualTo(4.5));
    expect(
      _contrast(dark.onInverseSurface, dark.inverseSurface),
      greaterThanOrEqualTo(4.5),
    );
    expect(
      _contrast(light.onPrimary, light.primary),
      greaterThanOrEqualTo(4.5),
    );
    final darkTheme = buildGramnotaTheme(brightness: Brightness.dark);
    final lightTheme = buildGramnotaTheme();
    expect(
      _contrast(
        darkTheme.snackBarTheme.actionTextColor!,
        darkTheme.snackBarTheme.backgroundColor!,
      ),
      greaterThanOrEqualTo(4.5),
    );
    expect(
      _contrast(
        lightTheme.snackBarTheme.actionTextColor!,
        lightTheme.snackBarTheme.backgroundColor!,
      ),
      greaterThanOrEqualTo(4.5),
    );
    final darkLink = darkTheme.outlinedButtonTheme.style?.foregroundColor
        ?.resolve(const <WidgetState>{});
    final lightLink = lightTheme.textButtonTheme.style?.foregroundColor
        ?.resolve(const <WidgetState>{});
    expect(darkLink, gramnotaGreenBright);
    expect(
      _contrast(darkLink!, darkTheme.colorScheme.surface),
      greaterThanOrEqualTo(4.5),
    );
    expect(
      _contrast(lightLink!, lightTheme.colorScheme.surface),
      greaterThanOrEqualTo(4.5),
    );
  });

  test('the theme preference is cached and a remote value wins', () async {
    SharedPreferences.setMockInitialValues({});
    final container = ProviderContainer();
    addTearDown(container.dispose);
    expect(await container.read(appThemeProvider.future), systemThemeCode);
    await container.read(appThemeProvider.notifier).setTheme('dark');
    expect(container.read(appThemeProvider).asData?.value, darkThemeCode);
    final prefs = await SharedPreferences.getInstance();
    expect(prefs.getString(themePreferenceKey), darkThemeCode);
    await container.read(appThemeProvider.notifier).applyRemote('light');
    expect(prefs.getString(themePreferenceKey), lightThemeCode);
    await container.read(appThemeProvider.notifier).applyRemote('not-a-theme');
    expect(container.read(appThemeProvider).asData?.value, systemThemeCode);
  });

  test('the Windows sign-in page can be dark without changing the button', () {
    final light = desktopGoogleSignInPage(
      apiKey: 'key',
      authDomain: 'gramnota-2c353.firebaseapp.com',
      projectId: 'gramnota-2c353',
      appId: '1:1:web:abc',
      nonce: 'n',
    );
    final dark = desktopGoogleSignInPage(
      apiKey: 'key',
      authDomain: 'gramnota-2c353.firebaseapp.com',
      projectId: 'gramnota-2c353',
      appId: '1:1:web:abc',
      nonce: 'n',
      dark: true,
    );
    expect(light, contains('#F6F3EC'));
    expect(light, contains('#0F6E56'));
    expect(dark, contains('#141A17'));
    expect(dark, contains('#F4F7F5'));
    expect(dark, contains('#0F6E56'));
    expect(dark, isNot(contains('#F6F3EC')));
  });

  testWidgets('dark mode paints the scaffold, a dialog, and a snackbar', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        theme: buildGramnotaTheme(),
        darkTheme: buildGramnotaTheme(brightness: Brightness.dark),
        themeMode: ThemeMode.dark,
        home: Builder(
          builder: (context) {
            return Scaffold(
              body: Column(
                children: [
                  const Text('Night'),
                  FilledButton(
                    onPressed: () {
                      showDialog<void>(
                        context: context,
                        builder: (context) => const AlertDialog(
                          title: Text('Update'),
                          content: Text('Searching…'),
                        ),
                      );
                    },
                    child: const Text('Dialog'),
                  ),
                  FilledButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Saved')),
                      );
                    },
                    child: const Text('Snack'),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
    final context = tester.element(find.text('Night'));
    final theme = Theme.of(context);
    expect(theme.brightness, Brightness.dark);
    expect(theme.scaffoldBackgroundColor, const Color(0xFF141A17));
    expect(theme.cardTheme.color, const Color(0xFF1E2823));

    await tester.tap(find.text('Dialog'));
    await tester.pumpAndSettle();
    expect(find.text('Searching…'), findsOneWidget);
    final dialog = tester.widget<AlertDialog>(find.byType(AlertDialog));
    expect(dialog.backgroundColor, isNull);
    expect(
      Theme.of(tester.element(find.text('Update'))).dialogTheme.backgroundColor,
      const Color(0xFF1E2823),
    );
    await tester.tapAt(const Offset(10, 10));
    await tester.pumpAndSettle();

    await tester.tap(find.text('Snack'));
    await tester.pump();
    expect(find.text('Saved'), findsOneWidget);
    expect(
      Theme.of(tester.element(find.text('Saved'))).snackBarTheme.backgroundColor,
      theme.colorScheme.inverseSurface,
    );
  });
}

double _contrast(Color foreground, Color background) {
  final hi = _luminance(foreground);
  final lo = _luminance(background);
  final light = hi > lo ? hi : lo;
  final dark = hi > lo ? lo : hi;
  return (light + 0.05) / (dark + 0.05);
}

double _luminance(Color color) {
  double channel(double value) {
    return value <= 0.04045
        ? value / 12.92
        : math.pow((value + 0.055) / 1.055, 2.4).toDouble();
  }

  return 0.2126 * channel(color.r) +
      0.7152 * channel(color.g) +
      0.0722 * channel(color.b);
}
