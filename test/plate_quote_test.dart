import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gramnota/features/filaments/domain/filament_spool.dart';
import 'package:gramnota/features/import/domain/gcode_metadata.dart';
import 'package:gramnota/features/import/domain/plate_quote.dart';
import 'package:gramnota/features/import/presentation/plate_import_dialog.dart';
import 'package:gramnota/features/settings/domain/workshop_settings.dart';

void main() {
  test('each plate becomes its own priced print', () {
    var ids = 0;
    final lines = quoteLinesFromPlates(
      plates: const [
        GcodePlate(
          name: 'Base',
          slicer: 'OrcaSlicer',
          printTimeSeconds: 3600,
          filaments: [GcodeFilament(grams: 10, material: 'PLA', colorHex: '#FFFFFF')],
        ),
        GcodePlate(
          name: 'Lid',
          slicer: 'OrcaSlicer',
          printTimeSeconds: 1800,
          filaments: [GcodeFilament(grams: 5, material: 'PLA')],
        ),
        GcodePlate(
          name: 'Empty',
          slicer: '',
          printTimeSeconds: null,
          filaments: [],
        ),
      ],
      newId: () => 'line-${ids++}',
      settings: const WorkshopSettings(
        electricityMinorPerKwh: 0,
        laborMinorPerHour: 0,
        defaultMarkupBasisPoints: 0,
        vatBasisPoints: 0,
      ),
      spools: const [
        FilamentSpool(
          id: 'pla',
          brand: 'Prusa',
          material: 'PLA',
          spoolWeightGrams: 1000,
          remainingGrams: 1000,
          pricePerSpoolMinor: 10000,
        ),
      ],
      printers: const [],
    );

    expect(lines, hasLength(2));
    expect(lines.map((line) => line.title), ['Base', 'Lid']);
    expect(lines.first.filaments.single.filamentId, 'pla');
    expect(lines.first.filaments.single.grams, 10);
    expect(lines.first.quantity, 1);
    expect(lines.first.breakdown.materialMinor, 100);
    expect(lines.last.breakdown.materialMinor, 50);
    expect(lines.last.printTimeSeconds, 1800);
  });

  testWidgets('the plate dialog can import all plates or one', (tester) async {
    const plates = [
      GcodePlate(
        name: 'Base',
        slicer: '',
        printTimeSeconds: 10,
        filaments: [GcodeFilament(grams: 1)],
      ),
      GcodePlate(
        name: 'Lid',
        slicer: '',
        printTimeSeconds: 10,
        filaments: [GcodeFilament(grams: 1)],
      ),
    ];

    PlateImportChoice? choice;
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) => Scaffold(
            body: TextButton(
              onPressed: () async {
                choice = await showPlateImportDialog(context, plates);
              },
              child: const Text('Open'),
            ),
          ),
        ),
      ),
    );

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    expect(find.text('Import all 2 plates'), findsOneWidget);
    await tester.tap(find.text('Import all 2 plates'));
    await tester.pumpAndSettle();
    expect(choice?.importAll, isTrue);

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Lid'));
    await tester.pumpAndSettle();
    expect(choice?.importAll, isFalse);
    expect(choice?.plate?.name, 'Lid');
  });
}