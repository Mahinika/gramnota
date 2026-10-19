import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gramnota/features/filaments/domain/filament_spool.dart';
import 'package:gramnota/l10n/l10n.dart';
import 'package:gramnota/features/orders/domain/print_order.dart';
import 'package:gramnota/features/orders/domain/stock_coverage.dart';
import 'package:gramnota/features/pricing/domain/price_breakdown.dart';

PrintOrder order({
  required String id,
  required OrderStatus status,
  required List<QuoteLine> lines,
  bool stockDeducted = false,
}) {
  return PrintOrder(
    id: id,
    quoteNumber: 1,
    title: 'Quote',
    status: status,
    validUntil: '2026-12-01T00:00:00.000Z',
    quantity: 1,
    printTimeSeconds: 1,
    filaments: const [],
    markupBasisPoints: 0,
    failureBasisPoints: 0,
    vatBasisPoints: 0,
    currencyCode: 'SEK',
    breakdown: PriceBreakdown.zero(),
    stockDeducted: stockDeducted,
    lines: lines,
    createdAt: '2026-03-01T00:00:00.000Z',
    updatedAt: '2026-03-01T00:00:00.000Z',
  );
}

QuoteLine line({
  required String id,
  required int quantity,
  required List<FilamentUsage> filaments,
}) {
  return QuoteLine(
    id: id,
    title: id,
    quantity: quantity,
    printTimeSeconds: 1,
    filaments: filaments,
    markupBasisPoints: 0,
    failureBasisPoints: 0,
    vatBasisPoints: 0,
    breakdown: PriceBreakdown.zero(),
  );
}

void main() {
  const spool = FilamentSpool(
    id: 'pla',
    brand: 'Prusa',
    material: 'PLA',
    remainingGrams: 100,
  );

  test('quantity and other accepted quotes can make a spool short', () {
    final current = order(
      id: 'current',
      status: OrderStatus.quote,
      lines: [
        line(
          id: 'a',
          quantity: 2,
          filaments: const [
            FilamentUsage(filamentId: 'pla', grams: 20, material: 'PLA'),
          ],
        ),
        line(
          id: 'b',
          quantity: 1,
          filaments: const [
            FilamentUsage(filamentId: 'pla', grams: 20, material: 'PLA'),
          ],
        ),
      ],
    );
    final accepted = order(
      id: 'other',
      status: OrderStatus.accepted,
      lines: [
        line(
          id: 'c',
          quantity: 1,
          filaments: const [
            FilamentUsage(filamentId: 'pla', grams: 50, material: 'PLA'),
          ],
        ),
      ],
    );
    final sent = order(
      id: 'sent',
      status: OrderStatus.sent,
      lines: [
        line(
          id: 'd',
          quantity: 1,
          filaments: const [
            FilamentUsage(filamentId: 'pla', grams: 80, material: 'PLA'),
          ],
        ),
      ],
    );
    final printed = order(
      id: 'printed',
      status: OrderStatus.printed,
      stockDeducted: true,
      lines: [
        line(
          id: 'e',
          quantity: 1,
          filaments: const [
            FilamentUsage(filamentId: 'pla', grams: 40, material: 'PLA'),
          ],
        ),
      ],
    );

    final warnings = quoteSpoolCoverage(
      order: current,
      orders: [current, accepted, sent, printed],
      spools: const [spool],
    );

    expect(warnings, hasLength(1));
    expect(warnings.single.neededGrams, 60);
    expect(warnings.single.reservedGrams, 50);
    expect(warnings.single.remainingGrams, 100);
    expect(warnings.single.shortfallGrams, 10);
    expect(
      warnings.single.messageFor(lookupAppLocalizations(const Locale('en'))),
      contains('short by 10 g'),
    );
  });

  test('a printed order does not warn again for grams already taken', () {
    final printed = order(
      id: 'current',
      status: OrderStatus.printed,
      stockDeducted: true,
      lines: [
        line(
          id: 'a',
          quantity: 2,
          filaments: const [
            FilamentUsage(filamentId: 'pla', grams: 50, material: 'PLA'),
          ],
        ),
      ],
    );

    final warnings = quoteSpoolCoverage(
      order: printed,
      orders: [printed],
      spools: const [spool],
    );

    expect(warnings, isEmpty);
  });

  test('exact coverage is not a warning', () {
    final current = order(
      id: 'current',
      status: OrderStatus.accepted,
      lines: [
        line(
          id: 'a',
          quantity: 2,
          filaments: const [
            FilamentUsage(filamentId: 'pla', grams: 50, material: 'PLA'),
          ],
        ),
      ],
    );

    final warnings = quoteSpoolCoverage(
      order: current,
      orders: [current],
      spools: const [spool],
    );

    expect(warnings, isEmpty);
  });
}
