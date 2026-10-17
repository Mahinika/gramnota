import 'package:flutter/material.dart';
import 'package:uuid/uuid.dart';

import '../../../core/user_store.dart';
import '../domain/customer.dart';

/// Shows the customer sheet. Returns a customer id, `''` for none, or `'new'`.
Future<String?> showCustomerQuotePicker(
  BuildContext context, {
  required List<Customer> customers,
  String title = 'Customer',
}) {
  return showModalBottomSheet<String>(
    context: context,
    isScrollControlled: true,
    showDragHandle: true,
    builder: (sheetContext) => CustomerQuotePickerSheet(
      customers: customers,
      title: title,
      onNew: () => Navigator.pop(sheetContext, 'new'),
      onNone: () => Navigator.pop(sheetContext, ''),
    ),
  );
}

Future<Customer?> promptNewCustomer(BuildContext context, UserStore store) async {
  final name = TextEditingController();
  final created = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('New customer'),
      content: TextField(
        controller: name,
        decoration: const InputDecoration(labelText: 'Name'),
        autofocus: true,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Save'),
        ),
      ],
    ),
  );
  if (created != true || name.text.trim().isEmpty) {
    name.dispose();
    return null;
  }
  final customer = Customer(id: const Uuid().v4(), name: name.text.trim());
  name.dispose();
  await store.saveCustomer(customer);
  return customer;
}

/// Resolves picker result to a customer id (`''` allowed).
Future<String?> pickCustomerId(
  BuildContext context,
  UserStore store,
  List<Customer> customers, {
  String title = 'Customer',
}) async {
  final picked = await showCustomerQuotePicker(
    context,
    customers: customers,
    title: title,
  );
  if (picked == null) {
    return null;
  }
  if (picked == 'new') {
    if (!context.mounted) {
      return null;
    }
    final created = await promptNewCustomer(context, store);
    return created?.id;
  }
  return picked;
}

class CustomerQuotePickerSheet extends StatefulWidget {
  const CustomerQuotePickerSheet({
    required this.customers,
    required this.title,
    required this.onNew,
    required this.onNone,
    super.key,
  });

  final List<Customer> customers;
  final String title;
  final VoidCallback onNew;
  final VoidCallback onNone;

  @override
  State<CustomerQuotePickerSheet> createState() =>
      _CustomerQuotePickerSheetState();
}

class _CustomerQuotePickerSheetState extends State<CustomerQuotePickerSheet> {
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
        if (query.isEmpty ||
            '${customer.name} ${customer.city} ${customer.email} ${customer.phone}'
                .toLowerCase()
                .contains(query))
          customer,
    ]..sort((a, b) => a.name.compareTo(b.name));
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    final bottom = MediaQuery.viewInsetsOf(context).bottom;
    return Padding(
      padding: EdgeInsets.fromLTRB(16, 0, 16, 16 + bottom),
      child: SizedBox(
        height: MediaQuery.sizeOf(context).height * 0.55,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(widget.title, style: theme.textTheme.titleLarge),
            const SizedBox(height: 12),
            TextField(
              controller: _search,
              decoration: const InputDecoration(
                hintText: 'Name, city, phone, or email',
                prefixIcon: Icon(Icons.search),
                filled: true,
              ),
              onChanged: (_) => setState(() {}),
            ),
            const SizedBox(height: 4),
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(Icons.person_off_outlined),
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
                  ? Center(
                      child: Text(
                        query.isEmpty
                            ? 'No customers yet. Add one above.'
                            : 'No customer with that name.',
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: scheme.onSurfaceVariant,
                        ),
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ListView.separated(
                      itemCount: visible.length,
                      separatorBuilder: (_, _) => const Divider(height: 1),
                      itemBuilder: (context, index) {
                        final customer = visible[index];
                        final city = customer.city.trim();
                        final email = customer.email.trim();
                        final subtitle = city.isNotEmpty
                            ? city
                            : email.isNotEmpty
                                ? email
                                : customer.phone.trim();
                        return ListTile(
                          contentPadding: EdgeInsets.zero,
                          leading: CircleAvatar(
                            backgroundColor: scheme.primaryContainer,
                            foregroundColor: scheme.onPrimaryContainer,
                            child: Text(customer.initials),
                          ),
                          title: Text(customer.name),
                          subtitle: subtitle.isEmpty ? null : Text(subtitle),
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
