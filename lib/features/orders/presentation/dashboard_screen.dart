import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/menu_card.dart';
import '../../../core/providers.dart';
import '../../../core/section_layout.dart';
import '../../../core/shell.dart';
import '../../../l10n/l10n.dart';
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
    final l10n = context.l10n;
    final store = ref.watch(userStoreProvider);
    if (store == null) {
      return Scaffold(body: EmptyView(message: l10n.dashSignIn));
    }
    final orders = ref.watch(ordersProvider(store));
    final customers =
        ref.watch(customersProvider(store)).asData?.value ?? const [];
    final spools =
        ref.watch(filamentsProvider(store)).asData?.value ??
        const <FilamentSpool>[];
    final products =
        ref.watch(productsProvider(store)).asData?.value ?? const [];
    final settings = ref.watch(settingsProvider(store)).asData?.value;
    final currency = settings?.currencyCode ?? 'SEK';
    final names = {
      for (final customer in customers) customer.id: customer.name,
    };
    final productNames = {
      for (final product in products) product.id: product.name,
    };
    return Scaffold(
      appBar: AppBar(title: Text(l10n.navHome)),
      body: orders.when(
        data: (list) {
          final snapshot = buildDashboard(
            orders: list,
            spools: spools,
            year: _year,
            month: _month,
            customerNames: names,
            productNames: productNames,
            workshopLowStockGrams: settings?.defaultLowStockGrams ?? 100,
            l10n: l10n,
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

  List<CurrencyTotals> get _blocks {
    if (snapshot.currencyTotals.isNotEmpty) {
      return snapshot.currencyTotals;
    }
    return [
      CurrencyTotals(
        currencyCode: currencyCode,
        orderCount: snapshot.orderCount,
        revenueInclVatMinor: snapshot.revenueInclVatMinor,
        revenueExclVatMinor: snapshot.revenueExclVatMinor,
        costMinor: snapshot.costMinor,
        profitMinor: snapshot.profitMinor,
        pipelineOrderCount: snapshot.pipelineOrderCount,
        pipelineInclVatMinor: snapshot.pipelineInclVatMinor,
        openDepositMinor: snapshot.openDepositMinor,
        depositsReceivedMinor: snapshot.depositsReceivedMinor,
        finalPaymentsMinor: snapshot.finalPaymentsMinor,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final blocks = _blocks;
    final multi = snapshot.currencyTotals.length > 1;
    final noFinished = blocks.every((item) => item.orderCount == 0);
    final anyDeposits = blocks.any((item) => item.depositsReceivedMinor != 0);
    return ListView(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 24),
      children: [
        Row(
          children: [
            IconButton(
              tooltip: l10n.dashPreviousMonth,
              onPressed: onPreviousMonth,
              icon: const Icon(Icons.chevron_left),
            ),
            Expanded(
              child: Text(
                snapshot.monthLabel(Localizations.localeOf(context).toString()),
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.titleLarge,
              ),
            ),
            IconButton(
              tooltip: l10n.dashNextMonth,
              onPressed: onNextMonth,
              icon: const Icon(Icons.chevron_right),
            ),
          ],
        ),
        const SizedBox(height: 8),
        Text(
          l10n.dashDepositHint,
          style: theme.textTheme.bodySmall?.copyWith(
            color: scheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 12),
        for (var i = 0; i < blocks.length; i++) ...[
          if (i > 0) const SizedBox(height: 12),
          if (multi) ...[
            Text(blocks[i].currencyCode, style: theme.textTheme.titleMedium),
            const SizedBox(height: 8),
          ],
          _MoneyBlock(totals: blocks[i]),
        ],
        if (noFinished) ...[
          const SizedBox(height: 8),
          Text(
            anyDeposits ? l10n.dashNoRevenueDeposits : l10n.dashNoRevenue,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
        const SectionRule(),
        SectionHeading(l10n.dashOpenPipeline),
        Text(
          l10n.dashPipelineHint,
          style: theme.textTheme.bodySmall?.copyWith(
            color: scheme.onSurfaceVariant,
          ),
        ),
        const SizedBox(height: 8),
        TappableListCard(
          child: Column(
            children: [
              DetailRow(
                label: l10n.dashQuotes,
                value: '${snapshot.pipelineOrderCount}',
              ),
              for (final totals in blocks) ...[
                if (multi)
                  DetailRow(
                    label: l10n.currencyLabel,
                    value: totals.currencyCode,
                  ),
                DetailRow(
                  label: l10n.dashValueIncl,
                  value: context.money(
                    totals.pipelineInclVatMinor,
                    totals.currencyCode,
                  ),
                ),
                DetailRow(
                  label: l10n.dashOpenDeposits,
                  value: context.money(
                    totals.openDepositMinor,
                    totals.currencyCode,
                  ),
                ),
              ],
              DetailRow(
                label: l10n.dashOverdueQuotes,
                value: '${snapshot.overdueCount}',
              ),
            ],
          ),
        ),
        const SectionRule(),
        SectionHeading(l10n.dashFilamentUsed),
        if (snapshot.materials.isEmpty)
          Text(
            l10n.dashNoFilament,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          )
        else
          for (final material in snapshot.materials) ...[
            _MaterialBar(
              material: material,
              maxGrams: snapshot.materials.first.grams,
            ),
            const SizedBox(height: 8),
          ],
        const SectionRule(),
        SectionHeading(l10n.dashTopCustomers),
        if (snapshot.topCustomers.isEmpty)
          Text(
            l10n.dashNoCustomers,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          )
        else
          for (final rank in snapshot.topCustomers) ...[
            TappableListCard(
              onTap: rank.id.isEmpty || onOpenCustomer == null
                  ? null
                  : () => onOpenCustomer!(rank.id),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      rank.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      context.money(rank.totalMinor, rank.currencyCode),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            TappableListCard.listSeparator,
          ],
        const SectionRule(),
        SectionHeading(l10n.dashTopProducts),
        if (snapshot.topProducts.isEmpty)
          Text(
            l10n.dashNoProducts,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          )
        else
          for (final rank in snapshot.topProducts) ...[
            TappableListCard(
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      l10n.dashProductCount(rank.count, rank.label),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Text(
                      context.money(rank.totalMinor, rank.currencyCode),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
            TappableListCard.listSeparator,
          ],
        if (snapshot.revenueOrders.isNotEmpty) ...[
          const SectionRule(),
          SectionHeading(l10n.dashOrdersThisMonth),
          for (final row in snapshot.revenueOrders) ...[
            TappableListCard(
              onTap: onOpenOrder == null ? null : () => onOpenOrder!(row.id),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          row.title,
                          style: theme.textTheme.titleMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          row.customerLabel,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          context.money(row.totalMinor, row.currencyCode),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        OrderStatusChip(status: row.status),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            TappableListCard.listSeparator,
          ],
        ],
        const SectionRule(),
        SectionHeading(l10n.dashLowSpools),
        if (snapshot.lowSpools.isEmpty)
          Text(
            l10n.dashNoLowSpools,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
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
                        Text(
                          spool.label,
                          style: theme.textTheme.titleMedium,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          l10n.dashSpoolLeft(
                            context.gramsText(spool.remainingGrams),
                            context.gramsText(spool.thresholdGrams),
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: scheme.error,
                          ),
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

class _MoneyBlock extends StatelessWidget {
  const _MoneyBlock({required this.totals});

  final CurrencyTotals totals;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return TappableListCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DetailRow(label: l10n.dashOrders, value: '${totals.orderCount}'),
          DetailRow(
            label: l10n.dashRevenueIncl,
            value: context.money(
              totals.revenueInclVatMinor,
              totals.currencyCode,
            ),
          ),
          DetailRow(
            label: l10n.dashRevenueExcl,
            value: context.money(
              totals.revenueExclVatMinor,
              totals.currencyCode,
            ),
          ),
          DetailRow(
            label: l10n.dashCost,
            value: context.money(totals.costMinor, totals.currencyCode),
          ),
          DetailRow(
            label: l10n.dashProfit,
            value: context.money(totals.profitMinor, totals.currencyCode),
          ),
          DetailRow(
            label: l10n.dashDepositsReceived,
            value: context.money(
              totals.depositsReceivedMinor,
              totals.currencyCode,
            ),
          ),
          DetailRow(
            label: l10n.dashFinalPayments,
            value: context.money(
              totals.finalPaymentsMinor,
              totals.currencyCode,
            ),
          ),
          const SizedBox(height: 12),
          MoneyBarChart(
            currencyCode: totals.currencyCode,
            bars: [
              MoneyBar(
                label: l10n.dashInclVat,
                minor: totals.revenueInclVatMinor,
              ),
              MoneyBar(
                label: l10n.dashExclVat,
                minor: totals.revenueExclVatMinor,
              ),
              MoneyBar(label: l10n.dashCost, minor: totals.costMinor),
              MoneyBar(label: l10n.dashProfit, minor: totals.profitMinor),
            ],
          ),
        ],
      ),
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
    final fraction = maxGrams <= 0
        ? 0.0
        : (material.grams / maxGrams).clamp(0.0, 1.0);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                material.material,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            const SizedBox(width: 8),
            Text(context.gramsText(material.grams)),
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
