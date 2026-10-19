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

/// Customer PDF summary. Subtotal is the ex-VAT amount (`netMinor`), so it
/// matches the line amounts. VAT and Total follow. Internal cost words such
/// as Net and Markup stay off the document.
const customerQuoteBreakdownFields = {'Subtotal', 'VAT', 'Total'};

bool isInternalQuoteBreakdownField(String label) =>
    internalQuoteBreakdownFields.contains(label);

/// Used in tests to ensure PDF rows stay customer-facing.
List<String> customerQuotePdfSummaryLabels() => [
  ...customerQuoteBreakdownFields,
];
