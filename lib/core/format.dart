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

/// Same as [formatMinorAmount], with a Swedish decimal comma.
String formatMinorField(int minor) =>
    formatMinorAmount(minor).replaceAll('.', ',');

String formatGrams(double grams) {
  if (grams == grams.roundToDouble()) {
    return '${grams.round()} g';
  }
  return '${grams.toStringAsFixed(1).replaceAll('.', ',')} g';
}

/// A decimal for a text field, with a Swedish comma. Parsers accept it.
String formatDecimalField(double value, {int fractionDigits = 2}) {
  if (value.isNaN || value.isInfinite) {
    return '';
  }
  if (value == value.roundToDouble()) {
    return value.round().toString();
  }
  var text = value.toStringAsFixed(fractionDigits);
  text = text.replaceFirst(RegExp(r'0+$'), '');
  text = text.replaceFirst(RegExp(r'\.$'), '');
  return text.replaceAll('.', ',');
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
String formatIsoDate(String iso) {
  final parsed = DateTime.tryParse(iso);
  if (parsed == null) {
    return iso.length >= 10 ? iso.substring(0, 10) : iso;
  }
  final local = parsed.toLocal();
  final month = local.month.toString().padLeft(2, '0');
  final day = local.day.toString().padLeft(2, '0');
  return '${local.year}-$month-$day';
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

String formatPercent(int basisPoints) {
  final percent = basisPoints / 100;
  final text = percent == percent.roundToDouble()
      ? percent.round().toString()
      : percent.toStringAsFixed(2).replaceAll('.', ',');
  return '$text%';
}
