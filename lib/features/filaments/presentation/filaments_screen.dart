import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gramnota/l10n/l10n.dart';
import 'package:uuid/uuid.dart';

import '../../../core/currencies.dart';
import '../../../core/save_feedback.dart';
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
      return Scaffold(
        body: EmptyView(message: context.l10n.filamentSignInList),
      );
    }
    final spools = ref.watch(filamentsProvider(store));
    final settings = ref.watch(settingsProvider(store)).asData?.value;
    final currency = settings?.currencyCode ?? defaultCurrencyCode;
    final lowStockGrams = settings?.defaultLowStockGrams ?? 100;
    return Scaffold(
      appBar: AppBar(
        title: Text(context.l10n.navFilament),
        actions: [
          IconButton(
            tooltip: context.l10n.filamentAddStandard,
            onPressed: () => _showStandardSpools(context, store),
            icon: const Icon(Icons.library_add_outlined),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        tooltip: context.l10n.filamentCustom,
        onPressed: () => context.go('/filaments/new'),
        child: const Icon(Icons.add),
      ),
      body: spools.when(
        data: (list) {
          if (list.isEmpty) {
            return EmptyView(
              message: context.l10n.filamentNoneYet,
              action: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  FilledButton(
                    onPressed: () => _showStandardSpools(context, store),
                    child: Text(
                      context.l10n.filamentAddStandard,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(height: 8),
                  TextButton(
                    onPressed: () => context.go('/filaments/new'),
                    child: Text(
                      context.l10n.filamentCustom,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          }
          final query = _search.text.trim().toLowerCase();
          final visible =
              [
                for (final spool in list)
                  if ((!_lowStockOnly || spool.isLowAt(lowStockGrams)) &&
                      (query.isEmpty ||
                          '${spool.brand} ${spool.material} ${spool.notes}'
                              .toLowerCase()
                              .contains(query)))
                    spool,
              ]..sort((a, b) {
                final brand = a.brand.toLowerCase().compareTo(
                  b.brand.toLowerCase(),
                );
                if (brand != 0) {
                  return brand;
                }
                return a.material.toLowerCase().compareTo(
                  b.material.toLowerCase(),
                );
              });
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: TextField(
                  controller: _search,
                  decoration: InputDecoration(
                    hintText: context.l10n.filamentSearchHint,
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                child: Row(
                  children: [
                    FilterChip(
                      label: Text(
                        context.l10n.filamentFilterAll,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      selected: !_lowStockOnly,
                      showCheckmark: false,
                      onSelected: (_) => setState(() => _lowStockOnly = false),
                    ),
                    const SizedBox(width: 8),
                    FilterChip(
                      label: Text(
                        context.l10n.filamentFilterLow,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
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
                      context.l10n.filamentCount(visible.length),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ),
              Expanded(
                child: visible.isEmpty
                    ? EmptyView(message: context.l10n.filamentSearchEmpty)
                    : ListView.separated(
                        padding: TappableListCard.listPadding,
                        itemCount: visible.length,
                        separatorBuilder: (_, _) =>
                            TappableListCard.listSeparator,
                        itemBuilder: (context, index) {
                          final spool = visible[index];
                          return _SpoolListCard(
                            spool: spool,
                            currencyCode: currency,
                            low: spool.isLowAt(lowStockGrams),
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
    required this.low,
    required this.onTap,
  });

  final FilamentSpool spool;
  final String currencyCode;
  final bool low;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final progress = spool.spoolWeightGrams <= 0
        ? 0.0
        : (spool.remainingGrams / spool.spoolWeightGrams).clamp(0.0, 1.0);
    final barColor = low ? scheme.error : scheme.primary;
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
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium,
                    ),
                    Text(
                      context.l10n.filamentRemainingOf(
                        context.gramsText(spool.remainingGrams),
                        context.gramsText(spool.spoolWeightGrams),
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
              if (low)
                Text(
                  context.l10n.filamentLow,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
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
            context.l10n.filamentListPrice(
              context.money(spool.pricePerSpoolMinor, currencyCode),
              context.money(spool.pricePerKgMinor, currencyCode),
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
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
    final l10n = context.l10n;
    final matches = _matchingFilamentPresets(l10n, _query.text);
    final bottom = MediaQuery.viewInsetsOf(context).bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 16 + bottom),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.55,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.filamentStandardTitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _query,
              decoration: InputDecoration(
                hintText: l10n.filamentStandardSearchHint,
                prefixIcon: const Icon(Icons.search),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 8),
            Expanded(
              child: matches.isEmpty
                  ? EmptyView(message: l10n.setupNoSpoolMatch)
                  : ListView.separated(
                      itemCount: matches.length,
                      separatorBuilder: (_, _) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final preset = matches[index];
                        final price = preset.pricePerSpoolMinor == 0
                            ? l10n.filamentSetPriceAfterAdding
                            : context.money(preset.pricePerSpoolMinor, 'SEK');
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: _ColorSwatch(hex: preset.colorHex),
                          title: Text(
                            _filamentPresetTitle(l10n, preset),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          subtitle: Text(
                            l10n.filamentPresetLine(
                              context.gramsText(preset.spoolWeightGrams),
                              price,
                            ),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
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
    lowStockUsesDefault: true,
  );
  try {
    await store.saveFilament(spool);
  } on Object {
    if (context.mounted) {
      showSaveError(context, context.l10n.filamentSaveFailed);
    }
    return;
  }
  if (!context.mounted) {
    return;
  }
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(
        context.l10n.filamentAdded(_filamentPresetTitle(context.l10n, preset)),
      ),
      action: SnackBarAction(
        label: context.l10n.filamentEditPrice,
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
  var _usesWorkshopDefault = true;
  String? _error;

  void _applyPreset(CommonSpool preset, String locale) {
    _brand.text = preset.brand;
    _material.text = preset.material;
    _color.text = preset.colorHex;
    _spoolWeight.text = preset.spoolWeightGrams.round().toString();
    _remaining.text = preset.spoolWeightGrams.round().toString();
    if (preset.pricePerSpoolMinor > 0) {
      _price.text = formatMinorField(preset.pricePerSpoolMinor, locale: locale);
    }
    _error = null;
  }

  List<CommonSpool> _matchingPresets(AppLocalizations l10n) =>
      _matchingFilamentPresets(l10n, _presetQuery.text);

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

  void _load(FilamentSpool spool, String locale) {
    if (_loaded) {
      return;
    }
    _brand.text = spool.brand;
    _material.text = spool.material;
    _color.text = spool.colorHex;
    _diameter.text = _plainNumber(spool.diameterMm);
    _spoolWeight.text = _plainNumber(spool.spoolWeightGrams);
    _remaining.text = _plainNumber(spool.remainingGrams);
    _price.text = formatMinorField(spool.pricePerSpoolMinor, locale: locale);
    _low.text = _plainNumber(spool.lowStockGrams);
    _usesWorkshopDefault = spool.lowStockUsesDefault;
    _notes.text = spool.notes;
    _loaded = true;
  }

  FilamentSpool? _draft(String currencyCode) {
    final price = parseMoneyInput(
      _price.text,
      currencyCode: currencyCode,
      locale: context.formattingLocale,
    );
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
      lowStockUsesDefault: _usesWorkshopDefault,
      notes: _notes.text.trim(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final store = ref.watch(userStoreProvider);
    if (store == null) {
      return Scaffold(
        body: EmptyView(message: context.l10n.filamentSignInEdit),
      );
    }
    final existing = ref.watch(filamentsProvider(store));
    if (widget.id != 'new') {
      final match = existing.asData?.value.where(
        (item) => item.id == widget.id,
      );
      if (match != null && match.isNotEmpty) {
        _load(match.first, context.formattingLocale);
      }
    }
    final settings = ref.watch(settingsProvider(store)).asData?.value;
    final currency = settings?.currencyCode ?? defaultCurrencyCode;
    final draft = _draft(currency);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.id == 'new' ? context.l10n.filamentNew : _brand.text,
        ),
        actions: [
          if (draft != null && widget.id != 'new')
            IconButton(
              tooltip: context.l10n.inboxSendToUser,
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
            SectionHeading(context.l10n.setupStandardSpool),
            TextField(
              controller: _presetQuery,
              decoration: InputDecoration(
                labelText: context.l10n.filamentFindStandard,
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 8),
            if (_matchingPresets(context.l10n).isEmpty)
              Text(context.l10n.setupNoSpoolMatch)
            else
              DropdownButtonFormField<String>(
                key: ValueKey(_presetQuery.text.trim().toLowerCase()),
                isExpanded: true,
                decoration: InputDecoration(
                  labelText: context.l10n.setupStandardSpool,
                ),
                items: [
                  for (final preset in _matchingPresets(context.l10n))
                    DropdownMenuItem(
                      value: preset.label,
                      child: Text(
                        _filamentPresetTitle(context.l10n, preset),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                ],
                onChanged: (label) {
                  if (label == null) {
                    return;
                  }
                  final preset = _matchingPresets(
                    context.l10n,
                  ).firstWhere((item) => item.label == label);
                  setState(
                    () => _applyPreset(preset, context.formattingLocale),
                  );
                },
              ),
            const SectionRule(),
          ],
          SectionHeading(context.l10n.filamentSection),
          TextField(
            controller: _color,
            decoration: InputDecoration(
              labelText: context.l10n.filamentColorHex,
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
            decoration: InputDecoration(labelText: context.l10n.filamentBrand),
            textCapitalization: TextCapitalization.words,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _material,
            decoration: InputDecoration(
              labelText: context.l10n.filamentMaterial,
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _diameter,
            decoration: InputDecoration(
              labelText: context.l10n.filamentDiameterMm,
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (_) => setState(() {}),
          ),
          const SectionRule(),
          SectionHeading(context.l10n.filamentStock),
          TextField(
            controller: _spoolWeight,
            decoration: InputDecoration(
              labelText: context.l10n.filamentWeightLabel,
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _remaining,
            decoration: InputDecoration(
              labelText: context.l10n.filamentRemainingLabel,
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          SwitchListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(
              context.l10n.filamentUseWorkshopLowStock,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            subtitle: Text(
              _usesWorkshopDefault
                  ? context.l10n.filamentWarnsAt(
                      context.gramsText(settings?.defaultLowStockGrams ?? 100),
                    )
                  : context.l10n.filamentOwnThreshold,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            value: _usesWorkshopDefault,
            onChanged: (value) => setState(() => _usesWorkshopDefault = value),
          ),
          if (!_usesWorkshopDefault) ...[
            const SizedBox(height: 12),
            TextField(
              controller: _low,
              decoration: InputDecoration(
                labelText: context.l10n.filamentLowStockThreshold,
              ),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),
          ],
          if (widget.id != 'new')
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () {
                  setState(() => _remaining.text = _spoolWeight.text);
                },
                child: Text(context.l10n.filamentRefill),
              ),
            ),
          const SectionRule(),
          SectionHeading(context.l10n.filamentPriceHeading),
          const SizedBox(height: 4),
          TextField(
            controller: _price,
            decoration: InputDecoration(
              labelText: context.l10n.filamentPricePerSpool(currency),
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            onChanged: (_) => setState(() {}),
          ),
          if (draft != null) ...[
            const SizedBox(height: 8),
            DetailRow(
              label: context.l10n.filamentPricePerKg,
              value: context.money(draft.pricePerKgMinor, currency),
            ),
          ],
          const SizedBox(height: 8),
          TextField(
            controller: _notes,
            decoration: InputDecoration(labelText: context.l10n.fieldNotes),
            minLines: 2,
            maxLines: 4,
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: () async {
              final spool = _draft(currency);
              if (spool == null) {
                setState(() => _error = context.l10n.filamentRequired);
                return;
              }
              try {
                await store.saveFilament(spool);
              } on Object {
                if (context.mounted) {
                  showSaveError(context, context.l10n.filamentSaveFailed);
                  setState(() => _error = context.l10n.filamentSaveFailed);
                }
                return;
              }
              if (context.mounted) {
                context.go('/filaments');
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
                  title: context.l10n.filamentDelete,
                  message: context.l10n.filamentDeleteMessage,
                );
                if (!confirmed || !context.mounted) {
                  return;
                }
                await store.deleteFilament(widget.id);
                if (context.mounted) {
                  context.go('/filaments');
                }
              },
              child: Text(context.l10n.filamentDelete),
            ),
        ],
      ),
    );
  }
}

String _filamentPresetTitle(AppLocalizations l10n, CommonSpool preset) {
  final brand = preset.brand == 'Generic'
      ? l10n.filamentBrandGeneric
      : preset.brand;
  final color = switch (preset.colorLabel) {
    'Black' => l10n.filamentColorBlack,
    'White' => l10n.filamentColorWhite,
    'Gray' => l10n.filamentColorGray,
    'Unspecified' => l10n.filamentColorUnspecified,
    _ => preset.colorLabel,
  };
  return '$brand ${preset.material} · $color';
}

List<CommonSpool> _matchingFilamentPresets(
  AppLocalizations l10n,
  String query,
) {
  final needle = query.trim().toLowerCase();
  if (needle.isEmpty) {
    return commonSpools;
  }
  return [
    for (final preset in commonSpools)
      if (preset.label.toLowerCase().contains(needle) ||
          preset.brand.toLowerCase().contains(needle) ||
          preset.material.toLowerCase().contains(needle) ||
          _filamentPresetTitle(l10n, preset).toLowerCase().contains(needle))
        preset,
  ];
}

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
