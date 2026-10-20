import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gramnota/core/save_feedback.dart';

void main() {
  testWidgets('a failed save shows the error on a snackbar', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Builder(
          builder: (context) {
            return Scaffold(
              body: FilledButton(
                onPressed: () => showSaveError(context, 'Could not save.'),
                child: const Text('Save'),
              ),
            );
          },
        ),
      ),
    );

    await tester.tap(find.text('Save'));
    await tester.pump();
    expect(find.text('Could not save.'), findsOneWidget);
    expect(find.byType(SnackBar), findsOneWidget);
  });
}
