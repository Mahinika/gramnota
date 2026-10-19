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
import '../../../l10n/l10n.dart';
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
      return Scaffold(body: EmptyView(message: context.l10n.productSignIn));
    }
    final products = ref.watch(productsProvider(store));
    final printers =
        ref.watch(printersProvider(store)).asData?.value ?? const [];
    return Scaffold(
      appBar: AppBar(
        title: Text(
          context.l10n.moreProducts,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          IconButton(
            tooltip: context.l10n.productNewTooltip,
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
              message: context.l10n.productEmpty,
              action: FilledButton(
                onPressed: () => context.go('/more/products/new'),
                child: Text(context.l10n.productNew),
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
                  decoration: InputDecoration(
                    hintText: context.l10n.productSearch,
                    prefixIcon: const Icon(Icons.search),
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
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      productSummary(product, l10n: context.l10n),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (printer != null)
                      Text(
                        printer.name,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
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
            cost: formatMinorField(extra.costMinor),
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
    final l10n = context.l10n;
    if (_name.text.trim().isEmpty) {
      setState(() => _message = l10n.productAddName);
      return;
    }
    final problems = [
      ?_numberError(l10n, l10n.productErrHours, _hours.text),
      ?_numberError(l10n, l10n.productErrMinutes, _minutes.text),
      ?_numberError(l10n, l10n.productErrPrepMinutes, _prep.text),
      ?_numberError(l10n, l10n.productErrPostMinutes, _post.text),
      ?_percentError(l10n, l10n.productErrMarkup, _markup.text),
      ?_percentError(l10n, l10n.productErrFailure, _failure.text),
      ?_percentError(l10n, l10n.productErrVat, _vat.text),
      for (final row in _filaments)
        ?_numberError(l10n, l10n.productErrGrams, row.grams.text),
      for (final extra in _extras) ?_moneyError(l10n, extra.cost.text),
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
                  ? context.l10n.productExtra
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
    final l10n = context.l10n;
    final confirmed = await confirmDelete(
      context,
      title: l10n.productDeleteTitle,
      message: l10n.productDeleteMessage(
        _name.text.trim().isEmpty ? l10n.productThisProduct : _name.text.trim(),
      ),
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
      return Scaffold(body: EmptyView(message: context.l10n.productSignInEdit));
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
        return Scaffold(body: EmptyView(message: context.l10n.productNotFound));
      }
      _load(matches.first, settings);
    } else if (settingsSnapshot != null) {
      _applyDefaults(settingsSnapshot);
    }
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isNew ? l10n.productNew : l10n.productEdit,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        actions: [
          if (!_isNew)
            IconButton(
              tooltip: l10n.productDeleteTooltip,
              onPressed: () => _delete(store),
              icon: const Icon(Icons.delete_outline),
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(productPriceExplanation(l10n: l10n)),
          const SizedBox(height: 12),
          TextField(
            controller: _name,
            decoration: InputDecoration(label: _clipLabel(l10n.fieldName)),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            key: ValueKey(_printerId),
            isExpanded: true,
            initialValue: printers.any((printer) => printer.id == _printerId)
                ? _printerId
                : null,
            decoration: InputDecoration(label: _clipLabel(l10n.productPrinter)),
            items: [
              DropdownMenuItem(
                child: Text(
                  l10n.noPrinter,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              for (final printer in printers)
                DropdownMenuItem(
                  value: printer.id,
                  child: Text(
                    printer.name,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
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
              child: Text(l10n.productAddFilament),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _hours,
                  decoration: InputDecoration(
                    label: _clipLabel(l10n.fieldHours),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _minutes,
                  decoration: InputDecoration(
                    label: _clipLabel(l10n.fieldMinutes),
                  ),
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
                  decoration: InputDecoration(
                    label: _clipLabel(l10n.productPrepMinutes),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _post,
                  decoration: InputDecoration(
                    label: _clipLabel(l10n.productPostMinutes),
                  ),
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
              child: Text(l10n.productAddExtra),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _markup,
                  decoration: InputDecoration(
                    label: _clipLabel(l10n.productMarkupPercent),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _failure,
                  decoration: InputDecoration(
                    label: _clipLabel(l10n.productFailurePercent),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _vat,
                  decoration: InputDecoration(
                    label: _clipLabel(l10n.productVatPercent),
                  ),
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
            decoration: InputDecoration(
              label: _clipLabel(l10n.productModelLink),
            ),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _notes,
            decoration: InputDecoration(label: _clipLabel(l10n.fieldNotes)),
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
            child: Text(
              _saving ? l10n.saving : l10n.productSave,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _filamentRow(int index, List<FilamentSpool> spools) {
    final row = _filaments[index];
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            flex: 3,
            child: DropdownButtonFormField<String>(
              key: ValueKey('${row.spoolId}-$index'),
              isExpanded: true,
              initialValue: spools.any((spool) => spool.id == row.spoolId)
                  ? row.spoolId
                  : null,
              decoration: InputDecoration(label: _clipLabel(l10n.productSpool)),
              items: [
                DropdownMenuItem(
                  child: Text(
                    l10n.noSpool,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                for (final spool in spools)
                  DropdownMenuItem(
                    value: spool.id,
                    child: Text(
                      '${spool.brand} ${spool.material}'.trim(),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
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
              decoration: InputDecoration(label: _clipLabel(l10n.fieldGrams)),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),
          ),
          if (_filaments.length > 1)
            IconButton(
              tooltip: l10n.productRemoveFilament,
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
    final l10n = context.l10n;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: extra.name,
              decoration: InputDecoration(label: _clipLabel(l10n.productExtra)),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: extra.cost,
              decoration: InputDecoration(label: _clipLabel(l10n.productCost)),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),
          ),
          IconButton(
            tooltip: l10n.productRemoveExtra,
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

Text _clipLabel(String text) {
  return Text(text, maxLines: 1, overflow: TextOverflow.ellipsis);
}

String? _numberError(AppLocalizations l10n, String label, String text) {
  final trimmed = text.trim();
  if (trimmed.isEmpty || parseNonNegativeDouble(trimmed) != null) {
    return null;
  }
  return l10n.productReadNumber(label);
}

String? _percentError(AppLocalizations l10n, String label, String text) {
  final trimmed = text.trim();
  if (trimmed.isEmpty || parseBasisPoints(trimmed) != null) {
    return null;
  }
  return l10n.productReadPercent(label);
}

String? _moneyError(AppLocalizations l10n, String text) {
  final trimmed = text.trim();
  if (trimmed.isEmpty || parseMinor(trimmed) != null) {
    return null;
  }
  return l10n.productReadExtraCost;
}

String _gramsText(double grams) => formatDecimalField(grams, fractionDigits: 3);

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
