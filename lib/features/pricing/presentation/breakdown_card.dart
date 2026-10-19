import 'package:flutter/material.dart';
import 'package:gramnota/l10n/l10n.dart';

import '../../../core/section_layout.dart';
import '../domain/price_breakdown.dart';

class BreakdownCard extends StatelessWidget {
  const BreakdownCard({
    required this.breakdown,
    required this.currencyCode,
    this.showPerUnit = true,
    super.key,
  });

  final PriceBreakdown breakdown;
  final String currencyCode;

  /// A quote with several different prints has no single unit price.
  final bool showPerUnit;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final rows = [
      (l10n.calcMaterial, breakdown.materialMinor),
      (l10n.setupElectricity, breakdown.electricityMinor),
      (l10n.calcMachineWear, breakdown.machineMinor),
      (l10n.calcFailureBuffer, breakdown.failureMinor),
      (l10n.setupLabor, breakdown.laborMinor),
      (l10n.calcExtras, breakdown.extrasMinor),
      (l10n.calcCost, breakdown.costMinor),
      (l10n.setupMarkup, breakdown.markupMinor),
      (l10n.calcNet, breakdown.netMinor),
      (l10n.setupVatShort, breakdown.vatMinor),
    ];
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            for (final row in rows)
              DetailRow(
                label: row.$1,
                value: context.money(row.$2, currencyCode),
              ),
            const Divider(),
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.calcTotal,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
                const SizedBox(width: 8),
                Flexible(
                  child: Text(
                    context.money(breakdown.totalMinor, currencyCode),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.end,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            if (showPerUnit)
              Text(
                l10n.calcPerUnit(
                  context.money(breakdown.perUnitMinor, currencyCode),
                  breakdown.quantity,
                ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
          ],
        ),
      ),
    );
  }
}
