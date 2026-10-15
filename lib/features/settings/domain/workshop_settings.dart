import 'package:freezed_annotation/freezed_annotation.dart';

part 'workshop_settings.freezed.dart';
part 'workshop_settings.g.dart';

@freezed
abstract class WorkshopSettings with _$WorkshopSettings {
  const factory WorkshopSettings({
    @Default('SEK') String currencyCode,
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
  }) = _WorkshopSettings;

  factory WorkshopSettings.fromJson(Map<String, dynamic> json) =>
      _$WorkshopSettingsFromJson(json);
}
