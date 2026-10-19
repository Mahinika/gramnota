/// Breakdown rows shown only inside the app, never on the customer PDF.
const internalQuoteBreakdownFields = {
  'Material',
  'Electricity',
  'Machine wear',
  'Failure buffer',
  'Labor',
  'Extras',
  'Cost',
  'Markup',
  'Net',
};

/// Customer PDF summary. Line prices are before VAT, so these rows add up.
const customerQuoteBreakdownFields = {'Price ex. VAT', 'VAT', 'Total'};

bool isInternalQuoteBreakdownField(String label) =>
    internalQuoteBreakdownFields.contains(label);

/// Used in tests to ensure PDF rows stay customer-facing.
List<String> customerQuotePdfSummaryLabels() => [
  ...customerQuoteBreakdownFields,
];
