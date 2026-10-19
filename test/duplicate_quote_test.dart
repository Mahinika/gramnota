import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:gramnota/core/providers.dart';
import 'package:gramnota/core/user_store.dart';
import 'package:gramnota/features/customers/domain/customer.dart';
import 'package:gramnota/features/filaments/domain/filament_spool.dart';
import 'package:gramnota/features/orders/domain/duplicate_quote.dart';
import 'package:gramnota/features/orders/domain/print_order.dart';
import 'package:gramnota/features/orders/presentation/orders_screen.dart';
import 'package:gramnota/features/pricing/domain/price_breakdown.dart';
import 'package:gramnota/features/printers/domain/printer_profile.dart';
import 'package:gramnota/features/settings/domain/workshop_settings.dart';

void main() {
  test('copies the quote, drops stock, and reprices from the current spool', () {
    const settings = WorkshopSettings(
      currencyCode: 'SEK',
      electricityMinorPerKwh: 250,
      laborMinorPerHour: 6000,
      quoteValidityDays: 7,
      nextQuoteNumber: 9,
    );
    const spool = FilamentSpool(
      id: 'pla',
      brand: 'Prusa',
      material: 'PLA',
      spoolWeightGrams: 1000,
      pricePerSpoolMinor: 40000,
    );
    const printer = PrinterProfile(id: 'a1', name: 'A1', powerWatts: 1000);
    final source = PrintOrder(
      id: 'old',
      quoteNumber: 3,
      customerId: 'ada',
      title: 'Dragon',
      status: OrderStatus.printed,
      validUntil: '2020-01-01T00:00:00.000Z',
      quantity: 2,
      printerId: 'a1',
      printTimeSeconds: 3600,
      filaments: const [FilamentUsage(filamentId: 'pla', grams: 100)],
      prepMinutes: 30,
      markupBasisPoints: 0,
      failureBasisPoints: 0,
      vatBasisPoints: 0,
      currencyCode: 'SEK',
      breakdown: PriceBreakdown.zero(),
      stockDeducted: true,
      deductedGrams: const {'pla': 80},
      stockWarning: 'Stock was short',
      note: 'Rush',
      lines: const [
        QuoteLine(
          id: 'line-old',
          productId: 'dragon-product',
          title: 'Dragon',
          quantity: 2,
          printerId: 'a1',
          printTimeSeconds: 3600,
          filaments: [
            FilamentUsage(filamentId: 'pla', grams: 100, material: 'PLA'),
          ],
          prepMinutes: 30,
          markupBasisPoints: 0,
          failureBasisPoints: 0,
          vatBasisPoints: 0,
          breakdown: PriceBreakdown(
            materialMinor: 1,
            electricityMinor: 1,
            machineMinor: 1,
            failureMinor: 1,
            laborMinor: 1,
            extrasMinor: 1,
            costMinor: 1,
            markupMinor: 1,
            netMinor: 1,
            vatMinor: 1,
            totalMinor: 2000,
            perUnitMinor: 1000,
            quantity: 2,
          ),
          sourceUrl: 'https://example.com/dragon',
        ),
      ],
      createdAt: '2020-01-01T00:00:00.000Z',
      updatedAt: '2020-01-02T00:00:00.000Z',
    );
    var nextId = 0;
    final duplicated = duplicateAsNewQuote(
      source: source,
      id: 'new',
      quoteNumber: 9,
      now: DateTime.utc(2026, 10, 19, 12),
      settings: settings,
      spools: const [spool],
      printers: const [printer],
      newLineId: () => 'line-${nextId++}',
    );
    final order = duplicated.order;
    expect(order.id, 'new');
    expect(order.quoteNumber, 9);
    expect(order.status, OrderStatus.quote);
    expect(order.customerId, 'ada');
    expect(order.note, 'Rush');
    expect(order.currencyCode, 'SEK');
    expect(order.stockDeducted, isFalse);
    expect(order.deductedGrams, isEmpty);
    expect(order.stockWarning, isEmpty);
    expect(order.createdAt, '2026-10-19T12:00:00.000Z');
    expect(order.updatedAt, '2026-10-19T12:00:00.000Z');
    expect(order.validUntil, '2026-10-26T12:00:00.000Z');
    expect(order.lines.single.id, 'line-0');
    expect(order.lines.single.sourceUrl, 'https://example.com/dragon');
    expect(order.lines.single.productId, 'dragon-product');
    expect(order.depositMinor, 0);
    expect(order.depositAt, '');
    // 100 g at 40 kr/kg is 4 kr, twice. One hour at 2.50 kr. Prep 30 min is 30 kr.
    expect(order.breakdown.materialMinor, 8000);
    expect(order.breakdown.electricityMinor, 500);
    expect(order.breakdown.laborMinor, 3000);
    expect(order.breakdown.totalMinor, 11500);
    expect(source.stockDeducted, isTrue);
    expect(source.deductedGrams['pla'], 80);
    expect(duplicated.warnings, isEmpty);

    final missing = duplicateAsNewQuote(
      source: source,
      id: 'other',
      quoteNumber: 10,
      now: DateTime.utc(2026, 10, 19),
      settings: settings,
      spools: const [],
      printers: const [],
      newLineId: () => 'x',
    );
    expect(missing.warnings, isNotEmpty);
    expect(missing.order.breakdown.materialMinor, 0);
    expect(missing.order.breakdown.electricityMinor, 0);
    expect(missing.warnings.join(' '), contains('priced at 0'));
    expect(
      missing.warnings.join(' '),
      contains('electricity and machine wear are 0'),
    );
  });

  testWidgets('the quote screen explains the copy and creates it', (
    tester,
  ) async {
    final firestore = FakeFirebaseFirestore();
    final store = UserStore(firestore, 'seller');
    await store.saveSettings(
      const WorkshopSettings(
        setupCompleted: true,
        nextQuoteNumber: 4,
        electricityMinorPerKwh: 0,
        laborMinorPerHour: 0,
        defaultMarkupBasisPoints: 0,
        vatBasisPoints: 0,
        defaultFailureBasisPoints: 0,
      ),
    );
    await store.saveCustomer(const Customer(id: 'ada', name: 'Ada'));
    await store.saveFilament(
      const FilamentSpool(
        id: 'pla',
        brand: 'Prusa',
        material: 'PLA',
        spoolWeightGrams: 1000,
        pricePerSpoolMinor: 40000,
      ),
    );
    await store.saveOrder(
      PrintOrder(
        id: 'order-1',
        quoteNumber: 3,
        customerId: 'ada',
        title: 'Dragon',
        status: OrderStatus.printed,
        validUntil: '2020-01-01T00:00:00.000Z',
        quantity: 1,
        printTimeSeconds: 0,
        filaments: const [FilamentUsage(filamentId: 'pla', grams: 100)],
        markupBasisPoints: 0,
        failureBasisPoints: 0,
        vatBasisPoints: 0,
        currencyCode: 'SEK',
        breakdown: PriceBreakdown.zero().copyWith(totalMinor: 2000),
        stockDeducted: true,
        deductedGrams: const {'pla': 100},
        stockWarning: 'Stock was short',
        lines: [
          QuoteLine(
            id: 'line-1',
            title: 'Dragon',
            quantity: 1,
            printTimeSeconds: 0,
            filaments: const [FilamentUsage(filamentId: 'pla', grams: 100)],
            markupBasisPoints: 0,
            failureBasisPoints: 0,
            vatBasisPoints: 0,
            breakdown: PriceBreakdown.zero().copyWith(totalMinor: 2000),
          ),
        ],
        createdAt: '2020-01-01T00:00:00.000Z',
        updatedAt: '2020-01-01T00:00:00.000Z',
      ),
    );

    tester.view.physicalSize = const Size(1200, 2600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    final router = GoRouter(
      initialLocation: '/orders/order-1',
      routes: [
        GoRoute(
          path: '/orders/:id',
          builder: (_, state) =>
              OrderDetailScreen(id: state.pathParameters['id']!),
        ),
      ],
    );
    addTearDown(router.dispose);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [userStoreProvider.overrideWithValue(store)],
        child: MaterialApp.router(routerConfig: router),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.textContaining('Stock stays on this order'), findsOneWidget);
    expect(find.textContaining('Prices are recalculated'), findsOneWidget);
    await tester.tap(find.text('Duplicate as new quote'));
    await tester.pumpAndSettle();
    expect(
      find.textContaining('Filament already taken out of stock'),
      findsOneWidget,
    );
    expect(find.textContaining('is not copied'), findsOneWidget);
    await tester.tap(find.text('Create quote'));
    await tester.pumpAndSettle();

    expect(find.text('Quote 4'), findsOneWidget);
    expect(find.textContaining('40,00 kr'), findsWidgets);
    final original = await store.orders.doc('order-1').get();
    expect(original.data()!['stockDeducted'], isTrue);
    expect(original.data()!['status'], 'printed');
    final copies = await store.orders.get();
    expect(copies.docs, hasLength(2));
    final created = copies.docs.singleWhere((doc) => doc.id != 'order-1');
    expect(created.data()['status'], 'quote');
    expect(created.data()['quoteNumber'], 4);
    expect(created.data()['customerId'], 'ada');
    expect(created.data()['stockDeducted'], isFalse);
    expect(created.data()['deductedGrams'], isEmpty);
    expect(created.data()['stockWarning'], '');
  });
}
