import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../core/format.dart';
import '../../../core/section_layout.dart';
import '../../../core/money.dart';
import '../../../core/providers.dart';
import '../../../core/shell.dart';
import '../../../core/user_store.dart';
import '../../customers/domain/customer.dart';
import '../../filaments/domain/filament_spool.dart';
import '../../import/data/link_import_service.dart';
import '../../import/domain/import_models.dart';
import '../../orders/data/order_stock.dart';
import '../../orders/domain/print_order.dart';
import '../../printers/domain/printer_profile.dart';
import '../../settings/domain/workshop_settings.dart';
import '../domain/price_breakdown.dart';
import '../domain/price_calculator.dart';
import 'breakdown_card.dart';

class CalculatorScreen extends ConsumerStatefulWidget {
  const CalculatorScreen({this.orderId, this.lineId, super.key});

  final String? orderId;
  final String? lineId;

  @override
  ConsumerState<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _FilamentRow {
  _FilamentRow({this.material = '', this.colorHex = ''});

  String? filamentId;
  String material;
  String colorHex;
  final grams = TextEditingController();
}

class _ExtraRow {
  final name = TextEditingController();
  final cost = TextEditingController();
}

const defaultPrepPostMinutes = 15;

class _CalculatorScreenState extends ConsumerState<CalculatorScreen> {
  final _title = TextEditingController();
  final _link = TextEditingController();
  final _hours = TextEditingController(text: '0');
  final _minutes = TextEditingController(text: '0');
  final _prep = TextEditingController(text: '$defaultPrepPostMinutes');
  final _post = TextEditingController(text: '$defaultPrepPostMinutes');
  final _quantity = TextEditingController(text: '1');
  final _markup = TextEditingController();
  final _failure = TextEditingController();
  final _vat = TextEditingController();
  final _rows = <_FilamentRow>[_FilamentRow()];
  final _extras = <_ExtraRow>[];
  String? _printerId;
  String _sourceUrl = '';
  String _profileTitle = '';
  String? _importNote;
  var _importing = false;
  var _saving = false;
  String? _appliedKey;
  String? _scheduledKey;

  String get _targetKey => '${widget.orderId ?? ''}|${widget.lineId ?? ''}';

  @override
  void initState() {
    super.initState();
    for (final controller in [
      _title,
      _hours,
      _minutes,
      _prep,
      _post,
      _quantity,
      _markup,
      _failure,
      _vat,
    ]) {
      controller.addListener(_refresh);
    }
    _rows.first.grams.addListener(_refresh);
  }

  void _refresh() {
    if (mounted) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    for (final controller in [
      _title,
      _link,
      _hours,
      _minutes,
      _prep,
      _post,
      _quantity,
      _markup,
      _failure,
      _vat,
    ]) {
      controller.dispose();
    }
    for (final row in _rows) {
      row.grams.dispose();
    }
    for (final extra in _extras) {
      extra.name.dispose();
      extra.cost.dispose();
    }
    super.dispose();
  }

  int _seconds() {
    final hours = parsePositiveInt(_hours.text) ?? 0;
    final minutes = parsePositiveInt(_minutes.text) ?? 0;
    return hours * 3600 + minutes * 60;
  }

  String _resolvedSourceUrl() {
    final typed = _link.text.trim();
    if (typed.startsWith('http://') || typed.startsWith('https://')) {
      return typed;
    }
    return _sourceUrl.trim();
  }

  void _applyProfile(
    ImportedProfile profile,
    List<PrinterProfile> printers,
    List<FilamentSpool> spools,
  ) {
    var seconds = profile.printTimeSeconds ?? 0;
    var filaments = profile.filaments;
    String? printerId = _printerId;
    for (final printer in printers) {
      if (_namesMatch(printer.name, profile.printerName)) {
        printerId = printer.id;
      }
      for (final variant in profile.variants) {
        if (_namesMatch(printer.name, variant.printerName)) {
          printerId = printer.id;
          seconds = variant.printTimeSeconds;
          if (variant.filaments.isNotEmpty) {
            filaments = variant.filaments;
          }
        }
      }
    }
    for (final row in _rows) {
      row.grams.dispose();
    }
    _rows
      ..clear()
      ..addAll(
        filaments.isEmpty
            ? [_FilamentRow()]
            : filaments.map((filament) {
                final row = _FilamentRow(
                  material: filament.material,
                  colorHex: filament.colorHex,
                );
                row.grams.text = filament.grams.toString();
                row.filamentId = _matchSpool(spools, filament.material);
                row.grams.addListener(_refresh);
                return row;
              }),
      );
    final hours = seconds ~/ 3600;
    final minutes = (seconds % 3600) ~/ 60;
    _hours.text = '$hours';
    _minutes.text = '$minutes';
    _printerId = printerId;
    _profileTitle = profile.title;
  }

  bool _namesMatch(String saved, String incoming) {
    final left = saved.trim().toLowerCase();
    final right = incoming.trim().toLowerCase();
    if (left.length < 2 || right.length < 2) {
      return false;
    }
    return left.contains(right) || right.contains(left);
  }

  String? _matchSpool(List<FilamentSpool> spools, String material) {
    final needle = material.trim().toLowerCase();
    if (needle.isEmpty) {
      return null;
    }
    final matches = spools
        .where((spool) => spool.material.trim().toLowerCase() == needle)
        .toList();
    if (matches.length == 1) {
      return matches.single.id;
    }
    return null;
  }

  Future<void> _import(UserStore store) async {
    final printers = await store.watchPrinters().first;
    final spools = await store.watchFilaments().first;
    setState(() {
      _importing = true;
      _importNote = null;
    });
    try {
      final result = await LinkImportService().importText(_link.text);
      if (!mounted) {
        return;
      }
      _sourceUrl = result.sourceUrl;
      if (result.sourceUrl.isNotEmpty) {
        _link.text = result.sourceUrl;
      }
      if (result.title.isNotEmpty) {
        _title.text = result.title;
      }
      if (result.profiles.length == 1) {
        _applyProfile(result.profiles.single, printers, spools);
      } else if (result.profiles.length > 1) {
        final picked = await showDialog<ImportedProfile>(
          context: context,
          builder: (context) => SimpleDialog(
            title: const Text('Choose a print profile'),
            children: [
              for (final profile in result.profiles)
                SimpleDialogOption(
                  onPressed: () => Navigator.pop(context, profile),
                  child: Text(
                    profile.title.isEmpty ? 'Print profile' : profile.title,
                  ),
                ),
            ],
          ),
        );
        if (picked != null) {
          _applyProfile(picked, printers, spools);
        }
      }
      setState(() => _importNote = result.note.isEmpty ? null : result.note);
    } on Object catch (error) {
      setState(
        () => _importNote =
            'The link could not be read ($error). Enter the print by hand.',
      );
    } finally {
      if (mounted) {
        setState(() => _importing = false);
      }
    }
  }

  PriceInput _input({
    required WorkshopSettings settings,
    required List<PrinterProfile> printers,
    required List<FilamentSpool> spools,
  }) {
    final printer = printers.cast<PrinterProfile?>().firstWhere(
      (printer) => printer!.id == _printerId,
      orElse: () => printers.isEmpty ? null : printers.first,
    );
    final materials = <MaterialUse>[];
    for (final row in _rows) {
      final grams = parseNonNegativeDouble(row.grams.text) ?? 0;
      final spool = spools.cast<FilamentSpool?>().firstWhere(
        (spool) => spool!.id == row.filamentId,
        orElse: () => null,
      );
      materials.add(
        MaterialUse(grams: grams, pricePerKgMinor: spool?.pricePerKgMinor ?? 0),
      );
    }
    return PriceInput(
      materials: materials,
      powerWatts: printer?.powerWatts ?? 0,
      printTimeSeconds: _seconds(),
      electricityMinorPerKwh: settings.electricityMinorPerKwh,
      purchasePriceMinor: printer?.purchasePriceMinor ?? 0,
      lifetimeHours: printer?.lifetimeHours ?? 0,
      maintenanceMinorPerHour: printer?.maintenanceMinorPerHour ?? 0,
      failureBasisPoints:
          parseBasisPoints(_failure.text) ?? settings.defaultFailureBasisPoints,
      prepMinutes: parsePositiveInt(_prep.text) ?? 0,
      postMinutes: parsePositiveInt(_post.text) ?? 0,
      laborMinorPerHour: settings.laborMinorPerHour,
      extraMinors: [
        for (final extra in _extras) parseMinor(extra.cost.text) ?? 0,
      ],
      markupBasisPoints:
          parseBasisPoints(_markup.text) ?? settings.defaultMarkupBasisPoints,
      vatBasisPoints: parseBasisPoints(_vat.text) ?? settings.vatBasisPoints,
      quantity: parsePositiveInt(_quantity.text) ?? 1,
    );
  }

  void _scheduleQuoteEdit(PrintOrder? order, WorkshopSettings? settings) {
    if (_appliedKey == _targetKey) {
      return;
    }
    if (widget.orderId != null && order == null) {
      return;
    }
    if (_scheduledKey == _targetKey) {
      return;
    }
    _scheduledKey = _targetKey;
    final key = _targetKey;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || key != _targetKey) {
        return;
      }
      _applyQuoteEdit(order, settings);
      _appliedKey = key;
      _scheduledKey = null;
      setState(() {});
    });
  }

  void _applyQuoteEdit(PrintOrder? order, WorkshopSettings? settings) {
    if (widget.orderId == null) {
      if (_appliedKey != null && _appliedKey != '|') {
        _clearForm(settings);
      }
      return;
    }
    if (widget.lineId == null) {
      _clearForm(settings);
      return;
    }
    if (order == null) {
      return;
    }
    for (final line in orderPrints(order)) {
      if (line.id == widget.lineId) {
        _fillFromLine(line);
        return;
      }
    }
    _importNote = 'That print is no longer on the quote.';
  }

  void _clearForm(WorkshopSettings? settings) {
    _title.clear();
    _link.clear();
    _hours.text = '0';
    _minutes.text = '0';
    _prep.text = '$defaultPrepPostMinutes';
    _post.text = '$defaultPrepPostMinutes';
    _quantity.text = '1';
    _markup.text = settings == null
        ? ''
        : basisPointsLabel(settings.defaultMarkupBasisPoints);
    _failure.text = settings == null
        ? ''
        : basisPointsLabel(settings.defaultFailureBasisPoints);
    _vat.text = settings == null
        ? ''
        : basisPointsLabel(settings.vatBasisPoints);
    _printerId = null;
    _sourceUrl = '';
    _profileTitle = '';
    _importNote = null;
    for (final row in _rows) {
      row.grams.removeListener(_refresh);
      row.grams.dispose();
    }
    final row = _FilamentRow();
    row.grams.addListener(_refresh);
    _rows
      ..clear()
      ..add(row);
    for (final extra in _extras) {
      extra.cost.removeListener(_refresh);
      extra.name.dispose();
      extra.cost.dispose();
    }
    _extras.clear();
  }

  void _fillFromLine(QuoteLine line) {
    _title.text = line.title;
    _link.text = line.sourceUrl;
    _hours.text = '${line.printTimeSeconds ~/ 3600}';
    _minutes.text = '${(line.printTimeSeconds % 3600) ~/ 60}';
    _prep.text = '${line.prepMinutes}';
    _post.text = '${line.postMinutes}';
    _quantity.text = '${line.quantity}';
    _markup.text = basisPointsLabel(line.markupBasisPoints);
    _failure.text = basisPointsLabel(line.failureBasisPoints);
    _vat.text = basisPointsLabel(line.vatBasisPoints);
    _printerId = line.printerId.isEmpty ? null : line.printerId;
    _sourceUrl = line.sourceUrl;
    _profileTitle = line.sourceProfileTitle;
    _importNote = null;
    for (final row in _rows) {
      row.grams.removeListener(_refresh);
      row.grams.dispose();
    }
    _rows.clear();
    if (line.filaments.isEmpty) {
      final row = _FilamentRow();
      row.grams.addListener(_refresh);
      _rows.add(row);
    } else {
      for (final filament in line.filaments) {
        final row = _FilamentRow(
          material: filament.material,
          colorHex: filament.colorHex,
        );
        row.filamentId = filament.filamentId.isEmpty
            ? null
            : filament.filamentId;
        row.grams.text = filament.grams.toString();
        row.grams.addListener(_refresh);
        _rows.add(row);
      }
    }
    for (final extra in _extras) {
      extra.cost.removeListener(_refresh);
      extra.name.dispose();
      extra.cost.dispose();
    }
    _extras
      ..clear()
      ..addAll(
        line.extras.map((extra) {
          final row = _ExtraRow();
          row.name.text = extra.name;
          final amount = extra.costMinor / 100;
          row.cost.text = amount == amount.roundToDouble()
              ? amount.round().toString()
              : amount.toStringAsFixed(2);
          row.cost.addListener(_refresh);
          return row;
        }),
      );
  }

  QuoteLine _captureLine(
    String id,
    PriceInput input,
    PriceBreakdown breakdown,
    List<FilamentSpool> spools,
  ) {
    return QuoteLine(
      id: id,
      title: _title.text.trim(),
      quantity: input.quantity,
      printerId: _printerId ?? '',
      printTimeSeconds: input.printTimeSeconds,
      filaments: [
        for (final row in _rows)
          FilamentUsage(
            filamentId: row.filamentId ?? '',
            grams: parseNonNegativeDouble(row.grams.text) ?? 0,
            material: row.material.isNotEmpty
                ? row.material
                : _spool(spools, row.filamentId)?.material ?? '',
            colorHex: row.colorHex,
          ),
      ],
      prepMinutes: input.prepMinutes,
      postMinutes: input.postMinutes,
      extras: [
        for (final extra in _extras)
          if (extra.name.text.trim().isNotEmpty)
            ExtraCost(
              name: extra.name.text.trim(),
              costMinor: parseMinor(extra.cost.text) ?? 0,
            ),
      ],
      markupBasisPoints: input.markupBasisPoints,
      failureBasisPoints: input.failureBasisPoints,
      vatBasisPoints: input.vatBasisPoints,
      breakdown: breakdown,
      sourceUrl: _resolvedSourceUrl(),
      sourceModelTitle: _title.text.trim(),
      sourceProfileTitle: _profileTitle,
    );
  }

  Future<void> _save(
    UserStore store,
    WorkshopSettings settings,
    PriceInput input,
    List<FilamentSpool> spools,
    PrintOrder? target,
  ) async {
    if (_title.text.trim().isEmpty) {
      setState(() => _importNote = 'Add a title before saving the quote.');
      return;
    }
    if (widget.orderId != null) {
      await _saveOnQuote(store, input, spools, target);
      return;
    }
    final customers = await store.watchCustomers().first;
    if (!mounted) {
      return;
    }
    final customerId = await _pickCustomerForQuote(customers);
    if (customerId == null || !mounted) {
      return;
    }
    var resolvedCustomer = customerId;
    if (customerId == 'new') {
      final created = await _createCustomer(store);
      if (created == null) {
        return;
      }
      resolvedCustomer = created.id;
    }
    setState(() => _saving = true);
    try {
      final number = await OrderStock(store).allocateQuoteNumber();
      final now = DateTime.now().toUtc();
      final breakdown = const PriceCalculator().calculate(input);
      final line = _captureLine(const Uuid().v4(), input, breakdown, spools);
      final draft = PrintOrder(
        id: const Uuid().v4(),
        quoteNumber: number,
        customerId: resolvedCustomer,
        title: line.title,
        status: OrderStatus.quote,
        validUntil: now
            .add(Duration(days: settings.quoteValidityDays))
            .toIso8601String(),
        quantity: line.quantity,
        printerId: line.printerId,
        printTimeSeconds: line.printTimeSeconds,
        filaments: line.filaments,
        prepMinutes: line.prepMinutes,
        postMinutes: line.postMinutes,
        extras: line.extras,
        markupBasisPoints: line.markupBasisPoints,
        failureBasisPoints: line.failureBasisPoints,
        vatBasisPoints: line.vatBasisPoints,
        currencyCode: settings.currencyCode,
        breakdown: line.breakdown,
        sourceUrl: line.sourceUrl,
        sourceModelTitle: line.sourceModelTitle,
        sourceProfileTitle: line.sourceProfileTitle,
        createdAt: now.toIso8601String(),
        updatedAt: now.toIso8601String(),
      );
      final order = orderWithPrints(draft, [line]);
      await store.saveOrder(order);
      if (mounted) {
        context.go('/orders/${order.id}');
      }
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  Future<void> _saveOnQuote(
    UserStore store,
    PriceInput input,
    List<FilamentSpool> spools,
    PrintOrder? target,
  ) async {
    if (target == null) {
      setState(() => _importNote = 'Quote not found.');
      return;
    }
    if (target.stockDeducted) {
      setState(
        () => _importNote =
            'Move the order back to Accepted before changing prints.',
      );
      return;
    }
    setState(() => _saving = true);
    try {
      final breakdown = const PriceCalculator().calculate(input);
      final line = _captureLine(
        widget.lineId ?? const Uuid().v4(),
        input,
        breakdown,
        spools,
      );
      final current = orderPrints(target);
      final next = <QuoteLine>[];
      if (widget.lineId == null) {
        next.addAll([...current, line]);
      } else {
        var found = false;
        for (final item in current) {
          if (item.id == widget.lineId) {
            next.add(line);
            found = true;
          } else {
            next.add(item);
          }
        }
        if (!found) {
          next.add(line);
        }
      }
      final now = DateTime.now().toUtc().toIso8601String();
      final updated = orderWithPrints(target, next).copyWith(
        title: quoteTitleFor(target, next),
        updatedAt: now,
      );
      await store.saveOrder(updated);
      if (mounted) {
        context.go('/orders/${updated.id}');
      }
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }

  FilamentSpool? _spool(List<FilamentSpool> spools, String? id) {
    for (final spool in spools) {
      if (spool.id == id) {
        return spool;
      }
    }
    return null;
  }

  Future<String?> _pickCustomerForQuote(List<Customer> customers) {
    return showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      showDragHandle: true,
      builder: (sheetContext) => _CustomerQuotePicker(
        customers: customers,
        onNew: () => Navigator.pop(sheetContext, 'new'),
        onNone: () => Navigator.pop(sheetContext, ''),
      ),
    );
  }

  Future<Customer?> _createCustomer(UserStore store) async {
    final name = TextEditingController();
    final created = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('New customer'),
        content: TextField(
          controller: name,
          decoration: const InputDecoration(labelText: 'Name'),
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
    if (created != true || name.text.trim().isEmpty) {
      name.dispose();
      return null;
    }
    final customer = Customer(id: const Uuid().v4(), name: name.text.trim());
    name.dispose();
    await store.saveCustomer(customer);
    return customer;
  }

  @override
  Widget build(BuildContext context) {
    final store = ref.watch(userStoreProvider);
    final pending = ref.watch(pendingLinkProvider);
    if (pending != null && pending != _link.text) {
      _link.text = pending;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        ref.read(pendingLinkProvider.notifier).setLink(null);
        if (store != null) {
          _import(store);
        }
      });
    }
    if (store == null) {
      return const Scaffold(body: EmptyView(message: 'Sign in to calculate.'));
    }
    final settings = ref.watch(_settingsProvider(store)).asData?.value;
    final printers =
        ref.watch(_printersProvider(store)).asData?.value ?? const [];
    final spools =
        ref.watch(_filamentsProvider(store)).asData?.value ?? const [];
    final orders = ref.watch(_ordersProvider(store)).asData?.value;
    PrintOrder? target;
    if (widget.orderId != null && orders != null) {
      for (final order in orders) {
        if (order.id == widget.orderId) {
          target = order;
        }
      }
    }
    _scheduleQuoteEdit(target, settings);
    if (settings != null &&
        widget.lineId == null &&
        _markup.text.isEmpty &&
        _vat.text.isEmpty &&
        _failure.text.isEmpty) {
      _markup.text = basisPointsLabel(settings.defaultMarkupBasisPoints);
      _failure.text = basisPointsLabel(settings.defaultFailureBasisPoints);
      _vat.text = basisPointsLabel(settings.vatBasisPoints);
    }
    final activeSettings = settings ?? const WorkshopSettings();
    final input = _input(
      settings: activeSettings,
      printers: printers,
      spools: spools,
    );
    final breakdown = const PriceCalculator().calculate(input);
    final locked = target != null && target.stockDeducted;
    final saveLabel = widget.lineId != null
        ? 'Update print'
        : widget.orderId != null
        ? 'Add print'
        : 'Save as quote';
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.lineId != null
              ? 'Edit print'
              : widget.orderId != null
              ? 'Add print'
              : 'Calculator',
        ),
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth >= 840;
          final summary = [
            const SectionHeading('Price'),
            BreakdownCard(
              breakdown: breakdown,
              currencyCode: activeSettings.currencyCode,
            ),
            const SizedBox(height: 12),
            FilledButton(
              onPressed: _saving || locked
                  ? null
                  : () => _save(store, activeSettings, input, spools, target),
              child: Text(_saving ? 'Saving…' : saveLabel),
            ),
          ];
          final fields = <Widget>[
          if (target != null) ...[
            Text(
              widget.lineId == null
                  ? 'Adding a print to ${target.title}'
                  : 'Editing a print on ${target.title}',
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () => context.go('/calculator'),
                child: const Text('Cancel'),
              ),
            ),
          ],
          if (locked)
            const Text(
              'Move the order back to Accepted before changing prints.',
            ),
          TextField(
            controller: _link,
            decoration: const InputDecoration(
              labelText: 'Model link',
              hintText: 'MakerWorld, Printables, Creality Cloud, or another site',
            ),
          ),
          const SizedBox(height: 8),
          Align(
            alignment: Alignment.centerLeft,
            child: FilledButton.tonal(
              onPressed: _importing ? null : () => _import(store),
              child: Text(_importing ? 'Reading link…' : 'Fill from link'),
            ),
          ),
          if (_importNote != null) ...[
            const SizedBox(height: 8),
            Text(_importNote!),
          ],
          const SizedBox(height: 12),
          TextField(
            controller: _title,
            decoration: const InputDecoration(labelText: 'Title'),
          ),
          const SizedBox(height: 12),
          DropdownButtonFormField<String>(
            key: ValueKey(_printerId),
            initialValue: printers.any((printer) => printer.id == _printerId)
                ? _printerId
                : null,
            decoration: const InputDecoration(labelText: 'Printer'),
            items: [
              for (final printer in printers)
                DropdownMenuItem(value: printer.id, child: Text(printer.name)),
            ],
            onChanged: (value) => setState(() => _printerId = value),
          ),
          const SizedBox(height: 12),
          for (var index = 0; index < _rows.length; index++)
            _filamentEditor(index, spools),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () => setState(() {
                final row = _FilamentRow();
                row.grams.addListener(_refresh);
                _rows.add(row);
              }),
              child: const Text('Add filament'),
            ),
          ),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _hours,
                  decoration: const InputDecoration(labelText: 'Hours'),
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _minutes,
                  decoration: const InputDecoration(labelText: 'Minutes'),
                  keyboardType: TextInputType.number,
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
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _post,
                  decoration: const InputDecoration(labelText: 'Post minutes'),
                  keyboardType: TextInputType.number,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _quantity,
            decoration: const InputDecoration(labelText: 'Quantity'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
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
          for (var index = 0; index < _extras.length; index++)
            Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _extras[index].name,
                    decoration: const InputDecoration(labelText: 'Extra'),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: TextField(
                    controller: _extras[index].cost,
                    decoration: const InputDecoration(labelText: 'Cost'),
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),
                ),
              ],
            ),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () => setState(() {
                final extra = _ExtraRow();
                extra.cost.addListener(_refresh);
                _extras.add(extra);
              }),
              child: const Text('Add extra cost'),
            ),
          ),
            DetailRow(
              label: 'Print time',
              value: formatDuration(_seconds()),
            ),
          ];
          if (!wide) {
            return ListView(
              padding: const EdgeInsets.all(16),
              children: [...fields, const SectionRule(), ...summary],
            );
          }
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              IntrinsicHeight(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      flex: 5,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: fields,
                      ),
                    ),
                    const VerticalDivider(width: 1),
                    Expanded(
                      flex: 4,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: summary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget _filamentEditor(int index, List<FilamentSpool> spools) {
    final row = _rows[index];
    final spool = _spool(spools, row.filamentId);
    final grams = parseNonNegativeDouble(row.grams.text);
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 2,
                child: DropdownButtonFormField<String>(
                  key: ValueKey('${row.filamentId}-$index'),
                  initialValue: spools.any((item) => item.id == row.filamentId)
                      ? row.filamentId
                      : null,
                  decoration: InputDecoration(
                    labelText: row.material.isEmpty
                        ? 'Spool'
                        : 'Spool (${row.material})',
                  ),
                  items: [
                    for (final item in spools)
                      DropdownMenuItem(
                        value: item.id,
                        child: Text(
                          item.isLowStock
                              ? '${item.brand} ${item.material} · low'
                              : '${item.brand} ${item.material}',
                        ),
                      ),
                  ],
                  onChanged: (value) => setState(() => row.filamentId = value),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: row.grams,
                  decoration: const InputDecoration(labelText: 'Grams'),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),
            ],
          ),
          if (spool != null && spool.isLowStock) ...[
            const SizedBox(height: 4),
            Text(
              'Low stock: ${formatGrams(spool.remainingGrams)} left on this spool.',
              style: theme.textTheme.bodySmall?.copyWith(color: scheme.error),
            ),
          ],
          if (spool != null &&
              grams != null &&
              grams > spool.remainingGrams) ...[
            const SizedBox(height: 4),
            Text(
              'This line uses ${formatGrams(grams)} but only ${formatGrams(spool.remainingGrams)} remains.',
              style: theme.textTheme.bodySmall?.copyWith(
                color: scheme.tertiary,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _CustomerQuotePicker extends StatefulWidget {
  const _CustomerQuotePicker({
    required this.customers,
    required this.onNew,
    required this.onNone,
  });

  final List<Customer> customers;
  final VoidCallback onNew;
  final VoidCallback onNone;

  @override
  State<_CustomerQuotePicker> createState() => _CustomerQuotePickerState();
}

class _CustomerQuotePickerState extends State<_CustomerQuotePicker> {
  final _search = TextEditingController();

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final query = _search.text.trim().toLowerCase();
    final visible = [
      for (final customer in widget.customers)
        if (query.isEmpty || customer.name.toLowerCase().contains(query))
          customer,
    ]..sort((a, b) => a.name.compareTo(b.name));
    final bottom = MediaQuery.viewInsetsOf(context).bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 16 + bottom),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.55,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Save as quote',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 12),
            TextField(
              controller: _search,
              decoration: const InputDecoration(
                hintText: 'Customer name',
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 8),
            ListTile(
              contentPadding: EdgeInsets.zero,
              title: const Text('No customer'),
              onTap: widget.onNone,
            ),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.person_add_outlined),
              title: const Text('New customer'),
              onTap: widget.onNew,
            ),
            const Divider(height: 1),
            Expanded(
              child: visible.isEmpty
                  ? const Center(child: Text('No customer with that name.'))
                  : ListView.separated(
                      itemCount: visible.length,
                      separatorBuilder: (_, _) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final customer = visible[index];
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          title: Text(customer.name),
                          subtitle: customer.city.trim().isEmpty
                              ? null
                              : Text(customer.city),
                          onTap: () => Navigator.pop(context, customer.id),
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

final _settingsProvider = StreamProvider.family<WorkshopSettings, UserStore>(
  (ref, store) => store.watchSettings(),
);

final _printersProvider = StreamProvider.family<List<PrinterProfile>, UserStore>(
  (ref, store) => store.watchPrinters(),
);

final _filamentsProvider = StreamProvider.family<List<FilamentSpool>, UserStore>(
  (ref, store) => store.watchFilaments(),
);

final _ordersProvider = StreamProvider.family<List<PrintOrder>, UserStore>(
  (ref, store) => store.watchOrders(),
);
