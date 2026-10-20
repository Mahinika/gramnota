import 'package:flutter_test/flutter_test.dart';
import 'package:gramnota/features/orders/domain/print_order.dart';
import 'package:gramnota/features/orders/presentation/quote_pdf.dart';
import 'package:gramnota/features/pricing/domain/price_breakdown.dart';

void main() {
  test('a unit price is shown only when it multiplies back to the amount', () {
    expect(exactUnitMinor(10000, 4), 2500);
    expect(exactUnitMinor(10000, 4)! * 4, 10000);
    expect(exactUnitMinor(10000, 3), isNull);
    expect(exactUnitMinor(100, 0), isNull);
    expect(exactUnitMinor(0, 2), 0);
    expect(exactUnitMinor(16250, 1), 16250);

    final even = _line(net: 9000, total: 11250, quantity: 3);
    expect(exactUnitMinor(even.breakdown.netMinor, even.quantity)! * 3, 9000);
    expect(
      exactUnitMinor(even.breakdown.totalMinor, even.quantity)! * 3,
      11250,
    );

    final odd = _line(net: 10000, total: 12500, quantity: 3);
    expect(exactUnitMinor(odd.breakdown.netMinor, odd.quantity), isNull);
    expect(exactUnitMinor(odd.breakdown.totalMinor, odd.quantity), isNull);
  });
}

QuoteLine _line({
  required int net,
  required int total,
  required int quantity,
}) {
  return QuoteLine(
    id: 'line',
    title: 'Clip',
    quantity: quantity,
    printTimeSeconds: 60,
    filaments: const [],
    markupBasisPoints: 0,
    failureBasisPoints: 0,
    vatBasisPoints: 2500,
    breakdown: PriceBreakdown(
      materialMinor: net,
      electricityMinor: 0,
      machineMinor: 0,
      failureMinor: 0,
      laborMinor: 0,
      extrasMinor: 0,
      costMinor: net,
      markupMinor: 0,
      netMinor: net,
      vatMinor: total - net,
      totalMinor: total,
      perUnitMinor: 1,
      quantity: quantity,
    ),
  );
}
