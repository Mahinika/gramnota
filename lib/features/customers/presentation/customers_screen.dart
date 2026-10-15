import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

import '../../../core/providers.dart';
import '../../../core/shell.dart';
import '../../../core/user_store.dart';
import '../../orders/domain/print_order.dart';
import '../../orders/presentation/orders_screen.dart';
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
    return Scaffold(
      appBar: AppBar(title: const Text('Customers')),
      floatingActionButton: FloatingActionButton(
        onPressed: () => context.go('/customers/new'),
        child: const Icon(Icons.add),
      ),
      body: customers.when(
        data: (list) {
          final query = _search.text.trim().toLowerCase();
          final visible = list.where((customer) {
            final haystack = '${customer.name} ${customer.city} ${customer.phone}'
                .toLowerCase();
            return query.isEmpty || haystack.contains(query);
          }).toList()..sort((a, b) => a.name.compareTo(b.name));
          return Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: TextField(
                  controller: _search,
                  decoration: const InputDecoration(
                    labelText: 'Search',
                    prefixIcon: Icon(Icons.search),
                  ),
                  onChanged: (_) => setState(() {}),
                ),
              ),
              if (visible.isEmpty)
                const Expanded(child: EmptyView(message: 'No customers yet.')),
              if (visible.isNotEmpty)
                Expanded(
                  child: ListView(
                    children: [
                      for (final customer in visible)
                        ListTile(
                          title: Text(customer.name),
                          subtitle: Text(customer.addressLine),
                          onTap: () => context.go('/customers/${customer.id}'),
                        ),
                    ],
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
    final customerOrders = orders.asData?.value
            .where((order) => order.customerId == widget.id)
            .toList() ??
        const <PrintOrder>[];
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.id == 'new' ? 'New customer' : _name.text),
        actions: [
          if (widget.id != 'new')
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
          TextField(controller: _name, decoration: const InputDecoration(labelText: 'Name')),
          TextField(controller: _street, decoration: const InputDecoration(labelText: 'Street')),
          TextField(controller: _postal, decoration: const InputDecoration(labelText: 'Postal code')),
          TextField(controller: _city, decoration: const InputDecoration(labelText: 'City')),
          TextField(controller: _country, decoration: const InputDecoration(labelText: 'Country')),
          TextField(controller: _phone, decoration: const InputDecoration(labelText: 'Phone')),
          TextField(controller: _email, decoration: const InputDecoration(labelText: 'Email')),
          TextField(controller: _notes, decoration: const InputDecoration(labelText: 'Notes')),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            children: [
              OutlinedButton(
                onPressed: _phone.text.trim().isEmpty
                    ? null
                    : () => launchUrl(Uri.parse('tel:${_phone.text.trim()}')),
                child: const Text('Call'),
              ),
              OutlinedButton(
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
                child: const Text('Map'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          FilledButton(onPressed: () => _save(store), child: const Text('Save')),
          if (customerOrders.isNotEmpty) ...[
            const SizedBox(height: 24),
            Text('Orders', style: Theme.of(context).textTheme.titleMedium),
            for (final order in customerOrders)
              ListTile(
                title: Text(order.title),
                subtitle: Text(orderStatusLabel(order.status)),
                onTap: () => context.go('/orders/${order.id}'),
              ),
          ],
        ],
      ),
    );
  }
}
