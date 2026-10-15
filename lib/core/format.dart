import 'package:intl/intl.dart';

String formatMoney(int minor, String currencyCode) {
  final format = NumberFormat.simpleCurrency(name: currencyCode);
  return format.format(minor / 100);
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
