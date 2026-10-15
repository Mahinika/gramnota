import 'package:flutter/material.dart';

import '../../../core/format.dart';
import '../domain/price_breakdown.dart';

class BreakdownCard extends StatelessWidget {
  const BreakdownCard({
    required this.breakdown,
    required this.currencyCode,
    super.key,
  });

  final PriceBreakdown breakdown;
  final String currencyCode;

  @override
  Widget build(BuildContext context) {
    final rows = [
      ('Material', breakdown.materialMinor),
      ('Electricity', breakdown.electricityMinor),
      ('Machine wear', breakdown.machineMinor),
      ('Failure buffer', breakdown.failureMinor),
      ('Labor', breakdown.laborMinor),
      ('Extras', breakdown.extrasMinor),
      ('Cost', breakdown.costMinor),
      ('Markup', breakdown.markupMinor),
      ('Net', breakdown.netMinor),
      ('VAT', breakdown.vatMinor),
    ];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final row in rows)
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  children: [
                    Expanded(child: Text(row.$1)),
                    Text(formatMoney(row.$2, currencyCode)),
                  ],
                ),
              ),
            const Divider(),
            Row(
              children: [
                const Expanded(
                  child: Text(
                    'Total',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  formatMoney(breakdown.totalMinor, currencyCode),
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
            Text(
              '${formatMoney(breakdown.perUnitMinor, currencyCode)} per unit · qty ${breakdown.quantity}',
            ),
          ],
        ),
      ),
    );
  }
}
