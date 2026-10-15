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

/// Adds breakdowns that were already rounded per print.
///
/// One print is returned as saved. Several prints sum the money fields.
/// The quote then has no single unit price: [PriceBreakdown.perUnitMinor] is 0.
PriceBreakdown sumBreakdowns(List<PriceBreakdown> parts) {
  if (parts.isEmpty) {
    return PriceBreakdown.zero();
  }
  if (parts.length == 1) {
    return parts.single;
  }
  var materialMinor = 0;
  var electricityMinor = 0;
  var machineMinor = 0;
  var failureMinor = 0;
  var laborMinor = 0;
  var extrasMinor = 0;
  var costMinor = 0;
  var markupMinor = 0;
  var netMinor = 0;
  var vatMinor = 0;
  var totalMinor = 0;
  for (final part in parts) {
    materialMinor += part.materialMinor;
    electricityMinor += part.electricityMinor;
    machineMinor += part.machineMinor;
    failureMinor += part.failureMinor;
    laborMinor += part.laborMinor;
    extrasMinor += part.extrasMinor;
    costMinor += part.costMinor;
    markupMinor += part.markupMinor;
    netMinor += part.netMinor;
    vatMinor += part.vatMinor;
    totalMinor += part.totalMinor;
  }
  return PriceBreakdown(
    materialMinor: materialMinor,
    electricityMinor: electricityMinor,
    machineMinor: machineMinor,
    failureMinor: failureMinor,
    laborMinor: laborMinor,
    extrasMinor: extrasMinor,
    costMinor: costMinor,
    markupMinor: markupMinor,
    netMinor: netMinor,
    vatMinor: vatMinor,
    totalMinor: totalMinor,
    perUnitMinor: 0,
    quantity: 1,
  );
}
