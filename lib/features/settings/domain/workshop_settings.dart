import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/app_languages.dart';
import '../../../core/currencies.dart';
import '../../../core/theme_mode.dart';

part 'workshop_settings.freezed.dart';
part 'workshop_settings.g.dart';

/// A settings document saved before workshop setup existed has no flag.
/// Those workshops are already in use, so a missing value counts as done.
Object? readSetupCompleted(Map<dynamic, dynamic> json, String key) {
  if (!json.containsKey(key)) {
    return true;
  }
  return json[key];
}

@freezed
abstract class WorkshopSettings with _$WorkshopSettings {
  const factory WorkshopSettings({
    @JsonKey(readValue: readSetupCompleted) @Default(false) bool setupCompleted,
    /// `sv` when the field is missing, so an existing workshop stays Swedish.
    /// [systemLanguageCode] follows the device language.
    @JsonKey(readValue: readLanguageCode) @Default('sv') String languageCode,
    @JsonKey(readValue: readCurrencyCode) @Default('SEK') String currencyCode,
    /// `system` when the field is missing, so an existing workshop follows
    /// the device until someone picks Light or Dark.
    @JsonKey(readValue: readThemeMode) @Default('system') String themeMode,
    @Default(0) int electricityMinorPerKwh,
    @Default(0) int laborMinorPerHour,
    @Default(3000) int defaultMarkupBasisPoints,
    @Default(2500) int vatBasisPoints,
    @Default(0) int defaultFailureBasisPoints,
    @Default('') String businessName,
    @Default('') String street,
    @Default('') String postalCode,
    @Default('') String city,
    @Default('') String orgNumber,
    @Default('') String phone,
    @Default('') String email,
    @Default(1) int nextQuoteNumber,
    @Default(14) int quoteValidityDays,
    @Default(100) double defaultLowStockGrams,
  }) = _WorkshopSettings;

  factory WorkshopSettings.fromJson(Map<String, dynamic> json) =>
      _$WorkshopSettingsFromJson(json);
}
