import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'app_languages.dart';

const languagePreferenceKey = 'gramnota_language_code';

/// Workshop language, cached on the device so sign-in uses it before Firestore
/// loads. Missing cache and missing settings both stay Swedish.
class AppLanguageController extends AsyncNotifier<String> {
  @override
  Future<String> build() async {
    final prefs = await SharedPreferences.getInstance();
    final stored = prefs.getString(languagePreferenceKey);
    if (stored == null || stored.trim().isEmpty) {
      return defaultLanguageCode;
    }
    if (stored.trim().toLowerCase() == systemLanguageCode) {
      return systemLanguageCode;
    }
    return normalizeLanguageCode(stored);
  }

  Future<void> setLanguage(String code) async {
    final next = code.trim().toLowerCase() == systemLanguageCode
        ? systemLanguageCode
        : normalizeLanguageCode(code);
    state = AsyncData(next);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(languagePreferenceKey, next);
  }

  /// Firestore is the copy that syncs between devices. Apply it when it loads.
  Future<void> applyRemote(String code) async {
    final next = code.trim().toLowerCase() == systemLanguageCode
        ? systemLanguageCode
        : normalizeLanguageCode(code);
    final current = state.asData?.value;
    if (current == next) {
      return;
    }
    await setLanguage(next);
  }
}

final appLanguageProvider = AsyncNotifierProvider<AppLanguageController, String>(
  AppLanguageController.new,
);
