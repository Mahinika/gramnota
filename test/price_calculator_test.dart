import 'package:flutter_test/flutter_test.dart';
import 'package:printprice/features/pricing/domain/price_calculator.dart';

void main() {
  const calculator = PriceCalculator();

  test('breaks a one-unit job into every cost line', () {
    final breakdown = calculator.calculate(
      const PriceInput(
        materials: [MaterialUse(grams: 100, pricePerKgMinor: 20000)],
        powerWatts: 100,
        printTimeSeconds: 3600,
        electricityMinorPerKwh: 200,
        purchasePriceMinor: 1000000,
        lifetimeHours: 10000,
        maintenanceMinorPerHour: 0,
        failureBasisPoints: 1000,
        prepMinutes: 0,
        postMinutes: 30,
        laborMinorPerHour: 60000,
        extraMinors: [500],
        markupBasisPoints: 5000,
        vatBasisPoints: 2500,
        quantity: 1,
      ),
    );

    expect(breakdown.materialMinor, 2000);
    expect(breakdown.electricityMinor, 20);
    expect(breakdown.machineMinor, 100);
    expect(breakdown.failureMinor, 212);
    expect(breakdown.laborMinor, 30000);
    expect(breakdown.extrasMinor, 500);
    expect(breakdown.costMinor, 32832);
    expect(breakdown.markupMinor, 16416);
    expect(breakdown.netMinor, 49248);
    expect(breakdown.vatMinor, 12312);
    expect(breakdown.totalMinor, 61560);
    expect(breakdown.perUnitMinor, 61560);
  });

  test('scales production and labor with quantity and leaves extras flat', () {
    final breakdown = calculator.calculate(
      const PriceInput(
        materials: [MaterialUse(grams: 100, pricePerKgMinor: 20000)],
        powerWatts: 100,
        printTimeSeconds: 3600,
        electricityMinorPerKwh: 200,
        purchasePriceMinor: 1000000,
        lifetimeHours: 10000,
        maintenanceMinorPerHour: 0,
        failureBasisPoints: 1000,
        prepMinutes: 0,
        postMinutes: 30,
        laborMinorPerHour: 60000,
        extraMinors: [500],
        markupBasisPoints: 0,
        vatBasisPoints: 0,
        quantity: 2,
      ),
    );

    expect(breakdown.materialMinor, 4000);
    expect(breakdown.electricityMinor, 40);
    expect(breakdown.machineMinor, 200);
    expect(breakdown.failureMinor, 424);
    expect(breakdown.laborMinor, 60000);
    expect(breakdown.extrasMinor, 500);
    expect(breakdown.quantity, 2);
    expect(breakdown.perUnitMinor, breakdown.totalMinor ~/ 2);
  });

  test('treats a zero lifetime as no depreciation', () {
    final breakdown = calculator.calculate(
      const PriceInput(
        materials: [],
        powerWatts: 0,
        printTimeSeconds: 3600,
        electricityMinorPerKwh: 0,
        purchasePriceMinor: 500000,
        lifetimeHours: 0,
        maintenanceMinorPerHour: 100,
        failureBasisPoints: 0,
        prepMinutes: 0,
        postMinutes: 0,
        laborMinorPerHour: 0,
        extraMinors: [],
        markupBasisPoints: 0,
        vatBasisPoints: 0,
        quantity: 1,
      ),
    );

    expect(breakdown.machineMinor, 100);
  });
}
