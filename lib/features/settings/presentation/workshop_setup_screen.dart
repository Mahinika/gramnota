import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';

import '../../../core/app_language_controller.dart';
import '../../../core/app_languages.dart';
import '../../../core/app_theme_controller.dart';
import '../../../core/theme_mode.dart';
import '../../../core/currencies.dart';
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
import '../domain/workshop_defaults.dart';

/// Printer, standard spool, then electricity. Profile and rates live in Settings.
const workshopSetupStepCount = 3;

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

/// Email of the signed-in account, or null when Firebase is not running.
String? currentAccountEmail() {
  try {
    if (Firebase.apps.isEmpty) {
      return null;
    }
    return FirebaseAuth.instance.currentUser?.email;
  } on Object {
    return null;
  }
}

class WorkshopSetupScreen extends ConsumerStatefulWidget {
  const WorkshopSetupScreen({super.key});

  @override
  ConsumerState<WorkshopSetupScreen> createState() =>
      _WorkshopSetupScreenState();
}

class _WorkshopSetupScreenState extends ConsumerState<WorkshopSetupScreen> {
  final _electricity = TextEditingController();
  final _printerQuery = TextEditingController();
  final _printerName = TextEditingController();
  final _watts = TextEditingController();
  final _price = TextEditingController();
  final _life = TextEditingController(text: '5000');
  final _maintenance = TextEditingController(text: '0');
  final _spoolQuery = TextEditingController();

  CommonSpool? _selectedSpool;
  var _currencyCode = defaultCurrencyCode;
  var _languageCode = firstRunFallbackLanguageCode;
  String? _appliedLanguage;
  final _themeMode = defaultThemeCode;
  var _step = 0;
  var _saving = false;
  String? _error;
  var _email = '';

  @override
  void initState() {
    super.initState();
    _email = currentAccountEmail()?.trim() ?? '';
    _applyLanguage(null);
  }

  @override
  void dispose() {
    for (final controller in [
      _electricity,
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

  void _applyLanguage(String? languageCode) {
    final locale = WidgetsBinding.instance.platformDispatcher.locale;
    final raw = languageCode ?? languageForDeviceLocale(locale);
    final resolved = raw == systemLanguageCode
        ? languageForDeviceLocale(locale)
        : normalizeLanguageCode(raw);
    _appliedLanguage = languageCode ?? resolved;
    _languageCode = resolved;
    _currencyCode = currencyForLanguage(
      languageCode: resolved,
      regionCode: locale.countryCode,
    );
  }

  int? _money(String text) {
    return parseMoneyInput(
      text,
      currencyCode: _currencyCode,
      locale: context.formattingLocale,
    );
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
      case 0:
        if (_printerName.text.trim().isEmpty) {
          return context.l10n.setupPrinterRequired;
        }
        final watts = parsePositiveInt(_watts.text);
        if (watts == null || watts <= 0) {
          return context.l10n.setupWattsRequired;
        }
        if (_money(_price.text) == null) {
          return context.l10n.setupPriceRequired;
        }
        final life = parseNonNegativeDouble(_life.text);
        if (life == null) {
          return context.l10n.setupLifeRequired;
        }
        if (_money(_maintenance.text) == null) {
          return context.l10n.setupMaintenanceRequired;
        }
        return null;
      case 2:
        if (_money(_electricity.text) == null) {
          return context.l10n.settingsElectricityRequired;
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
    if (_step == workshopSetupStepCount - 1) {
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
      final settings = newWorkshopSettings(
        languageCode: _languageCode,
        currencyCode: _currencyCode,
        nextQuoteNumber: nextQuote,
        email: _email,
        electricityMinorPerKwh: skipped ? 0 : (_money(_electricity.text) ?? 0),
        themeMode: _themeMode,
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
            purchasePriceMinor: _money(_price.text) ?? 0,
            lifetimeHours: parseNonNegativeDouble(_life.text) ?? 0,
            maintenanceMinorPerHour: _money(_maintenance.text) ?? 0,
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
      0 => l10n.setupPrinterTitle,
      1 => l10n.setupSpoolTitle,
      _ => l10n.setupElectricityTitle,
    };
  }

  @override
  Widget build(BuildContext context) {
    final store = ref.watch(userStoreProvider);
    final l10n = context.l10n;
    final watchedLanguage = ref.watch(appLanguageProvider).asData?.value;
    if (watchedLanguage != _appliedLanguage && watchedLanguage != null) {
      _applyLanguage(watchedLanguage);
    }
    if (store == null) {
      return Scaffold(body: EmptyView(message: l10n.setupSignIn));
    }
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
            child: LinearProgressIndicator(
              value: (_step + 1) / workshopSetupStepCount,
            ),
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
                        l10n.setupStep(_step + 1, workshopSetupStepCount),
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
                      ..._stepBody(),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                  child: Row(
                    children: [
                      if (_step == 0)
                        TextButton(
                          onPressed: _saving
                              ? null
                              : () => _save(skipped: true),
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
                              : _step == workshopSetupStepCount - 1
                              ? l10n.setupSaveStart
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

  List<Widget> _stepBody() {
    final l10n = context.l10n;
    switch (_step) {
      case 0:
        final matches = _matchingPrinters();
        final selected =
            matches.any((printer) => printer.name == _printerName.text)
            ? _printerName.text
            : null;
        return [
          Text(l10n.setupIntro),
          const SizedBox(height: 8),
          Text(l10n.setupSkipHint),
          const SizedBox(height: 12),
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
      case 1:
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
        return [
          Text(l10n.setupElectricityHint),
          const SizedBox(height: 12),
          TextField(
            controller: _electricity,
            decoration: InputDecoration(labelText: l10n.settingsElectricity),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
        ];
    }
  }
}
