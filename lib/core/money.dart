import 'format.dart';

/// Parses a decimal amount typed by the user into minor units (öre/cents).
///
/// Accepts a comma or a dot, and spaces used as thousands separators.
/// Hundredths are taken from the digits, so "19.99" and "1,005" do not
/// depend on binary floating point.
int? parseMinor(String text) => _parseHundredths(text);

/// Parses a percent such as "25" or "12,5" into basis points (10000 = 100%).
int? parseBasisPoints(String text) => _parseHundredths(text);

int? _parseHundredths(String text) {
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
  normalized = _decimalNormalized(normalized);
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

/// The last of `.` and `,` is the decimal mark when both appear
/// (`1.234,50` and `1,234.50`). A single separator stays a decimal mark,
/// which is how `1,005` already rounds to 1.01.
String _decimalNormalized(String text) {
  final lastComma = text.lastIndexOf(',');
  final lastDot = text.lastIndexOf('.');
  if (lastComma >= 0 && lastDot >= 0) {
    if (lastComma > lastDot) {
      return text.replaceAll('.', '').replaceAll(',', '.');
    }
    return text.replaceAll(',', '');
  }
  return text.replaceAll(',', '.');
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
