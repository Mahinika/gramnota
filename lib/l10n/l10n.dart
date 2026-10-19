import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';

import '../core/app_languages.dart';
import '../core/format.dart';
import 'app_localizations.dart';

export 'app_localizations.dart';

extension GramnotaLocalizations on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this);

  String get formattingLocale => Localizations.localeOf(this).toString();

  String money(int minor, String currencyCode) =>
      formatMoney(minor, currencyCode, locale: formattingLocale);

  String dateText(String iso) => formatIsoDate(iso, locale: formattingLocale);

  String gramsText(double grams) => formatGrams(grams, locale: formattingLocale);

  String percentText(int basisPoints) =>
      formatPercent(basisPoints, locale: formattingLocale);
}

/// Localizations for code that has no [BuildContext].
///
/// The app sets [Intl.defaultLocale] from the workshop language. Tests that
/// leave it unset get English, which matches the existing English assertions.
AppLocalizations get activeGramnotaL10n {
  final raw = (Intl.defaultLocale ?? 'en').trim();
  final language = raw.split(RegExp(r'[_-]')).first;
  final code = language == systemLanguageCode
      ? defaultLanguageCode
      : normalizeLanguageCode(language);
  return lookupAppLocalizations(Locale(code));
}
