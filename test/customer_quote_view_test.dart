import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gramnota/features/orders/domain/customer_quote_view.dart';
import 'package:gramnota/l10n/l10n.dart';

void main() {
  test('customer PDF labels exclude internal cost lines', () {
    final l10n = lookupAppLocalizations(const Locale('en'));
    for (final label in customerQuotePdfSummaryLabels(l10n)) {
      expect(isInternalQuoteBreakdownField(label), isFalse);
    }
    expect(internalQuoteBreakdownFields, contains('Markup'));
    expect(internalQuoteBreakdownFields, contains('Failure buffer'));
    expect(customerQuoteBreakdownFields(l10n), {
      l10n.pdfSubtotal,
      l10n.pdfVat,
      l10n.pdfTotal,
    });
    expect(customerQuoteBreakdownFields(l10n), {'Subtotal', 'VAT', 'Total'});
    expect(
      customerQuoteBreakdownFields(l10n),
      isNot(contains('Price ex. VAT')),
    );
    expect(customerQuoteBreakdownFields(l10n), isNot(contains('Net')));
    expect(customerQuoteBreakdownFields(l10n), isNot(contains('Markup')));
  });
}
