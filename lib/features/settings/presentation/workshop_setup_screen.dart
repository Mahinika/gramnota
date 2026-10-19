import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../core/format.dart';
import '../../../core/money.dart';
import '../../../core/gate_scaffold.dart';
import '../../../core/providers.dart';
import '../../../core/shell.dart';
import '../../orders/data/orders_providers.dart';
import '../../filaments/domain/common_spools.dart';
import '../../filaments/domain/filament_spool.dart';
import '../../printers/domain/common_printers.dart';
import '../../printers/domain/printer_profile.dart';
import '../domain/workshop_settings.dart';

bool setupBypassForUid({
  required String? markedUid,
  required String? currentUid,
}) {
  if (markedUid == null || currentUid == null) {
    return false;
  }
  return markedUid == currentUid;
}

/// True once this session has saved the workshop setup.
/// The Firestore snapshot can arrive after navigation, and this keeps the
/// router from sending the user back into the guide.
class SetupFinished extends Notifier<bool> {
  String? _markedUid;

  @override
  bool build() {
    final currentUid = ref.watch(authUserProvider).asData?.value?.uid;
    return setupBypassForUid(markedUid: _markedUid, currentUid: currentUid);
  }

  void mark() {
    _markedUid = ref.read(authUserProvider).asData?.value?.uid;
    state = setupBypassForUid(
      markedUid: _markedUid,
      currentUid: _markedUid,
    );
  }
}

final setupFinishedProvider = NotifierProvider<SetupFinished, bool>(
  SetupFinished.new,
);

/// Null while settings are still loading. True when the stream fails, so a
/// workshop is not stuck on the starting screen.
final setupCompletedProvider = Provider<bool?>((ref) {
  final store = ref.watch(userStoreProvider);
  if (store == null) {
    return null;
  }
  final settings = ref.watch(settingsProvider(store));
  if (settings.hasError) {
    return true;
  }
  return settings.asData?.value.setupCompleted;
});

class StartingScreen extends StatelessWidget {
  const StartingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const GateScaffold(
      title: 'Gramnota',
      child: CircularProgressIndicator(),
    );
  }
}

class WorkshopSetupScreen extends ConsumerStatefulWidget {
  const WorkshopSetupScreen({super.key});

  @override
  ConsumerState<WorkshopSetupScreen> createState() =>
      _WorkshopSetupScreenState();
}

class _WorkshopSetupScreenState extends ConsumerState<WorkshopSetupScreen> {
  static const _stepCount = 9;

  final _business = TextEditingController();
  final _street = TextEditingController();
  final _postal = TextEditingController();
  final _city = TextEditingController();
  final _org = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  final _electricity = TextEditingController();
  final _labor = TextEditingController();
  final _markup = TextEditingController(text: '30');
  final _failure = TextEditingController(text: '0');
  final _vat = TextEditingController(text: '25');
  final _currency = TextEditingController(text: 'SEK');
  final _validity = TextEditingController(text: '14');
  final _printerQuery = TextEditingController();
  final _printerName = TextEditingController();
  final _watts = TextEditingController();
  final _price = TextEditingController();
  final _life = TextEditingController(text: '5000');
  final _maintenance = TextEditingController(text: '0');
  final _spoolQuery = TextEditingController();

  CommonSpool? _selectedSpool;
  var _step = 0;
  var _saving = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    final email = FirebaseAuth.instance.currentUser?.email;
    if (email != null) {
      _email.text = email;
    }
  }

  @override
  void dispose() {
    for (final controller in [
      _business,
      _street,
      _postal,
      _city,
      _org,
      _phone,
      _email,
      _electricity,
      _labor,
      _markup,
      _failure,
      _vat,
      _currency,
      _validity,
      _printerQuery,
      _printerName,
      _watts,
      _price,
      _life,
      _maintenance,
      _spoolQuery,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  List<CommonSpool> _matchingSpools() => matchingCommonSpools(_spoolQuery.text);

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

  String? _validate() {
    switch (_step) {
      case 1:
        if (_business.text.trim().isEmpty) {
          return 'Enter the name that should appear on quotes.';
        }
        return null;
      case 2:
        if (parseMinor(_electricity.text) == null) {
          return 'Enter the electricity price. Use 0 if you do not charge for power.';
        }
        return null;
      case 3:
        if (parseMinor(_labor.text) == null) {
          return 'Enter the labor rate. Use 0 if you do not charge for labor.';
        }
        return null;
      case 4:
        if (parseBasisPoints(_markup.text) == null ||
            parseBasisPoints(_failure.text) == null ||
            parseBasisPoints(_vat.text) == null) {
          return 'Markup, failure, and VAT must be numbers.';
        }
        return null;
      case 5:
        final code = _currency.text.trim().toUpperCase();
        if (!RegExp(r'^[A-Z]{3}$').hasMatch(code)) {
          return 'Enter a 3-letter currency code, such as SEK.';
        }
        final days = parsePositiveInt(_validity.text);
        if (days == null || days < 1) {
          return 'Enter how many days a quote stays valid.';
        }
        return null;
      case 6:
        if (_printerName.text.trim().isEmpty) {
          return 'Choose or name the printer you price with.';
        }
        final watts = parsePositiveInt(_watts.text);
        if (watts == null || watts <= 0) {
          return 'Enter the average power in watts.';
        }
        if (parseMinor(_price.text) == null) {
          return 'Enter the purchase price. Use 0 if you do not count machine wear.';
        }
        final life = parseNonNegativeDouble(_life.text);
        if (life == null || life <= 0) {
          return 'Enter the lifetime in hours.';
        }
        if (parseMinor(_maintenance.text) == null) {
          return 'Enter maintenance per hour. Use 0 if you have none.';
        }
        return null;
      default:
        return null;
    }
  }

  void _next() {
    final error = _validate();
    if (error != null) {
      setState(() => _error = error);
      return;
    }
    if (_step == _stepCount - 1) {
      _save(skipped: false);
      return;
    }
    setState(() {
      _error = null;
      _step += 1;
    });
  }

  Future<void> _save({required bool skipped}) async {
    final store = ref.read(userStoreProvider);
    if (store == null || _saving) {
      return;
    }
    setState(() {
      _saving = true;
      _error = null;
    });
    try {
      final existing = ref.read(settingsProvider(store)).asData?.value;
      final nextQuote = existing?.nextQuoteNumber ?? 1;
      final settings = skipped
          ? WorkshopSettings(
              setupCompleted: true,
              nextQuoteNumber: nextQuote,
              email: _email.text.trim(),
            )
          : WorkshopSettings(
              setupCompleted: true,
              currencyCode: _currency.text.trim().toUpperCase(),
              electricityMinorPerKwh: parseMinor(_electricity.text) ?? 0,
              laborMinorPerHour: parseMinor(_labor.text) ?? 0,
              defaultMarkupBasisPoints: parseBasisPoints(_markup.text) ?? 3000,
              vatBasisPoints: parseBasisPoints(_vat.text) ?? 2500,
              defaultFailureBasisPoints: parseBasisPoints(_failure.text) ?? 0,
              businessName: _business.text.trim(),
              street: _street.text.trim(),
              postalCode: _postal.text.trim(),
              city: _city.text.trim(),
              orgNumber: _org.text.trim(),
              phone: _phone.text.trim(),
              email: _email.text.trim(),
              nextQuoteNumber: nextQuote,
              quoteValidityDays: parsePositiveInt(_validity.text) ?? 14,
            );
      await store.saveSettings(settings);
      if (!skipped) {
        await store.savePrinter(
          PrinterProfile(
            id: const Uuid().v4(),
            name: _printerName.text.trim(),
            powerWatts: parsePositiveInt(_watts.text) ?? 0,
            purchasePriceMinor: parseMinor(_price.text) ?? 0,
            lifetimeHours: parseNonNegativeDouble(_life.text) ?? 0,
            maintenanceMinorPerHour: parseMinor(_maintenance.text) ?? 0,
          ),
        );
        final preset = _selectedSpool;
        if (preset != null) {
          await store.saveFilament(
            FilamentSpool(
              id: const Uuid().v4(),
              brand: preset.brand,
              material: preset.material,
              colorHex: preset.colorHex,
              spoolWeightGrams: preset.spoolWeightGrams,
              remainingGrams: preset.spoolWeightGrams,
              pricePerSpoolMinor: preset.pricePerSpoolMinor,
            ),
          );
        }
      }
      ref.read(setupFinishedProvider.notifier).mark();
      if (mounted) {
        context.go('/calculator');
      }
    } catch (error) {
      if (mounted) {
        setState(() {
          _saving = false;
          _error = '$error';
        });
      }
    }
  }

  String get _title {
    return switch (_step) {
      0 => 'Set up your workshop',
      1 => 'Business profile',
      2 => 'Electricity',
      3 => 'Labor',
      4 => 'Markup, failure, and VAT',
      5 => 'Quotes',
      6 => 'Printer',
      7 => 'Filament spool',
      _ => 'Review',
    };
  }

  @override
  Widget build(BuildContext context) {
    final store = ref.watch(userStoreProvider);
    if (store == null) {
      return const Scaffold(
        body: EmptyView(message: 'Sign in to set up your workshop.'),
      );
    }
    final nextQuote =
        ref.watch(settingsProvider(store)).asData?.value.nextQuoteNumber ?? 1;
    return PopScope(
      canPop: false,
      onPopInvokedWithResult: (didPop, _) {
        if (didPop || _saving || _step == 0) {
          return;
        }
        setState(() {
          _error = null;
          _step -= 1;
        });
      },
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(_title),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(4),
            child: LinearProgressIndicator(value: (_step + 1) / _stepCount),
          ),
        ),
        body: Align(
          alignment: Alignment.topCenter,
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 640),
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.all(16),
                    children: [
                      Text(
                        'Step ${_step + 1} of $_stepCount',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                      const SizedBox(height: 12),
                      if (_error != null) ...[
                        Text(
                          _error!,
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.error,
                          ),
                        ),
                        const SizedBox(height: 12),
                      ],
                      ..._stepBody(nextQuote),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Row(
                    children: [
                      if (_step == 0)
                        TextButton(
                          onPressed: _saving ? null : () => _save(skipped: true),
                          child: const Text('Skip for now'),
                        )
                      else
                        TextButton(
                          onPressed: _saving
                              ? null
                              : () => setState(() {
                                  _error = null;
                                  _step -= 1;
                                }),
                          child: const Text('Back'),
                        ),
                      const Spacer(),
                      FilledButton(
                        onPressed: _saving ? null : _next,
                        child: Text(
                          _saving
                              ? 'Saving…'
                              : _step == _stepCount - 1
                              ? 'Save and start'
                              : _step == 0
                              ? 'Start'
                              : 'Next',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _stepBody(int nextQuote) {
    switch (_step) {
      case 0:
        return const [
          Text(
            'Quotes use your printer, your electricity price, and your labor rate. This setup asks for each of those once. You can change every answer later in Settings.',
          ),
          SizedBox(height: 12),
          Text(
            'Skip keeps electricity and labor at zero, with 30% markup and 25% VAT, until you fill them in.',
          ),
        ];
      case 1:
        return [
          const Text('This name and address appear on the quote PDF.'),
          const SizedBox(height: 12),
          TextField(
            controller: _business,
            decoration: const InputDecoration(labelText: 'Business name'),
            textCapitalization: TextCapitalization.words,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _street,
            decoration: const InputDecoration(labelText: 'Street'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _postal,
            decoration: const InputDecoration(labelText: 'Postal code'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _city,
            decoration: const InputDecoration(labelText: 'City'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _org,
            decoration: const InputDecoration(labelText: 'Org. number'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _phone,
            decoration: const InputDecoration(labelText: 'Phone'),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _email,
            decoration: const InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
          ),
        ];
      case 2:
        return [
          const Text(
            'Gramnota multiplies printer watts by the print time and this price. A 100 W printer running for one hour uses 0.1 kWh.',
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _electricity,
            decoration: const InputDecoration(
              labelText: 'Electricity price per kWh',
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ];
      case 3:
        return [
          const Text(
            'Prep and finishing time on each quote is multiplied by this hourly rate.',
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _labor,
            decoration: const InputDecoration(labelText: 'Labor per hour'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ];
      case 4:
        return [
          const Text(
            'Markup is added on top of the full cost. Failure is a percent of material, electricity, and machine wear. VAT is added on the net price. Enter 0 for VAT if you are not registered.',
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _markup,
            decoration: const InputDecoration(labelText: 'Default markup %'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _failure,
            decoration: const InputDecoration(labelText: 'Default failure %'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _vat,
            decoration: const InputDecoration(labelText: 'VAT %'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ];
      case 5:
        return [
          Text(
            'Currency is shown on quotes. A quote stays valid for the number of days below. The next quote number is $nextQuote.',
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _currency,
            decoration: const InputDecoration(labelText: 'Currency'),
            textCapitalization: TextCapitalization.characters,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _validity,
            decoration: const InputDecoration(labelText: 'Quote validity days'),
            keyboardType: TextInputType.number,
          ),
        ];
      case 6:
        final matches = _matchingPrinters();
        final selected =
            matches.any((printer) => printer.name == _printerName.text)
            ? _printerName.text
            : null;
        return [
          const Text(
            'Pick a common machine or type your own. The price should be what you paid. Power is the average while printing, not the power supply rating.',
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _printerQuery,
            decoration: const InputDecoration(labelText: 'Find a printer'),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          if (matches.isEmpty)
            const Text('No printer with that name.')
          else
            DropdownButtonFormField<String>(
              key: ValueKey(_printerQuery.text.trim().toLowerCase()),
              isExpanded: true,
              initialValue: selected,
              decoration: const InputDecoration(labelText: 'Common printer'),
              items: [
                for (final printer in matches)
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
                  _printerName.text = printer.name;
                  _watts.text = printer.powerWatts.toString();
                  _price.text = printer.purchasePriceKronor.toString();
                  _life.text = CommonPrinter.lifetimeHours.round().toString();
                  _maintenance.text = '0';
                  _error = null;
                });
              },
            ),
          TextField(
            controller: _printerName,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _watts,
            decoration: const InputDecoration(labelText: 'Power W'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _price,
            decoration: const InputDecoration(labelText: 'Purchase price'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _life,
            decoration: const InputDecoration(labelText: 'Lifetime hours'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _maintenance,
            decoration: const InputDecoration(
              labelText: 'Maintenance per hour',
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ];
      case 7:
        final spoolMatches = _matchingSpools();
        final selectedLabel = _selectedSpool?.label;
        return [
          const Text(
            'Pick a standard spool for pricing. You can add more spools later from the Filament tab.',
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _spoolQuery,
            decoration: const InputDecoration(labelText: 'Find a spool'),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 8),
          if (spoolMatches.isEmpty)
            const Text('No standard spool with that name.')
          else
            DropdownButtonFormField<String>(
              key: ValueKey(_spoolQuery.text.trim().toLowerCase()),
              isExpanded: true,
              initialValue: spoolMatches.any((item) => item.label == selectedLabel)
                  ? selectedLabel
                  : null,
              decoration: const InputDecoration(labelText: 'Standard spool'),
              items: [
                for (final preset in spoolMatches)
                  DropdownMenuItem(
                    value: preset.label,
                    child: Text(preset.label),
                  ),
              ],
              onChanged: (label) {
                if (label == null) {
                  return;
                }
                setState(() {
                  _selectedSpool = spoolMatches.firstWhere(
                    (item) => item.label == label,
                  );
                  _error = null;
                });
              },
            ),
          if (_selectedSpool != null) ...[
            const SizedBox(height: 8),
            Text(
              _selectedSpool!.pricePerSpoolMinor == 0
                  ? 'You can set the spool price on the Filament tab after setup.'
                  : 'Indicative price ${formatMoney(_selectedSpool!.pricePerSpoolMinor, _currency.text.trim().toUpperCase())}.',
            ),
          ],
        ];
      default:
        final currency = _currency.text.trim().toUpperCase();
        return [
          Text(
            _selectedSpool == null
                ? 'Save these answers, then add a filament spool from the Filament tab before you price a print.'
                : 'Save these answers, then open the calculator to price your first print.',
          ),
          const SizedBox(height: 12),
          _ReviewRow('Business', _business.text.trim()),
          _ReviewRow('Street', _street.text.trim()),
          _ReviewRow(
            'City',
            '${_postal.text.trim()} ${_city.text.trim()}'.trim(),
          ),
          _ReviewRow('Org. number', _org.text.trim()),
          _ReviewRow('Phone', _phone.text.trim()),
          _ReviewRow('Email', _email.text.trim()),
          _ReviewRow(
            'Electricity',
            formatMoney(parseMinor(_electricity.text) ?? 0, currency),
          ),
          _ReviewRow(
            'Labor',
            formatMoney(parseMinor(_labor.text) ?? 0, currency),
          ),
          _ReviewRow(
            'Markup',
            formatPercent(parseBasisPoints(_markup.text) ?? 0),
          ),
          _ReviewRow(
            'Failure',
            formatPercent(parseBasisPoints(_failure.text) ?? 0),
          ),
          _ReviewRow('VAT', formatPercent(parseBasisPoints(_vat.text) ?? 0)),
          _ReviewRow('Currency', currency),
          _ReviewRow('Quote validity', '${_validity.text.trim()} days'),
          _ReviewRow('Next quote', '$nextQuote'),
          _ReviewRow('Printer', _printerName.text.trim()),
          _ReviewRow('Power', '${_watts.text.trim()} W'),
          _ReviewRow(
            'Purchase price',
            formatMoney(parseMinor(_price.text) ?? 0, currency),
          ),
          _ReviewRow('Lifetime', '${_life.text.trim()} h'),
          _ReviewRow(
            'Maintenance',
            formatMoney(parseMinor(_maintenance.text) ?? 0, currency),
          ),
          _ReviewRow('Filament', _selectedSpool?.label ?? ''),
        ];
    }
  }
}

class _ReviewRow extends StatelessWidget {
  const _ReviewRow(this.label, this.value);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    if (value.isEmpty) {
      return const SizedBox.shrink();
    }
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(width: 140, child: Text(label)),
          Expanded(child: Text(value)),
        ],
      ),
    );
  }
}
