import '../../../core/app_languages.dart';
import '../../../core/currencies.dart';
import '../../../core/theme_mode.dart';
import 'workshop_settings.dart';

/// VAT for a workshop created from the short setup.
/// Swedish keeps the historical 25% moms default. Every other language
/// starts at 0% because most hobby sellers are not VAT-registered.
/// Documents that omit the field still decode as 25%.
int defaultVatBasisPointsForLanguage(String languageCode) {
  final language = languageCode
      .trim()
      .toLowerCase()
      .replaceAll('_', '-')
      .split('-')
      .first;
  if (language == 'sv') {
    return 2500;
  }
  return 0;
}

/// Settings written when workshop setup finishes or is skipped.
/// Profile, labor, failure, markup, validity, and the quote counter
/// stay at these defaults until someone edits Settings.
WorkshopSettings newWorkshopSettings({
  required String languageCode,
  required String currencyCode,
  int nextQuoteNumber = 1,
  String email = '',
  int electricityMinorPerKwh = 0,
  String themeMode = defaultThemeCode,
}) {
  final language = languageCode.trim().toLowerCase() == systemLanguageCode
      ? systemLanguageCode
      : normalizeLanguageCode(languageCode);
  return WorkshopSettings(
    setupCompleted: true,
    languageCode: language,
    currencyCode: normalizeCurrencyCode(currencyCode),
    themeMode: normalizeThemeMode(themeMode),
    electricityMinorPerKwh: electricityMinorPerKwh,
    laborMinorPerHour: 0,
    defaultMarkupBasisPoints: 3000,
    vatBasisPoints: defaultVatBasisPointsForLanguage(language),
    defaultFailureBasisPoints: 0,
    email: email.trim(),
    nextQuoteNumber: nextQuoteNumber,
    quoteValidityDays: 14,
  );
}
