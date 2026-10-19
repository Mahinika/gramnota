import 'package:flutter_test/flutter_test.dart';
import 'package:gramnota/features/filaments/domain/filament_spool.dart';
import 'package:gramnota/features/orders/domain/dashboard.dart';
import 'package:gramnota/features/orders/domain/print_order.dart';
import 'package:gramnota/features/pricing/domain/price_breakdown.dart';

DateTime plusTwoHours(DateTime instant) =>
    instant.toUtc().add(const Duration(hours: 2));

PriceBreakdown money({
  required int cost,
  required int net,
  required int vat,
  required int total,
}) {
  return PriceBreakdown(
    materialMinor: cost,
    electricityMinor: 0,
    machineMinor: 0,
    failureMinor: 0,
    laborMinor: 0,
    extrasMinor: 0,
    costMinor: cost,
    markupMinor: net - cost,
    netMinor: net,
    vatMinor: vat,
    totalMinor: total,
    perUnitMinor: total,
    quantity: 1,
  );
}

PrintOrder sample({
  required String id,
  required OrderStatus status,
  required String stamp,
  required PriceBreakdown breakdown,
  String customerId = '',
  String title = 'Clip',
  List<QuoteLine> lines = const [],
  int depositMinor = 0,
  String revenueAt = '',
}) {
  return PrintOrder(
    id: id,
    quoteNumber: 1,
    customerId: customerId,
    title: title,
    status: status,
    validUntil: '2026-12-01T00:00:00.000Z',
    quantity: 1,
    printTimeSeconds: 60,
    filaments: const [],
    markupBasisPoints: 0,
    failureBasisPoints: 0,
    vatBasisPoints: 2500,
    currencyCode: 'SEK',
    breakdown: breakdown,
    depositMinor: depositMinor,
    revenueAt: revenueAt,
    lines: lines,
    createdAt: stamp,
    updatedAt: stamp,
  );
}

void main() {
  test('month boundaries, VAT, and zero-price orders', () {
    final marchInside = sample(
      id: 'march',
      status: OrderStatus.paid,
      stamp: '2026-03-31T21:30:00.000Z',
      revenueAt: '2026-03-31T21:30:00.000Z',
      customerId: 'anna',
      title: 'Dragon',
      breakdown: money(cost: 10000, net: 13000, vat: 3250, total: 16250),
      lines: [
        QuoteLine(
          id: 'line',
          title: 'Dragon',
          quantity: 2,
          printTimeSeconds: 60,
          filaments: const [
            FilamentUsage(filamentId: 'pla', grams: 12.5, material: 'PLA'),
            FilamentUsage(filamentId: 'petg', grams: 10, material: 'petg'),
          ],
          markupBasisPoints: 0,
          failureBasisPoints: 0,
          vatBasisPoints: 2500,
          breakdown: money(cost: 10000, net: 13000, vat: 3250, total: 16250),
        ),
      ],
    );
    final aprilEdge = sample(
      id: 'april',
      status: OrderStatus.printed,
      stamp: '2026-03-31T22:30:00.000Z',
      revenueAt: '2026-03-31T22:30:00.000Z',
      breakdown: money(cost: 0, net: 0, vat: 0, total: 0),
      title: 'Zero',
    );
    final accepted = sample(
      id: 'pipe',
      status: OrderStatus.accepted,
      stamp: '2025-01-01T00:00:00.000Z',
      customerId: 'bo',
      breakdown: money(cost: 500, net: 500, vat: 125, total: 625),
      depositMinor: 200,
    );
    final sent = sample(
      id: 'sent',
      status: OrderStatus.sent,
      stamp: '2026-03-02T00:00:00.000Z',
      breakdown: money(cost: 100, net: 100, vat: 25, total: 125),
      depositMinor: 50,
    );

    final march = buildDashboard(
      orders: [marchInside, aprilEdge, accepted, sent],
      spools: const [],
      year: 2026,
      month: 3,
      customerNames: const {'anna': 'Anna'},
      toLocal: plusTwoHours,
    );

    expect(march.orderCount, 1);
    expect(march.revenueInclVatMinor, 16250);
    expect(march.revenueExclVatMinor, 13000);
    expect(march.costMinor, 10000);
    expect(march.profitMinor, 3000);
    expect(march.revenueOrders.single.title, 'Dragon');
    expect(march.materials.map((item) => item.material), ['PLA', 'petg']);
    expect(march.materials.first.grams, 25);
    expect(march.materials.last.grams, 20);
    expect(march.topCustomers.single.label, 'Anna');
    expect(march.topCustomers.single.totalMinor, 16250);
    expect(march.topProducts.single.label, 'Dragon');
    expect(march.topProducts.single.count, 2);
    expect(march.pipelineOrderCount, 2);
    expect(march.pipelineInclVatMinor, 750);
    expect(march.openDepositMinor, 250);

    final april = buildDashboard(
      orders: [marchInside, aprilEdge, accepted, sent],
      spools: const [],
      year: 2026,
      month: 4,
      toLocal: plusTwoHours,
    );
    expect(april.orderCount, 1);
    expect(april.revenueInclVatMinor, 0);
    expect(april.revenueExclVatMinor, 0);
    expect(april.costMinor, 0);
    expect(april.profitMinor, 0);
    expect(april.revenueOrders.single.title, 'Zero');
    expect(april.pipelineOrderCount, 2);
  });

  test('an empty month still reports the live pipeline', () {
    final snapshot = buildDashboard(
      orders: [
        sample(
          id: 'sent',
          status: OrderStatus.sent,
          stamp: '2026-01-15T00:00:00.000Z',
          breakdown: money(cost: 100, net: 100, vat: 25, total: 125),
        ),
      ],
      spools: const [],
      year: 2026,
      month: 8,
      toLocal: plusTwoHours,
    );

    expect(snapshot.orderCount, 0);
    expect(snapshot.hasRevenueMoney, isFalse);
    expect(snapshot.pipelineOrderCount, 1);
    expect(snapshot.pipelineInclVatMinor, 125);
    expect(snapshot.monthLabel, 'August 2026');
  });

  test('older printed orders without revenueAt use updatedAt', () {
    final order = sample(
      id: 'old',
      status: OrderStatus.printed,
      stamp: '2026-05-02T10:00:00.000Z',
      breakdown: money(cost: 100, net: 200, vat: 50, total: 250),
    );
    final snapshot = buildDashboard(
      orders: [order],
      spools: const [],
      year: 2026,
      month: 5,
      toLocal: plusTwoHours,
    );
    expect(snapshot.orderCount, 1);
    expect(snapshot.profitMinor, 100);
  });

  test('a spool exactly at the workshop threshold is low', () {
    const exact = FilamentSpool(
      id: 'exact',
      brand: 'Prusa',
      material: 'PLA',
      remainingGrams: 100,
      lowStockUsesDefault: true,
      lowStockGrams: 20,
    );
    const above = FilamentSpool(
      id: 'above',
      brand: 'Prusa',
      material: 'PETG',
      remainingGrams: 100.1,
      lowStockUsesDefault: true,
    );
    const own = FilamentSpool(
      id: 'own',
      brand: 'Bambu',
      material: 'ABS',
      remainingGrams: 40,
      lowStockGrams: 50,
    );

    final notices = lowSpoolNotices([exact, above, own], 100);
    expect(notices.map((item) => item.id), ['own', 'exact']);
    expect(exact.isLowAt(100), isTrue);
    expect(above.isLowAt(100), isFalse);
    expect(own.lowStockThreshold(100), 50);
  });

  test('a dated deposit and the final payment land in different months', () {
    final job = sample(
      id: 'split',
      status: OrderStatus.paid,
      stamp: '2026-04-10T10:00:00.000Z',
      revenueAt: '2026-04-10T10:00:00.000Z',
      breakdown: money(cost: 10000, net: 13000, vat: 3250, total: 16250),
      depositMinor: 5000,
    ).copyWith(depositAt: '2026-03-15T12:00:00.000Z');

    final march = buildDashboard(
      orders: [job],
      spools: const [],
      year: 2026,
      month: 3,
      toLocal: plusTwoHours,
    );
    expect(march.orderCount, 0);
    expect(march.depositsReceivedMinor, 5000);
    expect(march.finalPaymentsMinor, 0);
    expect(march.revenueInclVatMinor, 5000);
    expect(march.revenueExclVatMinor, 4000);
    expect(march.costMinor, 0);
    expect(march.profitMinor, 4000);

    final april = buildDashboard(
      orders: [job],
      spools: const [],
      year: 2026,
      month: 4,
      toLocal: plusTwoHours,
    );
    expect(april.orderCount, 1);
    expect(april.depositsReceivedMinor, 0);
    expect(april.finalPaymentsMinor, 11250);
    expect(april.revenueInclVatMinor, 11250);
    expect(april.revenueExclVatMinor, 9000);
    expect(april.costMinor, 10000);
    expect(april.profitMinor, -1000);
    expect(april.revenueOrders.single.totalMinor, 11250);

    final together = job.copyWith(
      depositAt: '2026-04-02T12:00:00.000Z',
    );
    final sameMonth = buildDashboard(
      orders: [together],
      spools: const [],
      year: 2026,
      month: 4,
      toLocal: plusTwoHours,
    );
    expect(sameMonth.revenueInclVatMinor, 16250);
    expect(sameMonth.revenueExclVatMinor, 13000);
    expect(sameMonth.profitMinor, 3000);
    expect(sameMonth.depositsReceivedMinor, 5000);
    expect(sameMonth.finalPaymentsMinor, 11250);
  });

  test('a deposit without a date stays in the finish month', () {
    final job = sample(
      id: 'legacy',
      status: OrderStatus.printed,
      stamp: '2026-05-02T10:00:00.000Z',
      revenueAt: '2026-05-02T10:00:00.000Z',
      breakdown: money(cost: 100, net: 200, vat: 50, total: 250),
      depositMinor: 100,
    );
    expect(recognizedDepositMinor(job), 0);
    final snapshot = buildDashboard(
      orders: [job],
      spools: const [],
      year: 2026,
      month: 5,
      toLocal: plusTwoHours,
    );
    expect(snapshot.revenueInclVatMinor, 250);
    expect(snapshot.depositsReceivedMinor, 0);
    expect(snapshot.finalPaymentsMinor, 250);
    expect(snapshot.openDepositMinor, 100);
  });

  test('top products stay together when the title changes', () {
    QuoteLine line({
      required String id,
      required String title,
      required String productId,
      required int total,
    }) {
      return QuoteLine(
        id: id,
        productId: productId,
        title: title,
        quantity: 1,
        printTimeSeconds: 60,
        filaments: const [],
        markupBasisPoints: 0,
        failureBasisPoints: 0,
        vatBasisPoints: 0,
        breakdown: money(cost: 10, net: 10, vat: 0, total: total),
      );
    }

    final renamed = sample(
      id: 'a',
      status: OrderStatus.paid,
      stamp: '2026-06-02T10:00:00.000Z',
      revenueAt: '2026-06-02T10:00:00.000Z',
      title: 'Old clip name',
      breakdown: money(cost: 10, net: 10, vat: 0, total: 400),
      lines: [
        line(id: '1', title: 'Old clip name', productId: 'clip', total: 400),
      ],
    );
    final current = sample(
      id: 'b',
      status: OrderStatus.paid,
      stamp: '2026-06-03T10:00:00.000Z',
      revenueAt: '2026-06-03T10:00:00.000Z',
      title: 'Benchy',
      breakdown: money(cost: 10, net: 10, vat: 0, total: 100),
      lines: [
        line(id: '2', title: 'Clip v2', productId: 'clip', total: 100),
        line(id: '3', title: 'Benchy', productId: '', total: 100),
      ],
    );
    final snapshot = buildDashboard(
      orders: [renamed, current],
      spools: const [],
      year: 2026,
      month: 6,
      productNames: const {'clip': 'Phone clip'},
      toLocal: plusTwoHours,
    );
    expect(snapshot.topProducts.map((item) => item.label), [
      'Phone clip',
      'Benchy',
    ]);
    expect(snapshot.topProducts.first.totalMinor, 500);
    expect(snapshot.topProducts.first.count, 2);
  });

  test('overdue quotes are counted outside the selected month', () {
    final until = DateTime.parse('2026-03-01T12:00:00.000Z').toLocal();
    final nextDay = DateTime(until.year, until.month, until.day).add(
      const Duration(days: 1),
    );
    final expired = sample(
      id: 'late',
      status: OrderStatus.sent,
      stamp: '2026-01-01T00:00:00.000Z',
      breakdown: money(cost: 1, net: 1, vat: 0, total: 100),
    ).copyWith(validUntil: '2026-03-01T12:00:00.000Z');
    final fresh = expired.copyWith(
      id: 'fresh',
      validUntil: nextDay.toUtc().toIso8601String(),
    );
    final paid = expired.copyWith(id: 'paid', status: OrderStatus.paid);
    final snapshot = buildDashboard(
      orders: [expired, fresh, paid],
      spools: const [],
      year: 2026,
      month: 8,
      now: nextDay,
      toLocal: plusTwoHours,
    );
    expect(snapshot.overdueCount, 1);
    expect(snapshot.orderCount, 0);
  });
}
