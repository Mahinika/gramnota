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
import '../../sharing/domain/inbox_item.dart';
import '../../sharing/presentation/inbox_screen.dart';
import '../domain/common_spools.dart';
import '../domain/filament_spool.dart';

class FilamentsScreen extends ConsumerWidget {
  const FilamentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(userStoreProvider);
    if (store == null) {
      return const Scaffold(body: EmptyView(message: 'Sign in to see filament.'));
    }
    final spools = ref.watch(filamentsProvider(store));
    return Scaffold(
      appBar: AppBar(title: const Text('Filament')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/filaments/new'),
        child: const Icon(Icons.add),
      ),
      body: spools.when(
        data: (list) {
          if (list.isEmpty) {
            return EmptyView(
              message: 'No spools yet. Pick a standard spool or add your own.',
              action: _StandardSpoolPicker(
                onCustom: () => context.go('/filaments/new'),
                onAdd: (preset) => _addStandardSpool(context, store, preset),
              ),
            );
          }
          return ListView.separated(
            padding: TappableListCard.listPadding,
            itemCount: list.length + 1,
            separatorBuilder: (_, _) => TappableListCard.listSeparator,
            itemBuilder: (context, index) {
              if (index == 0) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Standard spools',
                      style: Theme.of(context).textTheme.labelLarge,
                    ),
                    const SizedBox(height: 8),
                    _StandardSpoolPicker(
                      onCustom: () => context.go('/filaments/new'),
                      onAdd: (preset) => _addStandardSpool(context, store, preset),
                    ),
                  ],
                );
              }
              final spool = list[index - 1];
              final theme = Theme.of(context);
              final scheme = theme.colorScheme;
              final progress = spool.spoolWeightGrams <= 0
                  ? 0.0
                  : (spool.remainingGrams / spool.spoolWeightGrams).clamp(
                      0.0,
                      1.0,
                    );
              return TappableListCard(
                onTap: () => context.go('/filaments/${spool.id}'),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 16,
                          backgroundColor: _color(spool.colorHex),
                        ),
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
                                '${formatGrams(spool.remainingGrams)} left',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: scheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                        if (spool.isLowStock)
                          Text(
                            'Low stock',
                            style: theme.textTheme.labelMedium?.copyWith(
                              color: scheme.error,
                            ),
                          ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    LinearProgressIndicator(value: progress),
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

class _StandardSpoolPicker extends StatelessWidget {
  const _StandardSpoolPicker({
    required this.onAdd,
    required this.onCustom,
  });

  final void Function(CommonSpool preset) onAdd;
  final VoidCallback onCustom;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: [
            for (final preset in commonSpools)
              ActionChip(
                avatar: CircleAvatar(
                  radius: 8,
                  backgroundColor: _color(preset.colorHex),
                ),
                label: Text(preset.label),
                onPressed: () => onAdd(preset),
              ),
          ],
        ),
        const SizedBox(height: 8),
        Align(
          alignment: Alignment.centerLeft,
          child: TextButton(
            onPressed: onCustom,
            child: const Text('Custom spool'),
          ),
        ),
      ],
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
    _diameter.text = spool.diameterMm.toString();
    _spoolWeight.text = spool.spoolWeightGrams.toString();
    _remaining.text = spool.remainingGrams.toString();
    _price.text = (spool.pricePerSpoolMinor / 100).toString();
    _low.text = spool.lowStockGrams.toString();
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
          if (_error != null) Text(_error!),
          if (widget.id == 'new') ...[
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
            const SizedBox(height: 12),
          ],
          TextField(controller: _brand, decoration: const InputDecoration(labelText: 'Brand'), onChanged: (_) => setState(() {})),
          TextField(controller: _material, decoration: const InputDecoration(labelText: 'Material'), onChanged: (_) => setState(() {})),
          TextField(controller: _color, decoration: const InputDecoration(labelText: 'Color hex'), onChanged: (_) => setState(() {})),
          TextField(controller: _diameter, decoration: const InputDecoration(labelText: 'Diameter mm'), keyboardType: TextInputType.number, onChanged: (_) => setState(() {})),
          TextField(controller: _spoolWeight, decoration: const InputDecoration(labelText: 'Spool weight g'), keyboardType: TextInputType.number, onChanged: (_) => setState(() {})),
          TextField(controller: _remaining, decoration: const InputDecoration(labelText: 'Remaining g'), keyboardType: TextInputType.number, onChanged: (_) => setState(() {})),
          TextField(controller: _price, decoration: const InputDecoration(labelText: 'Price per spool'), keyboardType: const TextInputType.numberWithOptions(decimal: true), onChanged: (_) => setState(() {})),
          if (draft != null)
            Text('Price per kg ${formatMoney(draft.pricePerKgMinor, 'SEK')}'),
          TextField(controller: _low, decoration: const InputDecoration(labelText: 'Low stock threshold g'), keyboardType: TextInputType.number),
          TextField(controller: _notes, decoration: const InputDecoration(labelText: 'Notes')),
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
              onPressed: () async {
                final next = parseNonNegativeDouble(_remaining.text);
                if (next == null || draft == null) {
                  return;
                }
                await store.saveFilament(draft.copyWith(remainingGrams: next));
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Remaining weight updated.')),
                  );
                }
              },
              child: const Text('Adjust remaining'),
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
