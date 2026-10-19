import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:gramnota/l10n/l10n.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

import '../../../core/menu_card.dart';
import '../../../core/section_layout.dart';
import '../../../core/providers.dart';
import '../../../core/shell.dart';
import '../../../core/user_store.dart';
import '../../orders/data/orders_providers.dart';
import '../../orders/domain/print_order.dart';
import '../../orders/presentation/order_status_style.dart';
import '../../sharing/domain/inbox_item.dart';
import '../../sharing/presentation/inbox_screen.dart';
import '../domain/customer.dart';

class CustomersScreen extends ConsumerStatefulWidget {
  const CustomersScreen({super.key});

  @override
  ConsumerState<CustomersScreen> createState() => _CustomersScreenState();
}

class _CustomersScreenState extends ConsumerState<CustomersScreen> {
  final _search = TextEditingController();

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
        body: EmptyView(message: context.l10n.customerSignInList),
      );
    }
    final customers = ref.watch(customersProvider(store));
    final orders = ref.watch(ordersProvider(store));
    final quoteCounts = orders.asData?.value == null
        ? const <String, int>{}
        : _quoteCounts(orders.asData!.value);
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.navCustomers)),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/customers/new'),
        child: const Icon(Icons.add),
      ),
      body: customers.when(
        data: (list) {
          if (list.isEmpty) {
            return EmptyView(
              message: context.l10n.customerNoneYet,
              action: FilledButton(
                onPressed: () => context.go('/customers/new'),
                child: Text(
                  context.l10n.customerAdd,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            );
          }
          final query = _search.text.trim().toLowerCase();
          final visible = list.where((customer) {
            final haystack =
                '${customer.name} ${customer.city} ${customer.phone} ${customer.email}'
                    .toLowerCase();
            return query.isEmpty || haystack.contains(query);
          }).toList()..sort((a, b) => a.name.compareTo(b.name));
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: TextField(
                  controller: _search,
                  decoration: InputDecoration(
                    hintText: context.l10n.customerSearchHint,
                    prefixIcon: const Icon(Icons.search),
                    filled: true,
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),
              Expanded(
                child: visible.isEmpty
                    ? EmptyView(message: context.l10n.customerSearchEmpty)
                    : ListView.separated(
                        padding: TappableListCard.listPadding,
                        itemCount: visible.length,
                        separatorBuilder: (_, _) =>
                            TappableListCard.listSeparator,
                        itemBuilder: (context, index) {
                          final customer = visible[index];
                          return _CustomerListCard(
                            customer: customer,
                            quoteCount: quoteCounts[customer.id] ?? 0,
                            onTap: () =>
                                context.go('/customers/${customer.id}'),
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

Map<String, int> _quoteCounts(List<PrintOrder> orders) {
  final counts = <String, int>{};
  for (final order in orders) {
    final id = order.customerId;
    if (id.isEmpty) {
      continue;
    }
    counts[id] = (counts[id] ?? 0) + 1;
  }
  return counts;
}

class _CustomerListCard extends StatelessWidget {
  const _CustomerListCard({
    required this.customer,
    required this.quoteCount,
    required this.onTap,
  });

  final Customer customer;
  final int quoteCount;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final phone = customer.phone.trim();
    final email = customer.email.trim();
    final city = customer.city.trim();
    final subtitle = city.isNotEmpty
        ? city
        : email.isNotEmpty
        ? email
        : phone;
    return TappableListCard(
      onTap: onTap,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CircleAvatar(
            backgroundColor: scheme.primaryContainer,
            foregroundColor: scheme.onPrimaryContainer,
            child: Text(customer.initials),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  customer.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.titleMedium,
                ),
                if (subtitle.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
                if (customer.addressLine.trim().isNotEmpty &&
                    city.isNotEmpty &&
                    customer.street.trim().isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    customer.addressLine,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
                const SizedBox(height: 6),
                Text(
                  context.l10n.customerQuoteCount(quoteCount),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: quoteCount == 0
                        ? scheme.onSurfaceVariant
                        : scheme.primary,
                  ),
                ),
              ],
            ),
          ),
          if (phone.isNotEmpty)
            IconButton(
              tooltip: context.l10n.customerCall,
              onPressed: () => launchUrl(Uri.parse('tel:$phone')),
              icon: const Icon(Icons.phone_outlined),
            ),
          if (email.isNotEmpty)
            IconButton(
              tooltip: context.l10n.fieldEmail,
              onPressed: () => launchUrl(Uri.parse('mailto:$email')),
              icon: const Icon(Icons.mail_outline),
            ),
        ],
      ),
    );
  }
}

class CustomerEditScreen extends ConsumerStatefulWidget {
  const CustomerEditScreen({required this.id, super.key});

  final String id;

  @override
  ConsumerState<CustomerEditScreen> createState() => _CustomerEditScreenState();
}

class _CustomerEditScreenState extends ConsumerState<CustomerEditScreen> {
  final _name = TextEditingController();
  final _street = TextEditingController();
  final _postal = TextEditingController();
  final _city = TextEditingController();
  final _country = TextEditingController();
  final _phone = TextEditingController();
  final _email = TextEditingController();
  final _notes = TextEditingController();
  var _loaded = false;
  String? _error;

  @override
  void dispose() {
    for (final controller in [
      _name,
      _street,
      _postal,
      _city,
      _country,
      _phone,
      _email,
      _notes,
    ]) {
      controller.dispose();
    }
    super.dispose();
  }

  void _load(Customer customer) {
    if (_loaded) {
      return;
    }
    _name.text = customer.name;
    _street.text = customer.street;
    _postal.text = customer.postalCode;
    _city.text = customer.city;
    _country.text = customer.country;
    _phone.text = customer.phone;
    _email.text = customer.email;
    _notes.text = customer.notes;
    _loaded = true;
  }

  Future<void> _save(UserStore store) async {
    if (_name.text.trim().isEmpty) {
      setState(() => _error = context.l10n.customerNameRequired);
      return;
    }
    final customer = Customer(
      id: widget.id == 'new' ? const Uuid().v4() : widget.id,
      name: _name.text.trim(),
      street: _street.text.trim(),
      postalCode: _postal.text.trim(),
      city: _city.text.trim(),
      country: _country.text.trim(),
      phone: _phone.text.trim(),
      email: _email.text.trim(),
      notes: _notes.text.trim(),
    );
    try {
      await store.saveCustomer(customer);
    } on Object {
      if (mounted) {
        setState(() => _error = context.l10n.customerSaveFailed);
      }
      return;
    }
    if (mounted) {
      context.go('/customers/${customer.id}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final store = ref.watch(userStoreProvider);
    if (store == null) {
      return Scaffold(
        body: EmptyView(message: context.l10n.customerSignInEdit),
      );
    }
    final existing = ref.watch(customersProvider(store));
    final orders = ref.watch(ordersProvider(store));
    if (widget.id != 'new') {
      final match = existing.asData?.value.where(
        (item) => item.id == widget.id,
      );
      if (match != null && match.isNotEmpty) {
        _load(match.first);
      }
    }
    final customerOrders = [
      ...?orders.asData?.value.where((order) => order.customerId == widget.id),
    ]..sort((a, b) => b.updatedAt.compareTo(a.updatedAt));
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final isNew = widget.id == 'new';
    return Scaffold(
      appBar: AppBar(
        title: Text(isNew ? context.l10n.customerNew : _name.text),
        actions: [
          if (!isNew)
            IconButton(
              tooltip: context.l10n.inboxSendToUser,
              onPressed: () => sendItem(
                context: context,
                store: store,
                type: SharedItemType.customer,
                payload: Customer(
                  id: widget.id,
                  name: _name.text.trim(),
                  street: _street.text.trim(),
                  postalCode: _postal.text.trim(),
                  city: _city.text.trim(),
                  country: _country.text.trim(),
                  phone: _phone.text.trim(),
                  email: _email.text.trim(),
                  notes: _notes.text.trim(),
                ).toJson(),
              ),
              icon: const Icon(Icons.send_outlined),
            ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          if (_error != null) Text(_error!),
          if (!isNew && _name.text.trim().isNotEmpty)
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: TappableListCard(
                child: Row(
                  children: [
                    CircleAvatar(
                      radius: 28,
                      backgroundColor: scheme.primaryContainer,
                      foregroundColor: scheme.onPrimaryContainer,
                      child: Text(
                        Customer(id: '', name: _name.text).initials,
                        style: theme.textTheme.titleLarge,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _name.text.trim(),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: theme.textTheme.titleLarge,
                          ),
                          if (_phone.text.trim().isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              _phone.text.trim(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: scheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                          if (_email.text.trim().isNotEmpty) ...[
                            const SizedBox(height: 2),
                            Text(
                              _email.text.trim(),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: scheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                          if ([
                            _street.text,
                            _postal.text,
                            _city.text,
                            _country.text,
                          ].any((part) => part.trim().isNotEmpty)) ...[
                            const SizedBox(height: 4),
                            Text(
                              Customer(
                                id: widget.id,
                                name: _name.text,
                                street: _street.text,
                                postalCode: _postal.text,
                                city: _city.text,
                                country: _country.text,
                              ).addressLine,
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                              style: theme.textTheme.bodySmall?.copyWith(
                                color: scheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          TextField(
            controller: _name,
            decoration: InputDecoration(labelText: context.l10n.fieldName),
            textCapitalization: TextCapitalization.words,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _street,
            decoration: InputDecoration(labelText: context.l10n.fieldStreet),
            textCapitalization: TextCapitalization.words,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _postal,
            decoration: InputDecoration(
              labelText: context.l10n.fieldPostalCode,
            ),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _city,
            decoration: InputDecoration(labelText: context.l10n.fieldCity),
            textCapitalization: TextCapitalization.words,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _country,
            decoration: InputDecoration(
              labelText: context.l10n.customerCountry,
            ),
            textCapitalization: TextCapitalization.words,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _phone,
            decoration: InputDecoration(labelText: context.l10n.fieldPhone),
            keyboardType: TextInputType.phone,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _email,
            decoration: InputDecoration(labelText: context.l10n.fieldEmail),
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _notes,
            decoration: InputDecoration(labelText: context.l10n.fieldNotes),
            minLines: 2,
            maxLines: 4,
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              OutlinedButton.icon(
                onPressed: _phone.text.trim().isEmpty
                    ? null
                    : () => launchUrl(Uri.parse('tel:${_phone.text.trim()}')),
                icon: const Icon(Icons.phone_outlined),
                label: Text(
                  context.l10n.customerCall,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              OutlinedButton.icon(
                onPressed: _email.text.trim().isEmpty
                    ? null
                    : () =>
                          launchUrl(Uri.parse('mailto:${_email.text.trim()}')),
                icon: const Icon(Icons.mail_outline),
                label: Text(
                  context.l10n.fieldEmail,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              OutlinedButton.icon(
                onPressed:
                    [
                      _street.text,
                      _postal.text,
                      _city.text,
                      _country.text,
                    ].every((part) => part.trim().isEmpty)
                    ? null
                    : () {
                        final query = [
                          _street.text,
                          _postal.text,
                          _city.text,
                          _country.text,
                        ].where((part) => part.trim().isNotEmpty).join(' ');
                        launchUrl(
                          Uri.parse(
                            'https://www.google.com/maps/search/?api=1&query=${Uri.encodeComponent(query)}',
                          ),
                        );
                      },
                icon: const Icon(Icons.map_outlined),
                label: Text(
                  context.l10n.customerMap,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          FilledButton(
            onPressed: () => _save(store),
            child: Text(
              context.l10n.actionSave,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (!isNew)
            TextButton(
              style: TextButton.styleFrom(foregroundColor: scheme.error),
              onPressed: () async {
                final name = _name.text.trim();
                final quotes = customerOrders.length;
                final confirmed = await confirmDelete(
                  context,
                  title: context.l10n.customerDeleteTitle,
                  message: context.l10n.customerDeleteMessage(quotes, name),
                );
                if (!confirmed || !context.mounted) {
                  return;
                }
                await store.deleteCustomer(widget.id);
                if (context.mounted) {
                  context.go('/customers');
                }
              },
              child: Text(
                context.l10n.customerDeleteTitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          if (customerOrders.isNotEmpty) ...[
            const SectionRule(),
            SectionHeading(
              context.l10n.customerQuoteCount(customerOrders.length),
            ),
            for (final order in customerOrders) ...[
              _CustomerOrderCard(
                order: order,
                onTap: () => context.go('/orders/${order.id}'),
              ),
              const SizedBox(height: 8),
            ],
          ],
        ],
      ),
    );
  }
}

class _CustomerOrderCard extends StatelessWidget {
  const _CustomerOrderCard({required this.order, required this.onTap});

  final PrintOrder order;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final statusColor = orderStatusColor(order.status, scheme);
    final l10n = context.l10n;
    final statusLabel = switch (order.status) {
      OrderStatus.quote => l10n.statusQuote,
      OrderStatus.sent => l10n.statusSent,
      OrderStatus.accepted => l10n.statusAccepted,
      OrderStatus.printed => l10n.statusPrinted,
      OrderStatus.paid => l10n.statusPaid,
      OrderStatus.declined => l10n.statusDeclined,
      OrderStatus.cancelled => l10n.statusCancelled,
    };
    return TappableListCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.customerQuoteNumber(order.quoteNumber),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  statusLabel,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.labelMedium?.copyWith(
                    color: statusColor,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            order.title,
            style: theme.textTheme.titleMedium,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 4),
          Text(
            context.money(order.breakdown.totalMinor, order.currencyCode),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
