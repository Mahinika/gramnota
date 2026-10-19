/// A slicer export the calculator can read for time and filament weight.
bool isGcodeFileName(String name) {
  final base = _baseName(name).toLowerCase();
  return base.endsWith('.gcode') || base.endsWith('.gco');
}

bool isThreeMfFileName(String name) {
  return _baseName(name).toLowerCase().endsWith('.3mf');
}

bool isSliceFileName(String name) {
  return isGcodeFileName(name) || isThreeMfFileName(name);
}

String sliceFileStem(String name) {
  final base = _baseName(name);
  final dot = base.lastIndexOf('.');
  if (dot <= 0) {
    return base;
  }
  return base.substring(0, dot);
}

String _baseName(String name) {
  final trimmed = name.trim().split('?').first;
  final parts = trimmed.split(RegExp(r'[\\/]'));
  return parts.isEmpty ? '' : parts.last;
}
