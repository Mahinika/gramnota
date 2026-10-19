import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/format.dart';
import '../../../core/menu_card.dart';
import '../../../core/providers.dart';
import '../../../core/section_layout.dart';
import '../../../core/shell.dart';
import '../../filaments/domain/filament_spool.dart';
import '../data/orders_providers.dart';
import '../domain/dashboard.dart';
import 'money_bar_chart.dart';
import 'order_status_style.dart';

class DashboardScreen extends ConsumerStatefulWidget {
  const DashboardScreen({super.key});

  @override
  ConsumerState<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends ConsumerState<DashboardScreen> {
  late int _year;
  late int _month;

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _year = now.year;
    _month = now.month;
  }

  void _shift(int delta) {
    final next = DateTime(_year, _month + delta);
    setState(() {
      _year = next.year;
      _month = next.month;
    });
  }

  @override
  Widget build(BuildContext context) {
    final store = ref.watch(userStoreProvider);
    if (store == null) {
      return const Scaffold(body: EmptyView(message: 'Sign in to see the workshop.'));
    }
    final orders = ref.watch(ordersProvider(store));
    final customers = ref.watch(customersProvider(store)).asData?.value ?? const [];
    final spools = ref.watch(filamentsProvider(store)).asData?.value ?? const <FilamentSpool>[];
    final settings = ref.watch(settingsProvider(store)).asData?.value;
    final currency = settings?.currencyCode ?? 'SEK';
    final names = {for (final customer in customers) customer.id: customer.name};
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      body: orders.when(
        data: (list) {
          final snapshot = buildDashboard(
            orders: list,
            spools: spools,
            year: _year,
            month: _month,
            customerNames: names,
            workshopLowStockGrams: settings?.defaultLowStockGrams ?? 100,
          );
          return DashboardView(
            snapshot: snapshot,
            currencyCode: currency,
            onPreviousMonth: () => _shift(-1),
            onNextMonth: () => _shift(1),
            onOpenOrder: (id) => context.go('/orders/$id'),
            onOpenSpool: (id) => context.go('/filaments/$id'),
            onOpenCustomer: (id) => context.go('/customers/$id'),
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => EmptyView(message: '$error'),
      ),
    );
  }
}

class DashboardView extends StatelessWidget {
  const DashboardView({
    required this.snapshot,
    required this.currencyCode,
    required this.onPreviousMonth,
    required this.onNextMonth,
    this.onOpenOrder,
    this.onOpenSpool,
    this.onOpenCustomer,
    super.key,
  });

  final DashboardSnapshot snapshot;
  final String currencyCode;
  final VoidCallback onPreviousMonth;
  final VoidCallback onNextMonth;
  final ValueChanged<String>? onOpenOrder;
  final ValueChanged<String>? onOpenSpool;
  final ValueChanged<String>? onOpenCustomer;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: [
        Row(
          children: [
            IconButton(
              tooltip: 'Previous month',
              onPressed: onPreviousMonth,
              icon: const Icon(Icons.chevron_left),
            ),
            Expanded(
              child: Text(
                snapshot.monthLabel,
                textAlign: TextAlign.center,
                style: theme.textTheme.titleLarge,
              ),
            ),
            IconButton(
              tooltip: 'Next month',
              onPressed: onNextMonth,
              icon: const Icon(Icons.chevron_right),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          'Printed and paid orders. Profit is revenue excl. VAT minus cost.',
          style: theme.textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: 12),
        TappableListCard(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DetailRow(
                label: 'Orders',
                value: '${snapshot.orderCount}',
              ),
              DetailRow(
                label: 'Revenue incl. VAT',
                value: formatMoney(snapshot.revenueInclVatMinor, currencyCode),
              ),
              DetailRow(
                label: 'Revenue excl. VAT',
                value: formatMoney(snapshot.revenueExclVatMinor, currencyCode),
              ),
              DetailRow(
                label: 'Cost',
                value: formatMoney(snapshot.costMinor, currencyCode),
              ),
              DetailRow(
                label: 'Profit',
                value: formatMoney(snapshot.profitMinor, currencyCode),
              ),
              const SizedBox(height: 12),
              MoneyBarChart(
                currencyCode: currencyCode,
                bars: [
                  MoneyBar(label: 'Incl. VAT', minor: snapshot.revenueInclVatMinor),
                  MoneyBar(label: 'Excl. VAT', minor: snapshot.revenueExclVatMinor),
                  MoneyBar(label: 'Cost', minor: snapshot.costMinor),
                  MoneyBar(label: 'Profit', minor: snapshot.profitMinor),
                ],
              ),
            ],
          ),
        ),
        if (snapshot.orderCount == 0) ...[
          const SizedBox(height: 8),
          Text(
            'No printed or paid orders this month.',
            style: theme.textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
          ),
        ],
        const SectionRule(),
        const SectionHeading('Open pipeline'),
        Text(
          'Sent and accepted quotes, not limited to this month.',
          style: theme.textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
        ),
        const SizedBox(height: 8),
        TappableListCard(
          child: Column(
            children: [
              DetailRow(
                label: 'Quotes',
                value: '${snapshot.pipelineOrderCount}',
              ),
              DetailRow(
                label: 'Value incl. VAT',
                value: formatMoney(snapshot.pipelineInclVatMinor, currencyCode),
              ),
              DetailRow(
                label: 'Deposits on open orders',
                value: formatMoney(snapshot.openDepositMinor, currencyCode),
              ),
            ],
          ),
        ),
        const SectionRule(),
        const SectionHeading('Filament used'),
        if (snapshot.materials.isEmpty)
          Text(
            'No filament recorded on printed or paid orders this month.',
            style: theme.textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
          )
        else
          for (final material in snapshot.materials) ...[
            _MaterialBar(material: material, maxGrams: snapshot.materials.first.grams),
            const SizedBox(height: 8),
          ],
        const SectionRule(),
        const SectionHeading('Top customers'),
        if (snapshot.topCustomers.isEmpty)
          Text(
            'No customer revenue this month.',
            style: theme.textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
          )
        else
          for (final rank in snapshot.topCustomers) ...[
            TappableListCard(
              onTap: rank.id.isEmpty || onOpenCustomer == null
                  ? null
                  : () => onOpenCustomer!(rank.id),
              child: Row(
                children: [
                  Expanded(child: Text(rank.label)),
                  Text(formatMoney(rank.totalMinor, currencyCode)),
                ],
              ),
            ),
            TappableListCard.listSeparator,
          ],
        const SectionRule(),
        const SectionHeading('Top products'),
        if (snapshot.topProducts.isEmpty)
          Text(
            'No products on printed or paid orders this month.',
            style: theme.textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
          )
        else
          for (final rank in snapshot.topProducts) ...[
            TappableListCard(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      rank.count == 1 ? rank.label : '${rank.label} · ${rank.count}',
                    ),
                  ),
                  Text(formatMoney(rank.totalMinor, currencyCode)),
                ],
              ),
            ),
            TappableListCard.listSeparator,
          ],
        if (snapshot.revenueOrders.isNotEmpty) ...[
          const SectionRule(),
          const SectionHeading('Orders this month'),
          for (final row in snapshot.revenueOrders) ...[
            TappableListCard(
              onTap: onOpenOrder == null ? null : () => onOpenOrder!(row.id),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(row.title, style: theme.textTheme.titleMedium),
                        Text(
                          row.customerLabel,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(formatMoney(row.totalMinor, currencyCode)),
                      const SizedBox(height: 4),
                      OrderStatusChip(status: row.status),
                    ],
                  ),
                ],
              ),
            ),
            TappableListCard.listSeparator,
          ],
        ],
        const SectionRule(),
        const SectionHeading('Low spools'),
        if (snapshot.lowSpools.isEmpty)
          Text(
            'No spool is at or under its warning threshold.',
            style: theme.textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
          )
        else
          for (final spool in snapshot.lowSpools) ...[
            TappableListCard(
              onTap: onOpenSpool == null ? null : () => onOpenSpool!(spool.id),
              child: Row(
                children: [
                  Icon(Icons.warning_amber_outlined, color: scheme.error),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(spool.label, style: theme.textTheme.titleMedium),
                        Text(
                          '${formatGrams(spool.remainingGrams)} left · warns at ${formatGrams(spool.thresholdGrams)}',
                          style: theme.textTheme.bodySmall?.copyWith(color: scheme.error),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            TappableListCard.listSeparator,
          ],
      ],
    );
  }
}

class _MaterialBar extends StatelessWidget {
  const _MaterialBar({required this.material, required this.maxGrams});

  final DashboardMaterial material;
  final double maxGrams;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final fraction = maxGrams <= 0 ? 0.0 : (material.grams / maxGrams).clamp(0.0, 1.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(child: Text(material.material)),
            Text(formatGrams(material.grams)),
          ],
        ),
        const SizedBox(height: 4),
        ClipRRect(
          borderRadius: BorderRadius.circular(99),
          child: LinearProgressIndicator(
            value: fraction == 0 ? 0 : fraction,
            minHeight: 8,
            color: scheme.primary,
            backgroundColor: scheme.surfaceContainerHighest,
          ),
        ),
      ],
    );
  }
}
