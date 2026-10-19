import 'package:fake_cloud_firestore/fake_cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gramnota/core/providers.dart';
import 'package:gramnota/core/user_store.dart';
import 'package:gramnota/features/pricing/presentation/calculator_screen.dart';
import 'package:gramnota/l10n/l10n.dart';
import 'package:gramnota/features/settings/domain/workshop_settings.dart';

void main() {
  testWidgets('empty workshop shows customer choice and setup cards', (
    tester,
  ) async {
    final firestore = FakeFirebaseFirestore();
    final store = UserStore(firestore, 'seller');
    await store.saveSettings(const WorkshopSettings(setupCompleted: true));

    tester.view.physicalSize = const Size(800, 1600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [userStoreProvider.overrideWithValue(store)],
        child: const MaterialApp(
          locale: Locale('en'),
          supportedLocales: AppLocalizations.supportedLocales,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          home: CalculatorScreen(),
        ),
      ),
    );
    await tester.pump();
    await tester.pump();

    expect(find.text('Tap to choose before saving'), findsOneWidget);
    expect(find.text('No printers'), findsOneWidget);
    expect(find.text('No filament spools'), findsOneWidget);
    expect(find.text('Open Filament'), findsOneWidget);
    expect(find.text('Open Printers'), findsOneWidget);
  });
}
