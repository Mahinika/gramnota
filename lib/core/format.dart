import 'package:intl/intl.dart';

String formatMoney(int minor, String currencyCode) {
  final code = currencyCode.trim().isEmpty
      ? 'SEK'
      : currencyCode.trim().toUpperCase();
  if (code == 'SEK' || code == 'NOK' || code == 'DKK') {
    return _nordicMoney(minor);
  }
  final format = NumberFormat.simpleCurrency(name: code);
  return format.format(num.parse(formatMinorAmount(minor)));
}

String _nordicMoney(int minor) {
  final sign = minor < 0 ? '-' : '';
  final abs = minor.abs();
  final major = abs ~/ 100;
  final cents = (abs % 100).toString().padLeft(2, '0');
  final digits = major.toString();
  final groups = StringBuffer();
  for (var i = 0; i < digits.length; i++) {
    if (i > 0 && (digits.length - i) % 3 == 0) {
      groups.write('\u00a0');
    }
    groups.write(digits[i]);
  }
  return '$sign$groups,$cents kr';
}

/// Major units for a text field, with two decimals only when öre remain.
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

String formatGrams(double grams) {
  if (grams == grams.roundToDouble()) {
    return '${grams.round()} g';
  }
  return '${grams.toStringAsFixed(1)} g';
}

String formatDuration(int seconds) {
  final safe = seconds < 0 ? 0 : seconds;
  final hours = safe ~/ 3600;
  final minutes = (safe % 3600) ~/ 60;
  if (hours == 0) {
    return '${minutes}m';
  }
  return '${hours}h ${minutes}m';
}

String formatPercent(int basisPoints) {
  final percent = basisPoints / 100;
  final text = percent == percent.roundToDouble()
      ? percent.round().toString()
      : percent.toStringAsFixed(2);
  return '$text%';
}
