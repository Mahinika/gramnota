import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';

class MoneyBar {
  const MoneyBar({required this.label, required this.minor});

  final String label;
  final int minor;
}

/// Vertical bars for a few money totals. Zero months draw the labels only.
class MoneyBarChart extends StatelessWidget {
  const MoneyBarChart({
    required this.bars,
    required this.currencyCode,
    super.key,
  });

  final List<MoneyBar> bars;
  final String currencyCode;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final maxMinor = bars.fold<int>(0, (max, bar) {
      final abs = bar.minor.abs();
      return abs > max ? abs : max;
    });
    if (maxMinor == 0) {
      return Text(
        context.l10n.dashNothingToChart,
        style: theme.textTheme.bodyMedium?.copyWith(
          color: scheme.onSurfaceVariant,
        ),
      );
    }
    final colors = [
      scheme.primary,
      scheme.tertiary,
      scheme.secondary,
      scheme.primaryContainer,
    ];
    return SizedBox(
      height: 168,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          for (var i = 0; i < bars.length; i++)
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4),
                child: _BarColumn(
                  bar: bars[i],
                  currencyCode: currencyCode,
                  fraction: bars[i].minor.abs() / maxMinor,
                  color: colors[i % colors.length],
                  negative: bars[i].minor < 0,
                ),
              ),
            ),
        ],
      ),
    );
  }
}

class _BarColumn extends StatelessWidget {
  const _BarColumn({
    required this.bar,
    required this.currencyCode,
    required this.fraction,
    required this.color,
    required this.negative,
  });

  final MoneyBar bar;
  final String currencyCode;
  final double fraction;
  final Color color;
  final bool negative;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final height = (112 * fraction).clamp(4.0, 112.0);
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          context.money(bar.minor, currencyCode),
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.labelSmall,
        ),
        const SizedBox(height: 4),
        AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          height: height,
          decoration: BoxDecoration(
            color: negative ? theme.colorScheme.error : color,
            borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
          ),
        ),
        const SizedBox(height: 6),
        Text(
          bar.label,
          textAlign: TextAlign.center,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: theme.textTheme.labelSmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
