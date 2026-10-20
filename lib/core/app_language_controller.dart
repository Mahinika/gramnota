import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_languages.dart';

const languagePreferenceKey = 'gramnota_language_code';

/// Workshop language, cached on the device so sign-in uses it before Firestore
/// loads. A cached code is kept. With no cache, the device locale is used when
/// it is shipped, and English otherwise. A Firestore document with no language
/// field still reads as Swedish and replaces this once it loads.
class AppLanguageController extends AsyncNotifier<String> {
  /// A tap or an explicit save that happened while [build] was still reading
  /// the cache. The in-flight read must not put the old value back.
  String? _chosen;

  @override
  Future<String> build() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(languagePreferenceKey);
    final loaded = (stored == null || stored.trim().isEmpty)
        ? languageForDeviceLocale(
            WidgetsBinding.instance.platformDispatcher.locale,
          )
        : stored.trim().toLowerCase() == systemLanguageCode
        ? systemLanguageCode
        : normalizeLanguageCode(stored);
    return _chosen ?? loaded;
  }

  /// Switches the UI immediately without writing the device cache.
  /// The first-run screen uses this so a tap does not count as "already chosen".
  void previewLanguage(String code) {
    final next = _normalizeChoice(code);
    _chosen = next;
    state = AsyncData(next);
  }

  Future<void> setLanguage(String code) async {
    final next = _normalizeChoice(code);
    _chosen = next;
    state = AsyncData(next);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(languagePreferenceKey, next);
  }

  /// Firestore is the copy that syncs between devices. Apply it when it loads.
  Future<void> applyRemote(String code) async {
    final next = _normalizeChoice(code);
    final current = state.asData?.value;
    if (current == next) {
      return;
    }
    await setLanguage(next);
  }
}

String _normalizeChoice(String code) {
  if (code.trim().toLowerCase() == systemLanguageCode) {
    return systemLanguageCode;
  }
  return normalizeLanguageCode(code);
}

final appLanguageProvider = AsyncNotifierProvider<AppLanguageController, String>(
  AppLanguageController.new,
);
