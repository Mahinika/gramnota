import 'package:flutter_test/flutter_test.dart';
import 'package:gramnota/features/pricing/domain/price_breakdown.dart';
import 'package:gramnota/features/pricing/domain/price_calculator.dart';

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

  test('charges prep once and post per unit', () {
    final breakdown = calculator.calculate(
      const PriceInput(
        materials: [],
        powerWatts: 0,
        printTimeSeconds: 0,
        electricityMinorPerKwh: 0,
        purchasePriceMinor: 0,
        lifetimeHours: 1,
        maintenanceMinorPerHour: 0,
        failureBasisPoints: 0,
        prepMinutes: 15,
        postMinutes: 30,
        laborMinorPerHour: 60000,
        extraMinors: [],
        markupBasisPoints: 0,
        vatBasisPoints: 0,
        quantity: 2,
      ),
    );

    expect(breakdown.laborMinor, 75000);
  });

  test('scales production and post labor with quantity and leaves extras flat', () {
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

  test('sums stored line totals without recalculating them', () {
    final stand = calculator.calculate(
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
    final clip = calculator.calculate(
      const PriceInput(
        materials: [MaterialUse(grams: 10, pricePerKgMinor: 10000)],
        powerWatts: 0,
        printTimeSeconds: 0,
        electricityMinorPerKwh: 0,
        purchasePriceMinor: 0,
        lifetimeHours: 1,
        maintenanceMinorPerHour: 0,
        failureBasisPoints: 0,
        prepMinutes: 0,
        postMinutes: 0,
        laborMinorPerHour: 0,
        extraMinors: [100],
        markupBasisPoints: 0,
        vatBasisPoints: 0,
        quantity: 3,
      ),
    );

    expect(stand.totalMinor, 61560);
    expect(clip.materialMinor, 300);
    expect(clip.extrasMinor, 100);
    expect(clip.totalMinor, 400);
    expect(clip.perUnitMinor, 133);

    final quote = sumBreakdowns([stand, clip]);
    expect(quote.materialMinor, 2300);
    expect(quote.electricityMinor, 20);
    expect(quote.machineMinor, 100);
    expect(quote.failureMinor, 212);
    expect(quote.laborMinor, 30000);
    expect(quote.extrasMinor, 600);
    expect(quote.costMinor, 33232);
    expect(quote.markupMinor, 16416);
    expect(quote.netMinor, 49648);
    expect(quote.vatMinor, 12312);
    expect(quote.totalMinor, 61960);
    expect(quote.totalMinor, stand.totalMinor + clip.totalMinor);
    expect(quote.perUnitMinor, 0);
    expect(quote.quantity, 1);
    expect(sumBreakdowns([stand]).perUnitMinor, 61560);
    expect(sumBreakdowns([stand]).quantity, 1);
  });

  test('treats quantity below 1 as one print', () {
    final breakdown = calculator.calculate(
      const PriceInput(
        materials: [MaterialUse(grams: 100, pricePerKgMinor: 20000)],
        powerWatts: 0,
        printTimeSeconds: 0,
        electricityMinorPerKwh: 0,
        purchasePriceMinor: 0,
        lifetimeHours: 1,
        maintenanceMinorPerHour: 0,
        failureBasisPoints: 0,
        prepMinutes: 0,
        postMinutes: 0,
        laborMinorPerHour: 0,
        extraMinors: [],
        markupBasisPoints: 0,
        vatBasisPoints: 0,
        quantity: 0,
      ),
    );

    expect(breakdown.quantity, 1);
    expect(breakdown.materialMinor, 2000);
    expect(breakdown.perUnitMinor, 2000);
  });

  test('rounds a half öre up for the unit price', () {
    final breakdown = calculator.calculate(
      const PriceInput(
        materials: [],
        powerWatts: 0,
        printTimeSeconds: 0,
        electricityMinorPerKwh: 0,
        purchasePriceMinor: 0,
        lifetimeHours: 1,
        maintenanceMinorPerHour: 0,
        failureBasisPoints: 0,
        prepMinutes: 0,
        postMinutes: 0,
        laborMinorPerHour: 0,
        extraMinors: [1],
        markupBasisPoints: 0,
        vatBasisPoints: 0,
        quantity: 2,
      ),
    );

    expect(breakdown.totalMinor, 1);
    expect(breakdown.perUnitMinor, 1);
  });

  test('failure ignores labor and extras', () {
    final breakdown = calculator.calculate(
      const PriceInput(
        materials: [],
        powerWatts: 0,
        printTimeSeconds: 0,
        electricityMinorPerKwh: 0,
        purchasePriceMinor: 0,
        lifetimeHours: 1,
        maintenanceMinorPerHour: 0,
        failureBasisPoints: 10000,
        prepMinutes: 60,
        postMinutes: 0,
        laborMinorPerHour: 10000,
        extraMinors: [500],
        markupBasisPoints: 0,
        vatBasisPoints: 0,
        quantity: 1,
      ),
    );

    expect(breakdown.failureMinor, 0);
    expect(breakdown.laborMinor, 10000);
    expect(breakdown.extrasMinor, 500);
    expect(breakdown.costMinor, 10500);
  });

  test('sums filament lines before rounding', () {
    final breakdown = calculator.calculate(
      const PriceInput(
        materials: [
          MaterialUse(grams: 0.4, pricePerKgMinor: 1000),
          MaterialUse(grams: 0.4, pricePerKgMinor: 1000),
        ],
        powerWatts: 0,
        printTimeSeconds: 0,
        electricityMinorPerKwh: 0,
        purchasePriceMinor: 0,
        lifetimeHours: 1,
        maintenanceMinorPerHour: 0,
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

    expect(breakdown.materialMinor, 1);
  });

  test('ignores negative grams and negative rates', () {
    final breakdown = calculator.calculate(
      const PriceInput(
        materials: [MaterialUse(grams: -20, pricePerKgMinor: 20000)],
        powerWatts: -100,
        printTimeSeconds: -30,
        electricityMinorPerKwh: -200,
        purchasePriceMinor: -500,
        lifetimeHours: -10,
        maintenanceMinorPerHour: -5,
        failureBasisPoints: -1000,
        prepMinutes: -15,
        postMinutes: -15,
        laborMinorPerHour: -100,
        extraMinors: [],
        markupBasisPoints: -3000,
        vatBasisPoints: -2500,
        quantity: -2,
      ),
    );

    expect(breakdown.materialMinor, 0);
    expect(breakdown.electricityMinor, 0);
    expect(breakdown.machineMinor, 0);
    expect(breakdown.laborMinor, 0);
    expect(breakdown.totalMinor, 0);
    expect(breakdown.quantity, 1);
  });

  test('keeps a huge job finite', () {
    final breakdown = calculator.calculate(
      const PriceInput(
        materials: [MaterialUse(grams: 1e300, pricePerKgMinor: 20000)],
        powerWatts: 1000000000,
        printTimeSeconds: 999999999999999,
        electricityMinorPerKwh: 200,
        purchasePriceMinor: 100000000000000,
        lifetimeHours: 0.0000001,
        maintenanceMinorPerHour: 0,
        failureBasisPoints: 10000,
        prepMinutes: 1000000000,
        postMinutes: 1000000000,
        laborMinorPerHour: 1000000000,
        extraMinors: [],
        markupBasisPoints: 10000,
        vatBasisPoints: 10000,
        quantity: 1000000000,
      ),
    );

    expect(breakdown.totalMinor, greaterThan(0));
    expect(breakdown.perUnitMinor, greaterThan(0));
  });
}
