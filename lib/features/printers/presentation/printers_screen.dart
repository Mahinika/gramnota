import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../core/money.dart';
import '../../../core/providers.dart';
import '../../../core/shell.dart';
import '../../../core/user_store.dart';
import '../../sharing/domain/inbox_item.dart';
import '../../sharing/presentation/inbox_screen.dart';
import '../domain/printer_profile.dart';

class PrintersScreen extends ConsumerWidget {
  const PrintersScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(userStoreProvider);
    if (store == null) {
      return const Scaffold(body: EmptyView(message: 'Sign in to see printers.'));
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
          return ListView(
            children: [
              for (final printer in list)
                ListTile(
                  title: Text(printer.name),
                  subtitle: Text('${printer.powerWatts} W'),
                  onTap: () => context.go('/more/printers/${printer.id}'),
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
  var _loaded = false;
  String? _error;

  @override
  void dispose() {
    for (final controller in [_name, _watts, _price, _life, _maintenance]) {
      controller.dispose();
    }
    super.dispose();
  }

  void _load(PrinterProfile printer) {
    if (_loaded) {
      return;
    }
    _name.text = printer.name;
    _watts.text = printer.powerWatts.toString();
    _price.text = (printer.purchasePriceMinor / 100).toString();
    _life.text = printer.lifetimeHours.toString();
    _maintenance.text = (printer.maintenanceMinorPerHour / 100).toString();
    _loaded = true;
  }

  @override
  Widget build(BuildContext context) {
    final store = ref.watch(userStoreProvider);
    if (store == null) {
      return const Scaffold(body: EmptyView(message: 'Sign in to edit printers.'));
    }
    final printers = ref.watch(printersProvider(store));
    if (widget.id != 'new') {
      final match = printers.asData?.value.where((item) => item.id == widget.id);
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
          TextField(controller: _name, decoration: const InputDecoration(labelText: 'Name')),
          TextField(controller: _watts, decoration: const InputDecoration(labelText: 'Power W'), keyboardType: TextInputType.number),
          TextField(controller: _price, decoration: const InputDecoration(labelText: 'Purchase price'), keyboardType: const TextInputType.numberWithOptions(decimal: true)),
          TextField(controller: _life, decoration: const InputDecoration(labelText: 'Expected lifetime hours'), keyboardType: TextInputType.number),
          TextField(controller: _maintenance, decoration: const InputDecoration(labelText: 'Maintenance per hour'), keyboardType: const TextInputType.numberWithOptions(decimal: true)),
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
        ],
      ),
    );
  }
}

final printersProvider = StreamProvider.family<List<PrinterProfile>, UserStore>(
  (ref, store) => store.watchPrinters(),
);
