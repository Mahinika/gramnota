import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gramnota/l10n/l10n.dart';
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
      return Scaffold(body: EmptyView(message: context.l10n.printerSignInList));
    }
    final printers = ref.watch(printersProvider(store));
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.morePrinters)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/more/printers/new'),
        child: const Icon(Icons.add),
      ),
      body: printers.when(
        data: (list) {
          if (list.isEmpty) {
            return EmptyView(message: context.l10n.printerEmpty);
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
                    Text(
                      printer.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      context.l10n.setupPowerValue('${printer.powerWatts}'),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
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

  void _load(PrinterProfile printer, String locale) {
    if (_loaded) {
      return;
    }
    _name.text = printer.name;
    _watts.text = printer.powerWatts.toString();
    _price.text = formatMinorField(printer.purchasePriceMinor, locale: locale);
    _life.text = printer.lifetimeHours.toString();
    _maintenance.text = formatMinorField(
      printer.maintenanceMinorPerHour,
      locale: locale,
    );
    _loaded = true;
  }

  @override
  Widget build(BuildContext context) {
    final store = ref.watch(userStoreProvider);
    if (store == null) {
      return Scaffold(body: EmptyView(message: context.l10n.printerSignInEdit));
    }
    final printers = ref.watch(printersProvider(store));
    if (widget.id != 'new') {
      final match = printers.asData?.value.where(
        (item) => item.id == widget.id,
      );
      if (match != null && match.isNotEmpty) {
        _load(match.first, context.formattingLocale);
      }
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.id == 'new'
              ? context.l10n.printerNew
              : context.l10n.setupPrinterTitle,
        ),
        actions: [
          if (widget.id != 'new')
            IconButton(
              tooltip: context.l10n.inboxSendToUser,
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
              decoration: InputDecoration(
                labelText: context.l10n.setupFindPrinter,
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 8),
            if (_matchingPrinters().isEmpty)
              Text(context.l10n.setupNoPrinterMatch)
            else
              DropdownButtonFormField<String>(
                key: ValueKey(_printerQuery.text.trim().toLowerCase()),
                isExpanded: true,
                decoration: InputDecoration(
                  labelText: context.l10n.setupCommonPrinter,
                ),
                items: [
                  for (final printer in _matchingPrinters())
                    DropdownMenuItem(
                      value: printer.name,
                      child: Text(
                        context.l10n.setupPrinterWatts(
                          printer.name,
                          printer.powerWatts,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
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
            Text(context.l10n.printerCatalogNote),
            const SizedBox(height: 12),
          ],
          TextField(
            controller: _name,
            decoration: InputDecoration(labelText: context.l10n.fieldName),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _watts,
            decoration: InputDecoration(labelText: context.l10n.setupPower),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _price,
            decoration: InputDecoration(
              labelText: context.l10n.setupPurchasePrice,
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _life,
            decoration: InputDecoration(
              labelText: context.l10n.printerLifetime,
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _maintenance,
            decoration: InputDecoration(
              labelText: context.l10n.setupMaintenance,
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: () async {
              if (_name.text.trim().isEmpty) {
                setState(() => _error = context.l10n.printerNameRequired);
                return;
              }
              final watts = parsePositiveInt(_watts.text);
              final price = parseMinor(_price.text);
              final lifetime = parseNonNegativeDouble(_life.text);
              final maintenance = parseMinor(_maintenance.text);
              if (watts == null || watts <= 0) {
                setState(() => _error = context.l10n.setupWattsRequired);
                return;
              }
              if (price == null || maintenance == null) {
                setState(() => _error = context.l10n.printerAmountRequired);
                return;
              }
              if (lifetime == null) {
                setState(() => _error = context.l10n.printerLifetimeRequired);
                return;
              }
              final printer = PrinterProfile(
                id: widget.id == 'new' ? const Uuid().v4() : widget.id,
                name: _name.text.trim(),
                powerWatts: watts,
                purchasePriceMinor: price,
                lifetimeHours: lifetime,
                maintenanceMinorPerHour: maintenance,
              );
              try {
                await store.savePrinter(printer);
              } on Object {
                if (context.mounted) {
                  setState(() => _error = context.l10n.printerSaveFailed);
                }
                return;
              }
              if (context.mounted) {
                context.go('/more/printers');
              }
            },
            child: Text(context.l10n.actionSave),
          ),
          if (widget.id != 'new')
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.error,
              ),
              onPressed: () async {
                final confirmed = await confirmDelete(
                  context,
                  title: context.l10n.printerDelete,
                  message: context.l10n.printerDeleteMessage,
                );
                if (!confirmed || !context.mounted) {
                  return;
                }
                await store.deletePrinter(widget.id);
                if (context.mounted) {
                  context.go('/more/printers');
                }
              },
              child: Text(context.l10n.printerDelete),
            ),
        ],
      ),
    );
  }
}
