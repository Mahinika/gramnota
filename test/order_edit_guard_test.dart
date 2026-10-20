import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gramnota/core/user_store.dart';
import 'package:gramnota/features/orders/data/order_stock.dart';
import 'package:gramnota/features/orders/domain/print_order.dart';
import 'package:gramnota/features/pricing/domain/price_breakdown.dart';
import 'package:gramnota/features/settings/domain/workshop_settings.dart';

void main() {
  test('saving settings leaves the quote counter to allocation', () async {
    final firestore = FakeFirebaseFirestore();
    final store = UserStore(firestore, 'user');
    await store.settingsDoc.set({
      'businessName': 'Old',
      'nextQuoteNumber': 8,
    });

    await store.saveSettings(
      const WorkshopSettings(businessName: 'New', nextQuoteNumber: 1),
    );
    final saved = (await store.settingsDoc.get()).data()!;
    expect(saved['businessName'], 'New');
    expect(saved['nextQuoteNumber'], 8);
    expect(
      settingsWithoutQuoteCounter(
        const WorkshopSettings(businessName: 'New', nextQuoteNumber: 8),
      ).containsKey('nextQuoteNumber'),
      isFalse,
    );

    final number = await OrderStock(store).allocateQuoteNumber();
    final after = (await store.settingsDoc.get()).data()!;
    expect(number, 8);
    expect(after['nextQuoteNumber'], 9);
    expect(after['businessName'], 'New');
  });

  test('a stock-holding order refuses print edits and keeps its fields', () async {
    final firestore = FakeFirebaseFirestore();
    final store = UserStore(firestore, 'user');
    final order = _order(stockDeducted: true);
    await store.saveOrder(order);

    await expectLater(
      store.replaceOrderPrints(
        orderId: order.id,
        lines: [_line(title: 'Changed', net: 500)],
        title: 'Changed',
      ),
      throwsA(isA<OrderPrintsLocked>()),
    );

    final stored = PrintOrder.fromJson({
      ...(await store.orders.doc(order.id).get()).data()!,
      'id': order.id,
    });
    expect(stored.stockDeducted, isTrue);
    expect(stored.deductedGrams['spool'], 12);
    expect(stored.quoteNumber, 4);
    expect(stored.customerId, 'anna');
    expect(stored.status, OrderStatus.printed);
    expect(stored.title, 'Clip');
    expect(stored.breakdown.totalMinor, 1000);
  });

  test('linking a customer writes only the customer id', () async {
    final firestore = FakeFirebaseFirestore();
    final store = UserStore(firestore, 'user');
    final order = _order(stockDeducted: true);
    await store.saveOrder(order);

    await store.updateOrderCustomer(orderId: order.id, customerId: 'bo');

    final stored = PrintOrder.fromJson({
      ...(await store.orders.doc(order.id).get()).data()!,
      'id': order.id,
    });
    expect(stored.customerId, 'bo');
    expect(stored.stockDeducted, isTrue);
    expect(stored.quoteNumber, 4);
    expect(stored.status, OrderStatus.printed);
    expect(stored.title, 'Clip');
    expect(stored.deductedGrams['spool'], 12);
  });

  test('an open order can replace prints without touching stock fields', () async {
    final firestore = FakeFirebaseFirestore();
    final store = UserStore(firestore, 'user');
    final order = _order(stockDeducted: false);
    await store.saveOrder(order);

    await store.replaceOrderPrints(
      orderId: order.id,
      lines: [_line(title: 'Revised', net: 2500)],
      title: 'Revised',
    );

    final stored = PrintOrder.fromJson({
      ...(await store.orders.doc(order.id).get()).data()!,
      'id': order.id,
    });
    expect(stored.title, 'Revised');
    expect(stored.breakdown.totalMinor, 2500);
    expect(stored.quoteNumber, 4);
    expect(stored.customerId, 'anna');
    expect(stored.status, OrderStatus.accepted);
    expect(stored.stockDeducted, isFalse);
  });
}

PrintOrder _order({required bool stockDeducted}) {
  return PrintOrder(
    id: 'order',
    quoteNumber: 4,
    customerId: 'anna',
    title: 'Clip',
    status: stockDeducted ? OrderStatus.printed : OrderStatus.accepted,
    validUntil: '2026-12-01T00:00:00.000Z',
    quantity: 1,
    printTimeSeconds: 60,
    filaments: const [FilamentUsage(filamentId: 'spool', grams: 12)],
    markupBasisPoints: 0,
    failureBasisPoints: 0,
    vatBasisPoints: 0,
    currencyCode: 'SEK',
    breakdown: _money(1000),
    stockDeducted: stockDeducted,
    deductedGrams: stockDeducted ? const {'spool': 12} : const {},
    createdAt: '2026-04-01T00:00:00.000Z',
    updatedAt: '2026-04-01T00:00:00.000Z',
  );
}

QuoteLine _line({required String title, required int net}) {
  return QuoteLine(
    id: 'line',
    title: title,
    quantity: 1,
    printTimeSeconds: 90,
    filaments: const [],
    markupBasisPoints: 0,
    failureBasisPoints: 0,
    vatBasisPoints: 0,
    breakdown: _money(net),
  );
}

PriceBreakdown _money(int total) {
  return PriceBreakdown(
    materialMinor: total,
    electricityMinor: 0,
    machineMinor: 0,
    failureMinor: 0,
    laborMinor: 0,
    extrasMinor: 0,
    costMinor: total,
    markupMinor: 0,
    netMinor: total,
    vatMinor: 0,
    totalMinor: total,
    perUnitMinor: total,
    quantity: 1,
  );
}
