import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/format.dart';
import '../../../core/menu_card.dart';
import '../../../core/section_layout.dart';
import '../../../core/providers.dart';
import '../../../core/shell.dart';
import '../../../core/user_store.dart';
import '../../customers/domain/customer.dart';
import '../../filaments/domain/filament_spool.dart';
import '../../printers/domain/printer_profile.dart';
import '../../settings/domain/workshop_settings.dart';
import '../../sharing/domain/inbox_item.dart';
import '../../sharing/presentation/inbox_screen.dart';
import '../../pricing/presentation/breakdown_card.dart';
import '../data/order_stock.dart';
import '../data/orders_providers.dart';
import '../domain/print_order.dart';
import 'quote_pdf.dart';

Color _orderStatusColor(OrderStatus status, ColorScheme scheme) {
  return switch (status) {
    OrderStatus.quote => scheme.secondary,
    OrderStatus.accepted => scheme.primary,
    OrderStatus.printed => scheme.tertiary,
    OrderStatus.delivered => scheme.primary,
    OrderStatus.cancelled => scheme.error,
  };
}

String _formatOrderUpdated(String iso) {
  try {
    final updated = DateTime.parse(iso).toLocal();
    final now = DateTime.now();
    final day = DateTime(updated.year, updated.month, updated.day);
    final today = DateTime(now.year, now.month, now.day);
    final delta = today.difference(day).inDays;
    if (delta == 0) {
      return 'Updated today';
    }
    if (delta == 1) {
      return 'Updated yesterday';
    }
    if (delta < 7) {
      return 'Updated $delta days ago';
    }
    final month = updated.month.toString().padLeft(2, '0');
    final dayText = updated.day.toString().padLeft(2, '0');
    return 'Updated ${updated.year}-$month-$dayText';
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
  final _search = TextEditingController();

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store = ref.watch(userStoreProvider);
    if (store == null) {
      return const Scaffold(body: EmptyView(message: 'Sign in to see orders.'));
    }
    final orders = ref.watch(ordersProvider(store));
    final customers = ref.watch(customersProvider(store)).asData?.value ?? const [];
    final customerNames = {
      for (final customer in customers) customer.id: customer.name,
    };
    return Scaffold(
      appBar: AppBar(title: const Text('Orders')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/calculator'),
        tooltip: 'New quote',
        child: const Icon(Icons.add),
      ),
      body: orders.when(
        data: (list) {
          if (list.isEmpty) {
            return EmptyView(
              message: 'No quotes yet. Price a print in the calculator and save.',
              action: FilledButton(
                onPressed: () => context.go('/calculator'),
                child: const Text('Open calculator'),
              ),
            );
          }
          final sorted = [...list]
            ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
          final query = _search.text.trim().toLowerCase();
          final visible = sorted.where((order) {
            if (_inProgressOnly &&
                order.status != OrderStatus.quote &&
                order.status != OrderStatus.accepted &&
                order.status != OrderStatus.printed) {
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
                  decoration: const InputDecoration(
                    hintText: 'Title, quote no., customer, or note',
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),
              SizedBox(
                height: 56,
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: const Text('All'),
                        selected: _filter == null && !_inProgressOnly,
                        showCheckmark: false,
                        onSelected: (_) => setState(() {
                          _filter = null;
                          _inProgressOnly = false;
                        }),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 8),
                      child: FilterChip(
                        label: const Text('In progress'),
                        selected: _inProgressOnly,
                        showCheckmark: false,
                        onSelected: (_) => setState(() {
                          _inProgressOnly = !_inProgressOnly;
                          if (_inProgressOnly) {
                            _filter = null;
                          }
                        }),
                      ),
                    ),
                    for (final status in OrderStatus.values)
                      Padding(
                        padding: const EdgeInsets.only(right: 8),
                        child: FilterChip(
                          label: Text(orderStatusLabel(status)),
                          selected: _filter == status,
                          showCheckmark: false,
                          onSelected: (_) => setState(() {
                            _filter = status;
                            _inProgressOnly = false;
                          }),
                        ),
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
                      visible.length == 1
                          ? '1 quote'
                          : '${visible.length} quotes',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ),
                ),
              Expanded(
                child: visible.isEmpty
                    ? const EmptyView(
                        message: 'No orders match your search or filter.',
                      )
                    : ListView.separated(
                        padding: TappableListCard.listPadding,
                        itemCount: visible.length,
                        separatorBuilder: (_, _) => TappableListCard.listSeparator,
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
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final statusColor = _orderStatusColor(order.status, scheme);
    final note = order.note.trim();
    final prints = orderPrints(order);
    final updated = _formatOrderUpdated(order.updatedAt);
    return TappableListCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Quote ${order.quoteNumber}',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 2,
                ),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  orderStatusLabel(order.status),
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: statusColor,
                  ),
                ),
              ),
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
              Text(
                formatMoney(order.breakdown.totalMinor, order.currencyCode),
                style: theme.textTheme.titleMedium?.copyWith(
                  color: scheme.primary,
                ),
              ),
              const Spacer(),
              Text(
                prints.length == 1 ? '1 print' : '${prints.length} prints',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
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
    if (store == null) {
      return const Scaffold(body: EmptyView(message: 'Sign in to see this quote.'));
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
          return const Scaffold(body: EmptyView(message: 'Quote not found.'));
        }
        final order = matches.first;
        final customer = customers.asData?.value
            .where((item) => item.id == order.customerId)
            .cast<Customer?>()
            .firstOrNull;
        final spools = filaments.asData?.value ?? const <FilamentSpool>[];
        final printerList = printers.asData?.value ?? const <PrinterProfile>[];
        final prints = orderPrints(order);
        final locked = order.stockDeducted;
        return Scaffold(
          appBar: AppBar(
            title: Text('Quote ${order.quoteNumber}'),
            actions: [
              IconButton(
                tooltip: 'Share quote',
                onPressed: () async {
                  try {
                    await shareQuotePdf(
                      order: order,
                      settings:
                          settings.asData?.value ?? const WorkshopSettings(),
                      customer: customer,
                    );
                  } on Object catch (error) {
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('Could not share the quote. $error'),
                        ),
                      );
                    }
                  }
                },
                icon: const Icon(Icons.ios_share),
              ),
              IconButton(
                tooltip: 'Send to user',
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
                            style: Theme.of(context).textTheme.headlineSmall,
                          ),
                        ),
                        IconButton(
                          tooltip: 'Edit title',
                          onPressed: () => _renameQuote(context, store, order),
                          icon: const Icon(Icons.edit_outlined),
                        ),
                      ],
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        _StatusChip(
                          status: order.status,
                          scheme: Theme.of(context).colorScheme,
                        ),
                        const Spacer(),
                        Text(
                          formatMoney(
                            order.breakdown.totalMinor,
                            order.currencyCode,
                          ),
                          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                color: Theme.of(context).colorScheme.primary,
                              ),
                        ),
                      ],
                    ),
                    if (order.validUntil.isNotEmpty) ...[
                      const SizedBox(height: 8),
                      Text(
                        'Valid until ${formatIsoDate(order.validUntil)}',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                      ),
                    ],
                    if (_formatOrderUpdated(order.updatedAt).isNotEmpty) ...[
                      const SizedBox(height: 4),
                      Text(
                        _formatOrderUpdated(order.updatedAt),
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                              color: Theme.of(context)
                                  .colorScheme
                                  .onSurfaceVariant,
                            ),
                      ),
                    ],
                  ],
                ),
              ),
              if (order.stockWarning.isNotEmpty) ...[
                const SizedBox(height: 8),
                MaterialBanner(
                  content: Text(order.stockWarning),
                  leading: const Icon(Icons.warning_amber_outlined),
                  backgroundColor: Theme.of(context)
                      .colorScheme
                      .errorContainer
                      .withValues(alpha: 0.5),
                  actions: const [SizedBox.shrink()],
                ),
              ],
              const SizedBox(height: 12),
              if (customer == null)
                const TappableListCard(child: Text('No customer linked'))
              else
                TappableListCard(
                  onTap: () => context.go('/customers/${customer.id}'),
                  child: Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              customer.name,
                              style: Theme.of(context).textTheme.titleMedium,
                            ),
                            Text(
                              customer.addressLine.isEmpty
                                  ? 'View customer'
                                  : customer.addressLine,
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyMedium
                                  ?.copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onSurfaceVariant,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      const Icon(Icons.chevron_right),
                    ],
                  ),
                ),
              const SectionRule(),
              _OrderNoteField(order: order, store: store),
              const SectionRule(),
              const SectionHeading('Status'),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final status in OrderStatus.values)
                    FilterChip(
                      label: Text(orderStatusLabel(status)),
                      selected: order.status == status,
                      showCheckmark: false,
                      onSelected: (_) async {
                        final change = await OrderStock(store).setStatus(
                          order: order,
                          next: status,
                        );
                        if (change.warning.isNotEmpty && context.mounted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text(change.warning)),
                          );
                        }
                      },
                    ),
                ],
              ),
              const SectionRule(),
              Row(
                children: [
                  const Expanded(child: SectionHeading('Prints')),
                  if (!locked)
                    TextButton.icon(
                      onPressed: () => context.go(
                        '/calculator?orderId=${order.id}',
                      ),
                      icon: const Icon(Icons.add),
                      label: const Text('Add print'),
                    ),
                ],
              ),
              if (locked)
                Padding(
                  padding: const EdgeInsets.only(top: 4, bottom: 8),
                  child: Text(
                    'Move the order back to Accepted before changing prints.',
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
              const SectionHeading('Price breakdown'),
              BreakdownCard(
                breakdown: order.breakdown,
                currencyCode: order.currencyCode,
                showPerUnit: prints.length == 1,
              ),
            ],
          ),
        );
      },
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, _) => Scaffold(body: EmptyView(message: '$error')),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({required this.status, required this.scheme});

  final OrderStatus status;
  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final color = _orderStatusColor(status, scheme);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
      ),
      child: Text(
        orderStatusLabel(status),
        style: Theme.of(context).textTheme.labelLarge?.copyWith(color: color),
      ),
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
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: _note,
      decoration: InputDecoration(
        labelText: 'Note',
        hintText: 'Internal reminder for this quote',
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
                tooltip: 'Save note',
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
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ),
                if (!locked) ...[
                  IconButton(
                    tooltip: 'Open calculation',
                    onPressed: () => context.go(calculationRoute),
                    icon: const Icon(Icons.edit_outlined),
                  ),
                  if (prints.length > 1)
                    IconButton(
                      tooltip: 'Remove print',
                      onPressed: () =>
                          _removePrint(context, store, order, line),
                      icon: const Icon(Icons.delete_outline),
                    ),
                ],
              ],
            ),
            Text(
              'Qty ${line.quantity} · ${formatDuration(line.printTimeSeconds)}',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
            ),
            Text(
              '${formatMoney(line.breakdown.totalMinor, order.currencyCode)} incl. VAT',
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: scheme.primary,
                  ),
            ),
            if (printer != null) ...[
              const SizedBox(height: 4),
              Text(printer.name),
            ],
            if (line.filaments.isEmpty)
              const Text('No filament')
            else
              for (final usage in line.filaments)
                Text(
                  _filamentLine(usage, spools),
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
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              Wrap(
                spacing: 8,
                children: [
                  TextButton(
                    onPressed: () => launchUrl(
                      source,
                      mode: LaunchMode.externalApplication,
                    ),
                    child: const Text('Open model'),
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
  final title = TextEditingController(text: order.title);
  final saved = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Quote title'),
      content: TextField(
        controller: title,
        decoration: const InputDecoration(labelText: 'Title'),
        autofocus: true,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Save'),
        ),
      ],
    ),
  );
  final next = title.text.trim();
  title.dispose();
  if (saved != true || next.isEmpty) {
    return;
  }
  await store.saveOrder(
    order.copyWith(
      title: next,
      updatedAt: DateTime.now().toUtc().toIso8601String(),
    ),
  );
}

Future<void> _removePrint(
  BuildContext context,
  UserStore store,
  PrintOrder order,
  QuoteLine line,
) async {
  if (order.stockDeducted) {
    return;
  }
  final confirmed = await confirmDelete(
    context,
    title: 'Remove print',
    message: 'Remove ${line.title} from this quote?',
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
  await store.saveOrder(
    orderWithPrints(order, next).copyWith(
      title: quoteTitleFor(order, next),
      updatedAt: DateTime.now().toUtc().toIso8601String(),
    ),
  );
}

String _filamentLine(FilamentUsage usage, List<FilamentSpool> spools) {
  final spool = spools.where((item) => item.id == usage.filamentId).firstOrNull;
  final material = usage.material.isNotEmpty
      ? usage.material
      : spool?.material ?? '';
  final name = [
    spool?.brand ?? '',
    material,
  ].where((part) => part.trim().isNotEmpty).join(' ');
  if (name.isEmpty) {
    return formatGrams(usage.grams);
  }
  return '${formatGrams(usage.grams)} $name';
}

