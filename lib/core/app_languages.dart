import 'package:flutter/widgets.dart';

/// Stored when the workshop follows the device language.
const systemLanguageCode = 'system';

/// Existing settings documents have no language field. They stay Swedish.
const defaultLanguageCode = 'sv';

/// Languages shipped with the app, in picker order.
const supportedLanguageCodes = <String>[
  'sv',
  'en',
  'de',
  'nb',
  'da',
  'fi',
  'fr',
  'es',
  'pl',
  'nl',
];

/// Endonym shown in the language list so a user can find their language
/// even when the rest of the UI is in another language.
const languageEndonyms = <String, String>{
  'sv': 'Svenska',
  'en': 'English',
  'de': 'Deutsch',
  'nb': 'Norsk',
  'da': 'Dansk',
  'fi': 'Suomi',
  'fr': 'Français',
  'es': 'Español',
  'pl': 'Polski',
  'nl': 'Nederlands',
};

/// Missing or blank language on a saved workshop stays Swedish.
/// [systemLanguageCode] is kept so an explicit "system default" survives.
Object? readLanguageCode(Map<dynamic, dynamic> json, String key) {
  if (!json.containsKey(key)) {
    return defaultLanguageCode;
  }
  final value = json[key];
  if (value is! String || value.trim().isEmpty) {
    return defaultLanguageCode;
  }
  final code = value.trim().toLowerCase();
  if (code == systemLanguageCode) {
    return systemLanguageCode;
  }
  return normalizeLanguageCode(code);
}

/// Maps a stored or device code onto a shipped language.
/// Unknown codes become Swedish.
String normalizeLanguageCode(String raw) {
  final code = raw.trim().toLowerCase().replaceAll('_', '-');
  if (code == systemLanguageCode) {
    return systemLanguageCode;
  }
  final language = code.split('-').first;
  if (language == 'no' || language == 'nn') {
    return 'nb';
  }
  if (supportedLanguageCodes.contains(language)) {
    return language;
  }
  return defaultLanguageCode;
}

/// Explicit workshop language, or null when the device language should win.
Locale? localeForLanguageSetting(String languageCode) {
  if (languageCode == systemLanguageCode) {
    return null;
  }
  return Locale(normalizeLanguageCode(languageCode));
}

/// Picks a shipped locale. An unsupported device language falls back to Swedish.
Locale resolveSupportedLocale(Locale? device, Iterable<Locale> supported) {
  final available = supported.map((locale) => locale.languageCode).toSet();
  if (device != null) {
    final requested = normalizeLanguageCode(device.languageCode);
    if (available.contains(requested)) {
      return Locale(requested);
    }
  }
  if (available.contains(defaultLanguageCode)) {
    return const Locale(defaultLanguageCode);
  }
  return supported.isEmpty ? const Locale(defaultLanguageCode) : supported.first;
}
