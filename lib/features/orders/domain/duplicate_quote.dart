import '../../filaments/domain/filament_spool.dart';
import '../../pricing/domain/live_quote.dart';
import '../../pricing/domain/price_breakdown.dart';
import '../../printers/domain/printer_profile.dart';
import '../../settings/domain/workshop_settings.dart';
import 'print_order.dart';

class DuplicatedQuote {
  const DuplicatedQuote({required this.order, required this.warnings});

  final PrintOrder order;
  final List<String> warnings;
}

/// Copies prints, customer, and print settings into a new quote.
///
/// The copy is status Quote, with a new id, number, and dates. Stock fields
/// are cleared. Each print is priced again from the spools, printers, and
/// workshop rates passed in.
DuplicatedQuote duplicateAsNewQuote({
  required PrintOrder source,
  required String id,
  required int quoteNumber,
  required DateTime now,
  required WorkshopSettings settings,
  required List<FilamentSpool> spools,
  required List<PrinterProfile> printers,
  required String Function() newLineId,
}) {
  final stamp = now.toUtc();
  final iso = stamp.toIso8601String();
  final days = settings.quoteValidityDays < 0 ? 0 : settings.quoteValidityDays;
  final warnings = <String>[];
  final lines = <QuoteLine>[];
  for (final line in orderPrints(source)) {
    final priced = pricePrint(
      id: newLineId(),
      title: line.title,
      quantity: line.quantity,
      printerId: line.printerId,
      printTimeSeconds: line.printTimeSeconds,
      filaments: line.filaments,
      prepMinutes: line.prepMinutes,
      postMinutes: line.postMinutes,
      extras: line.extras,
      markupBasisPoints: line.markupBasisPoints,
      failureBasisPoints: line.failureBasisPoints,
      vatBasisPoints: line.vatBasisPoints,
      settings: settings,
      spools: spools,
      printers: printers,
      sourceUrl: line.sourceUrl,
      sourceModelTitle: line.sourceModelTitle,
      sourceProfileTitle: line.sourceProfileTitle,
    );
    lines.add(priced.line);
    warnings.addAll(priced.warnings);
  }
  if (lines.isEmpty) {
    lines.add(
      QuoteLine(
        id: newLineId(),
        title: source.title,
        quantity: 1,
        printTimeSeconds: 0,
        filaments: const [],
        markupBasisPoints: settings.defaultMarkupBasisPoints,
        failureBasisPoints: settings.defaultFailureBasisPoints,
        vatBasisPoints: settings.vatBasisPoints,
        breakdown: PriceBreakdown.zero(),
      ),
    );
  }
  final draft = PrintOrder(
    id: id,
    quoteNumber: quoteNumber,
    customerId: source.customerId,
    title: source.title,
    status: OrderStatus.quote,
    validUntil: stamp.add(Duration(days: days)).toIso8601String(),
    quantity: 1,
    printTimeSeconds: 0,
    filaments: const [],
    currencyCode: settings.currencyCode,
    markupBasisPoints: lines.first.markupBasisPoints,
    failureBasisPoints: lines.first.failureBasisPoints,
    vatBasisPoints: lines.first.vatBasisPoints,
    breakdown: PriceBreakdown.zero(),
    note: source.note,
    createdAt: iso,
    updatedAt: iso,
  );
  return DuplicatedQuote(
    order: orderWithPrints(draft, lines),
    warnings: warnings,
  );
}

const duplicateQuoteSummary =
    'Copies these prints and this customer into a new quote with status Quote, a new number, and new dates. '
    'Stock stays on this order. Prices are recalculated from current spools, the printer, and workshop rates.';

const duplicateQuoteExplanation =
    'This copies the prints, the customer, and the print settings into a new quote. '
    'The new quote gets status Quote, a new number, and new dates. '
    'Filament already taken out of stock stays on this order and is not copied. '
    'Prices are calculated again from the current spool prices, printer, electricity, and labor rate. '
    'Markup, failure, and VAT stay as they are on each print.';
