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
}
