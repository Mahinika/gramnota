import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gramnota/core/user_store.dart';
import 'package:gramnota/features/filaments/domain/filament_spool.dart';
import 'package:gramnota/features/orders/data/order_stock.dart';
import 'package:gramnota/features/orders/domain/print_order.dart';
import 'package:gramnota/features/pricing/domain/price_breakdown.dart';

void main() {
  test('sums the same spool and clamps remaining at zero', () async {
    final firestore = FakeFirebaseFirestore();
    final store = UserStore(firestore, 'user');
    await store.saveFilament(
      const FilamentSpool(
        id: 'spool',
        brand: 'Prusa',
        material: 'PLA',
        remainingGrams: 80,
        spoolWeightGrams: 1000,
      ),
    );
    const order = PrintOrder(
      id: 'order',
      quoteNumber: 1,
      title: 'Dragon',
      status: OrderStatus.accepted,
      validUntil: '2026-10-20T00:00:00.000Z',
      quantity: 2,
      printTimeSeconds: 3600,
      filaments: [
        FilamentUsage(filamentId: 'spool', grams: 30),
        FilamentUsage(filamentId: 'spool', grams: 30),
      ],
      markupBasisPoints: 0,
      failureBasisPoints: 0,
      vatBasisPoints: 0,
      currencyCode: 'SEK',
      breakdown: PriceBreakdown(
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
        quantity: 2,
      ),
      createdAt: '2026-10-15T00:00:00.000Z',
      updatedAt: '2026-10-15T00:00:00.000Z',
    );
    await store.saveOrder(order);

    final change = await OrderStock(store).setStatus(
      order: order,
      next: OrderStatus.printed,
    );

    final spool = FilamentSpool.fromJson({
      ...(await store.filaments.doc('spool').get()).data()!,
      'id': 'spool',
    });
    expect(spool.remainingGrams, 0);
    expect(change.order.deductedGrams['spool'], 80);
    expect(change.warning, contains('short'));
    expect(change.order.stockDeducted, isTrue);
  });

  test('puts the deducted grams back when a print is cancelled', () async {
    final firestore = FakeFirebaseFirestore();
    final store = UserStore(firestore, 'user');
    await store.saveFilament(
      const FilamentSpool(
        id: 'spool',
        brand: 'Prusa',
        material: 'PLA',
        remainingGrams: 50,
      ),
    );
    const printed = PrintOrder(
      id: 'order',
      quoteNumber: 2,
      title: 'Clip',
      status: OrderStatus.printed,
      validUntil: '2026-10-20T00:00:00.000Z',
      quantity: 1,
      printTimeSeconds: 600,
      filaments: [FilamentUsage(filamentId: 'spool', grams: 10)],
      markupBasisPoints: 0,
      failureBasisPoints: 0,
      vatBasisPoints: 0,
      currencyCode: 'SEK',
      breakdown: PriceBreakdown(
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
      ),
      stockDeducted: true,
      deductedGrams: {'spool': 10},
      createdAt: '2026-10-15T00:00:00.000Z',
      updatedAt: '2026-10-15T00:00:00.000Z',
    );

    await OrderStock(store).setStatus(
      order: printed,
      next: OrderStatus.cancelled,
    );

    final spool = FilamentSpool.fromJson({
      ...(await store.filaments.doc('spool').get()).data()!,
      'id': 'spool',
    });
    expect(spool.remainingGrams, 60);
  });

  test('deducts each print on a quote once for the same spool', () async {
    final firestore = FakeFirebaseFirestore();
    final store = UserStore(firestore, 'user');
    await store.saveFilament(
      const FilamentSpool(
        id: 'spool',
        brand: 'Prusa',
        material: 'PLA',
        remainingGrams: 100,
        spoolWeightGrams: 1000,
      ),
    );
    const breakdown = PriceBreakdown(
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
    const stand = QuoteLine(
      id: 'stand',
      title: 'Stand',
      quantity: 2,
      printTimeSeconds: 3600,
      filaments: [FilamentUsage(filamentId: 'spool', grams: 20)],
      markupBasisPoints: 0,
      failureBasisPoints: 0,
      vatBasisPoints: 0,
      breakdown: breakdown,
    );
    const clip = QuoteLine(
      id: 'clip',
      title: 'Clip',
      quantity: 1,
      printTimeSeconds: 600,
      filaments: [FilamentUsage(filamentId: 'spool', grams: 15)],
      markupBasisPoints: 0,
      failureBasisPoints: 0,
      vatBasisPoints: 0,
      breakdown: breakdown,
    );
    const order = PrintOrder(
      id: 'order',
      quoteNumber: 3,
      title: 'Stand',
      status: OrderStatus.accepted,
      validUntil: '2026-10-20T00:00:00.000Z',
      quantity: 9,
      printTimeSeconds: 0,
      filaments: [FilamentUsage(filamentId: 'spool', grams: 500)],
      markupBasisPoints: 0,
      failureBasisPoints: 0,
      vatBasisPoints: 0,
      currencyCode: 'SEK',
      breakdown: breakdown,
      lines: [stand, clip],
      createdAt: '2026-10-15T00:00:00.000Z',
      updatedAt: '2026-10-15T00:00:00.000Z',
    );

    final change = await OrderStock(store).setStatus(
      order: order,
      next: OrderStatus.printed,
    );

    final spool = FilamentSpool.fromJson({
      ...(await store.filaments.doc('spool').get()).data()!,
      'id': 'spool',
    });
    expect(spool.remainingGrams, 45);
    expect(change.order.deductedGrams['spool'], 55);
    expect(change.warning, isEmpty);
  });

  test('reads an order without lines as one print', () {
    const order = PrintOrder(
      id: 'order',
      quoteNumber: 4,
      title: 'Dragon',
      status: OrderStatus.quote,
      validUntil: '2026-10-20T00:00:00.000Z',
      quantity: 2,
      printTimeSeconds: 3600,
      filaments: [FilamentUsage(filamentId: 'spool', grams: 30)],
      markupBasisPoints: 0,
      failureBasisPoints: 0,
      vatBasisPoints: 0,
      currencyCode: 'SEK',
      breakdown: PriceBreakdown(
        materialMinor: 10,
        electricityMinor: 0,
        machineMinor: 0,
        failureMinor: 0,
        laborMinor: 0,
        extrasMinor: 0,
        costMinor: 10,
        markupMinor: 0,
        netMinor: 10,
        vatMinor: 0,
        totalMinor: 10,
        perUnitMinor: 5,
        quantity: 2,
      ),
      createdAt: '2026-10-15T00:00:00.000Z',
      updatedAt: '2026-10-15T00:00:00.000Z',
    );

    final prints = orderPrints(order);
    expect(prints, hasLength(1));
    expect(prints.single.id, 'order');
    expect(prints.single.quantity, 2);
    expect(prints.single.filaments.single.grams, 30);
    expect(prints.single.breakdown.totalMinor, 10);
  });

  test('stores several prints and leaves the legacy filament list empty', () {
    const breakdown = PriceBreakdown(
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
    const standBreakdown = PriceBreakdown(
      materialMinor: 100,
      electricityMinor: 0,
      machineMinor: 0,
      failureMinor: 0,
      laborMinor: 0,
      extrasMinor: 0,
      costMinor: 100,
      markupMinor: 0,
      netMinor: 100,
      vatMinor: 0,
      totalMinor: 180,
      perUnitMinor: 90,
      quantity: 2,
    );
    const clipBreakdown = PriceBreakdown(
      materialMinor: 40,
      electricityMinor: 0,
      machineMinor: 0,
      failureMinor: 0,
      laborMinor: 0,
      extrasMinor: 0,
      costMinor: 40,
      markupMinor: 0,
      netMinor: 40,
      vatMinor: 0,
      totalMinor: 40,
      perUnitMinor: 40,
      quantity: 1,
    );
    const order = PrintOrder(
      id: 'order',
      quoteNumber: 5,
      title: 'Stand',
      status: OrderStatus.quote,
      validUntil: '2026-10-20T00:00:00.000Z',
      quantity: 2,
      printTimeSeconds: 3600,
      filaments: [FilamentUsage(filamentId: 'spool', grams: 20)],
      markupBasisPoints: 0,
      failureBasisPoints: 0,
      vatBasisPoints: 0,
      currencyCode: 'SEK',
      breakdown: breakdown,
      createdAt: '2026-10-15T00:00:00.000Z',
      updatedAt: '2026-10-15T00:00:00.000Z',
    );
    const stand = QuoteLine(
      id: 'stand',
      title: 'Stand',
      quantity: 2,
      printTimeSeconds: 3600,
      filaments: [FilamentUsage(filamentId: 'spool', grams: 20)],
      markupBasisPoints: 0,
      failureBasisPoints: 0,
      vatBasisPoints: 0,
      breakdown: standBreakdown,
    );
    const clip = QuoteLine(
      id: 'clip',
      title: 'Clip',
      quantity: 1,
      printTimeSeconds: 600,
      filaments: [FilamentUsage(filamentId: 'spool', grams: 15)],
      markupBasisPoints: 0,
      failureBasisPoints: 0,
      vatBasisPoints: 0,
      breakdown: clipBreakdown,
    );

    final saved = orderWithPrints(order, [stand]);
    expect(quoteTitleFor(saved, [stand, clip]), 'Stand + Clip');
    expect(
      quoteTitleFor(saved.copyWith(title: 'Anna'), [stand, clip]),
      'Anna',
    );

    final stored = orderWithPrints(order, [stand, clip]);
    expect(stored.lines, hasLength(2));
    expect(stored.filaments, isEmpty);
    expect(stored.breakdown.totalMinor, 220);
    expect(stored.breakdown.perUnitMinor, 0);
    expect(stored.title, 'Stand');
  });

  test('does not deduct twice when printed is set again', () async {
    final firestore = FakeFirebaseFirestore();
    final store = UserStore(firestore, 'user');
    await store.saveFilament(
      const FilamentSpool(
        id: 'spool',
        brand: 'Prusa',
        material: 'PLA',
        remainingGrams: 100,
      ),
    );
    const order = PrintOrder(
      id: 'order',
      quoteNumber: 6,
      title: 'Clip',
      status: OrderStatus.accepted,
      validUntil: '2026-10-20T00:00:00.000Z',
      quantity: 1,
      printTimeSeconds: 600,
      filaments: [FilamentUsage(filamentId: 'spool', grams: 10)],
      markupBasisPoints: 0,
      failureBasisPoints: 0,
      vatBasisPoints: 0,
      currencyCode: 'SEK',
      breakdown: PriceBreakdown(
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
      ),
      createdAt: '2026-10-15T00:00:00.000Z',
      updatedAt: '2026-10-15T00:00:00.000Z',
    );
    await store.saveOrder(order);
    final stock = OrderStock(store);
    await stock.setStatus(order: order, next: OrderStatus.printed);
    await stock.setStatus(order: order, next: OrderStatus.printed);

    final spool = FilamentSpool.fromJson({
      ...(await store.filaments.doc('spool').get()).data()!,
      'id': 'spool',
    });
    expect(spool.remainingGrams, 90);
  });

  test('clamps a negative spool to zero instead of deducting backwards', () async {
    final firestore = FakeFirebaseFirestore();
    final store = UserStore(firestore, 'user');
    await store.saveFilament(
      const FilamentSpool(
        id: 'spool',
        brand: 'Prusa',
        material: 'PLA',
        remainingGrams: -10,
      ),
    );
    const order = PrintOrder(
      id: 'order',
      quoteNumber: 7,
      title: 'Clip',
      status: OrderStatus.accepted,
      validUntil: '2026-10-20T00:00:00.000Z',
      quantity: 1,
      printTimeSeconds: 600,
      filaments: [FilamentUsage(filamentId: 'spool', grams: 30)],
      markupBasisPoints: 0,
      failureBasisPoints: 0,
      vatBasisPoints: 0,
      currencyCode: 'SEK',
      breakdown: PriceBreakdown(
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
      ),
      createdAt: '2026-10-15T00:00:00.000Z',
      updatedAt: '2026-10-15T00:00:00.000Z',
    );
    await store.saveOrder(order);

    final change = await OrderStock(store).setStatus(
      order: order,
      next: OrderStatus.printed,
    );

    final spool = FilamentSpool.fromJson({
      ...(await store.filaments.doc('spool').get()).data()!,
      'id': 'spool',
    });
    expect(spool.remainingGrams, 0);
    expect(change.order.deductedGrams['spool'], 0);
    expect(change.warning, contains('short'));
    expect(change.warning, contains('30 g of Prusa PLA'));
    expect(change.warning, isNot(contains('30.0')));
  });

  test('saving a note does not roll back a printed status', () async {
    final firestore = FakeFirebaseFirestore();
    final store = UserStore(firestore, 'user');
    await store.saveFilament(
      const FilamentSpool(
        id: 'spool',
        brand: 'Prusa',
        material: 'PLA',
        remainingGrams: 100,
      ),
    );
    const order = PrintOrder(
      id: 'order',
      quoteNumber: 8,
      title: 'Clip',
      status: OrderStatus.accepted,
      validUntil: '2026-10-20T00:00:00.000Z',
      quantity: 1,
      printTimeSeconds: 600,
      filaments: [FilamentUsage(filamentId: 'spool', grams: 10)],
      markupBasisPoints: 0,
      failureBasisPoints: 0,
      vatBasisPoints: 0,
      currencyCode: 'SEK',
      breakdown: PriceBreakdown(
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
      ),
      createdAt: '2026-10-15T00:00:00.000Z',
      updatedAt: '2026-10-15T00:00:00.000Z',
    );
    await store.saveOrder(order);
    await OrderStock(store).setStatus(order: order, next: OrderStatus.printed);

    await store.saveOrderNote(orderId: order.id, note: 'Call the customer');

    final saved = PrintOrder.fromJson({
      ...(await store.orders.doc(order.id).get()).data()!,
      'id': order.id,
    });
    final spool = FilamentSpool.fromJson({
      ...(await store.filaments.doc('spool').get()).data()!,
      'id': 'spool',
    });
    expect(saved.status, OrderStatus.printed);
    expect(saved.stockDeducted, isTrue);
    expect(saved.deductedGrams['spool'], 10);
    expect(saved.note, 'Call the customer');
    expect(spool.remainingGrams, 90);
  });

  test('moving from printed to paid does not deduct again', () async {
    final firestore = FakeFirebaseFirestore();
    final store = UserStore(firestore, 'user');
    await store.saveFilament(
      const FilamentSpool(
        id: 'spool',
        brand: 'Prusa',
        material: 'PLA',
        remainingGrams: 100,
      ),
    );
    const order = PrintOrder(
      id: 'order',
      quoteNumber: 9,
      title: 'Clip',
      status: OrderStatus.accepted,
      validUntil: '2026-10-20T00:00:00.000Z',
      quantity: 1,
      printTimeSeconds: 600,
      filaments: [FilamentUsage(filamentId: 'spool', grams: 10)],
      markupBasisPoints: 0,
      failureBasisPoints: 0,
      vatBasisPoints: 0,
      currencyCode: 'SEK',
      breakdown: PriceBreakdown(
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
      ),
      createdAt: '2026-03-01T00:00:00.000Z',
      updatedAt: '2026-03-01T00:00:00.000Z',
    );
    await store.saveOrder(order);
    final stock = OrderStock(store);
    final printed = await stock.setStatus(order: order, next: OrderStatus.printed);
    final paid = await stock.setStatus(order: printed.order, next: OrderStatus.paid);

    final spool = FilamentSpool.fromJson({
      ...(await store.filaments.doc('spool').get()).data()!,
      'id': 'spool',
    });
    expect(spool.remainingGrams, 90);
    expect(paid.order.status, OrderStatus.paid);
    expect(paid.order.stockDeducted, isTrue);
    expect(paid.order.deductedGrams['spool'], 10);
    expect(paid.order.revenueAt, printed.order.revenueAt);
    expect(paid.order.revenueAt, isNotEmpty);
  });

  test('cancelling a paid order returns the deducted grams', () async {
    final firestore = FakeFirebaseFirestore();
    final store = UserStore(firestore, 'user');
    await store.saveFilament(
      const FilamentSpool(
        id: 'spool',
        brand: 'Prusa',
        material: 'PLA',
        remainingGrams: 40,
      ),
    );
    const paid = PrintOrder(
      id: 'order',
      quoteNumber: 10,
      title: 'Clip',
      status: OrderStatus.paid,
      validUntil: '2026-10-20T00:00:00.000Z',
      quantity: 1,
      printTimeSeconds: 600,
      filaments: [FilamentUsage(filamentId: 'spool', grams: 10)],
      markupBasisPoints: 0,
      failureBasisPoints: 0,
      vatBasisPoints: 0,
      currencyCode: 'SEK',
      breakdown: PriceBreakdown(
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
      ),
      stockDeducted: true,
      deductedGrams: {'spool': 10},
      revenueAt: '2026-03-02T00:00:00.000Z',
      createdAt: '2026-03-01T00:00:00.000Z',
      updatedAt: '2026-03-02T00:00:00.000Z',
    );
    await store.saveOrder(paid);

    final change = await OrderStock(store).setStatus(
      order: paid,
      next: OrderStatus.cancelled,
    );

    final spool = FilamentSpool.fromJson({
      ...(await store.filaments.doc('spool').get()).data()!,
      'id': 'spool',
    });
    expect(spool.remainingGrams, 50);
    expect(change.order.stockDeducted, isFalse);
    expect(change.order.deductedGrams, isEmpty);
    expect(change.order.revenueAt, isEmpty);
    expect(change.order.status, OrderStatus.cancelled);
  });

  test('reverting a printed order to accepted returns stock', () async {
    final firestore = FakeFirebaseFirestore();
    final store = UserStore(firestore, 'user');
    await store.saveFilament(
      const FilamentSpool(
        id: 'spool',
        brand: 'Prusa',
        material: 'PLA',
        remainingGrams: 70,
      ),
    );
    const printed = PrintOrder(
      id: 'order',
      quoteNumber: 11,
      title: 'Clip',
      status: OrderStatus.printed,
      validUntil: '2026-10-20T00:00:00.000Z',
      quantity: 1,
      printTimeSeconds: 600,
      filaments: [FilamentUsage(filamentId: 'spool', grams: 25)],
      markupBasisPoints: 0,
      failureBasisPoints: 0,
      vatBasisPoints: 0,
      currencyCode: 'SEK',
      breakdown: PriceBreakdown(
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
      ),
      stockDeducted: true,
      deductedGrams: {'spool': 25},
      revenueAt: '2026-03-04T00:00:00.000Z',
      createdAt: '2026-03-01T00:00:00.000Z',
      updatedAt: '2026-03-04T00:00:00.000Z',
    );
    await store.saveOrder(printed);

    await OrderStock(store).setStatus(
      order: printed,
      next: OrderStatus.accepted,
    );

    final spool = FilamentSpool.fromJson({
      ...(await store.filaments.doc('spool').get()).data()!,
      'id': 'spool',
    });
    expect(spool.remainingGrams, 95);
  });

  test('sent does not take filament', () async {
    final firestore = FakeFirebaseFirestore();
    final store = UserStore(firestore, 'user');
    await store.saveFilament(
      const FilamentSpool(
        id: 'spool',
        brand: 'Prusa',
        material: 'PLA',
        remainingGrams: 100,
      ),
    );
    const order = PrintOrder(
      id: 'order',
      quoteNumber: 12,
      title: 'Clip',
      status: OrderStatus.quote,
      validUntil: '2026-10-20T00:00:00.000Z',
      quantity: 1,
      printTimeSeconds: 600,
      filaments: [FilamentUsage(filamentId: 'spool', grams: 10)],
      markupBasisPoints: 0,
      failureBasisPoints: 0,
      vatBasisPoints: 0,
      currencyCode: 'SEK',
      breakdown: PriceBreakdown(
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
      ),
      createdAt: '2026-03-01T00:00:00.000Z',
      updatedAt: '2026-03-01T00:00:00.000Z',
    );
    await store.saveOrder(order);

    final change = await OrderStock(store).setStatus(
      order: order,
      next: OrderStatus.sent,
    );

    final spool = FilamentSpool.fromJson({
      ...(await store.filaments.doc('spool').get()).data()!,
      'id': 'spool',
    });
    expect(change.order.status, OrderStatus.sent);
    expect(change.order.stockDeducted, isFalse);
    expect(spool.remainingGrams, 100);
  });

  test('an old delivered order stays paid and can return stock', () async {
    final firestore = FakeFirebaseFirestore();
    final store = UserStore(firestore, 'user');
    await store.saveFilament(
      const FilamentSpool(
        id: 'spool',
        brand: 'Prusa',
        material: 'PLA',
        remainingGrams: 20,
      ),
    );
    await store.orders.doc('legacy').set({
      'id': 'legacy',
      'quoteNumber': 3,
      'title': 'Old',
      'status': 'delivered',
      'validUntil': '2026-01-01T00:00:00.000Z',
      'quantity': 1,
      'printTimeSeconds': 60,
      'filaments': [
        {'filamentId': 'spool', 'grams': 12.5, 'material': 'PLA', 'colorHex': ''},
      ],
      'markupBasisPoints': 0,
      'failureBasisPoints': 0,
      'vatBasisPoints': 0,
      'currencyCode': 'SEK',
      'breakdown': const PriceBreakdown(
        materialMinor: 100,
        electricityMinor: 0,
        machineMinor: 0,
        failureMinor: 0,
        laborMinor: 0,
        extrasMinor: 0,
        costMinor: 100,
        markupMinor: 0,
        netMinor: 100,
        vatMinor: 0,
        totalMinor: 100,
        perUnitMinor: 100,
        quantity: 1,
      ).toJson(),
      'stockDeducted': true,
      'deductedGrams': {'spool': 12.5},
      'createdAt': '2026-01-01T00:00:00.000Z',
      'updatedAt': '2026-01-02T00:00:00.000Z',
    });
    final stored = PrintOrder.fromJson({
      ...(await store.orders.doc('legacy').get()).data()!,
      'id': 'legacy',
    });
    expect(stored.status, OrderStatus.paid);
    expect(stored.deductedGrams['spool'], 12.5);
    expect(stored.depositMinor, 0);

    await OrderStock(store).setStatus(order: stored, next: OrderStatus.cancelled);

    final spool = FilamentSpool.fromJson({
      ...(await store.filaments.doc('spool').get()).data()!,
      'id': 'spool',
    });
    expect(spool.remainingGrams, 32.5);
  });
}
