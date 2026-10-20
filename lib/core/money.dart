import 'currencies.dart';
import 'format.dart';

/// Languages whose grouping mark is a dot (`1.249` is one thousand).
const _dotGroupingLanguages = {'de', 'nl', 'es', 'da', 'nb', 'no'};

/// Parses a decimal amount typed by the user into stored minor units.
///
/// Storage stays hundredths (`100` is one major unit) so existing SEK
/// quotes do not move. [fractionDigits] `0` (yen, króna) still stores
/// hundredths of a whole unit: `20` becomes `2000`. A dot used as a
/// thousands separator in [locale] (`de`, `nl`, `es`, `da`, `nb`) is
/// grouping, so `1.249` is 1249. Without a locale, a single separator
/// stays a decimal mark, which is how `1,005` rounds to 1.01.
int? parseMinor(String text, {String? locale, int fractionDigits = 2}) =>
    _parseHundredths(text, locale: locale, fractionDigits: fractionDigits);

/// Typed money for [currencyCode]. Zero-decimal currencies store hundredths
/// of a whole unit so an existing SEK document is unchanged.
int? parseMoneyInput(
  String text, {
  required String currencyCode,
  String? locale,
}) {
  return parseMinor(
    text,
    locale: locale,
    fractionDigits: currencyFractionDigits(currencyCode),
  );
}

/// Parses a percent such as "25" or "12,5" into basis points (10000 = 100%).
int? parseBasisPoints(String text) => _parseHundredths(text);

/// Empty input is one print. Zero and anything that is not a positive
/// whole number are rejected so the quote is not priced as a single unit.
int? readQuoteQuantity(String text) {
  final trimmed = text.trim();
  if (trimmed.isEmpty) {
    return 1;
  }
  final value = int.tryParse(trimmed);
  if (value == null || value < 1) {
    return null;
  }
  return value;
}

int? _parseHundredths(
  String text, {
  String? locale,
  int fractionDigits = 2,
}) {
  var normalized = text
      .trim()
      .replaceAll('\u00a0', '')
      .replaceAll('\u202f', '')
      .replaceAll(' ', '');
  if (normalized.isEmpty) {
    return null;
  }
  if (normalized.startsWith('+')) {
    normalized = normalized.substring(1);
  }
  if (normalized.startsWith('-') || normalized.isEmpty) {
    return null;
  }
  normalized = _decimalNormalized(normalized, locale);
  final parts = normalized.split('.');
  if (parts.length > 2) {
    return null;
  }
  final wholeText = parts[0].isEmpty ? '0' : parts[0];
  if (!RegExp(r'^\d+$').hasMatch(wholeText)) {
    return null;
  }
  // Twelve digits is a trillion currency units. Longer input is rejected
  // so a pasted wall of digits cannot throw or lose precision on the web.
  if (wholeText.length > 12) {
    return null;
  }
  final whole = int.parse(wholeText);
  final frac = parts.length == 2 ? parts[1] : '';
  if (frac.isNotEmpty && !RegExp(r'^\d+$').hasMatch(frac)) {
    return null;
  }
  if (fractionDigits <= 0) {
    final major = frac.isEmpty ? whole : _roundMajor(whole, frac);
    return major * 100;
  }
  if (frac.isEmpty) {
    return whole * 100;
  }
  final head = frac.length >= 2 ? frac.substring(0, 2) : frac.padRight(2, '0');
  var cents = int.parse(head);
  final roundUp = frac.length > 2 && int.parse(frac[2]) >= 5;
  if (roundUp) {
    cents += 1;
  }
  if (cents == 100) {
    return (whole + 1) * 100;
  }
  return whole * 100 + cents;
}

int _roundMajor(int whole, String frac) {
  if (frac.isEmpty) {
    return whole;
  }
  final roundUp = int.parse(frac[0]) >= 5;
  return roundUp ? whole + 1 : whole;
}

/// The last of `.` and `,` is the decimal mark when both appear
/// (`1.234,50` and `1,234.50`). A single separator stays a decimal mark,
/// which is how `1,005` already rounds to 1.01, unless [locale] groups
/// thousands with a dot.
String _decimalNormalized(String text, [String? locale]) {
  final lastComma = text.lastIndexOf(',');
  final lastDot = text.lastIndexOf('.');
  if (lastComma >= 0 && lastDot >= 0) {
    if (lastComma > lastDot) {
      return text.replaceAll('.', '').replaceAll(',', '.');
    }
    return text.replaceAll(',', '');
  }
  if (lastDot >= 0 && lastComma < 0 && _dotGroupsThousands(text, locale)) {
    return text.replaceAll('.', '');
  }
  return text.replaceAll(',', '.');
}

bool _dotGroupsThousands(String text, String? locale) {
  if (locale == null || locale.trim().isEmpty) {
    return false;
  }
  final language = locale.trim().toLowerCase().split(RegExp(r'[_-]')).first;
  if (!_dotGroupingLanguages.contains(language)) {
    return false;
  }
  final parts = text.split('.');
  if (parts.length < 2 || parts.first.isEmpty) {
    return false;
  }
  if (!RegExp(r'^\d+$').hasMatch(parts.first)) {
    return false;
  }
  for (final part in parts.skip(1)) {
    if (!RegExp(r'^\d{3}$').hasMatch(part)) {
      return false;
    }
  }
  return true;
}

double basisPointsToPercent(int basisPoints) => basisPoints / 100;

String basisPointsLabel(int basisPoints, {String? locale}) {
  final percent = basisPoints / 100;
  if (percent == percent.roundToDouble()) {
    return percent.round().toString();
  }
  return percent.toStringAsFixed(2).replaceAll('.', decimalSeparator(locale));
}

int? parsePositiveInt(String text) {
  final value = int.tryParse(text.trim());
  if (value == null || value < 0) {
    return null;
  }
  return value;
}

double? parseNonNegativeDouble(String text) {
  final normalized = text.trim().replaceAll(' ', '').replaceAll(',', '.');
  if (normalized.isEmpty) {
    return null;
  }
  final value = double.tryParse(normalized);
  if (value == null || value.isNaN || value.isInfinite || value < 0) {
    return null;
  }
  return value;
}
