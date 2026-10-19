import '../../catalog/domain/catalog_product.dart';
import '../../filaments/domain/filament_spool.dart';
import '../../orders/domain/print_order.dart';
import '../../printers/domain/printer_profile.dart';
import '../../settings/domain/workshop_settings.dart';
import 'price_calculator.dart';

class PricedPrint {
  const PricedPrint({required this.line, required this.warnings});

  final QuoteLine line;
  final List<String> warnings;
}

/// Prices one print from the workshop as it is now.
///
/// Filament kroner per kilogram, printer wear, watts, electricity, and labor
/// come from the current spool, printer, and settings. The print keeps its own
/// markup, failure buffer, and VAT.
PricedPrint pricePrint({
  required String id,
  required String title,
  required int quantity,
  required String printerId,
  required int printTimeSeconds,
  required List<FilamentUsage> filaments,
  required int prepMinutes,
  required int postMinutes,
  required List<ExtraCost> extras,
  required int markupBasisPoints,
  required int failureBasisPoints,
  required int vatBasisPoints,
  required WorkshopSettings settings,
  required List<FilamentSpool> spools,
  required List<PrinterProfile> printers,
  String sourceUrl = '',
  String sourceModelTitle = '',
  String sourceProfileTitle = '',
  String productId = '',
}) {
  final warnings = <String>[];
  PrinterProfile? printer;
  if (printerId.isNotEmpty) {
    for (final candidate in printers) {
      if (candidate.id == printerId) {
        printer = candidate;
      }
    }
    if (printer == null) {
      warnings.add(
        'Printer for “$title” is no longer in the workshop, so electricity and machine wear are 0.',
      );
    }
  }
  final materials = <MaterialUse>[];
  for (final usage in filaments) {
    FilamentSpool? spool;
    if (usage.filamentId.isNotEmpty) {
      for (final candidate in spools) {
        if (candidate.id == usage.filamentId) {
          spool = candidate;
        }
      }
      if (spool == null) {
        final label = usage.material.trim().isEmpty
            ? 'filament'
            : usage.material.trim();
        warnings.add(
          'Spool for “$title” ($label) is missing, so that filament is priced at 0.',
        );
      }
    }
    materials.add(
      MaterialUse(
        grams: usage.grams,
        pricePerKgMinor: spool?.pricePerKgMinor ?? 0,
      ),
    );
  }
  final breakdown = const PriceCalculator().calculate(
    PriceInput(
      materials: materials,
      powerWatts: printer?.powerWatts ?? 0,
      printTimeSeconds: printTimeSeconds,
      electricityMinorPerKwh: settings.electricityMinorPerKwh,
      purchasePriceMinor: printer?.purchasePriceMinor ?? 0,
      lifetimeHours: printer?.lifetimeHours ?? 0,
      maintenanceMinorPerHour: printer?.maintenanceMinorPerHour ?? 0,
      failureBasisPoints: failureBasisPoints,
      prepMinutes: prepMinutes,
      postMinutes: postMinutes,
      laborMinorPerHour: settings.laborMinorPerHour,
      extraMinors: [for (final extra in extras) extra.costMinor],
      markupBasisPoints: markupBasisPoints,
      vatBasisPoints: vatBasisPoints,
      quantity: quantity < 1 ? 1 : quantity,
    ),
  );
  return PricedPrint(
    line: QuoteLine(
      id: id,
      productId: productId,
      title: title,
      quantity: quantity < 1 ? 1 : quantity,
      printerId: printerId,
      printTimeSeconds: printTimeSeconds,
      filaments: filaments,
      prepMinutes: prepMinutes,
      postMinutes: postMinutes,
      extras: extras,
      markupBasisPoints: markupBasisPoints,
      failureBasisPoints: failureBasisPoints,
      vatBasisPoints: vatBasisPoints,
      breakdown: breakdown,
      sourceUrl: sourceUrl,
      sourceModelTitle: sourceModelTitle,
      sourceProfileTitle: sourceProfileTitle,
    ),
    warnings: warnings,
  );
}

PricedPrint priceProduct({
  required CatalogProduct product,
  required String lineId,
  required int quantity,
  required WorkshopSettings settings,
  required List<FilamentSpool> spools,
  required List<PrinterProfile> printers,
}) {
  return pricePrint(
    id: lineId,
    title: product.name,
    quantity: quantity,
    printerId: product.printerId,
    printTimeSeconds: product.printTimeSeconds,
    filaments: product.filaments,
    prepMinutes: product.prepMinutes,
    postMinutes: product.postMinutes,
    extras: product.extras,
    markupBasisPoints: product.markupBasisPoints,
    failureBasisPoints: product.failureBasisPoints,
    vatBasisPoints: product.vatBasisPoints,
    settings: settings,
    spools: spools,
    printers: printers,
    sourceUrl: product.sourceUrl,
    sourceModelTitle: product.name,
    productId: product.id,
  );
}

CatalogProduct productFromLine(
  QuoteLine line, {
  required String id,
  required DateTime now,
  String notes = '',
}) {
  final stamp = now.toUtc().toIso8601String();
  return CatalogProduct(
    id: id,
    name: line.title,
    printerId: line.printerId,
    printTimeSeconds: line.printTimeSeconds,
    filaments: line.filaments,
    prepMinutes: line.prepMinutes,
    postMinutes: line.postMinutes,
    extras: line.extras,
    markupBasisPoints: line.markupBasisPoints,
    failureBasisPoints: line.failureBasisPoints,
    vatBasisPoints: line.vatBasisPoints,
    sourceUrl: line.sourceUrl,
    notes: notes,
    createdAt: stamp,
    updatedAt: stamp,
  );
}

const productPriceExplanation =
    'The price is calculated from the current spool prices, printer, electricity, and labor rate. Markup, failure, and VAT stay as saved on the product.';
