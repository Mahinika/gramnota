import 'dart:io';
import 'dart:ui' as ui;

import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gramnota/core/app_language_controller.dart';
import 'package:gramnota/core/providers.dart';
import 'package:gramnota/core/theme.dart';
import 'package:gramnota/core/user_store.dart';
import 'package:gramnota/features/auth/presentation/choose_language_screen.dart';
import 'package:gramnota/features/settings/domain/workshop_settings.dart';
import 'package:gramnota/features/settings/presentation/business_profile_tip.dart';
import 'package:gramnota/features/settings/presentation/workshop_setup_screen.dart';
import 'package:gramnota/l10n/l10n.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Opt-in harness. `flutter test` skips it.
/// `GRAMNOTA_SCREENSHOTS=1 flutter test test/onboarding_screenshots_test.dart`
/// writes light and dark Swedish and German PNGs to /opt/cursor/artifacts.
void main() {
  final enabled = Platform.environment['GRAMNOTA_SCREENSHOTS'] == '1';
  if (enabled) {
    LiveTestWidgetsFlutterBinding.ensureInitialized();
  }

  testWidgets(
    'onboarding screenshots',
    (tester) async {
      SharedPreferences.setMockInitialValues({});
      await _loadShotFonts();
      tester.view.devicePixelRatio = 1;
      addTearDown(() => tester.binding.setSurfaceSize(null));
      addTearDown(tester.view.resetDevicePixelRatio);

      final firestore = FakeFirebaseFirestore();
      final store = UserStore(firestore, 'seller');
      await store.saveSettings(const WorkshopSettings(setupCompleted: true));

      for (final code in ['sv', 'de']) {
        for (final dark in [false, true]) {
          final tone = dark ? 'dark' : 'light';
          _ShotLanguage.code = code;
          await _pump(
            tester,
            code: code,
            dark: dark,
            size: const Size(420, 1280),
            child: const ChooseLanguageScreen(),
          );
          await _save(tester, 'choose-language-$code-$tone');

          await _pump(
            tester,
            code: code,
            dark: dark,
            store: store,
            size: const Size(420, 1400),
            child: const WorkshopSetupScreen(),
          );
          await _save(tester, 'setup-printer-$code-$tone');

          final l10n = lookupAppLocalizations(Locale(code));
          await tester.enterText(find.byType(TextField).first, 'A1 mini');
          await tester.pumpAndSettle();
          await tester.tap(find.byType(DropdownButtonFormField<String>));
          await tester.pumpAndSettle();
          await tester.tap(find.text('Bambu Lab A1 mini · 80 W').last);
          await tester.pumpAndSettle();
          await tester.tap(find.text(l10n.setupNext));
          await tester.pumpAndSettle();
          await _save(tester, 'setup-spool-$code-$tone');

          await tester.tap(find.byType(DropdownButtonFormField<String>));
          await tester.pumpAndSettle();
          await tester.tap(find.text('Bambu Lab PLA Basic · Black').last);
          await tester.pumpAndSettle();
          await tester.tap(find.text(l10n.setupNext));
          await tester.pumpAndSettle();
          await _save(tester, 'setup-electricity-$code-$tone');

          await _pump(
            tester,
            code: code,
            dark: dark,
            store: store,
            size: const Size(420, 280),
            child: const Scaffold(
              body: Padding(
                padding: EdgeInsets.all(16),
                child: BusinessProfileTip(),
              ),
            ),
          );
          await _save(tester, 'profile-tip-$code-$tone');
        }
      }
    },
    skip: !enabled,
    timeout: const Timeout(Duration(minutes: 3)),
  );
}

Future<void> _loadShotFonts() async {
  Future<ByteData> font(String path) async {
    final bytes = await File(path).readAsBytes();
    return ByteData.view(Uint8List.fromList(bytes).buffer);
  }

  final sans = FontLoader('NotoSans')
    ..addFont(font('/usr/share/fonts/truetype/noto/NotoSans-Regular.ttf'))
    ..addFont(font('/usr/share/fonts/truetype/noto/NotoSans-Bold.ttf'));
  final emoji = FontLoader('NotoColorEmoji')
    ..addFont(font('/usr/share/fonts/truetype/noto/NotoColorEmoji.ttf'));
  final icons = FontLoader('MaterialIcons')
    ..addFont(
      font(
        '${Platform.environment['HOME']}/sdk/flutter/bin/cache/artifacts/material_fonts/MaterialIcons-Regular.otf',
      ),
    );
  await Future.wait([sans.load(), emoji.load(), icons.load()]);
}

ThemeData _shotTheme({required bool dark}) {
  final base = buildGramnotaTheme(
    brightness: dark ? Brightness.dark : Brightness.light,
  );
  return base.copyWith(
    textTheme: base.textTheme.apply(
      fontFamily: 'NotoSans',
      fontFamilyFallback: const ['NotoColorEmoji'],
    ),
    primaryTextTheme: base.primaryTextTheme.apply(
      fontFamily: 'NotoSans',
      fontFamilyFallback: const ['NotoColorEmoji'],
    ),
  );
}

class _ShotLanguage extends AppLanguageController {
  static String code = 'sv';

  @override
  Future<String> build() async => code;
}

Future<void> _pump(
  WidgetTester tester, {
  required String code,
  required bool dark,
  required Widget child,
  required Size size,
  UserStore? store,
}) async {
  _ShotLanguage.code = code;
  await tester.binding.setSurfaceSize(size);
  final theme = _shotTheme(dark: false);
  final darkTheme = _shotTheme(dark: true);
  await tester.pumpWidget(
    ProviderScope(
      key: UniqueKey(),
      overrides: [
        appLanguageProvider.overrideWith(_ShotLanguage.new),
        if (store != null) userStoreProvider.overrideWithValue(store),
      ],
      child: MaterialApp(
        locale: Locale(code),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        theme: theme,
        darkTheme: darkTheme,
        themeMode: dark ? ThemeMode.dark : ThemeMode.light,
        home: RepaintBoundary(key: const Key('shot'), child: child),
      ),
    ),
  );
  await tester.pump();
  await tester.pump(const Duration(milliseconds: 100));
}

Future<void> _save(WidgetTester tester, String name) async {
  final boundary = tester.renderObject(find.byKey(const Key('shot')))
      as RenderRepaintBoundary;
  expect(boundary.debugNeedsPaint, isFalse);
  final layer = boundary.debugLayer! as OffsetLayer;
  final image = layer.toImageSync(boundary.paintBounds, pixelRatio: 2);
  final bytes = await tester.runAsync(
    () => image.toByteData(format: ui.ImageByteFormat.png),
  );
  final file = File('/opt/cursor/artifacts/$name.png');
  await file.parent.create(recursive: true);
  await file.writeAsBytes(bytes!.buffer.asUint8List());
  image.dispose();
}
