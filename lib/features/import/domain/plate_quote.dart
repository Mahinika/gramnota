import '../../../l10n/l10n.dart';
import '../../filaments/domain/filament_spool.dart';
import '../../orders/domain/print_order.dart';
import '../../pricing/domain/live_quote.dart';
import '../../printers/domain/printer_profile.dart';
import '../../settings/domain/workshop_settings.dart';
import 'gcode_metadata.dart';

/// One sliced plate turned into a priced print on a quote.
QuoteLine quoteLineFromPlate({
  required AppLocalizations l10n,
  required GcodePlate plate,
  required String id,
  required WorkshopSettings settings,
  required List<FilamentSpool> spools,
  required List<PrinterProfile> printers,
  String printerId = '',
  int quantity = 1,
  int prepMinutes = 0,
  int postMinutes = 0,
  int? markupBasisPoints,
  int? failureBasisPoints,
  int? vatBasisPoints,
}) {
  final title = plate.name.trim().isEmpty
      ? l10n.plateDefaultName
      : plate.name.trim();
  final filaments = [
    for (final filament in plate.filaments)
      if (filament.grams > 0)
        FilamentUsage(
          filamentId:
              matchSpoolId(spools, filament.material, filament.colorHex) ?? '',
          grams: filament.grams,
          material: filament.material,
          colorHex: filament.colorHex,
        ),
  ];
  return pricePrint(
    l10n: l10n,
    id: id,
    title: title,
    quantity: quantity < 1 ? 1 : quantity,
    printerId: printerId,
    printTimeSeconds: plate.printTimeSeconds ?? 0,
    filaments: filaments,
    prepMinutes: prepMinutes < 0 ? 0 : prepMinutes,
    postMinutes: postMinutes < 0 ? 0 : postMinutes,
    extras: const [],
    markupBasisPoints: markupBasisPoints ?? settings.defaultMarkupBasisPoints,
    failureBasisPoints:
        failureBasisPoints ?? settings.defaultFailureBasisPoints,
    vatBasisPoints: vatBasisPoints ?? settings.vatBasisPoints,
    settings: settings,
    spools: spools,
    printers: printers,
    sourceProfileTitle: title,
  ).line;
}

List<QuoteLine> quoteLinesFromPlates({
  required AppLocalizations l10n,
  required List<GcodePlate> plates,
  required String Function() newId,
  required WorkshopSettings settings,
  required List<FilamentSpool> spools,
  required List<PrinterProfile> printers,
  String printerId = '',
  int quantity = 1,
  int prepMinutes = 0,
  int postMinutes = 0,
  int? markupBasisPoints,
  int? failureBasisPoints,
  int? vatBasisPoints,
}) {
  return [
    for (final plate in plates)
      if (plate.hasData)
        quoteLineFromPlate(
          l10n: l10n,
          plate: plate,
          id: newId(),
          settings: settings,
          spools: spools,
          printers: printers,
          printerId: printerId,
          quantity: quantity,
          prepMinutes: prepMinutes,
          postMinutes: postMinutes,
          markupBasisPoints: markupBasisPoints,
          failureBasisPoints: failureBasisPoints,
          vatBasisPoints: vatBasisPoints,
        ),
  ];
}

/// Matches a slicer material to a workshop spool when the match is unambiguous.
String? matchSpoolId(
  List<FilamentSpool> spools,
  String material, [
  String colorHex = '',
]) {
  final needle = material.trim().toLowerCase();
  if (needle.isEmpty) {
    return null;
  }
  final matches = spools
      .where((spool) => spool.material.trim().toLowerCase() == needle)
      .toList();
  if (matches.length == 1) {
    return matches.single.id;
  }
  final color = colorHex.trim().toLowerCase();
  if (color.isEmpty || matches.isEmpty) {
    return null;
  }
  final colored = matches
      .where((spool) => spool.colorHex.trim().toLowerCase() == color)
      .toList();
  if (colored.length == 1) {
    return colored.single.id;
  }
  return null;
}

String multiPlateImportNote({required AppLocalizations l10n}) =>
    l10n.plateMultiImportNote;
