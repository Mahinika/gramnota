import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'preference_echo.dart';
import 'theme_mode.dart';

const themePreferenceKey = 'gramnota_theme_mode';

/// Workshop appearance, cached on the device so sign-in matches Firestore
/// before the settings document loads. Missing cache and missing settings
/// both follow the device.
class AppThemeController extends AsyncNotifier<String> {
  /// An explicit save that happened while [build] was still reading the cache.
  String? _chosen;

  final _echo = PreferenceEcho();

  @override
  Future<String> build() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(themePreferenceKey);
    final loaded = (stored == null || stored.trim().isEmpty)
        ? defaultThemeCode
        : normalizeThemeMode(stored);
    return _chosen ?? loaded;
  }

  Future<void> setTheme(String code) async {
    final next = normalizeThemeMode(code);
    _chosen = next;
    state = AsyncData(next);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(themePreferenceKey, next);
  }

  /// Call before the Firestore write, with the same stamp stored on the
  /// settings document. Older snapshots do not put the previous theme back.
  String expectEcho(String code, String updatedAt) {
    return _echo.expect(normalizeThemeMode(code), updatedAt);
  }

  void releaseEcho() => _echo.release();

  /// Firestore is the copy that syncs between devices. Apply it when it loads.
  /// [updatedAt] is the settings document's `themeUpdatedAt`.
  Future<void> applyRemote(String code, {String updatedAt = ''}) async {
    final next = normalizeThemeMode(code);
    final shown = _echo.resolve(remoteCode: next, updatedAt: updatedAt);
    if (shown != next) {
      return;
    }
    if (state.asData?.value == next) {
      return;
    }
    await setTheme(next);
  }
}

final appThemeProvider = AsyncNotifierProvider<AppThemeController, String>(
  AppThemeController.new,
);
