import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../core/format.dart';
import '../../../core/section_layout.dart';
import '../../../core/money.dart';
import '../../../core/text_prompt.dart';
import '../../../core/providers.dart';
import '../../../core/shell.dart';
import '../../../core/user_store.dart';
import '../../customers/domain/customer.dart';
import '../../filaments/domain/filament_spool.dart';
import '../../import/data/link_import_service.dart';
import '../../import/domain/import_models.dart';
import '../../orders/data/order_stock.dart';
import '../../orders/data/orders_providers.dart';
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
  var _mute = false;
  var _extraSeconds = 0;
  String? _appliedKey;
  String? _scheduledKey;

  String get _targetKey => '${widget.orderId ?? ''}|${widget.lineId ?? ''}';

  @override
  void initState() {
    super.initState();
    for (final controller in [
      _title,
      _prep,
      _post,
      _quantity,
      _markup,
      _failure,
      _vat,
    ]) {
      controller.addListener(_refresh);
    }
    _hours.addListener(_onDurationEdited);
    _minutes.addListener(_onDurationEdited);
    _rows.first.grams.addListener(_refresh);
  }

  void _refresh() {
    if (_mute || !mounted) {
      return;
    }
    setState(() {});
  }

  void _onDurationEdited() {
    if (!_mute) {
      _extraSeconds = 0;
    }
    _refresh();
  }

  void _write(TextEditingController controller, String value) {
    if (controller.text == value) {
      return;
    }
    final previous = _mute;
    _mute = true;
    controller.text = value;
    _mute = previous;
  }

  void _setDuration(int seconds) {
    final safe = seconds < 0 ? 0 : seconds;
    final previous = _mute;
    _mute = true;
    _extraSeconds = safe % 60;
    _hours.text = '${safe ~/ 3600}';
    _minutes.text = '${(safe % 3600) ~/ 60}';
    _mute = previous;
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
    final hours = parseNonNegativeDouble(_hours.text) ?? 0;
    final minutes = parseNonNegativeDouble(_minutes.text) ?? 0;
    return _scaled(hours, 3600) + _scaled(minutes, 60) + _extraSeconds;
  }

  int _scaled(double amount, int unit) {
    final scaled = amount * unit;
    if (scaled.isNaN || scaled.isInfinite || scaled > 1000000000000) {
      return 1000000000000;
    }
    return scaled.round();
  }

  int _minuteCount(TextEditingController controller) {
    final value = parseNonNegativeDouble(controller.text);
    if (value == null) {
      return 0;
    }
    return value.round();
  }

  String? _decimalError(String label, String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty || parseNonNegativeDouble(trimmed) != null) {
      return null;
    }
    return 'Could not read $label. Use a number, 0 or more.';
  }

  String? _wholeNumberError(String label, String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty || parsePositiveInt(trimmed) != null) {
      return null;
    }
    return '$label must be a whole number of 0 or more.';
  }

  String? _moneyError(String label, String text) {
    final trimmed = text.trim();
    if (trimmed.isEmpty || parseMinor(trimmed) != null) {
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

  String? _defaultPercentHint(String text, int workshopBasisPoints) {
    if (text.trim().isNotEmpty) {
      return null;
    }
    return 'Using workshop default ${formatPercent(workshopBasisPoints)}';
  }

  String? _roundedMinutesNote(TextEditingController controller) {
    final value = parseNonNegativeDouble(controller.text);
    if (value == null || value == value.roundToDouble()) {
      return null;
    }
    return 'Priced as ${value.round()} minutes.';
  }

  List<String> _inputProblems() {
    return [
      ?_decimalError('hours', _hours.text),
      ?_decimalError('minutes', _minutes.text),
      ?_decimalError('prep minutes', _prep.text),
      ?_decimalError('post minutes', _post.text),
      ?_wholeNumberError('Quantity', _quantity.text),
      ?_percentError('markup', _markup.text),
      ?_percentError('failure', _failure.text),
      ?_percentError('VAT', _vat.text),
      for (final row in _rows) ?_decimalError('grams', row.grams.text),
      for (final extra in _extras)
        ?_moneyError('the extra cost', extra.cost.text),
    ];
  }

  int _quantityValue() {
    final parsed = parsePositiveInt(_quantity.text) ?? 1;
    return parsed < 1 ? 1 : parsed;
  }

  void _scheduleDefaultPrinter(List<PrinterProfile> printers) {
    if (widget.lineId != null || printers.length != 1 || _printerId != null) {
      return;
    }
    final id = printers.single.id;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted || _printerId != null || widget.lineId != null) {
        return;
      }
      if (widget.orderId != null && _appliedKey != _targetKey) {
        return;
      }
      setState(() => _printerId = id);
    });
  }

  PrinterProfile? _selectedPrinter(List<PrinterProfile> printers) {
    final id = _printerId;
    if (id == null) {
      return null;
    }
    for (final printer in printers) {
      if (printer.id == id) {
        return printer;
      }
    }
    return null;
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
    _setDuration(seconds);
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
    final printer = _selectedPrinter(printers);
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
      prepMinutes: _minuteCount(_prep),
      postMinutes: _minuteCount(_post),
      laborMinorPerHour: settings.laborMinorPerHour,
      extraMinors: [
        for (final extra in _extras) parseMinor(extra.cost.text) ?? 0,
      ],
      markupBasisPoints:
          parseBasisPoints(_markup.text) ?? settings.defaultMarkupBasisPoints,
      vatBasisPoints: parseBasisPoints(_vat.text) ?? settings.vatBasisPoints,
      quantity: _quantityValue(),
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
    _mute = true;
    _title.clear();
    _link.clear();
    _extraSeconds = 0;
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
    _mute = false;
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
    _mute = true;
    _title.text = line.title;
    _link.text = line.sourceUrl;
    _setDuration(line.printTimeSeconds);
    _prep.text = '${line.prepMinutes}';
    _post.text = '${line.postMinutes}';
    _quantity.text = '${line.quantity < 1 ? 1 : line.quantity}';
    _markup.text = basisPointsLabel(line.markupBasisPoints);
    _failure.text = basisPointsLabel(line.failureBasisPoints);
    _vat.text = basisPointsLabel(line.vatBasisPoints);
    _mute = false;
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
          row.cost.text = formatMinorAmount(extra.costMinor);
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
          if (_keepsFilament(row))
            FilamentUsage(
              filamentId: row.filamentId ?? '',
              grams: parseNonNegativeDouble(row.grams.text) ?? 0,
              material: _pricedMaterial(row, spools),
              colorHex: _pricedColor(row, spools),
            ),
      ],
      prepMinutes: input.prepMinutes,
      postMinutes: input.postMinutes,
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
    final problems = _inputProblems();
    if (problems.isNotEmpty) {
      setState(() => _importNote = problems.join(' '));
      return;
    }
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
            'Move the order back to Quote or Accepted before changing prints.',
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

  bool _keepsFilament(_FilamentRow row) {
    final grams = parseNonNegativeDouble(row.grams.text) ?? 0;
    return grams > 0 ||
        (row.filamentId?.isNotEmpty ?? false) ||
        row.material.trim().isNotEmpty;
  }

  String _pricedMaterial(_FilamentRow row, List<FilamentSpool> spools) {
    final spool = _spool(spools, row.filamentId);
    if (spool != null && spool.material.trim().isNotEmpty) {
      return spool.material;
    }
    return row.material;
  }

  String _pricedColor(_FilamentRow row, List<FilamentSpool> spools) {
    if (row.colorHex.isNotEmpty) {
      return row.colorHex;
    }
    return _spool(spools, row.filamentId)?.colorHex ?? '';
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
    final name = await promptForText(
      context,
      title: 'New customer',
      label: 'Name',
    );
    if (name == null || name.isEmpty) {
      return null;
    }
    final customer = Customer(id: const Uuid().v4(), name: name);
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
    final settings = ref.watch(settingsProvider(store)).asData?.value;
    final printers =
        ref.watch(printersProvider(store)).asData?.value ?? const [];
    final spools =
        ref.watch(filamentsProvider(store)).asData?.value ?? const [];
    final orders = ref.watch(ordersProvider(store)).asData?.value;
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
      _write(_markup, basisPointsLabel(settings.defaultMarkupBasisPoints));
      _write(_failure, basisPointsLabel(settings.defaultFailureBasisPoints));
      _write(_vat, basisPointsLabel(settings.vatBasisPoints));
    }
    _scheduleDefaultPrinter(printers);
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
              'Move the order back to Quote or Accepted before changing prints.',
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
            onChanged: (value) {
              if (value.trim().isNotEmpty &&
                  _importNote == 'Add a title before saving the quote.') {
                setState(() => _importNote = null);
              }
            },
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
          if (_selectedPrinter(printers) == null) ...[
            const SizedBox(height: 4),
            Text(
              'No printer selected, so electricity and machine wear stay at 0.',
              style: Theme.of(context).textTheme.bodySmall,
            ),
          ],
          const SizedBox(height: 12),
          for (var index = 0; index < _rows.length; index++)
            _filamentEditor(
              index,
              spools,
              activeSettings.currencyCode,
              input.quantity,
            ),
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
                  decoration: InputDecoration(
                    labelText: 'Hours',
                    errorText: _decimalError('hours', _hours.text),
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
                    labelText: 'Minutes',
                    errorText: _decimalError('minutes', _minutes.text),
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
                    labelText: 'Prep minutes',
                    helperText: _roundedMinutesNote(_prep),
                    errorText: _decimalError('prep minutes', _prep.text),
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
                    labelText: 'Post minutes',
                    helperText: _roundedMinutesNote(_post),
                    errorText: _decimalError('post minutes', _post.text),
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
            controller: _quantity,
            decoration: InputDecoration(
              labelText: 'Quantity',
              helperText: (parsePositiveInt(_quantity.text) ?? 1) < 1
                  ? 'Quantity below 1 is priced as 1.'
                  : 'Material, time, and post-processing scale with quantity. Prep is charged once.',
              errorText: _wholeNumberError('Quantity', _quantity.text),
            ),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _markup,
                  decoration: InputDecoration(
                    labelText: 'Markup %',
                    helperText: _defaultPercentHint(
                      _markup.text,
                      activeSettings.defaultMarkupBasisPoints,
                    ),
                    errorText: _percentError('markup', _markup.text),
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
                    labelText: 'Failure %',
                    helperText: _defaultPercentHint(
                      _failure.text,
                      activeSettings.defaultFailureBasisPoints,
                    ),
                    errorText: _percentError('failure', _failure.text),
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
                    labelText: 'VAT %',
                    helperText: _defaultPercentHint(
                      _vat.text,
                      activeSettings.vatBasisPoints,
                    ),
                    errorText: _percentError('VAT', _vat.text),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          for (var index = 0; index < _extras.length; index++)
            Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
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
                      decoration: InputDecoration(
                        labelText: 'Cost',
                        errorText: _moneyError(
                          'the extra cost',
                          _extras[index].cost.text,
                        ),
                      ),
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: 'Remove extra',
                    onPressed: () => setState(() {
                      final extra = _extras.removeAt(index);
                      extra.cost.removeListener(_refresh);
                      extra.name.dispose();
                      extra.cost.dispose();
                    }),
                    icon: const Icon(Icons.close),
                  ),
                ],
              ),
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
          if (_extras.isNotEmpty)
            Text(
              'Extras are a flat amount for the whole print, not per unit. A cost without a name is saved as Extra.',
              style: Theme.of(context).textTheme.bodySmall,
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

  Widget _filamentEditor(
    int index,
    List<FilamentSpool> spools,
    String currencyCode,
    int quantity,
  ) {
    final row = _rows[index];
    final spool = _spool(spools, row.filamentId);
    final grams = parseNonNegativeDouble(row.grams.text);
    final needed = grams == null ? null : grams * quantity;
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
                    const DropdownMenuItem(child: Text('No spool')),
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
                  decoration: InputDecoration(
                    labelText: 'Grams',
                    errorText: _decimalError('grams', row.grams.text),
                  ),
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),
              if (_rows.length > 1)
                IconButton(
                  tooltip: 'Remove filament',
                  onPressed: () => setState(() {
                    final removed = _rows.removeAt(index);
                    removed.grams.removeListener(_refresh);
                    removed.grams.dispose();
                  }),
                  icon: const Icon(Icons.close),
                ),
            ],
          ),
          if (grams != null && grams > 0 && spool == null) ...[
            const SizedBox(height: 4),
            Text(
              'Pick a spool. These grams are priced at 0.',
              style: theme.textTheme.bodySmall?.copyWith(color: scheme.error),
            ),
          ],
          if (spool != null) ...[
            const SizedBox(height: 4),
            Text(
              '${formatMoney(spool.pricePerKgMinor, currencyCode)} / kg',
              style: theme.textTheme.bodySmall,
            ),
          ],
          if (spool != null && spool.isLowStock) ...[
            const SizedBox(height: 4),
            Text(
              'Low stock: ${formatGrams(spool.remainingGrams)} left on this spool.',
              style: theme.textTheme.bodySmall?.copyWith(color: scheme.error),
            ),
          ],
          if (spool != null &&
              needed != null &&
              needed > spool.remainingGrams) ...[
            const SizedBox(height: 4),
            Text(
              quantity > 1
                  ? 'This print needs ${formatGrams(needed)} (${formatGrams(grams!)} × $quantity) but only ${formatGrams(spool.remainingGrams)} remains.'
                  : 'This line uses ${formatGrams(needed)} but only ${formatGrams(spool.remainingGrams)} remains.',
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

