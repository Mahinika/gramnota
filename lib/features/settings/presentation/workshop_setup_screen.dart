import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../core/app_language_controller.dart';
import '../../../core/app_languages.dart';
import '../../../core/app_theme_controller.dart';
import '../../../core/theme_mode.dart';
import '../../../core/currencies.dart';
import '../../../core/locale_pickers.dart';
import '../../../core/money.dart';
import '../../../core/gate_scaffold.dart';
import '../../../core/providers.dart';
import '../../../core/shell.dart';
import '../../../l10n/l10n.dart';
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
  final _validity = TextEditingController(text: '14');
  final _printerQuery = TextEditingController();
  final _printerName = TextEditingController();
  final _watts = TextEditingController();
  final _price = TextEditingController();
  final _life = TextEditingController(text: '5000');
  final _maintenance = TextEditingController(text: '0');
  final _spoolQuery = TextEditingController();

  CommonSpool? _selectedSpool;
  var _currencyCode = defaultCurrencyCode;
  var _languageCode = defaultLanguageCode;
  var _themeMode = defaultThemeCode;
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
          return context.l10n.setupNameRequired;
        }
        return null;
      case 2:
        if (parseMinor(_electricity.text) == null) {
          return context.l10n.settingsElectricityRequired;
        }
        return null;
      case 3:
        if (parseMinor(_labor.text) == null) {
          return context.l10n.settingsLaborRequired;
        }
        return null;
      case 4:
        if (parseBasisPoints(_markup.text) == null ||
            parseBasisPoints(_failure.text) == null ||
            parseBasisPoints(_vat.text) == null) {
          return context.l10n.setupRatesRequired;
        }
        return null;
      case 5:
        final days = parsePositiveInt(_validity.text);
        if (days == null || days < 1) {
          return context.l10n.settingsValidityRequired;
        }
        return null;
      case 6:
        if (_printerName.text.trim().isEmpty) {
          return context.l10n.setupPrinterRequired;
        }
        final watts = parsePositiveInt(_watts.text);
        if (watts == null || watts <= 0) {
          return context.l10n.setupWattsRequired;
        }
        if (parseMinor(_price.text) == null) {
          return context.l10n.setupPriceRequired;
        }
        final life = parseNonNegativeDouble(_life.text);
        if (life == null) {
          return context.l10n.setupLifeRequired;
        }
        if (parseMinor(_maintenance.text) == null) {
          return context.l10n.setupMaintenanceRequired;
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
              languageCode: _languageCode,
              currencyCode: _currencyCode,
              themeMode: normalizeThemeMode(_themeMode),
              nextQuoteNumber: nextQuote,
              email: _email.text.trim(),
            )
          : WorkshopSettings(
              setupCompleted: true,
              languageCode: _languageCode,
              currencyCode: normalizeCurrencyCode(_currencyCode),
              themeMode: normalizeThemeMode(_themeMode),
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
      await ref.read(appLanguageProvider.notifier).setLanguage(_languageCode);
      await ref.read(appThemeProvider.notifier).setTheme(_themeMode);
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
              lowStockUsesDefault: true,
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

  String _title(AppLocalizations l10n) {
    return switch (_step) {
      0 => l10n.setupTitle,
      1 => l10n.settingsBusinessProfile,
      2 => l10n.setupElectricityTitle,
      3 => l10n.setupLaborTitle,
      4 => l10n.setupRatesTitle,
      5 => l10n.setupQuotesTitle,
      6 => l10n.setupPrinterTitle,
      7 => l10n.setupSpoolTitle,
      _ => l10n.setupReviewTitle,
    };
  }

  @override
  Widget build(BuildContext context) {
    final store = ref.watch(userStoreProvider);
    final l10n = context.l10n;
    if (store == null) {
      return Scaffold(body: EmptyView(message: l10n.setupSignIn));
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
          title: Text(_title(l10n)),
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
                        l10n.setupStep(_step + 1, _stepCount),
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
                          child: Text(l10n.setupSkip),
                        )
                      else
                        TextButton(
                          onPressed: _saving
                              ? null
                              : () => setState(() {
                                  _error = null;
                                  _step -= 1;
                                }),
                          child: Text(l10n.setupBack),
                        ),
                      const Spacer(),
                      FilledButton(
                        onPressed: _saving ? null : _next,
                        child: Text(
                          _saving
                              ? l10n.saving
                              : _step == _stepCount - 1
                              ? l10n.setupSaveStart
                              : _step == 0
                              ? l10n.setupStart
                              : l10n.setupNext,
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
    final l10n = context.l10n;
    switch (_step) {
      case 0:
        return [
          Text(l10n.setupIntro),
          const SizedBox(height: 12),
          Text(l10n.setupSkipHint),
        ];
      case 1:
        return [
          Text(l10n.setupProfileHint),
          const SizedBox(height: 12),
          TextField(
            controller: _business,
            decoration: InputDecoration(labelText: l10n.setupBusinessName),
            textCapitalization: TextCapitalization.words,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _street,
            decoration: InputDecoration(labelText: l10n.fieldStreet),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _postal,
            decoration: InputDecoration(labelText: l10n.fieldPostalCode),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _city,
            decoration: InputDecoration(labelText: l10n.fieldCity),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _org,
            decoration: InputDecoration(labelText: l10n.fieldOrgNumber),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _phone,
            decoration: InputDecoration(labelText: l10n.fieldPhone),
            keyboardType: TextInputType.phone,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _email,
            decoration: InputDecoration(labelText: l10n.fieldEmail),
            keyboardType: TextInputType.emailAddress,
          ),
        ];
      case 2:
        return [
          Text(l10n.setupElectricityHint),
          const SizedBox(height: 12),
          TextField(
            controller: _electricity,
            decoration: InputDecoration(labelText: l10n.settingsElectricity),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ];
      case 3:
        return [
          Text(l10n.setupLaborHint),
          const SizedBox(height: 12),
          TextField(
            controller: _labor,
            decoration: InputDecoration(labelText: l10n.settingsLabor),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ];
      case 4:
        return [
          Text(l10n.setupRatesHint),
          const SizedBox(height: 12),
          TextField(
            controller: _markup,
            decoration: InputDecoration(labelText: l10n.settingsMarkup),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _failure,
            decoration: InputDecoration(labelText: l10n.settingsFailure),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _vat,
            decoration: InputDecoration(labelText: l10n.setupVat),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ];
      case 5:
        return [
          Text(l10n.setupQuotesHint(nextQuote)),
          const SizedBox(height: 12),
          LanguageMenu(
            languageCode: _languageCode,
            onChanged: (code) => setState(() => _languageCode = code),
          ),
          const SizedBox(height: 12),
          ThemeMenu(
            themeMode: _themeMode,
            onChanged: (code) => setState(() => _themeMode = code),
          ),
          const SizedBox(height: 12),
          CurrencyField(
            currencyCode: _currencyCode,
            onChanged: (code) => setState(() => _currencyCode = code),
          ),
          const SizedBox(height: 8),
          Text(l10n.currencyChangedHint),
          const SizedBox(height: 12),
          TextField(
            controller: _validity,
            decoration: InputDecoration(labelText: l10n.settingsValidityDays),
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
          Text(l10n.setupPrinterHint),
          const SizedBox(height: 12),
          TextField(
            controller: _printerQuery,
            decoration: InputDecoration(labelText: l10n.setupFindPrinter),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          if (matches.isEmpty)
            Text(l10n.setupNoPrinterMatch)
          else
            DropdownButtonFormField<String>(
              key: ValueKey(_printerQuery.text.trim().toLowerCase()),
              isExpanded: true,
              initialValue: selected,
              decoration: InputDecoration(labelText: l10n.setupCommonPrinter),
              items: [
                for (final printer in matches)
                  DropdownMenuItem(
                    value: printer.name,
                    child: Text(
                      l10n.setupPrinterWatts(printer.name, printer.powerWatts),
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
            decoration: InputDecoration(labelText: l10n.fieldName),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _watts,
            decoration: InputDecoration(labelText: l10n.setupPower),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _price,
            decoration: InputDecoration(labelText: l10n.setupPurchasePrice),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _life,
            decoration: InputDecoration(
              labelText: l10n.setupLifetime,
              helperText: l10n.setupLifetimeHelp,
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _maintenance,
            decoration: InputDecoration(labelText: l10n.setupMaintenance),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ];
      case 7:
        final spoolMatches = _matchingSpools();
        final selectedLabel = _selectedSpool?.label;
        return [
          Text(l10n.setupSpoolHint),
          const SizedBox(height: 12),
          TextField(
            controller: _spoolQuery,
            decoration: InputDecoration(labelText: l10n.setupFindSpool),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 8),
          if (spoolMatches.isEmpty)
            Text(l10n.setupNoSpoolMatch)
          else
            DropdownButtonFormField<String>(
              key: ValueKey(_spoolQuery.text.trim().toLowerCase()),
              isExpanded: true,
              initialValue: spoolMatches.any((item) => item.label == selectedLabel)
                  ? selectedLabel
                  : null,
              decoration: InputDecoration(labelText: l10n.setupStandardSpool),
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
                  ? l10n.setupSpoolPriceLater
                  : l10n.setupSpoolPrice(
                      context.money(
                        _selectedSpool!.pricePerSpoolMinor,
                        _currencyCode,
                      ),
                    ),
            ),
          ],
        ];
      default:
        final currency = normalizeCurrencyCode(_currencyCode);
        return [
          Text(
            _selectedSpool == null
                ? l10n.setupReviewNeedSpool
                : l10n.setupReviewReady,
          ),
          const SizedBox(height: 12),
          _ReviewRow(l10n.setupBusiness, _business.text.trim()),
          _ReviewRow(l10n.fieldStreet, _street.text.trim()),
          _ReviewRow(
            l10n.fieldCity,
            '${_postal.text.trim()} ${_city.text.trim()}'.trim(),
          ),
          _ReviewRow(l10n.fieldOrgNumber, _org.text.trim()),
          _ReviewRow(l10n.fieldPhone, _phone.text.trim()),
          _ReviewRow(l10n.fieldEmail, _email.text.trim()),
          _ReviewRow(
            l10n.setupElectricity,
            context.money(parseMinor(_electricity.text) ?? 0, currency),
          ),
          _ReviewRow(
            l10n.setupLabor,
            context.money(parseMinor(_labor.text) ?? 0, currency),
          ),
          _ReviewRow(
            l10n.setupMarkup,
            context.percentText(parseBasisPoints(_markup.text) ?? 0),
          ),
          _ReviewRow(
            l10n.setupFailure,
            context.percentText(parseBasisPoints(_failure.text) ?? 0),
          ),
          _ReviewRow(
            l10n.setupVatShort,
            context.percentText(parseBasisPoints(_vat.text) ?? 0),
          ),
          _ReviewRow(l10n.currencyLabel, currency),
          _ReviewRow(
            l10n.settingsValidityDays,
            l10n.setupValidityValue(_validity.text.trim()),
          ),
          _ReviewRow(l10n.setupNextQuote, '$nextQuote'),
          _ReviewRow(l10n.setupPrinterTitle, _printerName.text.trim()),
          _ReviewRow(l10n.setupPower, l10n.setupPowerValue(_watts.text.trim())),
          _ReviewRow(
            l10n.setupPurchasePrice,
            context.money(parseMinor(_price.text) ?? 0, currency),
          ),
          _ReviewRow(
            l10n.setupLifetime,
            l10n.setupLifetimeValue(_life.text.trim()),
          ),
          _ReviewRow(
            l10n.setupMaintenance,
            context.money(parseMinor(_maintenance.text) ?? 0, currency),
          ),
          _ReviewRow(l10n.navFilament, _selectedSpool?.label ?? ''),
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
          Expanded(
            flex: 2,
            child: Text(label, maxLines: 3, overflow: TextOverflow.ellipsis),
          ),
          const SizedBox(width: 8),
          Expanded(flex: 3, child: Text(value)),
        ],
      ),
    );
  }
}
