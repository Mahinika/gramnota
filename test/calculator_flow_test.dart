import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gramnota/core/format.dart';
import 'package:gramnota/core/providers.dart';
import 'package:gramnota/core/user_store.dart';
import 'package:gramnota/features/filaments/domain/filament_spool.dart';
import 'package:gramnota/features/pricing/presentation/calculator_screen.dart';
import 'package:gramnota/features/printers/domain/printer_profile.dart';
import 'package:gramnota/features/settings/domain/workshop_settings.dart';

void main() {
  testWidgets('prices comma grams with the selected spool and printer', (
    tester,
  ) async {
    final firestore = FakeFirebaseFirestore();
    final store = UserStore(firestore, 'seller');
    await store.saveSettings(
      const WorkshopSettings(
        setupCompleted: true,
        currencyCode: 'SEK',
        electricityMinorPerKwh: 150,
        laborMinorPerHour: 0,
        defaultMarkupBasisPoints: 0,
        vatBasisPoints: 0,
        defaultFailureBasisPoints: 0,
      ),
    );
    await store.savePrinter(
      const PrinterProfile(
        id: 'printer',
        name: 'A1 mini',
        powerWatts: 100,
        purchasePriceMinor: 1000000,
        lifetimeHours: 10000,
      ),
    );
    await store.saveFilament(
      const FilamentSpool(
        id: 'spool',
        brand: 'Bambu',
        material: 'PLA',
        spoolWeightGrams: 1000,
        remainingGrams: 1000,
        pricePerSpoolMinor: 20000,
      ),
    );

    tester.view.physicalSize = const Size(1200, 2000);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [userStoreProvider.overrideWithValue(store)],
        child: const MaterialApp(home: CalculatorScreen()),
      ),
    );
    await tester.pump();
    await tester.pump();

    expect(
      find.text(
        'No printer selected, so electricity and machine wear stay at 0.',
      ),
      findsNothing,
    );
    expect(find.text('Pick a spool. These grams are priced at 0.'), findsNothing);

    await tester.enterText(find.widgetWithText(TextField, 'Grams'), '100,5');
    await tester.enterText(find.widgetWithText(TextField, 'Hours'), '1');
    await tester.enterText(find.widgetWithText(TextField, 'Minutes'), '0');
    await tester.pump();

    expect(
      find.text('Pick a spool. These grams are priced at 0.'),
      findsOneWidget,
    );

    await tester.tap(find.widgetWithText(DropdownButtonFormField<String>, 'Spool'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 300));
    await tester.tap(find.text('Bambu PLA').last);
    await tester.pump();

    expect(find.text('Pick a spool. These grams are priced at 0.'), findsNothing);
    // 100.5 g at 200 kr/kg = 20.10. 100 W for 1 h at 1.50/kWh = 0.15.
    // Machine wear is 100 kr / 10 000 h = 1.00. No labor, markup, or VAT.
    expect(find.text(formatMoney(2010, 'SEK')), findsWidgets);
    expect(find.text(formatMoney(15, 'SEK')), findsWidgets);
    expect(find.text(formatMoney(100, 'SEK')), findsWidgets);
    expect(find.text(formatMoney(2125, 'SEK')), findsWidgets);

    await tester.enterText(find.widgetWithText(TextField, 'Quantity'), '2');
    await tester.pump();

    expect(find.text(formatMoney(4020, 'SEK')), findsWidgets);
    expect(find.text(formatMoney(4250, 'SEK')), findsWidgets);
    expect(
      find.textContaining('Prep is charged once'),
      findsOneWidget,
    );

    await tester.enterText(find.widgetWithText(TextField, 'Hours'), '1,5');
    await tester.enterText(find.widgetWithText(TextField, 'Quantity'), '1');
    await tester.pump();

    // 1,5 h is 90 minutes. Electricity 0.1 kW * 1.5 h * 1.50 = 0.225 -> 23 öre.
    // Machine 1.50. Material stays 20.10. Total 21.83.
    expect(find.text('1h 30m'), findsOneWidget);
    expect(find.text(formatMoney(23, 'SEK')), findsWidgets);
    expect(find.text(formatMoney(150, 'SEK')), findsWidgets);
    expect(find.text(formatMoney(2183, 'SEK')), findsWidgets);

    await tester.enterText(find.widgetWithText(TextField, 'Hours'), 'abc');
    await tester.pump();
    expect(find.textContaining('Could not read hours'), findsOneWidget);

    await tester.enterText(find.widgetWithText(TextField, 'Quantity'), '2,5');
    await tester.pump();
    expect(find.textContaining('whole number'), findsOneWidget);

    await tester.enterText(find.widgetWithText(TextField, 'Prep minutes'), '15,4');
    await tester.pump();
    expect(find.text('Priced as 15 minutes.'), findsOneWidget);

    await tester.enterText(find.widgetWithText(TextField, 'Hours'), '0');
    await tester.enterText(find.widgetWithText(TextField, 'Grams'), '1500');
    await tester.enterText(find.widgetWithText(TextField, 'Quantity'), '1');
    await tester.pump();
    expect(
      find.textContaining('1500 g'),
      findsOneWidget,
    );
    expect(find.textContaining('only 1000 g remains'), findsOneWidget);
  });
}