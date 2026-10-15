/// Parses a decimal amount typed by the user into minor units (öre/cents).
int? parseMinor(String text) {
  final normalized = text.trim().replaceAll(' ', '').replaceAll(',', '.');
  if (normalized.isEmpty) {
    return null;
  }
  final value = double.tryParse(normalized);
  if (value == null || value.isNaN || value.isInfinite || value < 0) {
    return null;
  }
  return (value * 100).round();
}

/// Parses a percent such as "25" or "12.5" into basis points (10000 = 100%).
int? parseBasisPoints(String text) {
  final normalized = text.trim().replaceAll(' ', '').replaceAll(',', '.');
  if (normalized.isEmpty) {
    return null;
  }
  final value = double.tryParse(normalized);
  if (value == null || value.isNaN || value.isInfinite || value < 0) {
    return null;
  }
  return (value * 100).round();
}

double basisPointsToPercent(int basisPoints) => basisPoints / 100;

String basisPointsLabel(int basisPoints) {
  final percent = basisPoints / 100;
  if (percent == percent.roundToDouble()) {
    return percent.round().toString();
  }
  return percent.toStringAsFixed(2);
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
