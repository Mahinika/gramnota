import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/save_feedback.dart';
import '../../auth/domain/account_deletion.dart';
import '../data/workshop_backup_io.dart';
import '../domain/workshop_backup.dart';

import '../../../core/app_language_controller.dart';
import '../../../core/app_languages.dart';
import '../../../core/app_theme_controller.dart';
import '../../../core/preference_echo.dart';
import '../../../core/theme_mode.dart';
import '../../../core/brand_icon.dart';
import '../../../core/currencies.dart';
import '../../../core/format.dart';
import '../../../core/locale_pickers.dart';
import '../../../core/menu_card.dart';
import '../../../core/section_layout.dart';
import '../../../l10n/l10n.dart';
import '../../customers/domain/customer.dart';
import '../../../core/money.dart';
import '../../../core/providers.dart';
import '../../../core/user_store.dart';
import '../../../core/shell.dart';
import '../../orders/data/orders_providers.dart';
import '../../updates/presentation/update_section.dart';
import '../domain/workshop_settings.dart';

class MoreScreen extends ConsumerWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;
    final displayName = user?.displayName?.trim();
    final email = user?.email;
    final l10n = context.l10n;
    final title = displayName != null && displayName.isNotEmpty
        ? displayName
        : l10n.moreSignedIn;
    final initialsSource = displayName != null && displayName.isNotEmpty
        ? displayName
        : (email?.split('@').first ?? '');
    final initials = initialsSource.isEmpty
        ? '?'
        : Customer(id: '', name: initialsSource).initials;
    final scheme = Theme.of(context).colorScheme;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.navMore)),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        children: [
          TappableListCard(
            child: Row(
              children: [
                CircleAvatar(
                  backgroundColor: scheme.primaryContainer,
                  foregroundColor: scheme.onPrimaryContainer,
                  child: Text(initials),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: theme.textTheme.titleMedium),
                      if (email != null)
                        Text(
                          email,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: scheme.onSurfaceVariant,
                          ),
                        ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          SectionHeading(l10n.moreApp),
          const UpdateSection(),
          const SizedBox(height: 16),
          SectionHeading(l10n.moreWorkshop),
          _MoreDestination(
            label: l10n.moreProducts,
            icon: 'products',
            onTap: () => context.go('/more/products'),
          ),
          TappableListCard.listSeparator,
          _MoreDestination(
            label: l10n.morePrinters,
            icon: 'printer',
            onTap: () => context.go('/more/printers'),
          ),
          TappableListCard.listSeparator,
          _MoreDestination(
            label: l10n.moreSettings,
            icon: 'sliders',
            onTap: () => context.go('/more/settings'),
          ),
          const SizedBox(height: 16),
          SectionHeading(l10n.moreSharing),
          _MoreDestination(
            label: l10n.moreInbox,
            icon: 'inbox',
            onTap: () => context.go('/more/inbox'),
          ),
          TappableListCard.listSeparator,
          TappableListCard(
            onTap: signOut,
            child: Row(
              children: [
                const BrandIconWell(child: Icon(Icons.logout)),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(l10n.moreSignOut, style: theme.textTheme.titleMedium),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MoreDestination extends StatelessWidget {
  const _MoreDestination({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final String icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return TappableListCard(
      onTap: onTap,
      child: Row(
        children: [
          BrandIconWell(
            child: GramnotaSvgIcon(icon, color: scheme.onPrimaryContainer),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(label, style: Theme.of(context).textTheme.titleMedium),
          ),
          Icon(Icons.chevron_right, color: scheme.onSurfaceVariant),
        ],
      ),
    );
  }
}

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  final _electricity = TextEditingController();
  final _labor = TextEditingController();
  final _markup = TextEditingController();
  final _vat = TextEditingController();
  final _failure = TextEditingController();
  final _business = TextEditingController();
  final _street = TextEditingController();
  final _postal = TextEditingController();
  final _city = TextEditingController();
  final _org = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  final _validity = TextEditingController(text: '14');
  final _lowStock = TextEditingController(text: '100');
  var _loaded = false;
  var _setupCompleted = true;
  var _nextQuote = 1;
  var _languageCode = defaultLanguageCode;
  var _currencyCode = defaultCurrencyCode;
  var _themeMode = defaultThemeCode;
  String? _message;

  Future<void> _exportWorkshop(UserStore store) async {
    final l10n = context.l10n;
    try {
      final backup = await store.loadWorkshopBackup();
      await deliverWorkshopBackup(backup.encode());
      if (mounted) {
        setState(() => _message = l10n.settingsExportDone);
      }
    } on Object {
      if (mounted) {
        showSaveError(context, l10n.settingsBackupShareFailed);
        setState(() => _message = l10n.settingsBackupShareFailed);
      }
    }
  }

  Future<void> _importWorkshop(UserStore store) async {
    final l10n = context.l10n;
    final String raw;
    try {
      final picked = await readPickedWorkshopBackup();
      if (picked == null || !mounted) {
        return;
      }
      raw = picked;
    } on Object {
      if (mounted) {
        showSaveError(context, l10n.settingsBackupFailed);
      }
      return;
    }
    final WorkshopBackup backup;
    try {
      backup = WorkshopBackup.decode(raw);
    } on Object {
      if (mounted) {
        showSaveError(context, l10n.settingsBackupFailed);
        setState(() => _message = l10n.settingsBackupFailed);
      }
      return;
    }
    if (!mounted) {
      return;
    }
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(l10n.settingsImportTitle),
        content: Text(l10n.settingsImportBody),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(l10n.actionCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(l10n.settingsImportWorkshop),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) {
      return;
    }
    try {
      final local = await store.loadWorkshopBackup();
      final plan = planWorkshopImport(
        incoming: backup,
        localSettings: local.settings,
        localFilaments: {for (final spool in local.filaments) spool.id: spool},
        localOrders: {for (final order in local.orders) order.id: order},
      );
      await store.applyWorkshopImport(plan);
      if (mounted) {
        setState(() => _message = l10n.settingsImportDone);
      }
    } on Object {
      if (mounted) {
        showSaveError(context, l10n.settingsBackupFailed);
        setState(() => _message = l10n.settingsBackupFailed);
      }
    }
  }

  @override
  void dispose() {
    for (final controller in [
      _electricity,
      _labor,
      _markup,
      _vat,
      _failure,
      _business,
      _street,
      _postal,
      _city,
      _org,
      _phone,
      _email,
      _validity,
      _lowStock,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  Future<void> _commitLanguage(String code) async {
    final next = code.trim().toLowerCase() == systemLanguageCode
        ? systemLanguageCode
        : normalizeLanguageCode(code);
    if (next == _languageCode) {
      return;
    }
    final previous = _languageCode;
    final stamp = preferenceStamp();
    final language = ref.read(appLanguageProvider.notifier);
    language.expectEcho(next, stamp);
    setState(() => _languageCode = next);
    final store = ref.read(userStoreProvider);
    if (store == null) {
      await language.setLanguage(next);
      return;
    }
    try {
      await store.saveLocalePreferences(
        languageCode: next,
        languageUpdatedAt: stamp,
      );
    } on Object {
      language.releaseEcho();
      if (mounted) {
        setState(() => _languageCode = previous);
        showSaveError(context, context.l10n.settingsSaveFailed);
      }
      return;
    }
    await language.setLanguage(next);
  }

  Future<void> _commitTheme(String code) async {
    final next = normalizeThemeMode(code);
    if (next == _themeMode) {
      return;
    }
    final previous = _themeMode;
    final stamp = preferenceStamp();
    final theme = ref.read(appThemeProvider.notifier);
    theme.expectEcho(next, stamp);
    setState(() => _themeMode = next);
    final store = ref.read(userStoreProvider);
    if (store == null) {
      await theme.setTheme(next);
      return;
    }
    try {
      await store.saveLocalePreferences(
        themeMode: next,
        themeUpdatedAt: stamp,
      );
    } on Object {
      theme.releaseEcho();
      if (mounted) {
        setState(() => _themeMode = previous);
        showSaveError(context, context.l10n.settingsSaveFailed);
      }
      return;
    }
    await theme.setTheme(next);
  }

  Future<void> _commitCurrency(String code) async {
    final next = normalizeCurrencyCode(code);
    if (next == _currencyCode) {
      return;
    }
    final previous = _currencyCode;
    final stamp = preferenceStamp();
    setState(() => _currencyCode = next);
    final store = ref.read(userStoreProvider);
    if (store == null) {
      return;
    }
    store.expectCurrencyEcho(next, stamp);
    try {
      await store.saveLocalePreferences(
        currencyCode: next,
        currencyUpdatedAt: stamp,
      );
    } on Object {
      store.releaseCurrencyEcho();
      if (mounted) {
        setState(() => _currencyCode = previous);
        showSaveError(context, context.l10n.settingsSaveFailed);
      }
    }
  }

  void _load(WorkshopSettings settings) {
    _nextQuote = settings.nextQuoteNumber;
    if (_loaded) {
      return;
    }
    _languageCode = settings.languageCode;
    _currencyCode = normalizeCurrencyCode(settings.currencyCode);
    _themeMode = normalizeThemeMode(settings.themeMode);
    final locale = context.formattingLocale;
    _electricity.text = formatMinorField(
      settings.electricityMinorPerKwh,
      locale: locale,
    );
    _labor.text = formatMinorField(settings.laborMinorPerHour, locale: locale);
    _markup.text = basisPointsLabel(
      settings.defaultMarkupBasisPoints,
      locale: locale,
    );
    _vat.text = basisPointsLabel(settings.vatBasisPoints, locale: locale);
    _failure.text = basisPointsLabel(
      settings.defaultFailureBasisPoints,
      locale: locale,
    );
    _business.text = settings.businessName;
    _street.text = settings.street;
    _postal.text = settings.postalCode;
    _city.text = settings.city;
    _org.text = settings.orgNumber;
    _phone.text = settings.phone;
    _email.text = settings.email;
    _validity.text = settings.quoteValidityDays.toString();
    final low = settings.defaultLowStockGrams;
    _lowStock.text = low == low.roundToDouble()
        ? low.round().toString()
        : low.toString();
    _setupCompleted = settings.setupCompleted;
    _loaded = true;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final store = ref.watch(userStoreProvider);
    if (store == null) {
      return Scaffold(body: EmptyView(message: l10n.settingsSignIn));
    }
    final settings = ref.watch(settingsProvider(store));
    final current = settings.asData?.value;
    if (current != null) {
      _load(current);
    }
    return Scaffold(
      appBar: AppBar(title: Text(l10n.moreSettings)),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SectionHeading(l10n.moreApp),
          const UpdateSection(),
          const SizedBox(height: 16),
          if (_message != null) Text(_message!),
          LanguageMenu(
            languageCode: _languageCode,
            onChanged: _commitLanguage,
          ),
          const SizedBox(height: 12),
          ThemeMenu(
            themeMode: _themeMode,
            onChanged: _commitTheme,
          ),
          const SizedBox(height: 12),
          CurrencyField(
            currencyCode: _currencyCode,
            onChanged: _commitCurrency,
          ),
          const SizedBox(height: 8),
          Text(
            l10n.currencyChangedHint,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _electricity,
            decoration: InputDecoration(labelText: l10n.settingsElectricity),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _labor,
            decoration: InputDecoration(labelText: l10n.settingsLabor),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _markup,
            decoration: InputDecoration(labelText: l10n.settingsMarkup),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _vat,
            decoration: InputDecoration(labelText: l10n.settingsVatOptional),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 8),
          Text(
            l10n.settingsVatHint,
            style: Theme.of(context).textTheme.bodySmall,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _failure,
            decoration: InputDecoration(labelText: l10n.settingsFailure),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _validity,
            decoration: InputDecoration(labelText: l10n.settingsValidityDays),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _lowStock,
            decoration: InputDecoration(
              labelText: l10n.settingsLowStock,
              helperText: l10n.settingsLowStockHelp,
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 16),
          Text(
            l10n.settingsBusinessProfile,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _business,
            decoration: InputDecoration(labelText: l10n.fieldName),
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
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _email,
            decoration: InputDecoration(labelText: l10n.fieldEmail),
          ),
          Text(l10n.settingsNextQuote(_nextQuote)),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: () async {
              final markup = parseBasisPoints(_markup.text);
              final vat = parseBasisPoints(_vat.text);
              final failure = parseBasisPoints(_failure.text);
              final locale = context.formattingLocale;
              final currency = normalizeCurrencyCode(_currencyCode);
              final electricity = parseMoneyInput(
                _electricity.text,
                currencyCode: currency,
                locale: locale,
              );
              final labor = parseMoneyInput(
                _labor.text,
                currencyCode: currency,
                locale: locale,
              );
              final validity = parsePositiveInt(_validity.text);
              final lowStock = parseNonNegativeDouble(_lowStock.text);
              if (electricity == null) {
                setState(() => _message = l10n.settingsElectricityRequired);
                return;
              }
              if (labor == null) {
                setState(() => _message = l10n.settingsLaborRequired);
                return;
              }
              if (markup == null || vat == null || failure == null) {
                setState(() => _message = l10n.settingsPercentsRequired);
                return;
              }
              if (validity == null || validity < 1) {
                setState(() => _message = l10n.settingsValidityRequired);
                return;
              }
              if (lowStock == null) {
                setState(() => _message = l10n.settingsLowStockRequired);
                return;
              }
              final stamp = preferenceStamp();
              final language = ref.read(appLanguageProvider.notifier);
              final theme = ref.read(appThemeProvider.notifier);
              language.expectEcho(_languageCode, stamp);
              theme.expectEcho(_themeMode, stamp);
              store.expectCurrencyEcho(currency, stamp);
              try {
                await store.saveSettings(
                  WorkshopSettings(
                    setupCompleted: _setupCompleted,
                    languageCode: _languageCode,
                    currencyCode: currency,
                    themeMode: normalizeThemeMode(_themeMode),
                    electricityMinorPerKwh: electricity,
                    laborMinorPerHour: labor,
                    defaultMarkupBasisPoints: markup,
                    vatBasisPoints: vat,
                    defaultFailureBasisPoints: failure,
                    businessName: _business.text.trim(),
                    street: _street.text.trim(),
                    postalCode: _postal.text.trim(),
                    city: _city.text.trim(),
                    orgNumber: _org.text.trim(),
                    phone: _phone.text.trim(),
                    email: _email.text.trim(),
                    nextQuoteNumber: _nextQuote,
                    quoteValidityDays: validity,
                    defaultLowStockGrams: lowStock,
                    languageUpdatedAt: stamp,
                    themeUpdatedAt: stamp,
                    currencyUpdatedAt: stamp,
                  ),
                );
              } on Object {
                language.releaseEcho();
                theme.releaseEcho();
                store.releaseCurrencyEcho();
                if (context.mounted) {
                  showSaveError(context, l10n.settingsSaveFailed);
                  setState(() => _message = l10n.settingsSaveFailed);
                }
                return;
              }
              await language.setLanguage(_languageCode);
              await theme.setTheme(_themeMode);
              if (mounted) {
                setState(() => _message = l10n.settingsSaved);
              }
            },
            child: Text(l10n.actionSave),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () => _exportWorkshop(store),
            child: Text(l10n.settingsExportWorkshop),
          ),
          const SizedBox(height: 12),
          OutlinedButton(
            onPressed: () => _importWorkshop(store),
            child: Text(l10n.settingsImportWorkshop),
          ),
          const SizedBox(height: 24),
          OutlinedButton(
            onPressed: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: Text(l10n.settingsDeleteAccount),
                  content: Text(l10n.settingsDeleteAccountBody),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: Text(l10n.actionCancel),
                    ),
                    FilledButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: Text(l10n.actionDelete),
                    ),
                  ],
                ),
              );
              if (confirmed != true) {
                return;
              }
              final user = FirebaseAuth.instance.currentUser;
              if (user == null) {
                return;
              }
              try {
                await AccountDeletion(
                  reauthenticate: () => reauthenticateCurrentUser(
                    darkPage: Theme.of(context).brightness == Brightness.dark,
                  ),
                  deleteOwnedData: () =>
                      store.deleteOwnedData(email: user.email),
                  deleteUser: user.delete,
                ).run();
              } on FirebaseAuthException catch (error) {
                if (!context.mounted) {
                  return;
                }
                final message = error.code == 'requires-recent-login'
                    ? l10n.settingsRecentLogin
                    : (error.message ?? l10n.settingsDeleteFailed);
                showSaveError(context, message);
                setState(() => _message = message);
              } on Object {
                if (!context.mounted) {
                  return;
                }
                showSaveError(context, l10n.settingsDeleteFailed);
                setState(() => _message = l10n.settingsDeleteFailed);
              }
            },
            child: Text(l10n.settingsDeleteAccount),
          ),
        ],
      ),
    );
  }
}
