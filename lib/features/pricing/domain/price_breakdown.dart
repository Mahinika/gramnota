import 'package:freezed_annotation/freezed_annotation.dart';

part 'price_breakdown.freezed.dart';
part 'price_breakdown.g.dart';

@freezed
abstract class PriceBreakdown with _$PriceBreakdown {
  const factory PriceBreakdown({
    required int materialMinor,
    required int electricityMinor,
    required int machineMinor,
    required int failureMinor,
    required int laborMinor,
    required int extrasMinor,
    required int costMinor,
    required int markupMinor,
    required int netMinor,
    required int vatMinor,
    required int totalMinor,
    required int perUnitMinor,
    required int quantity,
  }) = _PriceBreakdown;

  factory PriceBreakdown.fromJson(Map<String, dynamic> json) =>
      _$PriceBreakdownFromJson(json);

  factory PriceBreakdown.zero() => const PriceBreakdown(
    materialMinor: 0,
    electricityMinor: 0,
    machineMinor: 0,
    failureMinor: 0,
    laborMinor: 0,
    extrasMinor: 0,
    costMinor: 0,
    markupMinor: 0,
    netMinor: 0,
    vatMinor: 0,
    totalMinor: 0,
    perUnitMinor: 0,
    quantity: 1,
  );
}
