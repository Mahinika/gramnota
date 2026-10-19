import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gramnota/core/text_prompt.dart';
import 'package:gramnota/l10n/l10n.dart';

void main() {
  testWidgets('prompt can be opened, filled, and closed twice', (tester) async {
    String? saved;
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('en'),
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: Scaffold(
          body: Builder(
            builder: (context) => FilledButton(
              onPressed: () async {
                saved = await promptForText(
                  context,
                  title: 'New customer',
                  label: 'Name',
                );
              },
              child: const Text('Open'),
            ),
          ),
        ),
      ),
    );

    Future<void> openAndCancel() async {
      await tester.tap(find.text('Open'));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
    }

    await openAndCancel();
    await openAndCancel();
    expect(tester.takeException(), isNull);

    await tester.tap(find.text('Open'));
    await tester.pumpAndSettle();
    await tester.enterText(find.widgetWithText(TextField, 'Name'), 'Anna');
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();
    expect(saved, 'Anna');
    expect(tester.takeException(), isNull);
  });
}
