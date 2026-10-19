import 'package:flutter_test/flutter_test.dart';
import 'package:gramnota/features/orders/domain/customer_quote_view.dart';

void main() {
  test('customer PDF labels exclude internal cost lines', () {
    for (final label in customerQuotePdfSummaryLabels()) {
      expect(isInternalQuoteBreakdownField(label), isFalse);
    }
    expect(internalQuoteBreakdownFields, contains('Markup'));
    expect(internalQuoteBreakdownFields, contains('Failure buffer'));
    expect(customerQuoteBreakdownFields, {'Subtotal', 'VAT', 'Total'});
    expect(customerQuoteBreakdownFields, isNot(contains('Price ex. VAT')));
    expect(customerQuoteBreakdownFields, isNot(contains('Net')));
  });
}
