import 'price_breakdown.dart';

class MaterialUse {
  const MaterialUse({required this.grams, required this.pricePerKgMinor});

  final double grams;
  final int pricePerKgMinor;
}

class PriceInput {
  const PriceInput({
    required this.materials,
    required this.powerWatts,
    required this.printTimeSeconds,
    required this.electricityMinorPerKwh,
    required this.purchasePriceMinor,
    required this.lifetimeHours,
    required this.maintenanceMinorPerHour,
    required this.failureBasisPoints,
    required this.prepMinutes,
    required this.postMinutes,
    required this.laborMinorPerHour,
    required this.extraMinors,
    required this.markupBasisPoints,
    required this.vatBasisPoints,
    required this.quantity,
  });

  final List<MaterialUse> materials;
  final int powerWatts;
  final int printTimeSeconds;
  final int electricityMinorPerKwh;
  final int purchasePriceMinor;
  final double lifetimeHours;
  final int maintenanceMinorPerHour;
  final int failureBasisPoints;
  final int prepMinutes;
  final int postMinutes;
  final int laborMinorPerHour;
  final List<int> extraMinors;
  final int markupBasisPoints;
  final int vatBasisPoints;
  final int quantity;
}

class PriceCalculator {
  const PriceCalculator();

  PriceBreakdown calculate(PriceInput input) {
    final quantity = input.quantity < 1 ? 1 : input.quantity;
    final hours = input.printTimeSeconds / 3600;

    final materialOne = input.materials.fold<double>(
      0,
      (sum, material) =>
          sum + material.grams / 1000 * material.pricePerKgMinor,
    );
    final materialMinor = (materialOne * quantity).round();

    final electricityOne =
        input.powerWatts / 1000 * hours * input.electricityMinorPerKwh;
    final electricityMinor = (electricityOne * quantity).round();

    final depreciationPerHour = input.lifetimeHours <= 0
        ? 0.0
        : input.purchasePriceMinor / input.lifetimeHours;
    final machineOne =
        hours * (depreciationPerHour + input.maintenanceMinorPerHour);
    final machineMinor = (machineOne * quantity).round();

    final failureBase = materialMinor + electricityMinor + machineMinor;
    final failureMinor = (failureBase * input.failureBasisPoints / 10000)
        .round();

    final laborOne =
        (input.prepMinutes + input.postMinutes) /
        60 *
        input.laborMinorPerHour;
    final laborMinor = (laborOne * quantity).round();

    final extrasMinor = input.extraMinors.fold<int>(0, (sum, cost) => sum + cost);
    final costMinor =
        materialMinor +
        electricityMinor +
        machineMinor +
        failureMinor +
        laborMinor +
        extrasMinor;
    final markupMinor = (costMinor * input.markupBasisPoints / 10000).round();
    final netMinor = costMinor + markupMinor;
    final vatMinor = (netMinor * input.vatBasisPoints / 10000).round();
    final totalMinor = netMinor + vatMinor;
    final perUnitMinor = (totalMinor / quantity).round();

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
      perUnitMinor: perUnitMinor,
      quantity: quantity,
    );
  }
}
