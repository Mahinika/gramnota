import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';

import 'currencies.dart';

bool _datesReady = false;

/// Loads CLDR date symbols for every locale. Safe to call more than once.
void ensureGramnotaDateFormatting() {
  if (_datesReady) {
    return;
  }
  initializeDateFormatting();
  _datesReady = true;
}

/// Formats [minor] hundredths of a major unit with [NumberFormat] for [locale].
///
/// Storage is always hundredths (100 = 1), including for currencies whose
/// cash has fewer or more decimal places. Display uses the currency's own
/// fraction digits, symbol, and position. There is no exchange conversion.
String formatMoney(int minor, String currencyCode, {String? locale}) {
  final code = normalizeCurrencyCode(currencyCode);
  final loc = _formattingLocale(locale);
  final digits = currencyFractionDigits(code);
  // ISK and SEK both render as "kr". The code keeps an Icelandic amount
  // from looking like Swedish kronor. Storage is still hundredths.
  if (code == 'ISK') {
    final format = NumberFormat.currency(
      locale: loc,
      name: code,
      symbol: 'ISK',
      decimalDigits: digits,
    );
    return format.format(minor / 100);
  }
  final format = NumberFormat.simpleCurrency(
    locale: loc,
    name: code,
    decimalDigits: digits,
  );
  return format.format(minor / 100);
}

String _formattingLocale(String? locale) {
  final raw = (locale ?? Intl.defaultLocale ?? 'sv').trim();
  if (raw.isEmpty) {
    return 'sv';
  }
  return raw;
}

/// Major units for a text field, with two decimals only when öre remain.
/// The decimal mark is a dot so [NumberFormat] can parse it. Seller-facing
/// fields use [formatMinorField].
String formatMinorAmount(int minor) {
  final sign = minor < 0 ? '-' : '';
  final abs = minor.abs();
  final major = abs ~/ 100;
  final cents = abs % 100;
  if (cents == 0) {
    return '$sign$major';
  }
  return '$sign$major.${cents.toString().padLeft(2, '0')}';
}

/// Same as [formatMinorAmount], using the locale decimal separator.
/// The default locale is Swedish, so existing fields keep a comma.
String formatMinorField(int minor, {String? locale}) =>
    formatMinorAmount(minor).replaceAll('.', decimalSeparator(locale));

String decimalSeparator([String? locale]) {
  return NumberFormat.decimalPattern(_formattingLocale(locale)).symbols.DECIMAL_SEP;
}

String formatGrams(double grams, {String? locale}) {
  if (grams == grams.roundToDouble()) {
    return '${grams.round()} g';
  }
  final format = NumberFormat.decimalPattern(_formattingLocale(locale))
    ..minimumFractionDigits = 1
    ..maximumFractionDigits = 1;
  return '${format.format(grams)} g';
}

/// A decimal for a text field. Parsers accept a comma or a dot.
String formatDecimalField(double value, {int fractionDigits = 2, String? locale}) {
  if (value.isNaN || value.isInfinite) {
    return '';
  }
  if (value == value.roundToDouble()) {
    return value.round().toString();
  }
  var text = value.toStringAsFixed(fractionDigits);
  text = text.replaceFirst(RegExp(r'0+$'), '');
  text = text.replaceFirst(RegExp(r'\.$'), '');
  return text.replaceAll('.', decimalSeparator(locale));
}

/// Noon UTC on a calendar day. The date stays the same from UTC−12 to UTC+12,
/// so a deposit picked as 15 March stays in March on Home.
String calendarDayStamp(DateTime day) {
  return DateTime.utc(day.year, day.month, day.day, 12).toIso8601String();
}

/// The calendar day stored by [calendarDayStamp]. Other timestamps use the
/// device zone via [formatIsoDate].
DateTime? calendarDayOf(String iso) {
  final parsed = DateTime.tryParse(iso);
  if (parsed == null) {
    return null;
  }
  final utc = parsed.toUtc();
  return DateTime(utc.year, utc.month, utc.day);
}

/// Calendar date for a stored UTC timestamp, in the device's local zone.
///
/// Uses the locale's medium date (for example 2 Nov 2026 or 2 nov. 2026).
String formatIsoDate(String iso, {String? locale}) {
  final parsed = DateTime.tryParse(iso);
  if (parsed == null) {
    return iso.length >= 10 ? iso.substring(0, 10) : iso;
  }
  final local = parsed.toLocal();
  ensureGramnotaDateFormatting();
  return DateFormat.yMMMd(_formattingLocale(locale)).format(local);
}

String formatDuration(int seconds) {
  final safe = seconds < 0 ? 0 : seconds;
  if (safe == 0) {
    return '0m';
  }
  final hours = safe ~/ 3600;
  final minutes = (safe % 3600) ~/ 60;
  final remainder = safe % 60;
  if (hours == 0 && minutes == 0) {
    return '${remainder}s';
  }
  if (hours == 0) {
    return remainder == 0 ? '${minutes}m' : '${minutes}m ${remainder}s';
  }
  final clock = '${hours}h ${minutes}m';
  return remainder == 0 ? clock : '$clock ${remainder}s';
}

String formatPercent(int basisPoints, {String? locale}) {
  final percent = basisPoints / 100;
  final text = percent == percent.roundToDouble()
      ? percent.round().toString()
      : percent.toStringAsFixed(2).replaceAll('.', decimalSeparator(locale));
  return '$text%';
}
