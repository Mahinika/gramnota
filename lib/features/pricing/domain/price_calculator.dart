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

double _materialOne(MaterialUse material) {
  if (material.grams <= 0 || material.pricePerKgMinor <= 0) {
    return 0;
  }
  return material.grams / 1000 * material.pricePerKgMinor;
}

class PriceCalculator {
  const PriceCalculator();

  PriceBreakdown calculate(PriceInput input) {
    final quantity = input.quantity < 1 ? 1 : input.quantity;
    final seconds = input.printTimeSeconds < 0 ? 0 : input.printTimeSeconds;
    final watts = input.powerWatts < 0 ? 0 : input.powerWatts;
    final hours = seconds / 3600;
    final failureBasisPoints = input.failureBasisPoints < 0
        ? 0
        : input.failureBasisPoints;
    final markupBasisPoints = input.markupBasisPoints < 0
        ? 0
        : input.markupBasisPoints;
    final vatBasisPoints = input.vatBasisPoints < 0
        ? 0
        : input.vatBasisPoints;
    final prepMinutes = input.prepMinutes < 0 ? 0 : input.prepMinutes;
    final postMinutes = input.postMinutes < 0 ? 0 : input.postMinutes;
    final laborMinorPerHour = input.laborMinorPerHour < 0
        ? 0
        : input.laborMinorPerHour;
    final electricityMinorPerKwh = input.electricityMinorPerKwh < 0
        ? 0
        : input.electricityMinorPerKwh;
    final purchasePriceMinor = input.purchasePriceMinor < 0
        ? 0
        : input.purchasePriceMinor;

    final materialOne = input.materials.fold<double>(
      0,
      (sum, material) => sum + _materialOne(material),
    );
    final materialMinor = (materialOne * quantity).round();

    final electricityOne = watts / 1000 * hours * electricityMinorPerKwh;
    final electricityMinor = (electricityOne * quantity).round();

    final lifetime = input.lifetimeHours <= 0 ? 0.0 : input.lifetimeHours;
    final depreciationPerHour = lifetime == 0
        ? 0.0
        : purchasePriceMinor / lifetime;
    final maintenance = input.maintenanceMinorPerHour < 0
        ? 0
        : input.maintenanceMinorPerHour;
    final machineOne = hours * (depreciationPerHour + maintenance);
    final machineMinor = (machineOne * quantity).round();

    final failureBase = materialMinor + electricityMinor + machineMinor;
    final failureMinor = (failureBase * failureBasisPoints / 10000).round();

    final prepLaborMinor =
        (prepMinutes / 60 * laborMinorPerHour).round();
    final postLaborMinor =
        (postMinutes / 60 * laborMinorPerHour * quantity).round();
    final laborMinor = prepLaborMinor + postLaborMinor;

    final extrasMinor = input.extraMinors.fold<int>(0, (sum, cost) => sum + cost);
    final costMinor =
        materialMinor +
        electricityMinor +
        machineMinor +
        failureMinor +
        laborMinor +
        extrasMinor;
    final markupMinor = (costMinor * markupBasisPoints / 10000).round();
    final netMinor = costMinor + markupMinor;
    final vatMinor = (netMinor * vatBasisPoints / 10000).round();
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
