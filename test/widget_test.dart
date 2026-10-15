import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:printprice/core/format.dart';
import 'package:printprice/features/pricing/domain/price_breakdown.dart';
import 'package:printprice/features/pricing/presentation/breakdown_card.dart';

void main() {
  testWidgets('shows every cost line and the total', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: BreakdownCard(
            currencyCode: 'SEK',
            breakdown: PriceBreakdown(
              materialMinor: 2000,
              electricityMinor: 20,
              machineMinor: 100,
              failureMinor: 212,
              laborMinor: 30000,
              extrasMinor: 500,
              costMinor: 32832,
              markupMinor: 16416,
              netMinor: 49248,
              vatMinor: 12312,
              totalMinor: 61560,
              perUnitMinor: 30780,
              quantity: 2,
            ),
          ),
        ),
      ),
    );

    expect(find.text('Material'), findsOneWidget);
    expect(find.text('Total'), findsOneWidget);
    expect(find.textContaining('per unit'), findsOneWidget);
    expect(formatMoney(61560, 'SEK'), contains('615'));
  });
}
