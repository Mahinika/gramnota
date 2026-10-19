import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'theme_mode.dart';

const themePreferenceKey = 'gramnota_theme_mode';

/// Workshop appearance, cached on the device so sign-in matches Firestore
/// before the settings document loads. Missing cache and missing settings
/// both follow the device.
class AppThemeController extends AsyncNotifier<String> {
  @override
  Future<String> build() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(themePreferenceKey);
    if (stored == null || stored.trim().isEmpty) {
      return defaultThemeCode;
    }
    return normalizeThemeMode(stored);
  }

  Future<void> setTheme(String code) async {
    final next = normalizeThemeMode(code);
    state = AsyncData(next);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(themePreferenceKey, next);
  }

  /// Firestore is the copy that syncs between devices. Apply it when it loads.
  Future<void> applyRemote(String code) async {
    final next = normalizeThemeMode(code);
    if (state.asData?.value == next) {
      return;
    }
    await setTheme(next);
  }
}

final appThemeProvider = AsyncNotifierProvider<AppThemeController, String>(
  AppThemeController.new,
);
