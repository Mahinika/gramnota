import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

import '../../../core/menu_card.dart';
import '../../../core/providers.dart';
import '../../../core/shell.dart';
import '../../../core/user_store.dart';
import '../../customers/domain/customer.dart';
import '../../filaments/domain/filament_spool.dart';
import '../../orders/data/order_stock.dart';
import '../../orders/domain/print_order.dart';
import '../../printers/domain/printer_profile.dart';
import '../domain/inbox_item.dart';

Future<void> sendItem({
  required BuildContext context,
  required UserStore store,
  required SharedItemType type,
  required Map<String, dynamic> payload,
}) async {
  final email = TextEditingController();
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: const Text('Send to user'),
      content: TextField(
        controller: email,
        decoration: const InputDecoration(labelText: 'Their email'),
        keyboardType: TextInputType.emailAddress,
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: const Text('Cancel'),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          child: const Text('Send'),
        ),
      ],
    ),
  );
  if (confirmed != true) {
    email.dispose();
    return;
  }
  final recipient = await store.findUserByEmail(email.text);
  email.dispose();
  if (!context.mounted) {
    return;
  }
  if (recipient == null) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('No Gramnota user with that email.')),
    );
    return;
  }
  if (recipient.uid == store.uid) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('That email is your own account.')),
    );
    return;
  }
  final user = FirebaseAuth.instance.currentUser;
  await store.sendToUser(
    recipientUid: recipient.uid,
    type: type,
    payload: payload,
    senderName: user?.displayName ?? user?.email ?? 'Gramnota user',
    senderEmail: user?.email ?? '',
  );
  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Sent to ${recipient.displayName}.')),
    );
  }
}

class InboxScreen extends ConsumerWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(userStoreProvider);
    if (store == null) {
      return const Scaffold(
        body: EmptyView(message: 'Sign in to see inbox.'),
      );
    }
    final items = ref.watch(_inboxProvider(store));
    return Scaffold(
      appBar: AppBar(title: const Text('Inbox')),
      body: items.when(
        data: (list) {
          if (list.isEmpty) {
            return const EmptyView(
              message: 'Nothing shared with you yet.',
            );
          }
          return ListView.separated(
            padding: MenuCard.listPadding,
            itemCount: list.length,
            separatorBuilder: (_, _) => MenuCard.listSeparator,
            itemBuilder: (context, index) {
              final item = list[index];
              final theme = Theme.of(context);
              final scheme = theme.colorScheme;
              return MenuCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${item.senderName} sent a ${item.type.name}',
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.senderEmail,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () => _decline(store, item),
                          child: const Text('Decline'),
                        ),
                        const SizedBox(width: 8),
                        FilledButton(
                          onPressed: () => _accept(context, store, item),
                          child: const Text('Accept'),
                        ),
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, _) => EmptyView(message: '$error'),
      ),
    );
  }

  Future<void> _decline(UserStore store, InboxItem item) {
    return store.deleteInboxItem(item.id);
  }

  Future<void> _accept(
    BuildContext context,
    UserStore store,
    InboxItem item,
  ) async {
    final payload = jsonDecode(item.payloadJson);
    if (payload is! Map<String, dynamic>) {
      return;
    }
    final stock = await _copy(store, item.type, payload);
    await store.deleteInboxItem(item.id);
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(stock)),
      );
    }
  }

  Future<String> _copy(
    UserStore store,
    SharedItemType type,
    Map<String, dynamic> payload,
  ) async {
    final id = const Uuid().v4();
    switch (type) {
      case SharedItemType.filament:
        await store.saveFilament(
          FilamentSpool.fromJson({...payload, 'id': id}),
        );
        return 'Filament added to your inventory.';
      case SharedItemType.customer:
        await store.saveCustomer(Customer.fromJson({...payload, 'id': id}));
        return 'Customer added.';
      case SharedItemType.printer:
        await store.savePrinter(
          PrinterProfile.fromJson({...payload, 'id': id}),
        );
        return 'Printer added.';
      case SharedItemType.order:
        final order = PrintOrder.fromJson({...payload, 'id': id});
        final number = await OrderStock(store).allocateQuoteNumber();
        await store.saveOrder(
          order.copyWith(
            customerId: '',
            printerId: '',
            filaments: [
              for (final usage in order.filaments)
                usage.copyWith(filamentId: ''),
            ],
            lines: [
              for (final line in order.lines)
                line.copyWith(
                  printerId: '',
                  filaments: [
                    for (final usage in line.filaments)
                      usage.copyWith(filamentId: ''),
                  ],
                ),
            ],
            status: OrderStatus.quote,
            stockDeducted: false,
            deductedGrams: const {},
            stockWarning: '',
            quoteNumber: number,
          ),
        );
        return 'Quote added. Customer, printer, and spool links were cleared.';
    }
  }
}

final _inboxProvider = StreamProvider.family<List<InboxItem>, UserStore>(
  (ref, store) => store.watchInbox(),
);
