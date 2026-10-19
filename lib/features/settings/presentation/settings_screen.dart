import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../core/brand_icon.dart';
import '../../../core/format.dart';
import '../../../core/menu_card.dart';
import '../../../core/section_layout.dart';
import '../../customers/domain/customer.dart';
import '../../../core/money.dart';
import '../../../core/providers.dart';
import '../../../core/shell.dart';
import '../../orders/data/orders_providers.dart';
import '../domain/workshop_settings.dart';

class MoreScreen extends ConsumerWidget {
  const MoreScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = FirebaseAuth.instance.currentUser;
    final displayName = user?.displayName?.trim();
    final email = user?.email;
    final title = displayName != null && displayName.isNotEmpty
        ? displayName
        : 'Signed in';
    final initialsSource = displayName != null && displayName.isNotEmpty
        ? displayName
        : (email?.split('@').first ?? '');
    final initials = initialsSource.isEmpty
        ? '?'
        : Customer(id: '', name: initialsSource).initials;
    final scheme = Theme.of(context).colorScheme;
    final theme = Theme.of(context);
    return Scaffold(
      appBar: AppBar(title: const Text('More')),
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
          const SectionHeading('Workshop'),
          _MoreDestination(
            label: 'Products',
            icon: 'products',
            onTap: () => context.go('/more/products'),
          ),
          TappableListCard.listSeparator,
          _MoreDestination(
            label: 'Printers',
            icon: 'printer',
            onTap: () => context.go('/more/printers'),
          ),
          TappableListCard.listSeparator,
          _MoreDestination(
            label: 'Settings',
            icon: 'sliders',
            onTap: () => context.go('/more/settings'),
          ),
          const SizedBox(height: 16),
          const SectionHeading('Sharing'),
          _MoreDestination(
            label: 'Inbox',
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
                  child: Text('Sign out', style: theme.textTheme.titleMedium),
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
  final _lowStock = TextEditingController(text: '100');
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
      _lowStock,
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
    _electricity.text = formatMinorField(settings.electricityMinorPerKwh);
    _labor.text = formatMinorField(settings.laborMinorPerHour);
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
    final low = settings.defaultLowStockGrams;
    _lowStock.text = low == low.roundToDouble()
        ? low.round().toString()
        : low.toString();
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
          const SizedBox(height: 12),
          TextField(
            controller: _electricity,
            decoration: const InputDecoration(
              labelText: 'Electricity price per kWh',
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _labor,
            decoration: const InputDecoration(labelText: 'Labor per hour'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _markup,
            decoration: const InputDecoration(labelText: 'Default markup %'),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _vat,
            decoration: const InputDecoration(
              labelText: 'VAT % (0 if not registered)',
            ),
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
            controller: _validity,
            decoration: const InputDecoration(labelText: 'Quote validity days'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _lowStock,
            decoration: const InputDecoration(
              labelText: 'Low stock warning (g)',
              helperText:
                  'Spools can use this workshop default or their own threshold.',
            ),
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 16),
          Text(
            'Business profile',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _business,
            decoration: const InputDecoration(labelText: 'Name'),
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
          ),
          const SizedBox(height: 12),
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
              final electricity = parseMinor(_electricity.text);
              final labor = parseMinor(_labor.text);
              final validity = parsePositiveInt(_validity.text);
              final lowStock = parseNonNegativeDouble(_lowStock.text);
              final currency = _currency.text.trim().toUpperCase();
              if (electricity == null) {
                setState(
                  () => _message =
                      'Enter the electricity price. Use 0 if you do not charge for power.',
                );
                return;
              }
              if (labor == null) {
                setState(
                  () => _message =
                      'Enter the labor rate. Use 0 if you do not charge for labor.',
                );
                return;
              }
              if (markup == null || vat == null || failure == null) {
                setState(
                  () => _message = 'Markup, VAT, and failure must be numbers.',
                );
                return;
              }
              if (!RegExp(r'^[A-Z]{3}$').hasMatch(currency)) {
                setState(
                  () =>
                      _message = 'Enter a 3-letter currency code, such as SEK.',
                );
                return;
              }
              if (validity == null || validity < 1) {
                setState(
                  () => _message = 'Enter how many days a quote stays valid.',
                );
                return;
              }
              if (lowStock == null) {
                setState(
                  () => _message =
                      'Enter the low-stock warning in grams. Use 0 to warn only when a spool is empty.',
                );
                return;
              }
              await store.saveSettings(
                WorkshopSettings(
                  setupCompleted: _setupCompleted,
                  currencyCode: currency,
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
