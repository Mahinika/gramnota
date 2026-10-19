import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../core/format.dart';
import '../../../core/menu_card.dart';
import '../../../core/money.dart';
import '../../../core/providers.dart';
import '../../../core/shell.dart';
import '../../../core/user_store.dart';
import '../../filaments/domain/filament_spool.dart';
import '../../orders/data/orders_providers.dart';
import '../../orders/domain/print_order.dart';
import '../../pricing/domain/live_quote.dart';
import '../../settings/domain/workshop_settings.dart';
import '../domain/catalog_product.dart';
import 'product_picker.dart';

class ProductsScreen extends ConsumerStatefulWidget {
  const ProductsScreen({super.key});

  @override
  ConsumerState<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends ConsumerState<ProductsScreen> {
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
      return const Scaffold(
        body: EmptyView(message: 'Sign in to see products.'),
      );
    }
    final products = ref.watch(productsProvider(store));
    final printers =
        ref.watch(printersProvider(store)).asData?.value ?? const [];
    return Scaffold(
      appBar: AppBar(
        title: const Text('Products'),
        actions: [
          IconButton(
            tooltip: 'New product',
            onPressed: () => context.go('/more/products/new'),
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: products.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => EmptyView(message: '$error'),
        data: (list) {
          final query = _search.text.trim().toLowerCase();
          final visible =
              list.where((product) {
                if (query.isEmpty) {
                  return true;
                }
                return product.name.toLowerCase().contains(query) ||
                    product.notes.toLowerCase().contains(query);
              }).toList()..sort(
                (a, b) => a.name.toLowerCase().compareTo(b.name.toLowerCase()),
              );
          if (list.isEmpty) {
            return EmptyView(
              message:
                  'No saved products yet. Save a print from the calculator or a quote, then add it again at today’s spool and printer prices.',
              action: FilledButton(
                onPressed: () => context.go('/more/products/new'),
                child: const Text('New product'),
              ),
            );
          }
          return ListView.separated(
            padding: TappableListCard.listPadding,
            itemCount: visible.length + 1,
            separatorBuilder: (_, index) => index == 0
                ? const SizedBox(height: 12)
                : TappableListCard.listSeparator,
            itemBuilder: (context, index) {
              if (index == 0) {
                return TextField(
                  controller: _search,
                  decoration: const InputDecoration(
                    hintText: 'Search products',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (_) => setState(() {}),
                );
              }
              final product = visible[index - 1];
              final printer = printers
                  .where((item) => item.id == product.printerId)
                  .firstOrNull;
              return TappableListCard(
                onTap: () => context.go('/more/products/${product.id}'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      product.name,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(productSummary(product)),
                    if (printer != null)
                      Text(
                        printer.name,
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class ProductEditScreen extends ConsumerStatefulWidget {
  const ProductEditScreen({required this.id, super.key});

  final String id;

  @override
  ConsumerState<ProductEditScreen> createState() => _ProductEditScreenState();
}

class _FilamentDraft {
  _FilamentDraft({this.spoolId, String grams = ''}) {
    this.grams.text = grams;
  }

  String? spoolId;
  final grams = TextEditingController();
}

class _ExtraDraft {
  _ExtraDraft({String name = '', String cost = ''}) {
    this.name.text = name;
    this.cost.text = cost;
  }

  final name = TextEditingController();
  final cost = TextEditingController();
}

class _ProductEditScreenState extends ConsumerState<ProductEditScreen> {
  final _name = TextEditingController();
  final _hours = TextEditingController(text: '0');
  final _minutes = TextEditingController(text: '0');
  final _prep = TextEditingController(text: '0');
  final _post = TextEditingController(text: '0');
  final _markup = TextEditingController();
  final _failure = TextEditingController();
  final _vat = TextEditingController();
  final _notes = TextEditingController();
  final _link = TextEditingController();
  final _filaments = <_FilamentDraft>[_FilamentDraft()];
  final _extras = <_ExtraDraft>[];
  String? _printerId;
  String? _loadedId;
  String? _createdAt;
  String? _message;
  var _saving = false;

  bool get _isNew => widget.id == 'new';

  @override
  void dispose() {
    for (final controller in [
      _name,
      _hours,
      _minutes,
      _prep,
      _post,
      _markup,
      _failure,
      _vat,
      _notes,
      _link,
    ]) {
      controller.dispose();
    }
    for (final row in _filaments) {
      row.grams.dispose();
    }
    for (final extra in _extras) {
      extra.name.dispose();
      extra.cost.dispose();
    }
    super.dispose();
  }

  void _load(CatalogProduct product, WorkshopSettings settings) {
    if (_loadedId == product.id) {
      return;
    }
    _loadedId = product.id;
    _name.text = product.name;
    _hours.text = '${product.printTimeSeconds ~/ 3600}';
    _minutes.text = '${(product.printTimeSeconds % 3600) ~/ 60}';
    _prep.text = '${product.prepMinutes}';
    _post.text = '${product.postMinutes}';
    _markup.text = basisPointsLabel(product.markupBasisPoints);
    _failure.text = basisPointsLabel(product.failureBasisPoints);
    _vat.text = basisPointsLabel(product.vatBasisPoints);
    _notes.text = product.notes;
    _link.text = product.sourceUrl;
    _printerId = product.printerId.isEmpty ? null : product.printerId;
    _createdAt = product.createdAt;
    for (final row in _filaments) {
      row.grams.dispose();
    }
    _filaments
      ..clear()
      ..addAll(
        product.filaments.isEmpty
            ? [_FilamentDraft()]
            : [
                for (final filament in product.filaments)
                  _FilamentDraft(
                    spoolId: filament.filamentId.isEmpty
                        ? null
                        : filament.filamentId,
                    grams: _gramsText(filament.grams),
                  ),
              ],
      );
    for (final extra in _extras) {
      extra.name.dispose();
      extra.cost.dispose();
    }
    _extras
      ..clear()
      ..addAll(
        product.extras.map(
          (extra) => _ExtraDraft(
            name: extra.name,
            cost: formatMinorAmount(extra.costMinor),
          ),
        ),
      );
  }

  void _applyDefaults(WorkshopSettings settings) {
    if (_loadedId != null || !_isNew) {
      return;
    }
    _loadedId = 'new';
    _markup.text = basisPointsLabel(settings.defaultMarkupBasisPoints);
    _failure.text = basisPointsLabel(settings.defaultFailureBasisPoints);
    _vat.text = basisPointsLabel(settings.vatBasisPoints);
  }

  int _seconds() {
    final hours = parseNonNegativeDouble(_hours.text) ?? 0;
    final minutes = parseNonNegativeDouble(_minutes.text) ?? 0;
    return (hours * 3600).round() + (minutes * 60).round();
  }

  Future<void> _save(
    UserStore store,
    WorkshopSettings settings,
    List<FilamentSpool> spools,
  ) async {
    if (_name.text.trim().isEmpty) {
      setState(() => _message = 'Add a name before saving the product.');
      return;
    }
    final problems = [
      ?_numberError('hours', _hours.text),
      ?_numberError('minutes', _minutes.text),
      ?_numberError('prep minutes', _prep.text),
      ?_numberError('post minutes', _post.text),
      ?_percentError('markup', _markup.text),
      ?_percentError('failure', _failure.text),
      ?_percentError('VAT', _vat.text),
      for (final row in _filaments) ?_numberError('grams', row.grams.text),
      for (final extra in _extras) ?_moneyError(extra.cost.text),
    ];
    if (problems.isNotEmpty) {
      setState(() => _message = problems.join(' '));
      return;
    }
    setState(() {
      _saving = true;
      _message = null;
    });
    final now = DateTime.now().toUtc().toIso8601String();
    final product = CatalogProduct(
      id: _isNew ? const Uuid().v4() : widget.id,
      name: _name.text.trim(),
      printerId: _printerId ?? '',
      printTimeSeconds: _seconds(),
      filaments: [
        for (final row in _filaments)
          if ((parseNonNegativeDouble(row.grams.text) ?? 0) > 0 ||
              (row.spoolId?.isNotEmpty ?? false))
            FilamentUsage(
              filamentId: row.spoolId ?? '',
              grams: parseNonNegativeDouble(row.grams.text) ?? 0,
              material: _material(spools, row.spoolId),
              colorHex: _color(spools, row.spoolId),
            ),
      ],
      prepMinutes: (parseNonNegativeDouble(_prep.text) ?? 0).round(),
      postMinutes: (parseNonNegativeDouble(_post.text) ?? 0).round(),
      extras: [
        for (final extra in _extras)
          if (extra.name.text.trim().isNotEmpty ||
              (parseMinor(extra.cost.text) ?? 0) > 0)
            ExtraCost(
              name: extra.name.text.trim().isEmpty
                  ? 'Extra'
                  : extra.name.text.trim(),
              costMinor: parseMinor(extra.cost.text) ?? 0,
            ),
      ],
      markupBasisPoints:
          parseBasisPoints(_markup.text) ?? settings.defaultMarkupBasisPoints,
      failureBasisPoints:
          parseBasisPoints(_failure.text) ?? settings.defaultFailureBasisPoints,
      vatBasisPoints: parseBasisPoints(_vat.text) ?? settings.vatBasisPoints,
      sourceUrl: _link.text.trim(),
      notes: _notes.text.trim(),
      createdAt: _createdAt?.isNotEmpty == true ? _createdAt! : now,
      updatedAt: now,
    );
    try {
      await store.saveProduct(product);
      if (mounted) {
        context.go('/more/products');
      }
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  Future<void> _delete(UserStore store) async {
    final confirmed = await confirmDelete(
      context,
      title: 'Delete product',
      message:
          'Delete ${_name.text.trim().isEmpty ? 'this product' : _name.text.trim()}? Quotes that already use it stay as they are.',
    );
    if (!confirmed) {
      return;
    }
    await store.deleteProduct(widget.id);
    if (mounted) {
      context.go('/more/products');
    }
  }

  @override
  Widget build(BuildContext context) {
    final store = ref.watch(userStoreProvider);
    if (store == null) {
      return const Scaffold(
        body: EmptyView(message: 'Sign in to edit products.'),
      );
    }
    final settingsSnapshot = ref.watch(settingsProvider(store)).asData?.value;
    final settings = settingsSnapshot ?? const WorkshopSettings();
    final products = ref.watch(productsProvider(store)).asData?.value;
    final spools =
        ref.watch(filamentsProvider(store)).asData?.value ?? const [];
    final printers =
        ref.watch(printersProvider(store)).asData?.value ?? const [];
    if (!_isNew) {
      if (products == null) {
        return const Scaffold(body: Center(child: CircularProgressIndicator()));
      }
      final matches = products.where((item) => item.id == widget.id);
      if (matches.isEmpty) {
        return const Scaffold(body: EmptyView(message: 'Product not found.'));
      }
      _load(matches.first, settings);
    } else if (settingsSnapshot != null) {
      _applyDefaults(settingsSnapshot);
    }
    return Scaffold(
      appBar: AppBar(
        title: Text(_isNew ? 'New product' : 'Edit product'),
        actions: [
          if (!_isNew)
            IconButton(
              tooltip: 'Delete product',
              onPressed: () => _delete(store),
              icon: const Icon(Icons.delete_outline),
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          const Text(productPriceExplanation),
          const SizedBox(height: 12),
          TextField(
            controller: _name,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            key: ValueKey(_printerId),
            initialValue: printers.any((printer) => printer.id == _printerId)
                ? _printerId
                : null,
            decoration: const InputDecoration(labelText: 'Printer'),
            items: [
              const DropdownMenuItem(child: Text('No printer')),
              for (final printer in printers)
                DropdownMenuItem(value: printer.id, child: Text(printer.name)),
            ],
            onChanged: (value) => setState(() => _printerId = value),
          ),
          const SizedBox(height: 12),
          for (var index = 0; index < _filaments.length; index++)
            _filamentRow(index, spools),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () => setState(() => _filaments.add(_FilamentDraft())),
              child: const Text('Add filament'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _hours,
                  decoration: const InputDecoration(labelText: 'Hours'),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _minutes,
                  decoration: const InputDecoration(labelText: 'Minutes'),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _prep,
                  decoration: const InputDecoration(labelText: 'Prep minutes'),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _post,
                  decoration: const InputDecoration(labelText: 'Post minutes'),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          for (var index = 0; index < _extras.length; index++) _extraRow(index),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () => setState(() => _extras.add(_ExtraDraft())),
              child: const Text('Add extra'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _markup,
                  decoration: const InputDecoration(labelText: 'Markup %'),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _failure,
                  decoration: const InputDecoration(labelText: 'Failure %'),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _vat,
                  decoration: const InputDecoration(labelText: 'VAT %'),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _link,
            decoration: const InputDecoration(labelText: 'Model link'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _notes,
            decoration: const InputDecoration(labelText: 'Notes'),
            minLines: 1,
            maxLines: 3,
          ),
          if (_message != null) ...[
            const SizedBox(height: 12),
            Text(_message!),
          ],
          const SizedBox(height: 16),
          FilledButton(
            onPressed: _saving ? null : () => _save(store, settings, spools),
            child: Text(_saving ? 'Saving…' : 'Save product'),
          ),
        ],
      ),
    );
  }

  Widget _filamentRow(int index, List<FilamentSpool> spools) {
    final row = _filaments[index];
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: DropdownButtonFormField<String>(
              key: ValueKey('${row.spoolId}-$index'),
              initialValue: spools.any((spool) => spool.id == row.spoolId)
                  ? row.spoolId
                  : null,
              decoration: const InputDecoration(labelText: 'Spool'),
              items: [
                const DropdownMenuItem(child: Text('No spool')),
                for (final spool in spools)
                  DropdownMenuItem(
                    value: spool.id,
                    child: Text('${spool.brand} ${spool.material}'.trim()),
                  ),
              ],
              onChanged: (value) => setState(() => row.spoolId = value),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            flex: 2,
            child: TextField(
              controller: row.grams,
              decoration: const InputDecoration(labelText: 'Grams'),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),
          ),
          if (_filaments.length > 1)
            IconButton(
              tooltip: 'Remove filament',
              onPressed: () => setState(() {
                row.grams.dispose();
                _filaments.removeAt(index);
              }),
              icon: const Icon(Icons.close),
            ),
        ],
      ),
    );
  }

  Widget _extraRow(int index) {
    final extra = _extras[index];
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: extra.name,
              decoration: const InputDecoration(labelText: 'Extra'),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: extra.cost,
              decoration: const InputDecoration(labelText: 'Cost'),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),
          ),
          IconButton(
            tooltip: 'Remove extra',
            onPressed: () => setState(() {
              extra.name.dispose();
              extra.cost.dispose();
              _extras.removeAt(index);
            }),
            icon: const Icon(Icons.close),
          ),
        ],
      ),
    );
  }
}

String? _numberError(String label, String text) {
  final trimmed = text.trim();
  if (trimmed.isEmpty || parseNonNegativeDouble(trimmed) != null) {
    return null;
  }
  return 'Could not read $label. Use a number, 0 or more.';
}

String? _percentError(String label, String text) {
  final trimmed = text.trim();
  if (trimmed.isEmpty || parseBasisPoints(trimmed) != null) {
    return null;
  }
  return 'Could not read $label. Use a percent, 0 or more.';
}

String? _moneyError(String text) {
  final trimmed = text.trim();
  if (trimmed.isEmpty || parseMinor(trimmed) != null) {
    return null;
  }
  return 'Could not read the extra cost. Use a number, 0 or more.';
}

String _gramsText(double grams) {
  if (grams == grams.roundToDouble()) {
    return grams.round().toString();
  }
  var text = grams.toStringAsFixed(3);
  text = text.replaceFirst(RegExp(r'0+$'), '');
  return text.replaceFirst(RegExp(r'\.$'), '');
}

String _material(List<FilamentSpool> spools, String? id) {
  for (final spool in spools) {
    if (spool.id == id) {
      return spool.material;
    }
  }
  return '';
}

String _color(List<FilamentSpool> spools, String? id) {
  for (final spool in spools) {
    if (spool.id == id) {
      return spool.colorHex;
    }
  }
  return '';
}
