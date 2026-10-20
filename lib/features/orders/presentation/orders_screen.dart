import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/format.dart';
import '../../../core/save_feedback.dart';
import '../../../core/locale_pickers.dart';
import '../../../core/money.dart';
import '../../../core/text_prompt.dart';
import '../../../core/menu_card.dart';
import '../../../core/section_layout.dart';
import '../../../core/providers.dart';
import '../../../core/shell.dart';
import '../../../core/user_store.dart';
import '../../../l10n/l10n.dart';
import '../../catalog/domain/catalog_product.dart';
import '../../customers/domain/customer.dart';
import '../../customers/presentation/customer_quote_picker.dart';
import '../../filaments/domain/filament_spool.dart';
import '../../printers/domain/printer_profile.dart';
import '../../settings/domain/workshop_settings.dart';
import '../../sharing/domain/inbox_item.dart';
import '../../sharing/presentation/inbox_screen.dart';
import '../../pricing/presentation/breakdown_card.dart';
import '../data/order_stock.dart';
import '../data/orders_providers.dart';
import '../domain/duplicate_quote.dart';
import '../domain/print_order.dart';
import '../domain/stock_coverage.dart';
import 'order_status_style.dart';
import 'quote_actions.dart';
import 'quote_pdf.dart';

Future<void> _assignOrderCustomer(
  BuildContext context,
  UserStore store,
  PrintOrder order,
  List<Customer> customers,
) async {
  final id = await pickCustomerId(
    context,
    store,
    customers,
    title: context.l10n.orderLinkCustomer,
  );
  if (id == null || !context.mounted) {
    return;
  }
  try {
    await store.updateOrderCustomer(orderId: order.id, customerId: id);
  } on Object {
    if (context.mounted) {
      showSaveError(context, context.l10n.orderCustomerSaveFailed);
    }
  }
}

Widget _chipLabel(BuildContext context, String text) {
  return ConstrainedBox(
    constraints: BoxConstraints(
      maxWidth: MediaQuery.sizeOf(context).width - 64,
    ),
    child: Text(text, maxLines: 1, overflow: TextOverflow.ellipsis),
  );
}

String _formatOrderUpdated(String iso, AppLocalizations l10n, String locale) {
  try {
    final updated = DateTime.parse(iso).toLocal();
    final now = DateTime.now();
    final day = DateTime(updated.year, updated.month, updated.day);
    final today = DateTime(now.year, now.month, now.day);
    final delta = today.difference(day).inDays;
    if (delta == 0) {
      return l10n.orderUpdatedToday;
    }
    if (delta == 1) {
      return l10n.orderUpdatedYesterday;
    }
    if (delta < 7) {
      return l10n.orderUpdatedDaysAgo(delta);
    }
    return l10n.orderUpdatedOn(formatIsoDate(iso, locale: locale));
  } on FormatException {
    return '';
  }
}

class OrdersScreen extends ConsumerStatefulWidget {
  const OrdersScreen({super.key});

  @override
  ConsumerState<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends ConsumerState<OrdersScreen> {
  OrderStatus? _filter;
  var _inProgressOnly = false;
  var _overdueOnly = false;
  final _search = TextEditingController();

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final store = ref.watch(userStoreProvider);
    if (store == null) {
      return Scaffold(body: EmptyView(message: l10n.orderSignIn));
    }
    final orders = ref.watch(ordersProvider(store));
    final customers =
        ref.watch(customersProvider(store)).asData?.value ?? const [];
    final customerNames = {
      for (final customer in customers) customer.id: customer.name,
    };
    return Scaffold(
      appBar: AppBar(title: Text(l10n.navOrders)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/calculator'),
        tooltip: l10n.orderNewQuote,
        child: const Icon(Icons.add),
      ),
      body: orders.when(
        data: (list) {
          if (list.isEmpty) {
            return EmptyView(
              message: l10n.orderEmpty,
              action: FilledButton(
                onPressed: () => context.go('/calculator'),
                child: Text(l10n.orderOpenCalculator),
              ),
            );
          }
          final sorted = [...list]
            ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
          final query = _search.text.trim().toLowerCase();
          final visible = sorted.where((order) {
            if (_overdueOnly && !quoteIsExpired(order, DateTime.now())) {
              return false;
            }
            if (_inProgressOnly && !statusIsInProgress(order.status)) {
              return false;
            }
            if (_filter != null && order.status != _filter) {
              return false;
            }
            if (query.isEmpty) {
              return true;
            }
            if (order.title.toLowerCase().contains(query)) {
              return true;
            }
            if ('${order.quoteNumber}'.contains(query)) {
              return true;
            }
            if (order.note.toLowerCase().contains(query)) {
              return true;
            }
            final name = customerNames[order.customerId];
            return name != null && name.toLowerCase().contains(query);
          }).toList();
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: TextField(
                  controller: _search,
                  decoration: InputDecoration(
                    hintText: l10n.orderSearchHint,
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FilterChip(
                      label: _chipLabel(context, l10n.orderFilterAll),
                      selected:
                          _filter == null && !_inProgressOnly && !_overdueOnly,
                      showCheckmark: false,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      onSelected: (_) => setState(() {
                        _filter = null;
                        _inProgressOnly = false;
                        _overdueOnly = false;
                      }),
                    ),
                    FilterChip(
                      label: _chipLabel(context, l10n.orderFilterInProgress),
                      selected: _inProgressOnly,
                      showCheckmark: false,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      onSelected: (_) => setState(() {
                        _inProgressOnly = !_inProgressOnly;
                        if (_inProgressOnly) {
                          _filter = null;
                          _overdueOnly = false;
                        }
                      }),
                    ),
                    FilterChip(
                      label: _chipLabel(context, l10n.orderFilterOverdue),
                      selected: _overdueOnly,
                      showCheckmark: false,
                      materialTapTargetSize: MaterialTapTargetSize.padded,
                      onSelected: (_) => setState(() {
                        _overdueOnly = !_overdueOnly;
                        if (_overdueOnly) {
                          _filter = null;
                          _inProgressOnly = false;
                        }
                      }),
                    ),
                    for (final status in OrderStatus.values)
                      FilterChip(
                        label: _chipLabel(
                          context,
                          orderStatusLabel(status, l10n),
                        ),
                        selected: _filter == status,
                        showCheckmark: false,
                        materialTapTargetSize: MaterialTapTargetSize.padded,
                        onSelected: (_) => setState(() {
                          _filter = status;
                          _inProgressOnly = false;
                          _overdueOnly = false;
                        }),
                      ),
                  ],
                ),
              ),
              if (visible.isNotEmpty)
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 4),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      l10n.orderQuoteCount(visible.length),
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
              Expanded(
                child: visible.isEmpty
                    ? EmptyView(message: l10n.orderNoMatch)
                    : ListView.separated(
                        padding: TappableListCard.listPadding,
                        itemCount: visible.length,
                        separatorBuilder: (_, _) =>
                            TappableListCard.listSeparator,
                        itemBuilder: (context, index) {
                          final order = visible[index];
                          return _OrderListCard(
                            order: order,
                            customerName: customerNames[order.customerId],
                            onTap: () => context.go('/orders/${order.id}'),
                          );
                        },
                      ),
              ),
            ],
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => EmptyView(message: '$error'),
      ),
    );
  }
}

class _OrderListCard extends StatelessWidget {
  const _OrderListCard({
    required this.order,
    required this.onTap,
    this.customerName,
  });

  final PrintOrder order;
  final String? customerName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final statusColor = orderStatusColor(order.status, scheme);
    final expired = quoteIsExpired(order, DateTime.now());
    final note = order.note.trim();
    final prints = orderPrints(order);
    final updated = _formatOrderUpdated(
      order.updatedAt,
      l10n,
      context.formattingLocale,
    );
    return TappableListCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.orderQuoteNumber(order.quoteNumber),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: MediaQuery.sizeOf(context).width * 0.4,
                  ),
                  child: Text(
                    orderStatusLabel(order.status, l10n),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: statusColor,
                    ),
                  ),
                ),
              ),
              if (expired) ...[
                const SizedBox(width: 6),
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 2,
                  ),
                  decoration: BoxDecoration(
                    color: scheme.errorContainer,
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    l10n.orderFilterOverdue,
                    style: theme.textTheme.labelMedium?.copyWith(
                      color: scheme.onErrorContainer,
                    ),
                  ),
                ),
              ],
            ],
          ),
          const SizedBox(height: 6),
          Text(
            order.title,
            style: theme.textTheme.titleMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          if (customerName != null && customerName!.isNotEmpty) ...[
            const SizedBox(height: 2),
            Row(
              children: [
                Icon(
                  Icons.person_outline,
                  size: 16,
                  color: scheme.onSurfaceVariant,
                ),
                const SizedBox(width: 4),
                Expanded(
                  child: Text(
                    customerName!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ],
          if (note.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              note,
              style: theme.textTheme.bodySmall?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          const SizedBox(height: 8),
          Row(
            children: [
              Expanded(
                child: Text(
                  context.money(order.breakdown.totalMinor, order.currencyCode),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: scheme.primary,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  l10n.orderPrintCount(prints.length),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
            ],
          ),
          if (updated.isNotEmpty) ...[
            const SizedBox(height: 4),
            Text(
              updated,
              style: theme.textTheme.bodySmall?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class OrderDetailScreen extends ConsumerWidget {
  const OrderDetailScreen({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(userStoreProvider);
    final l10n = context.l10n;
    if (store == null) {
      return Scaffold(body: EmptyView(message: l10n.orderSignInQuote));
    }
    final orders = ref.watch(ordersProvider(store));
    final settings = ref.watch(settingsProvider(store));
    final customers = ref.watch(customersProvider(store));
    final filaments = ref.watch(filamentsProvider(store));
    final printers = ref.watch(printersProvider(store));
    return orders.when(
      data: (list) {
        final matches = list.where((order) => order.id == id);
        if (matches.isEmpty) {
          return Scaffold(body: EmptyView(message: l10n.orderNotFound));
        }
        final order = matches.first;
        final customer = customers.asData?.value
            .where((item) => item.id == order.customerId)
            .cast<Customer?>()
            .firstOrNull;
        final spools = filaments.asData?.value ?? const <FilamentSpool>[];
        final printerList = printers.asData?.value ?? const <PrinterProfile>[];
        final products =
            ref.watch(productsProvider(store)).asData?.value ??
            const <CatalogProduct>[];
        final workshop = settings.asData?.value ?? const WorkshopSettings();
        final prints = orderPrints(order);
        final locked = order.stockDeducted;
        final coverage = quoteSpoolCoverage(
          order: order,
          orders: list,
          spools: spools,
        );
        return Scaffold(
          appBar: AppBar(
            title: Text(l10n.orderQuoteNumber(order.quoteNumber)),
            actions: [
              IconButton(
                tooltip: l10n.orderPreview,
                onPressed: () => openQuotePdfPreview(
                  context,
                  order: order,
                  settings: workshop,
                  customer: customer,
                ),
                icon: const Icon(Icons.picture_as_pdf_outlined),
              ),
              IconButton(
                tooltip: l10n.orderSendToUser,
                onPressed: () => sendItem(
                  context: context,
                  store: store,
                  type: SharedItemType.order,
                  payload: order.toJson(),
                ),
                icon: const Icon(Icons.send_outlined),
              ),
            ],
          ),
          body: ListView(
            padding: const EdgeInsets.all(16),
            children: [
              TappableListCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Text(
                            order.title,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                        IconButton(
                          tooltip: l10n.orderEditTitle,
                          onPressed: () => _renameQuote(context, store, order),
                          icon: const Icon(Icons.edit_outlined),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        OrderStatusChip(status: order.status),
                        const Spacer(),
                        Text(
                          context.money(
                            order.breakdown.totalMinor,
                            order.currencyCode,
                          ),
                          style: Theme.of(context).textTheme.titleLarge
                              ?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ],
                    ),
                    if (order.validUntil.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        quoteIsExpired(order, DateTime.now())
                            ? l10n.orderOverdueUntil(
                                context.dateText(order.validUntil),
                              )
                            : l10n.orderValidUntil(
                                context.dateText(order.validUntil),
                              ),
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          color: quoteIsExpired(order, DateTime.now())
                              ? Theme.of(context).colorScheme.error
                              : Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                    if (_formatOrderUpdated(
                      order.updatedAt,
                      l10n,
                      context.formattingLocale,
                    ).isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        _formatOrderUpdated(
                          order.updatedAt,
                          l10n,
                          context.formattingLocale,
                        ),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: Theme.of(context).colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (order.stockWarning.isNotEmpty) ...[
                const SizedBox(height: 8),
                StockWarningBanner(messages: [order.stockWarning]),
              ],
              if (coverage.isNotEmpty) ...[
                const SizedBox(height: 8),
                StockWarningBanner(
                  messages: [
                    for (final item in coverage) item.messageFor(l10n),
                  ],
                ),
              ],
              const SizedBox(height: 12),
              TappableListCard(
                onTap: customer == null
                    ? () => _assignOrderCustomer(
                        context,
                        store,
                        order,
                        customers.asData?.value ?? const [],
                      )
                    : () => context.go('/customers/${customer.id}'),
                child: Row(
                  children: [
                    CircleAvatar(
                      backgroundColor: Theme.of(
                        context,
                      ).colorScheme.primaryContainer,
                      foregroundColor: Theme.of(
                        context,
                      ).colorScheme.onPrimaryContainer,
                      child: Text(customer?.initials ?? '?'),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            customer?.name ?? l10n.orderNoCustomerLinked,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          Text(
                            customer == null
                                ? l10n.orderTapToLink
                                : customer.addressLine.isEmpty
                                ? l10n.orderViewCustomer
                                : customer.addressLine,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: Theme.of(context).textTheme.bodyMedium
                                ?.copyWith(
                                  color: Theme.of(
                                    context,
                                  ).colorScheme.onSurfaceVariant,
                                ),
                          ),
                        ],
                      ),
                    ),
                    if (customer != null)
                      IconButton(
                        tooltip: l10n.orderChangeCustomer,
                        visualDensity: VisualDensity.compact,
                        onPressed: () => _assignOrderCustomer(
                          context,
                          store,
                          order,
                          customers.asData?.value ?? const [],
                        ),
                        icon: const Icon(Icons.edit_outlined),
                      ),
                    const Icon(Icons.chevron_right),
                  ],
                ),
              ),
              const SectionRule(),
              _OrderNoteField(order: order, store: store),
              const SizedBox(height: 12),
              QuoteLanguageMenu(
                quoteLanguage: order.quoteLanguage,
                onChanged: (language) {
                  if (language == order.quoteLanguage) {
                    return;
                  }
                  store.orders.doc(order.id).update({
                    'quoteLanguage': language,
                    'updatedAt': DateTime.now().toUtc().toIso8601String(),
                  });
                },
              ),
              const SectionRule(),
              SectionHeading(l10n.orderStatusHeading),
              OrderStatusSection(
                selected: order.status,
                onSelected: (status) => _changeOrderStatus(
                  context: context,
                  store: store,
                  order: order,
                  next: status,
                  coverage: coverage,
                ),
              ),
              const SizedBox(height: 12),
              _DepositField(order: order, store: store),
              const SectionRule(),
              SectionHeading(l10n.orderNewQuote),
              Text(duplicateQuoteSummary(l10n)),
              const SizedBox(height: 8),
              Align(
                alignment: Alignment.centerLeft,
                child: FilledButton.tonal(
                  onPressed: () async {
                    final id = await duplicateQuoteAsNew(
                      context: context,
                      store: store,
                      order: order,
                      settings: workshop,
                      spools: spools,
                      printers: printerList,
                    );
                    if (id != null && context.mounted) {
                      context.go('/orders/$id');
                    }
                  },
                  child: Text(l10n.orderDuplicateAction),
                ),
              ),
              const SectionRule(),
              SectionHeading(l10n.orderPrintsHeading),
              if (!locked)
                Wrap(
                  spacing: 8,
                  children: [
                    TextButton.icon(
                      onPressed: () =>
                          context.go('/calculator?orderId=${order.id}'),
                      icon: const Icon(Icons.add),
                      label: Text(l10n.orderAddPrint),
                    ),
                    TextButton.icon(
                      onPressed: () => addProductToQuote(
                        context: context,
                        store: store,
                        order: order,
                        products: products,
                        settings: workshop,
                        spools: spools,
                        printers: printerList,
                      ),
                      icon: const Icon(Icons.inventory_2_outlined),
                      label: Text(l10n.orderAddProduct),
                    ),
                  ],
                ),
              if (locked)
                Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 8),
                  child: Text(
                    printsLockedMessage(l10n),
                    style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: Theme.of(context).colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              for (final line in prints)
                _PrintLineTile(
                  order: order,
                  line: line,
                  spools: spools,
                  printers: printerList,
                  locked: locked,
                  store: store,
                ),
              const SectionRule(),
              SectionHeading(l10n.orderPriceBreakdown),
              BreakdownCard(
                breakdown: order.breakdown,
                currencyCode: order.currencyCode,
                showPerUnit: prints.length == 1,
              ),
            ],
          ),
        );
      },
      loading: () =>
          const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, _) => Scaffold(body: EmptyView(message: '$error')),
    );
  }
}

Future<void> _changeOrderStatus({
  required BuildContext context,
  required UserStore store,
  required PrintOrder order,
  required OrderStatus next,
  required List<SpoolCoverage> coverage,
}) async {
  if (order.status == next) {
    return;
  }
  final l10n = context.l10n;
  final explanation = stockChangeExplanation(order.status, next, l10n);
  final short = statusHoldsStock(next) && !statusHoldsStock(order.status)
      ? [for (final item in coverage) item.messageFor(l10n)]
      : const <String>[];
  final blocks = [?explanation, ...short];
  if (blocks.isNotEmpty) {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.orderMarkAs(orderStatusLabel(next, l10n))),
        content: Text(blocks.join('\n\n')),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.setupBack),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.orderUpdateStatus),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) {
      return;
    }
  }
  final change = await OrderStock(store).setStatus(order: order, next: next);
  if (change.warning.isNotEmpty && context.mounted) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(change.warning)));
  }
}

class _DepositField extends StatefulWidget {
  const _DepositField({required this.order, required this.store});

  final PrintOrder order;
  final UserStore store;

  @override
  State<_DepositField> createState() => _DepositFieldState();
}

class _DepositFieldState extends State<_DepositField> {
  late final TextEditingController _amount;
  DateTime? _date;
  var _saving = false;
  String? _amountLocale;

  @override
  void initState() {
    super.initState();
    _amount = TextEditingController();
    _date = calendarDayOf(widget.order.depositAt);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context).toString();
    if (_amountLocale == locale) {
      return;
    }
    _amountLocale = locale;
    _amount.text = formatMinorField(widget.order.depositMinor, locale: locale);
  }

  @override
  void didUpdateWidget(covariant _DepositField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.order.id != widget.order.id ||
        oldWidget.order.depositMinor != widget.order.depositMinor) {
      _amount.text = formatMinorField(
        widget.order.depositMinor,
        locale: _amountLocale ?? Localizations.localeOf(context).toString(),
      );
    }
    if (oldWidget.order.id != widget.order.id ||
        oldWidget.order.depositAt != widget.order.depositAt) {
      _date = calendarDayOf(widget.order.depositAt);
    }
  }

  @override
  void dispose() {
    _amount.dispose();
    super.dispose();
  }

  String _dateLabel() {
    final date = _date;
    if (date == null) {
      return context.l10n.orderDepositDate;
    }
    return context.dateText(calendarDayStamp(date));
  }

  Future<void> _pickDate() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: _date ?? now,
      firstDate: DateTime(now.year - 10),
      lastDate: DateTime(now.year + 2),
      helpText: context.l10n.orderDepositReceived,
    );
    if (picked == null) {
      return;
    }
    setState(() => _date = DateTime(picked.year, picked.month, picked.day));
  }

  Future<void> _save() async {
    final parsed = parseMoneyInput(
      _amount.text.trim().isEmpty ? '0' : _amount.text,
      currencyCode: widget.order.currencyCode,
      locale: context.formattingLocale,
    );
    if (parsed == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.l10n.orderDepositInvalid)));
      return;
    }
    if (_saving) {
      return;
    }
    final today = DateTime.now();
    final day = parsed <= 0
        ? null
        : (_date ?? DateTime(today.year, today.month, today.day));
    final stamp = day == null ? '' : calendarDayStamp(day);
    if (parsed == widget.order.depositMinor &&
        stamp == widget.order.depositAt) {
      return;
    }
    setState(() => _saving = true);
    try {
      await widget.store.saveOrderDeposit(
        orderId: widget.order.id,
        depositMinor: parsed,
        depositAt: stamp,
      );
      if (mounted) {
        setState(() => _date = day);
      }
    } on Object {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.orderDepositSaveFailed)),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final order = widget.order;
    final balance = order.breakdown.totalMinor - order.depositMinor;
    final settled = order.status == OrderStatus.paid;
    final l10n = context.l10n;
    final balanceLabel = settled
        ? l10n.orderMarkedPaid
        : balance <= 0
        ? l10n.orderDepositCovers
        : l10n.orderStillToPay(context.money(balance, order.currencyCode));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: _amount,
          decoration: InputDecoration(
            labelText: l10n.orderDepositPaid(order.currencyCode),
            helperText: settled
                ? l10n.orderDepositPaidHelp
                : l10n.orderDepositOptionalHelp,
          ),
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          onSubmitted: (_) => _save(),
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: OutlinedButton.icon(
            onPressed: _pickDate,
            icon: const Icon(Icons.event_outlined),
            label: Text(_dateLabel()),
          ),
        ),
        const SizedBox(height: 8),
        Row(
          children: [
            Expanded(child: Text(balanceLabel)),
            TextButton(
              onPressed: _saving ? null : _save,
              child: Text(_saving ? l10n.saving : l10n.orderSaveDeposit),
            ),
          ],
        ),
      ],
    );
  }
}

class _OrderNoteField extends StatefulWidget {
  const _OrderNoteField({required this.order, required this.store});

  final PrintOrder order;
  final UserStore store;

  @override
  State<_OrderNoteField> createState() => _OrderNoteFieldState();
}

class _OrderNoteFieldState extends State<_OrderNoteField> {
  late final TextEditingController _note;
  var _saving = false;

  @override
  void initState() {
    super.initState();
    _note = TextEditingController(text: widget.order.note);
  }

  @override
  void didUpdateWidget(covariant _OrderNoteField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.order.id != widget.order.id ||
        oldWidget.order.note != widget.order.note) {
      _note.text = widget.order.note;
    }
  }

  @override
  void dispose() {
    _note.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    final next = _note.text.trim();
    if (next == widget.order.note || _saving) {
      return;
    }
    setState(() => _saving = true);
    try {
      await widget.store.saveOrderNote(orderId: widget.order.id, note: next);
    } on Object {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(context.l10n.orderNoteSaveFailed)),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return TextField(
      controller: _note,
      decoration: InputDecoration(
        labelText: l10n.orderNoteLabel,
        hintText: l10n.orderNoteHint,
        suffixIcon: _saving
            ? const Padding(
                padding: EdgeInsets.all(12),
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                ),
              )
            : IconButton(
                tooltip: l10n.orderSaveNote,
                onPressed: _save,
                icon: const Icon(Icons.check),
              ),
      ),
      minLines: 1,
      maxLines: 3,
      onSubmitted: (_) => _save(),
    );
  }
}

class _PrintLineTile extends StatelessWidget {
  const _PrintLineTile({
    required this.order,
    required this.line,
    required this.spools,
    required this.printers,
    required this.locked,
    required this.store,
  });

  final PrintOrder order;
  final QuoteLine line;
  final List<FilamentSpool> spools;
  final List<PrinterProfile> printers;
  final bool locked;
  final UserStore store;

  @override
  Widget build(BuildContext context) {
    final printer = printers
        .where((item) => item.id == line.printerId)
        .firstOrNull;
    final source = Uri.tryParse(line.sourceUrl);
    final prints = orderPrints(order);
    final calculationRoute =
        '/calculator?orderId=${order.id}&lineId=${line.id}';
    final scheme = Theme.of(context).colorScheme;
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: TappableListCard(
        onTap: locked ? null : () => context.go(calculationRoute),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    line.title,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                IconButton(
                  tooltip: context.l10n.orderSaveAsProduct,
                  onPressed: () => saveLineAsProduct(
                    context: context,
                    store: store,
                    order: order,
                    line: line,
                  ),
                  icon: const Icon(Icons.bookmark_add_outlined),
                ),
                if (!locked) ...[
                  IconButton(
                    tooltip: context.l10n.orderOpenCalculation,
                    onPressed: () => context.go(calculationRoute),
                    icon: const Icon(Icons.edit_outlined),
                  ),
                  if (prints.length > 1)
                    IconButton(
                      tooltip: context.l10n.orderRemovePrint,
                      onPressed: () =>
                          _removePrint(context, store, order, line),
                      icon: const Icon(Icons.delete_outline),
                    ),
                ],
              ],
            ),
            Text(
              context.l10n.orderLineQty(
                line.quantity,
                formatDuration(line.printTimeSeconds),
              ),
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(color: scheme.onSurfaceVariant),
            ),
            Text(
              context.l10n.orderInclVat(
                context.money(line.breakdown.totalMinor, order.currencyCode),
              ),
              style: Theme.of(
                context,
              ).textTheme.titleSmall?.copyWith(color: scheme.primary),
            ),
            if (printer != null) ...[
              const SizedBox(height: 4),
              Text(printer.name),
            ],
            if (line.filaments.isEmpty)
              Text(context.l10n.orderNoFilament)
            else
              for (final usage in line.filaments)
                Text(
                  _filamentLine(context, usage, spools),
                  style: Theme.of(context).textTheme.bodySmall,
                ),
            if (line.sourceProfileTitle.isNotEmpty)
              Text(
                line.sourceProfileTitle,
                style: Theme.of(context).textTheme.bodySmall,
              ),
            if (source != null && source.hasScheme) ...[
              const SizedBox(height: 4),
              Text(
                line.sourceUrl,
                style: Theme.of(
                  context,
                ).textTheme.bodySmall?.copyWith(color: scheme.onSurfaceVariant),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Wrap(
                spacing: 8,
                children: [
                  TextButton(
                    onPressed: () =>
                        launchUrl(source, mode: LaunchMode.externalApplication),
                    child: Text(context.l10n.orderOpenModel),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}

Future<void> _renameQuote(
  BuildContext context,
  UserStore store,
  PrintOrder order,
) async {
  final l10n = context.l10n;
  final next = await promptForText(
    context,
    title: l10n.orderQuoteTitlePrompt,
    label: l10n.orderTitleLabel,
    initialText: order.title,
    confirmLabel: l10n.actionSave,
  );
  if (next == null || next.isEmpty) {
    return;
  }
  await store.saveOrderTitle(orderId: order.id, title: next);
}

Future<void> _removePrint(
  BuildContext context,
  UserStore store,
  PrintOrder order,
  QuoteLine line,
) async {
  if (order.stockDeducted) {
    showSaveError(context, context.l10n.calcPrintsLocked);
    return;
  }
  final l10n = context.l10n;
  final confirmed = await confirmDelete(
    context,
    title: l10n.orderRemovePrint,
    message: l10n.orderRemovePrintMessage(line.title),
  );
  if (!confirmed) {
    return;
  }
  final next = [
    for (final item in orderPrints(order))
      if (item.id != line.id) item,
  ];
  if (next.isEmpty) {
    return;
  }
  try {
    await store.replaceOrderPrints(
      orderId: order.id,
      lines: next,
      title: quoteTitleFor(order, next),
    );
  } on OrderPrintsLocked {
    if (context.mounted) {
      showSaveError(context, context.l10n.calcPrintsLocked);
    }
  } on Object {
    if (context.mounted) {
      showSaveError(context, context.l10n.calcSavePrintFailed);
    }
  }
}

String _filamentLine(
  BuildContext context,
  FilamentUsage usage,
  List<FilamentSpool> spools,
) {
  final spool = spools.where((item) => item.id == usage.filamentId).firstOrNull;
  final material = usage.material.isNotEmpty
      ? usage.material
      : spool?.material ?? '';
  final name = [
    spool?.brand ?? '',
    material,
  ].where((part) => part.trim().isNotEmpty).join(' ');
  if (name.isEmpty) {
    return context.gramsText(usage.grams);
  }
  return '${context.gramsText(usage.grams)} $name';
}
