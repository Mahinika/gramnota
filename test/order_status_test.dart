import 'package:flutter_test/flutter_test.dart';
import 'package:gramnota/features/orders/domain/print_order.dart';
import 'package:gramnota/features/pricing/domain/price_breakdown.dart';

void main() {
  test('old delivered status becomes paid without dropping fields', () {
    final order = PrintOrder.fromJson({
      'id': 'old',
      'quoteNumber': 4,
      'customerId': 'anna',
      'title': 'Dragon',
      'status': 'delivered',
      'validUntil': '2026-02-01T00:00:00.000Z',
      'quantity': 2,
      'printTimeSeconds': 3600,
      'filaments': [
        {
          'filamentId': 'spool',
          'grams': 30,
          'material': 'PLA',
          'colorHex': '#112233',
        },
      ],
      'markupBasisPoints': 3000,
      'failureBasisPoints': 0,
      'vatBasisPoints': 2500,
      'currencyCode': 'SEK',
      'breakdown': PriceBreakdown.zero().toJson(),
      'stockDeducted': true,
      'deductedGrams': {'spool': 60},
      'note': 'Keep me',
      'createdAt': '2026-01-01T00:00:00.000Z',
      'updatedAt': '2026-01-02T00:00:00.000Z',
    });

    expect(order.status, OrderStatus.paid);
    expect(order.customerId, 'anna');
    expect(order.note, 'Keep me');
    expect(order.stockDeducted, isTrue);
    expect(order.deductedGrams['spool'], 60);
    expect(order.filaments.single.grams, 30);
    expect(order.depositMinor, 0);
    expect(order.toJson()['status'], 'paid');
  });

  test('status labels and stock explanations follow the workflow', () {
    expect(orderStatusLabel(OrderStatus.sent), 'Sent');
    expect(orderStatusLabel(OrderStatus.paid), 'Paid');
    expect(orderStatusLabel(OrderStatus.declined), 'Declined');
    expect(statusHoldsStock(OrderStatus.printed), isTrue);
    expect(statusHoldsStock(OrderStatus.paid), isTrue);
    expect(statusHoldsStock(OrderStatus.sent), isFalse);
    expect(statusHoldsStock(OrderStatus.accepted), isFalse);
    expect(statusIsInProgress(OrderStatus.sent), isTrue);
    expect(statusIsInProgress(OrderStatus.paid), isFalse);
    expect(
      stockChangeExplanation(OrderStatus.printed, OrderStatus.paid),
      stockStaysDeductedExplanation,
    );
    expect(
      stockChangeExplanation(OrderStatus.paid, OrderStatus.cancelled),
      stockReturnedOnCloseExplanation,
    );
    expect(
      stockChangeExplanation(OrderStatus.printed, OrderStatus.accepted),
      stockReturnedOnRevertExplanation,
    );
    expect(
      stockChangeExplanation(OrderStatus.accepted, OrderStatus.printed),
      stockTakenOnPrintExplanation,
    );
    expect(stockChangeExplanation(OrderStatus.quote, OrderStatus.sent), isNull);
  });

  test('a sent quote expires the day after valid until', () {
    final order = PrintOrder(
      id: 'q',
      quoteNumber: 1,
      title: 'Clip',
      status: OrderStatus.sent,
      validUntil: '2026-03-31T22:00:00.000Z',
      quantity: 1,
      printTimeSeconds: 1,
      filaments: const [],
      markupBasisPoints: 0,
      failureBasisPoints: 0,
      vatBasisPoints: 0,
      currencyCode: 'SEK',
      breakdown: PriceBreakdown.zero(),
      createdAt: '2026-03-01T00:00:00.000Z',
      updatedAt: '2026-03-01T00:00:00.000Z',
    );
    final until = DateTime.parse(order.validUntil).toLocal();
    final onTheDay = DateTime(until.year, until.month, until.day, 23);
    final nextDay = onTheDay.add(const Duration(days: 1));

    expect(quoteIsExpired(order, onTheDay), isFalse);
    expect(quoteIsExpired(order, nextDay), isTrue);
    expect(
      quoteIsExpired(order.copyWith(status: OrderStatus.paid), nextDay),
      isFalse,
    );
  });
}
