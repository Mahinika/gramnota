import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gramnota/core/user_store.dart';
import 'package:gramnota/features/catalog/domain/catalog_product.dart';
import 'package:gramnota/features/customers/domain/customer.dart';
import 'package:gramnota/features/filaments/domain/filament_spool.dart';
import 'package:gramnota/features/orders/domain/print_order.dart';
import 'package:gramnota/features/pricing/domain/price_breakdown.dart';
import 'package:gramnota/features/printers/domain/printer_profile.dart';
import 'package:gramnota/features/settings/domain/workshop_backup.dart';
import 'package:gramnota/features/settings/domain/workshop_settings.dart';

void main() {
  test('a backup round-trips and a merge does not wipe the workshop', () {
    const localSettings = WorkshopSettings(
      businessName: 'Local',
      nextQuoteNumber: 12,
    );
    final incoming = WorkshopBackup(
      settings: WorkshopSettings(businessName: 'File', nextQuoteNumber: 4),
      printers: [PrinterProfile(id: 'printer', name: 'A1')],
      filaments: [
        FilamentSpool(
          id: 'spool',
          brand: 'Bambu',
          material: 'PLA',
          remainingGrams: 900,
        ),
      ],
      customers: [Customer(id: 'new', name: 'New')],
      orders: [
        _order(id: 'open', title: 'From file', stockDeducted: false),
        _order(id: 'held', title: 'Overwrite', stockDeducted: false),
      ],
      products: [CatalogProduct(id: 'product', name: 'Clip')],
      exportedAt: '2026-10-20T00:00:00.000Z',
    );

    final decoded = WorkshopBackup.decode(incoming.encode());
    expect(decoded.settings.businessName, 'File');
    expect(decoded.printers.single.name, 'A1');
    expect(decoded.customers.single.name, 'New');
    expect(decoded.products.single.name, 'Clip');

    final plan = planWorkshopImport(
      incoming: decoded,
      localSettings: localSettings,
      localFilaments: const {
        'spool': FilamentSpool(
          id: 'spool',
          brand: 'Bambu',
          material: 'PLA',
          remainingGrams: 40,
        ),
      },
      localOrders: {
        'held': _order(id: 'held', title: 'Printed', stockDeducted: true),
      },
    );

    expect(plan.settings.nextQuoteNumber, 12);
    expect(plan.settings.businessName, 'File');
    expect(plan.filaments.single.remainingGrams, 40);
    expect(plan.orders.map((order) => order.id), ['open']);
    expect(plan.customers.single.id, 'new');
    expect(plan.printers.single.id, 'printer');
  });

  test('import keeps local stock, customers, and the quote counter', () async {
    final firestore = FakeFirebaseFirestore();
    final store = UserStore(firestore, 'user');
    await store.saveSettings(
      const WorkshopSettings(businessName: 'Local', nextQuoteNumber: 9),
    );
    await store.settingsDoc.set({'nextQuoteNumber': 9}, SetOptions(merge: true));
    await store.saveCustomer(const Customer(id: 'keep', name: 'Keep'));
    await store.saveFilament(
      const FilamentSpool(
        id: 'spool',
        brand: 'Bambu',
        material: 'PLA',
        remainingGrams: 40,
      ),
    );
    await store.saveOrder(
      _order(id: 'held', title: 'Printed', stockDeducted: true),
    );

    final backup = WorkshopBackup(
      settings: const WorkshopSettings(businessName: 'File', nextQuoteNumber: 2),
      printers: const [PrinterProfile(id: 'printer', name: 'A1')],
      filaments: const [
        FilamentSpool(
          id: 'spool',
          brand: 'Bambu',
          material: 'PLA',
          remainingGrams: 900,
        ),
      ],
      customers: const [Customer(id: 'new', name: 'New')],
      orders: [
        _order(id: 'held', title: 'Overwrite', stockDeducted: false),
        _order(id: 'open', title: 'Imported', stockDeducted: false),
      ],
      products: const [],
    );
    final loaded = await store.loadWorkshopBackup();
    final plan = planWorkshopImport(
      incoming: backup,
      localSettings: loaded.settings,
      localFilaments: {for (final spool in loaded.filaments) spool.id: spool},
      localOrders: {for (final order in loaded.orders) order.id: order},
    );
    await store.applyWorkshopImport(plan);

    final settings = WorkshopSettings.fromJson(
      (await store.settingsDoc.get()).data()!,
    );
    expect(settings.businessName, 'File');
    expect(settings.nextQuoteNumber, 9);
    final customers = await store.customers.get();
    expect(customers.docs.map((doc) => doc.id).toSet(), {'keep', 'new'});
    final spool = FilamentSpool.fromJson({
      ...(await store.filaments.doc('spool').get()).data()!,
      'id': 'spool',
    });
    expect(spool.remainingGrams, 40);
    final held = PrintOrder.fromJson({
      ...(await store.orders.doc('held').get()).data()!,
      'id': 'held',
    });
    expect(held.title, 'Printed');
    expect(held.stockDeducted, isTrue);
    expect((await store.orders.doc('open').get()).exists, isTrue);
    expect((await store.printers.doc('printer').get()).exists, isTrue);
  });
}

PrintOrder _order({
  required String id,
  required String title,
  required bool stockDeducted,
}) {
  return PrintOrder(
    id: id,
    quoteNumber: 3,
    title: title,
    status: stockDeducted ? OrderStatus.printed : OrderStatus.accepted,
    validUntil: '2026-12-01T00:00:00.000Z',
    quantity: 1,
    printTimeSeconds: 60,
    filaments: const [],
    markupBasisPoints: 0,
    failureBasisPoints: 0,
    vatBasisPoints: 0,
    currencyCode: 'SEK',
    breakdown: const PriceBreakdown(
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
    ),
    stockDeducted: stockDeducted,
    createdAt: '2026-04-01T00:00:00.000Z',
    updatedAt: '2026-04-01T00:00:00.000Z',
  );
}
