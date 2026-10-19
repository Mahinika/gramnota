import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../core/format.dart';
import '../../../core/menu_card.dart';
import '../../../core/money.dart';
import '../../../core/providers.dart';
import '../../../core/shell.dart';
import '../../orders/data/orders_providers.dart';
import '../../sharing/domain/inbox_item.dart';
import '../../sharing/presentation/inbox_screen.dart';
import '../domain/common_printers.dart';
import '../domain/printer_profile.dart';

class PrintersScreen extends ConsumerWidget {
  const PrintersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(userStoreProvider);
    if (store == null) {
      return const Scaffold(
        body: EmptyView(message: 'Sign in to see printers.'),
      );
    }
    final printers = ref.watch(printersProvider(store));
    return Scaffold(
      appBar: AppBar(title: const Text('Printers')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/more/printers/new'),
        child: const Icon(Icons.add),
      ),
      body: printers.when(
        data: (list) {
          if (list.isEmpty) {
            return const EmptyView(message: 'Add the printer you price with.');
          }
          return ListView.separated(
            padding: TappableListCard.listPadding,
            itemCount: list.length,
            separatorBuilder: (_, _) => TappableListCard.listSeparator,
            itemBuilder: (context, index) {
              final printer = list[index];
              final theme = Theme.of(context);
              final scheme = theme.colorScheme;
              return TappableListCard(
                onTap: () => context.go('/more/printers/${printer.id}'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(printer.name, style: theme.textTheme.titleMedium),
                    const SizedBox(height: 4),
                    Text(
                      '${printer.powerWatts} W',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => EmptyView(message: '$error'),
      ),
    );
  }
}

class PrinterEditScreen extends ConsumerStatefulWidget {
  const PrinterEditScreen({required this.id, super.key});

  final String id;

  @override
  ConsumerState<PrinterEditScreen> createState() => _PrinterEditScreenState();
}

class _PrinterEditScreenState extends ConsumerState<PrinterEditScreen> {
  final _name = TextEditingController();
  final _watts = TextEditingController();
  final _price = TextEditingController();
  final _life = TextEditingController();
  final _maintenance = TextEditingController();
  final _printerQuery = TextEditingController();
  var _loaded = false;
  String? _error;

  @override
  void dispose() {
    for (final controller in [
      _name,
      _watts,
      _price,
      _life,
      _maintenance,
      _printerQuery,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  List<CommonPrinter> _matchingPrinters() {
    final query = _printerQuery.text.trim().toLowerCase();
    final matches = [
      for (final printer in commonPrinters)
        if (query.isEmpty || printer.name.toLowerCase().contains(query))
          printer,
    ];
    matches.sort(
      (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
    );
    return matches;
  }

  void _load(PrinterProfile printer) {
    if (_loaded) {
      return;
    }
    _name.text = printer.name;
    _watts.text = printer.powerWatts.toString();
    _price.text = formatMinorAmount(printer.purchasePriceMinor);
    _life.text = printer.lifetimeHours.toString();
    _maintenance.text = formatMinorAmount(printer.maintenanceMinorPerHour);
    _loaded = true;
  }

  @override
  Widget build(BuildContext context) {
    final store = ref.watch(userStoreProvider);
    if (store == null) {
      return const Scaffold(
        body: EmptyView(message: 'Sign in to edit printers.'),
      );
    }
    final printers = ref.watch(printersProvider(store));
    if (widget.id != 'new') {
      final match = printers.asData?.value.where(
        (item) => item.id == widget.id,
      );
      if (match != null && match.isNotEmpty) {
        _load(match.first);
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id == 'new' ? 'New printer' : 'Printer'),
        actions: [
          if (widget.id != 'new')
            IconButton(
              tooltip: 'Send to user',
              onPressed: () => sendItem(
                context: context,
                store: store,
                type: SharedItemType.printer,
                payload: PrinterProfile(
                  id: widget.id,
                  name: _name.text.trim(),
                  powerWatts: parsePositiveInt(_watts.text) ?? 0,
                  purchasePriceMinor: parseMinor(_price.text) ?? 0,
                  lifetimeHours: parseNonNegativeDouble(_life.text) ?? 0,
                  maintenanceMinorPerHour: parseMinor(_maintenance.text) ?? 0,
                ).toJson(),
              ),
              icon: const Icon(Icons.send_outlined),
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (_error != null) Text(_error!),
          if (widget.id == 'new') ...[
            TextField(
              controller: _printerQuery,
              decoration: const InputDecoration(labelText: 'Find a printer'),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 8),
            if (_matchingPrinters().isEmpty)
              const Text('No printer with that name.')
            else
              DropdownButtonFormField<String>(
                key: ValueKey(_printerQuery.text.trim().toLowerCase()),
                decoration: const InputDecoration(labelText: 'Common printer'),
                items: [
                  for (final printer in _matchingPrinters())
                    DropdownMenuItem(
                      value: printer.name,
                      child: Text('${printer.name} · ${printer.powerWatts} W'),
                    ),
                ],
                onChanged: (name) {
                  if (name == null) {
                    return;
                  }
                  final printer = commonPrinters.firstWhere(
                    (item) => item.name == name,
                  );
                  setState(() {
                    _name.text = printer.name;
                    _watts.text = printer.powerWatts.toString();
                    _price.text = printer.purchasePriceKronor.toString();
                    _life.text = CommonPrinter.lifetimeHours.round().toString();
                    _maintenance.text = '0';
                    _error = null;
                  });
                },
              ),
            const SizedBox(height: 8),
            const Text(
              'The first printers use a maker PLA average and a Swedish shop price. The rest use a community catalog: euro prices converted on 15 October 2026, and power estimated from the heater because the catalog lists the power supply. Lifetime starts at 5,000 hours. Change the price and watts to your machine.',
            ),
            const SizedBox(height: 12),
          ],
          TextField(
            controller: _name,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: _watts,
            decoration: const InputDecoration(labelText: 'Power W'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _price,
            decoration: const InputDecoration(labelText: 'Purchase price'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          TextField(
            controller: _life,
            decoration: const InputDecoration(
              labelText: 'Expected lifetime hours',
            ),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _maintenance,
            decoration: const InputDecoration(
              labelText: 'Maintenance per hour',
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: () async {
              if (_name.text.trim().isEmpty) {
                setState(() => _error = 'Name is required.');
                return;
              }
              final printer = PrinterProfile(
                id: widget.id == 'new' ? const Uuid().v4() : widget.id,
                name: _name.text.trim(),
                powerWatts: parsePositiveInt(_watts.text) ?? 0,
                purchasePriceMinor: parseMinor(_price.text) ?? 0,
                lifetimeHours: parseNonNegativeDouble(_life.text) ?? 0,
                maintenanceMinorPerHour: parseMinor(_maintenance.text) ?? 0,
              );
              await store.savePrinter(printer);
              if (context.mounted) {
                context.go('/more/printers');
              }
            },
            child: const Text('Save'),
          ),
          if (widget.id != 'new')
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.error,
              ),
              onPressed: () async {
                final confirmed = await confirmDelete(
                  context,
                  title: 'Delete printer',
                  message:
                      'This removes the printer. Saved quotes keep their prices.',
                );
                if (!confirmed || !context.mounted) {
                  return;
                }
                await store.deletePrinter(widget.id);
                if (context.mounted) {
                  context.go('/more/printers');
                }
              },
              child: const Text('Delete printer'),
            ),
        ],
      ),
    );
  }
}
