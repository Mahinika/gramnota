import 'package:flutter/material.dart';

/// Section title above a block of rows or cards (More, Orders filters, etc.).
class SectionHeading extends StatelessWidget {
  const SectionHeading(this.text, {super.key});

  final String text;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(text, style: Theme.of(context).textTheme.titleMedium),
    );
  }
}

/// Label on the left, value on the right — same rhythm as [BreakdownCard].
class DetailRow extends StatelessWidget {
  const DetailRow({
    required this.label,
    required this.value,
    this.dense = false,
    super.key,
  });

  final String label;
  final String value;
  final bool dense;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final style = dense ? theme.textTheme.bodySmall : theme.textTheme.bodyMedium;
    return Padding(
      padding: EdgeInsets.symmetric(vertical: dense ? 1 : 2),
      child: Row(
        children: [
          Expanded(child: Text(label, style: style)),
          Text(value, style: style),
        ],
      ),
    );
  }
}

/// Space + line between major blocks on a scroll screen.
class SectionRule extends StatelessWidget {
  const SectionRule({super.key});

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 16),
      child: Divider(height: 1),
    );
  }
}
