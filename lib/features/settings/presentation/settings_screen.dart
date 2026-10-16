import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/menu_card.dart';
import '../../../core/money.dart';
import '../../../core/providers.dart';
import '../../../core/shell.dart';
import '../../orders/presentation/orders_screen.dart';
import '../domain/workshop_settings.dart';

class MoreScreen extends ConsumerWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;
    final displayName = user?.displayName?.trim();
    final title = displayName != null && displayName.isNotEmpty
        ? displayName
        : 'Signed in';
    final email = user?.email;
    final scheme = Theme.of(context).colorScheme;
    return Scaffold(
      appBar: AppBar(title: const Text('More')),
      body: ListView(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
        children: [
          ListTile(
            contentPadding: EdgeInsets.zero,
            title: Text(title, style: Theme.of(context).textTheme.titleMedium),
            subtitle: email == null ? null : Text(email),
          ),
          const SizedBox(height: 8),
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              'Workshop',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          MenuCard(
            onTap: () => context.go('/more/printers'),
            child: Row(
              children: [
                Icon(Icons.print_outlined, color: scheme.onSurfaceVariant),
                const SizedBox(width: 16),
                const Expanded(child: Text('Printers')),
                Icon(Icons.chevron_right, color: scheme.onSurfaceVariant),
              ],
            ),
          ),
          MenuCard.listSeparator,
          MenuCard(
            onTap: () => context.go('/more/settings'),
            child: Row(
              children: [
                Icon(Icons.tune, color: scheme.onSurfaceVariant),
                const SizedBox(width: 16),
                const Expanded(child: Text('Settings')),
                Icon(Icons.chevron_right, color: scheme.onSurfaceVariant),
              ],
            ),
          ),
          const SizedBox(height: 16),
          Padding(
            padding: const EdgeInsets.only(bottom: 4),
            child: Text(
              'Sharing',
              style: Theme.of(context).textTheme.labelLarge,
            ),
          ),
          MenuCard(
            onTap: () => context.go('/more/inbox'),
            child: Row(
              children: [
                Icon(Icons.inbox_outlined, color: scheme.onSurfaceVariant),
                const SizedBox(width: 16),
                const Expanded(child: Text('Inbox')),
                Icon(Icons.chevron_right, color: scheme.onSurfaceVariant),
              ],
            ),
          ),
          const Divider(height: 1),
          ListTile(
            contentPadding: EdgeInsets.zero,
            leading: const Icon(Icons.logout),
            title: const Text('Sign out'),
            onTap: signOut,
          ),
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
  final _currency = TextEditingController(text: 'SEK');
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
  var _loaded = false;
  var _setupCompleted = true;
  var _nextQuote = 1;
  String? _message;

  @override
  void dispose() {
    for (final controller in [
      _currency,
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
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  void _load(WorkshopSettings settings) {
    if (_loaded) {
      return;
    }
    _currency.text = settings.currencyCode;
    _electricity.text = (settings.electricityMinorPerKwh / 100).toString();
    _labor.text = (settings.laborMinorPerHour / 100).toString();
    _markup.text = basisPointsLabel(settings.defaultMarkupBasisPoints);
    _vat.text = basisPointsLabel(settings.vatBasisPoints);
    _failure.text = basisPointsLabel(settings.defaultFailureBasisPoints);
    _business.text = settings.businessName;
    _street.text = settings.street;
    _postal.text = settings.postalCode;
    _city.text = settings.city;
    _org.text = settings.orgNumber;
    _phone.text = settings.phone;
    _email.text = settings.email;
    _validity.text = settings.quoteValidityDays.toString();
    _nextQuote = settings.nextQuoteNumber;
    _setupCompleted = settings.setupCompleted;
    _loaded = true;
  }

  @override
  Widget build(BuildContext context) {
    final store = ref.watch(userStoreProvider);
    if (store == null) {
      return const Scaffold(
        body: EmptyView(message: 'Sign in to edit settings.'),
      );
    }
    final settings = ref.watch(settingsProvider(store));
    final current = settings.asData?.value;
    if (current != null) {
      _load(current);
    }
    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (_message != null) Text(_message!),
          TextField(
            controller: _currency,
            decoration: const InputDecoration(labelText: 'Currency'),
          ),
          TextField(
            controller: _electricity,
            decoration: const InputDecoration(
              labelText: 'Electricity price per kWh',
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          TextField(
            controller: _labor,
            decoration: const InputDecoration(labelText: 'Labor per hour'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          TextField(
            controller: _markup,
            decoration: const InputDecoration(labelText: 'Default markup %'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          TextField(
            controller: _vat,
            decoration: const InputDecoration(
              labelText: 'VAT % (0 if not registered)',
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          TextField(
            controller: _failure,
            decoration: const InputDecoration(labelText: 'Default failure %'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          TextField(
            controller: _validity,
            decoration: const InputDecoration(labelText: 'Quote validity days'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          Text(
            'Business profile',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          TextField(
            controller: _business,
            decoration: const InputDecoration(labelText: 'Name'),
          ),
          TextField(
            controller: _street,
            decoration: const InputDecoration(labelText: 'Street'),
          ),
          TextField(
            controller: _postal,
            decoration: const InputDecoration(labelText: 'Postal code'),
          ),
          TextField(
            controller: _city,
            decoration: const InputDecoration(labelText: 'City'),
          ),
          TextField(
            controller: _org,
            decoration: const InputDecoration(labelText: 'Org. number'),
          ),
          TextField(
            controller: _phone,
            decoration: const InputDecoration(labelText: 'Phone'),
          ),
          TextField(
            controller: _email,
            decoration: const InputDecoration(labelText: 'Email'),
          ),
          Text('Next quote number $_nextQuote'),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: () async {
              final markup = parseBasisPoints(_markup.text);
              final vat = parseBasisPoints(_vat.text);
              final failure = parseBasisPoints(_failure.text);
              if (markup == null || vat == null || failure == null) {
                setState(
                  () => _message = 'Markup, VAT, and failure must be numbers.',
                );
                return;
              }
              await store.saveSettings(
                WorkshopSettings(
                  setupCompleted: _setupCompleted,
                  currencyCode: _currency.text.trim().isEmpty
                      ? 'SEK'
                      : _currency.text.trim().toUpperCase(),
                  electricityMinorPerKwh: parseMinor(_electricity.text) ?? 0,
                  laborMinorPerHour: parseMinor(_labor.text) ?? 0,
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
                  quoteValidityDays: parsePositiveInt(_validity.text) ?? 14,
                ),
              );
              setState(() => _message = 'Settings saved.');
            },
            child: const Text('Save'),
          ),
          const SizedBox(height: 24),
          OutlinedButton(
            onPressed: () async {
              final confirmed = await showDialog<bool>(
                context: context,
                builder: (context) => AlertDialog(
                  title: const Text('Delete account'),
                  content: const Text(
                    'This deletes your workshop data and Google sign-in for Gramnota.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(context, false),
                      child: const Text('Cancel'),
                    ),
                    FilledButton(
                      onPressed: () => Navigator.pop(context, true),
                      child: const Text('Delete'),
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
                await store.deleteOwnedData(email: user.email);
                await user.delete();
              } on FirebaseAuthException catch (error) {
                if (error.code == 'requires-recent-login') {
                  setState(
                    () => _message =
                        'Sign in again, then delete the account. Google asked for a fresh login.',
                  );
                  return;
                }
                setState(() => _message = error.message ?? error.code);
              }
            },
            child: const Text('Delete account'),
          ),
        ],
      ),
    );
  }
}
