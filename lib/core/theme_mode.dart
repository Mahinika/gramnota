import 'package:flutter/material.dart';

/// Stored when the workshop follows the device theme.
const systemThemeCode = 'system';

const lightThemeCode = 'light';

const darkThemeCode = 'dark';

/// Existing settings documents have no theme field. They follow the device.
const defaultThemeCode = systemThemeCode;

const themeModeCodes = <String>[
  systemThemeCode,
  lightThemeCode,
  darkThemeCode,
];

/// Missing or unknown values stay on the system theme.
Object? readThemeMode(Map<dynamic, dynamic> json, String key) {
  final raw = json[key];
  if (raw == null) {
    return defaultThemeCode;
  }
  return normalizeThemeMode('$raw');
}

String normalizeThemeMode(String raw) {
  final code = raw.trim().toLowerCase();
  if (themeModeCodes.contains(code)) {
    return code;
  }
  return defaultThemeCode;
}

ThemeMode themeModeForSetting(String code) {
  return switch (normalizeThemeMode(code)) {
    lightThemeCode => ThemeMode.light,
    darkThemeCode => ThemeMode.dark,
    _ => ThemeMode.system,
  };
}
