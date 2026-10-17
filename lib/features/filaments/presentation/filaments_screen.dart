import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../core/format.dart';
import '../../../core/menu_card.dart';
import '../../../core/money.dart';
import '../../../core/providers.dart';
import '../../../core/section_layout.dart';
import '../../../core/shell.dart';
import '../../../core/user_store.dart';
import '../../orders/data/orders_providers.dart';
import '../../sharing/domain/inbox_item.dart';
import '../../sharing/presentation/inbox_screen.dart';
import '../domain/common_spools.dart';
import '../domain/filament_spool.dart';

class FilamentsScreen extends ConsumerStatefulWidget {
  const FilamentsScreen({super.key});

  @override
  ConsumerState<FilamentsScreen> createState() => _FilamentsScreenState();
}

class _FilamentsScreenState extends ConsumerState<FilamentsScreen> {
  final _search = TextEditingController();
  var _lowStockOnly = false;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final store = ref.watch(userStoreProvider);
    if (store == null) {
      return const Scaffold(body: EmptyView(message: 'Sign in to see filament.'));
    }
    final spools = ref.watch(filamentsProvider(store));
    final currency =
        ref.watch(settingsProvider(store)).asData?.value.currencyCode ?? 'SEK';
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filament'),
        actions: [
          IconButton(
            tooltip: 'Add standard spool',
            onPressed: () => _showStandardSpools(context, store),
            icon: const Icon(Icons.library_add_outlined),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: 'Custom spool',
        onPressed: () => context.go('/filaments/new'),
        child: const Icon(Icons.add),
      ),
      body: spools.when(
        data: (list) {
          if (list.isEmpty) {
            return EmptyView(
              message: 'No spools yet.',
              action: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FilledButton(
                    onPressed: () => _showStandardSpools(context, store),
                    child: const Text('Add standard spool'),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => context.go('/filaments/new'),
                    child: const Text('Custom spool'),
                  ),
                ],
              ),
            );
          }
          final query = _search.text.trim().toLowerCase();
          final visible = [
            for (final spool in list)
              if ((!_lowStockOnly || spool.isLowStock) &&
                  (query.isEmpty ||
                      '${spool.brand} ${spool.material} ${spool.notes}'
                          .toLowerCase()
                          .contains(query)))
                spool,
          ]..sort((a, b) {
              final brand = a.brand.toLowerCase().compareTo(b.brand.toLowerCase());
              if (brand != 0) {
                return brand;
              }
              return a.material.toLowerCase().compareTo(b.material.toLowerCase());
            });
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: TextField(
                  controller: _search,
                  decoration: const InputDecoration(
                    hintText: 'Brand, material, or notes',
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
                        selected: !_lowStockOnly,
                        showCheckmark: false,
                        onSelected: (_) => setState(() => _lowStockOnly = false),
                      ),
                    ),
                    FilterChip(
                      label: const Text('Low stock'),
                      selected: _lowStockOnly,
                      showCheckmark: false,
                      onSelected: (_) => setState(() => _lowStockOnly = true),
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
                      visible.length == 1 ? '1 spool' : '${visible.length} spools',
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                    ),
                  ),
                ),
              Expanded(
                child: visible.isEmpty
                    ? const EmptyView(message: 'No spools match your search.')
                    : ListView.separated(
                        padding: TappableListCard.listPadding,
                        itemCount: visible.length,
                        separatorBuilder: (_, _) => TappableListCard.listSeparator,
                        itemBuilder: (context, index) {
                          final spool = visible[index];
                          return _SpoolListCard(
                            spool: spool,
                            currencyCode: currency,
                            onTap: () => context.go('/filaments/${spool.id}'),
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

class _SpoolListCard extends StatelessWidget {
  const _SpoolListCard({
    required this.spool,
    required this.currencyCode,
    required this.onTap,
  });

  final FilamentSpool spool;
  final String currencyCode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final progress = spool.spoolWeightGrams <= 0
        ? 0.0
        : (spool.remainingGrams / spool.spoolWeightGrams).clamp(0.0, 1.0);
    final barColor = spool.isLowStock ? scheme.error : scheme.primary;
    return TappableListCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _ColorSwatch(hex: spool.colorHex),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${spool.brand} ${spool.material}',
                      style: theme.textTheme.titleMedium,
                    ),
                    Text(
                      '${formatGrams(spool.remainingGrams)} of ${formatGrams(spool.spoolWeightGrams)}',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              if (spool.isLowStock)
                Text(
                  'Low',
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: scheme.error,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 10),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 6,
              color: barColor,
              backgroundColor: scheme.surfaceContainerHighest,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            '${formatMoney(spool.pricePerSpoolMinor, currencyCode)} · ${formatMoney(spool.pricePerKgMinor, currencyCode)}/kg',
            style: theme.textTheme.labelMedium?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> _showStandardSpools(BuildContext context, UserStore store) {
  return showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (sheetContext) => _StandardSpoolSheet(
      onAdd: (preset) async {
        Navigator.pop(sheetContext);
        await _addStandardSpool(context, store, preset);
      },
    ),
  );
}

class _StandardSpoolSheet extends StatefulWidget {
  const _StandardSpoolSheet({required this.onAdd});

  final Future<void> Function(CommonSpool preset) onAdd;

  @override
  State<_StandardSpoolSheet> createState() => _StandardSpoolSheetState();
}

class _StandardSpoolSheetState extends State<_StandardSpoolSheet> {
  final _query = TextEditingController();

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final matches = matchingCommonSpools(_query.text);
    final bottom = MediaQuery.viewInsetsOf(context).bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 16 + bottom),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.55,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Standard spools',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _query,
              decoration: const InputDecoration(
                hintText: 'Brand or material',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: matches.isEmpty
                  ? const EmptyView(message: 'No standard spool with that name.')
                  : ListView.separated(
                      itemCount: matches.length,
                      separatorBuilder: (_, _) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final preset = matches[index];
                        final price = preset.pricePerSpoolMinor == 0
                            ? 'Set price after adding'
                            : formatMoney(preset.pricePerSpoolMinor, 'SEK');
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: _ColorSwatch(hex: preset.colorHex),
                          title: Text(preset.label),
                          subtitle: Text(
                            '${preset.spoolWeightGrams.round()} g · $price',
                          ),
                          onTap: () => widget.onAdd(preset),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

Future<void> _addStandardSpool(
  BuildContext context,
  UserStore store,
  CommonSpool preset,
) async {
  final spool = FilamentSpool(
    id: const Uuid().v4(),
    brand: preset.brand,
    material: preset.material,
    colorHex: preset.colorHex,
    spoolWeightGrams: preset.spoolWeightGrams,
    remainingGrams: preset.spoolWeightGrams,
    pricePerSpoolMinor: preset.pricePerSpoolMinor,
  );
  await store.saveFilament(spool);
  if (!context.mounted) {
    return;
  }
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text('Added ${preset.label}.'),
      action: SnackBarAction(
        label: 'Edit price',
        onPressed: () => context.go('/filaments/${spool.id}'),
      ),
    ),
  );
}

class FilamentEditScreen extends ConsumerStatefulWidget {
  const FilamentEditScreen({required this.id, super.key});

  final String id;

  @override
  ConsumerState<FilamentEditScreen> createState() => _FilamentEditScreenState();
}

class _FilamentEditScreenState extends ConsumerState<FilamentEditScreen> {
  final _presetQuery = TextEditingController();
  final _brand = TextEditingController();
  final _material = TextEditingController(text: 'PLA');
  final _color = TextEditingController(text: '#808080');
  final _diameter = TextEditingController(text: '1.75');
  final _spoolWeight = TextEditingController(text: '1000');
  final _remaining = TextEditingController(text: '1000');
  final _price = TextEditingController();
  final _low = TextEditingController(text: '100');
  final _notes = TextEditingController();
  var _loaded = false;
  String? _error;

  void _applyPreset(CommonSpool preset) {
    _brand.text = preset.brand;
    _material.text = preset.material;
    _color.text = preset.colorHex;
    _spoolWeight.text = preset.spoolWeightGrams.round().toString();
    _remaining.text = preset.spoolWeightGrams.round().toString();
    if (preset.pricePerSpoolMinor > 0) {
      _price.text = (preset.pricePerSpoolMinor / 100).toString();
    }
    _error = null;
  }

  List<CommonSpool> _matchingPresets() => matchingCommonSpools(_presetQuery.text);

  @override
  void dispose() {
    for (final controller in [
      _presetQuery,
      _brand,
      _material,
      _color,
      _diameter,
      _spoolWeight,
      _remaining,
      _price,
      _low,
      _notes,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  void _load(FilamentSpool spool) {
    if (_loaded) {
      return;
    }
    _brand.text = spool.brand;
    _material.text = spool.material;
    _color.text = spool.colorHex;
    _diameter.text = _plainNumber(spool.diameterMm);
    _spoolWeight.text = _plainNumber(spool.spoolWeightGrams);
    _remaining.text = _plainNumber(spool.remainingGrams);
    _price.text = _plainMoney(spool.pricePerSpoolMinor);
    _low.text = _plainNumber(spool.lowStockGrams);
    _notes.text = spool.notes;
    _loaded = true;
  }

  FilamentSpool? _draft() {
    final price = parseMinor(_price.text);
    final spoolWeight = parseNonNegativeDouble(_spoolWeight.text);
    final remaining = parseNonNegativeDouble(_remaining.text);
    if (_brand.text.trim().isEmpty ||
        _material.text.trim().isEmpty ||
        price == null ||
        spoolWeight == null ||
        remaining == null) {
      return null;
    }
    return FilamentSpool(
      id: widget.id == 'new' ? const Uuid().v4() : widget.id,
      brand: _brand.text.trim(),
      material: _material.text.trim(),
      colorHex: _color.text.trim().isEmpty ? '#808080' : _color.text.trim(),
      diameterMm: parseNonNegativeDouble(_diameter.text) ?? 1.75,
      spoolWeightGrams: spoolWeight,
      remainingGrams: remaining,
      pricePerSpoolMinor: price,
      lowStockGrams: parseNonNegativeDouble(_low.text) ?? 100,
      notes: _notes.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final store = ref.watch(userStoreProvider);
    if (store == null) {
      return const Scaffold(body: EmptyView(message: 'Sign in to edit filament.'));
    }
    final existing = ref.watch(filamentsProvider(store));
    if (widget.id != 'new') {
      final match = existing.asData?.value.where((item) => item.id == widget.id);
      if (match != null && match.isNotEmpty) {
        _load(match.first);
      }
    }
    final draft = _draft();
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id == 'new' ? 'New spool' : _brand.text),
        actions: [
          if (draft != null && widget.id != 'new')
            IconButton(
              tooltip: 'Send to user',
              onPressed: () => sendItem(
                context: context,
                store: store,
                type: SharedItemType.filament,
                payload: draft.toJson(),
              ),
              icon: const Icon(Icons.send_outlined),
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (_error != null) ...[
            Text(
              _error!,
              style: TextStyle(color: Theme.of(context).colorScheme.error),
            ),
            const SizedBox(height: 8),
          ],
          if (widget.id == 'new') ...[
            const SectionHeading('Standard spool'),
            TextField(
              controller: _presetQuery,
              decoration: const InputDecoration(
                labelText: 'Find a standard spool',
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 8),
            if (_matchingPresets().isEmpty)
              const Text('No standard spool with that name.')
            else
              DropdownButtonFormField<String>(
                key: ValueKey(_presetQuery.text.trim().toLowerCase()),
                isExpanded: true,
                decoration: const InputDecoration(labelText: 'Standard spool'),
                items: [
                  for (final preset in _matchingPresets())
                    DropdownMenuItem(
                      value: preset.label,
                      child: Text(preset.label),
                    ),
                ],
                onChanged: (label) {
                  if (label == null) {
                    return;
                  }
                  final preset = _matchingPresets().firstWhere(
                    (item) => item.label == label,
                  );
                  setState(() => _applyPreset(preset));
                },
              ),
            const SectionRule(),
          ],
          const SectionHeading('Spool'),
          TextField(
            controller: _color,
            decoration: InputDecoration(
              labelText: 'Color hex',
              prefixIcon: Padding(
                padding: const EdgeInsets.all(12),
                child: _ColorSwatch(hex: _color.text, size: 20),
              ),
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _brand,
            decoration: const InputDecoration(labelText: 'Brand'),
            textCapitalization: TextCapitalization.words,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _material,
            decoration: const InputDecoration(labelText: 'Material'),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _diameter,
            decoration: const InputDecoration(labelText: 'Diameter mm'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (_) => setState(() {}),
          ),
          const SectionRule(),
          const SectionHeading('Stock'),
          TextField(
            controller: _spoolWeight,
            decoration: const InputDecoration(labelText: 'Spool weight g'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _remaining,
            decoration: const InputDecoration(labelText: 'Remaining g'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _low,
            decoration: const InputDecoration(labelText: 'Low stock threshold g'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          if (widget.id != 'new')
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  setState(() => _remaining.text = _spoolWeight.text);
                },
                child: const Text('Refill to full'),
              ),
            ),
          const SectionRule(),
          const SectionHeading('Price'),
          const SizedBox(height: 4),
          TextField(
            controller: _price,
            decoration: InputDecoration(
              labelText:
                  'Price per spool (${ref.watch(settingsProvider(store)).asData?.value.currencyCode ?? 'SEK'})',
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (_) => setState(() {}),
          ),
          if (draft != null) ...[
            const SizedBox(height: 8),
            DetailRow(
              label: 'Price per kg',
              value: formatMoney(
                draft.pricePerKgMinor,
                ref.watch(settingsProvider(store)).asData?.value.currencyCode ??
                    'SEK',
              ),
            ),
          ],
          const SizedBox(height: 8),
          TextField(
            controller: _notes,
            decoration: const InputDecoration(labelText: 'Notes'),
            minLines: 2,
            maxLines: 4,
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: () async {
              final spool = _draft();
              if (spool == null) {
                setState(() => _error = 'Brand, material, weight, and price are required.');
                return;
              }
              await store.saveFilament(spool);
              if (context.mounted) {
                context.go('/filaments');
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
                  title: 'Delete spool',
                  message:
                      'This removes the spool. Quotes keep their saved weights.',
                );
                if (!confirmed || !context.mounted) {
                  return;
                }
                await store.deleteFilament(widget.id);
                if (context.mounted) {
                  context.go('/filaments');
                }
              },
              child: const Text('Delete spool'),
            ),
        ],
      ),
    );
  }
}

final filamentsProvider = StreamProvider.family<List<FilamentSpool>, UserStore>(
  (ref, store) => store.watchFilaments(),
);

class _ColorSwatch extends StatelessWidget {
  const _ColorSwatch({required this.hex, this.size = 32});

  final String hex;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(
        color: _color(hex),
        shape: BoxShape.circle,
        border: Border.all(color: Theme.of(context).colorScheme.outlineVariant),
      ),
    );
  }
}

String _plainNumber(double value) {
  if (value == value.roundToDouble()) {
    return value.round().toString();
  }
  return value.toString();
}

String _plainMoney(int minor) {
  final major = minor / 100;
  if (major == major.roundToDouble()) {
    return major.round().toString();
  }
  return major.toStringAsFixed(2);
}

Color _color(String hex) {
  var value = hex.replaceAll('#', '');
  if (value.length == 6) {
    value = 'FF$value';
  }
  final parsed = int.tryParse(value, radix: 16);
  if (parsed == null) {
    return const Color(0xFF808080);
  }
  return Color(parsed);
}
