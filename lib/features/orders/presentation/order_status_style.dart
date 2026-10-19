import 'package:flutter/material.dart';

import '../../../l10n/l10n.dart';
import '../domain/print_order.dart';

Color orderStatusColor(OrderStatus status, ColorScheme scheme) {
  return switch (status) {
    OrderStatus.quote => scheme.secondary,
    OrderStatus.sent => scheme.primary,
    OrderStatus.accepted => scheme.tertiary,
    OrderStatus.printed => scheme.tertiary,
    OrderStatus.paid => scheme.primary,
    OrderStatus.declined => scheme.error,
    OrderStatus.cancelled => scheme.error,
  };
}

IconData orderStatusIcon(OrderStatus status) {
  return switch (status) {
    OrderStatus.quote => Icons.edit_outlined,
    OrderStatus.sent => Icons.outbox_outlined,
    OrderStatus.accepted => Icons.thumb_up_outlined,
    OrderStatus.printed => Icons.print_outlined,
    OrderStatus.paid => Icons.payments_outlined,
    OrderStatus.declined => Icons.thumb_down_outlined,
    OrderStatus.cancelled => Icons.cancel_outlined,
  };
}

class OrderStatusChip extends StatelessWidget {
  const OrderStatusChip({required this.status, super.key});

  final OrderStatus status;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final color = orderStatusColor(status, scheme);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(orderStatusIcon(status), size: 14, color: color),
          const SizedBox(width: 4),
          ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.sizeOf(context).width * 0.45,
            ),
            child: Text(
              orderStatusLabel(status, context.l10n),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(
                context,
              ).textTheme.labelLarge?.copyWith(color: color),
            ),
          ),
        ],
      ),
    );
  }
}

/// The seller's path from a draft quote through payment, plus the two exits.
class OrderStatusSection extends StatelessWidget {
  const OrderStatusSection({
    required this.selected,
    required this.onSelected,
    super.key,
  });

  final OrderStatus selected;
  final ValueChanged<OrderStatus> onSelected;

  static const path = [
    OrderStatus.quote,
    OrderStatus.sent,
    OrderStatus.accepted,
    OrderStatus.printed,
    OrderStatus.paid,
  ];

  static const exits = [OrderStatus.declined, OrderStatus.cancelled];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          crossAxisAlignment: WrapCrossAlignment.center,
          children: [
            for (var i = 0; i < path.length; i++) ...[
              if (i > 0)
                Icon(
                  Icons.arrow_forward,
                  size: 16,
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              _StatusChoice(
                status: path[i],
                selected: selected == path[i],
                onSelected: () => onSelected(path[i]),
              ),
            ],
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final status in exits)
              _StatusChoice(
                status: status,
                selected: selected == status,
                onSelected: () => onSelected(status),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          stockRuleSummary(context.l10n),
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}

class _StatusChoice extends StatelessWidget {
  const _StatusChoice({
    required this.status,
    required this.selected,
    required this.onSelected,
  });

  final OrderStatus status;
  final bool selected;
  final VoidCallback onSelected;

  @override
  Widget build(BuildContext context) {
    return FilterChip(
      avatar: Icon(orderStatusIcon(status), size: 16),
      label: ConstrainedBox(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width - 80,
        ),
        child: Text(
          orderStatusLabel(status, context.l10n),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
      ),
      selected: selected,
      showCheckmark: false,
      onSelected: (_) => onSelected(),
    );
  }
}

class StockWarningBanner extends StatelessWidget {
  const StockWarningBanner({required this.messages, super.key});

  final List<String> messages;

  @override
  Widget build(BuildContext context) {
    final visible = [
      for (final message in messages)
        if (message.trim().isNotEmpty) message.trim(),
    ];
    if (visible.isEmpty) {
      return const SizedBox.shrink();
    }
    final scheme = Theme.of(context).colorScheme;
    return Material(
      color: scheme.errorContainer.withValues(alpha: 0.55),
      borderRadius: BorderRadius.circular(12),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(Icons.warning_amber_outlined, color: scheme.onErrorContainer),
            const SizedBox(width: 12),
            Expanded(child: Text(visible.join('\n\n'))),
          ],
        ),
      ),
    );
  }
}
