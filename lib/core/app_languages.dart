import 'package:flutter/widgets.dart';

/// Stored when the workshop follows the device language.
const systemLanguageCode = 'system';

/// Existing settings documents have no language field. They stay Swedish.
const defaultLanguageCode = 'sv';

/// Languages shipped with the app, in the Settings picker order.
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

/// First-run list. Native names stay readable before the UI language changes.
const onboardingLanguageCodes = <String>[
  'sv',
  'en',
  'de',
  'fr',
  'pl',
  'fi',
  'nb',
  'da',
  'nl',
  'es',
];

/// Flag shown beside the native name on the first-run language screen.
const languageFlags = <String, String>{
  'sv': '🇸🇪',
  'en': '🇬🇧',
  'de': '🇩🇪',
  'fr': '🇫🇷',
  'pl': '🇵🇱',
  'fi': '🇫🇮',
  'nb': '🇳🇴',
  'da': '🇩🇰',
  'nl': '🇳🇱',
  'es': '🇪🇸',
};

String languageFlag(String languageCode) =>
    languageFlags[languageCode] ?? languageFlags['en']!;

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

/// First launch, when nothing is cached. Unsupported device languages use English.
/// A saved workshop with no language field still uses [defaultLanguageCode].
const firstRunFallbackLanguageCode = 'en';

/// Device language for a fresh install. `no` and `nn` map to `nb`.
/// Unknown languages, including a missing locale, become English.
String languageForDeviceLocale(Locale? device) {
  if (device == null) {
    return firstRunFallbackLanguageCode;
  }
  final language = device.languageCode
      .trim()
      .toLowerCase()
      .replaceAll('_', '-')
      .split('-')
      .first;
  if (language.isEmpty) {
    return firstRunFallbackLanguageCode;
  }
  if (language == 'no' || language == 'nn') {
    return 'nb';
  }
  if (supportedLanguageCodes.contains(language)) {
    return language;
  }
  return firstRunFallbackLanguageCode;
}

/// Maps a stored or device code onto a shipped language.
/// Unknown codes become Swedish so an old workshop does not change language.
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
