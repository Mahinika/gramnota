import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gramnota/features/customers/domain/customer.dart';
import 'package:gramnota/features/customers/presentation/customer_quote_picker.dart';

void main() {
  testWidgets('customer sheet searches and shows initials', (tester) async {
    await tester.pumpWidget(
      MaterialApp(
        home: Scaffold(
          body: CustomerQuotePickerSheet(
            title: 'Customer',
            customers: const [
              Customer(id: 'a', name: 'Anna Lind', city: 'Stockholm'),
              Customer(id: 'b', name: 'Bo Ek', email: 'bo@example.com'),
            ],
            onNew: () {},
            onNone: () {},
          ),
        ),
      ),
    );

    expect(find.text('AL'), findsOneWidget);
    expect(find.text('BE'), findsOneWidget);
    expect(find.text('No customer'), findsOneWidget);
    expect(find.text('New customer'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'stockholm');
    await tester.pump();

    expect(find.text('Anna Lind'), findsOneWidget);
    expect(find.text('Bo Ek'), findsNothing);
    expect(find.text('BE'), findsNothing);
  });
}
