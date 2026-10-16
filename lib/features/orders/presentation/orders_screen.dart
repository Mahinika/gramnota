import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/format.dart';
import '../../../core/providers.dart';
import '../../../core/shell.dart';
import '../../../core/user_store.dart';
import '../../customers/domain/customer.dart';
import '../../filaments/domain/filament_spool.dart';
import '../../filaments/presentation/filaments_screen.dart';
import '../../printers/domain/printer_profile.dart';
import '../../printers/presentation/printers_screen.dart';
import '../../settings/domain/workshop_settings.dart';
import '../../sharing/domain/inbox_item.dart';
import '../../sharing/presentation/inbox_screen.dart';
import '../data/order_stock.dart';
import '../domain/print_order.dart';
import 'quote_pdf.dart';

class OrdersScreen extends ConsumerStatefulWidget {
  const OrdersScreen({super.key});

  @override
  ConsumerState<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends ConsumerState<OrdersScreen> {
  OrderStatus? _filter;
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
      body: orders.when(
        data: (list) {
          if (list.isEmpty) {
            return const EmptyView(
              message: 'No quotes yet. Save one from the calculator.',
            );
          }
          final sorted = [...list]
            ..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
          final query = _search.text.trim().toLowerCase();
          final visible = sorted.where((order) {
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
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                child: TextField(
                  controller: _search,
                  decoration: const InputDecoration(
                    labelText: 'Search',
                    hintText: 'Title, quote no., customer, or note',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 0),
                child: Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    FilterChip(
                      label: const Text('All'),
                      selected: _filter == null,
                      onSelected: (_) => setState(() => _filter = null),
                    ),
                    for (final status in OrderStatus.values)
                      FilterChip(
                        label: Text(orderStatusLabel(status)),
                        selected: _filter == status,
                        onSelected: (_) => setState(() => _filter = status),
                      ),
                  ],
                ),
              ),
              Expanded(
                child: visible.isEmpty
                    ? const EmptyView(
                        message: 'No orders match your search or filter.',
                      )
                    : ListView(
                        children: [
                          for (final order in visible)
                            ListTile(
                              title: Text(order.title),
                              subtitle: Text(
                                '${orderStatusLabel(order.status)} · ${formatMoney(order.breakdown.totalMinor, order.currencyCode)}',
                              ),
                              onTap: () => context.go('/orders/${order.id}'),
                            ),
                        ],
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
                onPressed: () => shareQuotePdf(
                  order: order,
                  settings: settings.asData?.value ?? const WorkshopSettings(),
                  customer: customer,
                ),
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
              Row(
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
              Text(orderStatusLabel(order.status)),
              if (order.stockWarning.isNotEmpty)
                Text(order.stockWarning),
              const SizedBox(height: 12),
              if (customer == null)
                const Text('No customer')
              else
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(customer.name),
                  subtitle: Text(
                    customer.addressLine.isEmpty
                        ? 'Customer'
                        : customer.addressLine,
                  ),
                  onTap: () => context.go('/customers/${customer.id}'),
                ),
              if (order.validUntil.length >= 10)
                Text('Valid until ${order.validUntil.substring(0, 10)}'),
              const SizedBox(height: 12),
              _OrderNoteField(order: order, store: store),
              const SizedBox(height: 12),
              Text('Prints', style: Theme.of(context).textTheme.titleMedium),
              for (final line in prints)
                _PrintLineTile(
                  order: order,
                  line: line,
                  spools: spools,
                  printers: printerList,
                  locked: locked,
                  store: store,
                ),
              if (locked)
                const Text(
                  'Move the order back to Accepted before changing prints.',
                )
              else
                Align(
                  alignment: Alignment.centerLeft,
                  child: TextButton(
                    onPressed: () => context.go(
                      '/calculator?orderId=${order.id}',
                    ),
                    child: const Text('Add print'),
                  ),
                ),
              const SizedBox(height: 12),
              Wrap(
                spacing: 8,
                children: [
                  for (final status in OrderStatus.values)
                    ChoiceChip(
                      label: Text(orderStatusLabel(status)),
                      selected: order.status == status,
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
              const SizedBox(height: 12),
              Text(formatMoney(order.breakdown.totalMinor, order.currencyCode)),
              if (prints.length == 1)
                Text(
                  'Per unit ${formatMoney(prints.single.breakdown.perUnitMinor, order.currencyCode)}',
                ),
              Text('Material ${formatMoney(order.breakdown.materialMinor, order.currencyCode)}'),
              Text('Electricity ${formatMoney(order.breakdown.electricityMinor, order.currencyCode)}'),
              Text('Machine ${formatMoney(order.breakdown.machineMinor, order.currencyCode)}'),
              Text('Failure ${formatMoney(order.breakdown.failureMinor, order.currencyCode)}'),
              Text('Labor ${formatMoney(order.breakdown.laborMinor, order.currencyCode)}'),
              Text('Extras ${formatMoney(order.breakdown.extrasMinor, order.currencyCode)}'),
              Text('VAT ${formatMoney(order.breakdown.vatMinor, order.currencyCode)}'),
            ],
          ),
        );
      },
      loading: () => const Scaffold(body: Center(child: CircularProgressIndicator())),
      error: (error, _) => Scaffold(body: EmptyView(message: '$error')),
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
      final now = DateTime.now().toUtc().toIso8601String();
      await widget.store.saveOrder(
        widget.order.copyWith(note: next, updatedAt: now),
      );
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
    return Padding(
      padding: const EdgeInsets.only(top: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  line.title,
                  style: Theme.of(context).textTheme.titleSmall,
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
                    onPressed: () => _removePrint(context, store, order, line),
                    icon: const Icon(Icons.delete_outline),
                  ),
              ],
            ],
          ),
          Text(
            'Quantity ${line.quantity} · ${formatDuration(line.printTimeSeconds)} · ${formatMoney(line.breakdown.totalMinor, order.currencyCode)}',
          ),
          if (printer != null) Text(printer.name),
          if (line.filaments.isEmpty)
            const Text('No filament')
          else
            for (final usage in line.filaments)
              Text(_filamentLine(usage, spools)),
          if (line.sourceProfileTitle.isNotEmpty)
            Text(line.sourceProfileTitle),
          if (source != null && source.hasScheme) ...[
            Text(
              line.sourceUrl,
              style: Theme.of(context).textTheme.bodySmall,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            Wrap(
              spacing: 8,
              children: [
                TextButton(
                  onPressed: () => launchUrl(source, mode: LaunchMode.externalApplication),
                  child: const Text('Open model'),
                ),
                if (!locked)
                  TextButton(
                    onPressed: () => context.go(calculationRoute),
                    child: const Text('Open calculation'),
                  ),
              ],
            ),
          ] else if (!locked)
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () => context.go(calculationRoute),
                child: const Text('Open calculation'),
              ),
            ),
        ],
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

final ordersProvider = StreamProvider.family<List<PrintOrder>, UserStore>(
  (ref, store) => store.watchOrders(),
);

final settingsProvider = StreamProvider.family<WorkshopSettings, UserStore>(
  (ref, store) => store.watchSettings(),
);

final customersProvider = StreamProvider.family<List<Customer>, UserStore>(
  (ref, store) => store.watchCustomers(),
);
