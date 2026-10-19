import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

import '../../../core/format.dart';
import '../../../core/menu_card.dart';
import '../../../core/section_layout.dart';
import '../../../core/providers.dart';
import '../../../core/shell.dart';
import '../../../core/user_store.dart';
import '../../orders/data/orders_providers.dart';
import '../../orders/domain/print_order.dart';
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
      return const Scaffold(body: EmptyView(message: 'Sign in to see customers.'));
    }
    final customers = ref.watch(customersProvider(store));
    final orders = ref.watch(ordersProvider(store));
    final quoteCounts = orders.asData?.value == null
        ? const <String, int>{}
        : _quoteCounts(orders.asData!.value);
    return Scaffold(
      appBar: AppBar(title: const Text('Customers')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/customers/new'),
        child: const Icon(Icons.add),
      ),
      body: customers.when(
        data: (list) {
          if (list.isEmpty) {
            return EmptyView(
              message: 'No customers yet.',
              action: FilledButton(
                onPressed: () => context.go('/customers/new'),
                child: const Text('Add customer'),
              ),
            );
          }
          final query = _search.text.trim().toLowerCase();
          final visible = list.where((customer) {
            final haystack =
                '${customer.name} ${customer.city} ${customer.phone} ${customer.email}'
                    .toLowerCase();
            return query.isEmpty || haystack.contains(query);
          }).toList()
            ..sort((a, b) => a.name.compareTo(b.name));
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(16, 12, 16, 0),
                child: TextField(
                  controller: _search,
                  decoration: const InputDecoration(
                    hintText: 'Name, city, phone, or email',
                    prefixIcon: Icon(Icons.search),
                    filled: true,
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),
              Expanded(
                child: visible.isEmpty
                    ? const EmptyView(
                        message: 'No customers match your search.',
                      )
                    : ListView.separated(
                        padding: TappableListCard.listPadding,
                        itemCount: visible.length,
                        separatorBuilder: (_, _) => TappableListCard.listSeparator,
                        itemBuilder: (context, index) {
                          final customer = visible[index];
                          return _CustomerListCard(
                            customer: customer,
                            quoteCount: quoteCounts[customer.id] ?? 0,
                            onTap: () => context.go('/customers/${customer.id}'),
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
                  style: theme.textTheme.titleMedium,
                ),
                if (subtitle.isNotEmpty) ...[
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
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
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
                const SizedBox(height: 6),
                Text(
                  quoteCount == 0
                      ? 'No quotes'
                      : quoteCount == 1
                          ? '1 quote'
                          : '$quoteCount quotes',
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
              tooltip: 'Call',
              onPressed: () => launchUrl(Uri.parse('tel:$phone')),
              icon: const Icon(Icons.phone_outlined),
            ),
          if (email.isNotEmpty)
            IconButton(
              tooltip: 'Email',
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
      setState(() => _error = 'Name is required.');
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
    await store.saveCustomer(customer);
    if (mounted) {
      context.go('/customers/${customer.id}');
    }
  }

  @override
  Widget build(BuildContext context) {
    final store = ref.watch(userStoreProvider);
    if (store == null) {
      return const Scaffold(body: EmptyView(message: 'Sign in to edit customers.'));
    }
    final existing = ref.watch(customersProvider(store));
    final orders = ref.watch(ordersProvider(store));
    if (widget.id != 'new') {
      final match = existing.asData?.value.where((item) => item.id == widget.id);
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
        title: Text(isNew ? 'New customer' : _name.text),
        actions: [
          if (!isNew)
            IconButton(
              tooltip: 'Send to user',
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
                            style: theme.textTheme.titleLarge,
                          ),
                          if (_phone.text.trim().isNotEmpty) ...[
                            const SizedBox(height: 4),
                            Text(
                              _phone.text.trim(),
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: scheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                          if (_email.text.trim().isNotEmpty) ...[
                            const SizedBox(height: 2),
                            Text(
                              _email.text.trim(),
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
            decoration: const InputDecoration(labelText: 'Name'),
            textCapitalization: TextCapitalization.words,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _street,
            decoration: const InputDecoration(labelText: 'Street'),
            textCapitalization: TextCapitalization.words,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _postal,
            decoration: const InputDecoration(labelText: 'Postal code'),
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _city,
            decoration: const InputDecoration(labelText: 'City'),
            textCapitalization: TextCapitalization.words,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _country,
            decoration: const InputDecoration(labelText: 'Country'),
            textCapitalization: TextCapitalization.words,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _phone,
            decoration: const InputDecoration(labelText: 'Phone'),
            keyboardType: TextInputType.phone,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _email,
            decoration: const InputDecoration(labelText: 'Email'),
            keyboardType: TextInputType.emailAddress,
            autocorrect: false,
            onChanged: (_) => setState(() {}),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _notes,
            decoration: const InputDecoration(labelText: 'Notes'),
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
                label: const Text('Call'),
              ),
              OutlinedButton.icon(
                onPressed: _email.text.trim().isEmpty
                    ? null
                    : () => launchUrl(
                          Uri.parse('mailto:${_email.text.trim()}'),
                        ),
                icon: const Icon(Icons.mail_outline),
                label: const Text('Email'),
              ),
              OutlinedButton.icon(
                onPressed: [
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
                label: const Text('Map'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          FilledButton(onPressed: () => _save(store), child: const Text('Save')),
          if (!isNew)
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: scheme.error,
              ),
              onPressed: () async {
                final name = _name.text.trim();
                final quotes = customerOrders.length;
                final confirmed = await confirmDelete(
                  context,
                  title: 'Delete customer',
                  message: quotes == 0
                      ? 'This removes $name.'
                      : 'This removes $name. ${quotes == 1 ? '1 quote stays' : '$quotes quotes stay'}, without this customer.',
                );
                if (!confirmed || !context.mounted) {
                  return;
                }
                await store.deleteCustomer(widget.id);
                if (context.mounted) {
                  context.go('/customers');
                }
              },
              child: const Text('Delete customer'),
            ),
          if (customerOrders.isNotEmpty) ...[
            const SectionRule(),
            SectionHeading(
              customerOrders.length == 1
                  ? '1 quote'
                  : '${customerOrders.length} quotes',
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
  const _CustomerOrderCard({
    required this.order,
    required this.onTap,
  });

  final PrintOrder order;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final statusColor = switch (order.status) {
      OrderStatus.quote => scheme.secondary,
      OrderStatus.accepted => scheme.primary,
      OrderStatus.printed => scheme.tertiary,
      OrderStatus.delivered => scheme.primary,
      OrderStatus.cancelled => scheme.error,
    };
    return TappableListCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                'Quote ${order.quoteNumber}',
                style: theme.textTheme.labelMedium?.copyWith(
                  color: scheme.onSurfaceVariant,
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  orderStatusLabel(order.status),
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
            formatMoney(order.breakdown.totalMinor, order.currencyCode),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: scheme.onSurfaceVariant,
            ),
          ),
        ],
      ),
    );
  }
}
