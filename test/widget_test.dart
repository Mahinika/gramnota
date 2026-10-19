import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gramnota/core/format.dart';
import 'package:gramnota/features/pricing/domain/price_breakdown.dart';
import 'package:gramnota/features/pricing/presentation/breakdown_card.dart';

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

  testWidgets('hides the unit price on a combined quote', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(
        home: Scaffold(
          body: BreakdownCard(
            currencyCode: 'SEK',
            showPerUnit: false,
            breakdown: PriceBreakdown(
              materialMinor: 2000,
              electricityMinor: 0,
              machineMinor: 0,
              failureMinor: 0,
              laborMinor: 0,
              extrasMinor: 0,
              costMinor: 2000,
              markupMinor: 0,
              netMinor: 2000,
              vatMinor: 0,
              totalMinor: 2000,
              perUnitMinor: 0,
              quantity: 1,
            ),
          ),
        ),
      ),
    );

    expect(find.text('Total'), findsOneWidget);
    expect(find.textContaining('per unit'), findsNothing);
  });
}
