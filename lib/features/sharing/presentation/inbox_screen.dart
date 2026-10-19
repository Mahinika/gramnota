import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gramnota/l10n/l10n.dart';
import 'package:uuid/uuid.dart';

import '../../../core/menu_card.dart';
import '../../../core/text_prompt.dart';
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
  final email = await promptForText(
    context,
    title: context.l10n.inboxSendToUser,
    label: context.l10n.inboxRecipientEmail,
    confirmLabel: context.l10n.inboxSend,
    keyboardType: TextInputType.emailAddress,
  );
  if (email == null || email.isEmpty) {
    return;
  }
  final recipient = await store.findUserByEmail(email);
  if (!context.mounted) {
    return;
  }
  if (recipient == null) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(context.l10n.inboxUserNotFound)));
    return;
  }
  if (recipient.uid == store.uid) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(context.l10n.inboxOwnAccount)));
    return;
  }
  final user = FirebaseAuth.instance.currentUser;
  try {
    await store.sendToUser(
      recipientUid: recipient.uid,
      type: type,
      payload: payload,
      senderName:
          user?.displayName ?? user?.email ?? context.l10n.inboxSenderFallback,
      senderEmail: user?.email ?? '',
    );
  } on InboxPayloadTooLarge {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(context.l10n.inboxTooLarge)));
    }
    return;
  }
  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(context.l10n.inboxSentTo(recipient.displayName))),
    );
  }
}

class InboxScreen extends ConsumerWidget {
  const InboxScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(userStoreProvider);
    if (store == null) {
      return Scaffold(body: EmptyView(message: context.l10n.inboxSignIn));
    }
    final items = ref.watch(_inboxProvider(store));
    return Scaffold(
      appBar: AppBar(title: Text(context.l10n.moreInbox)),
      body: items.when(
        data: (list) {
          if (list.isEmpty) {
            return EmptyView(message: context.l10n.inboxEmpty);
          }
          return ListView.separated(
            padding: TappableListCard.listPadding,
            itemCount: list.length,
            separatorBuilder: (_, _) => TappableListCard.listSeparator,
            itemBuilder: (context, index) {
              final item = list[index];
              final theme = Theme.of(context);
              final scheme = theme.colorScheme;
              return TappableListCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _inboxSentLine(context.l10n, item),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleMedium,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      item.senderEmail,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Row(
                      children: [
                        TextButton(
                          onPressed: () => _decline(store, item),
                          child: Text(
                            context.l10n.inboxDecline,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                        const SizedBox(width: 8),
                        FilledButton(
                          onPressed: () => _accept(context, store, item),
                          child: Text(
                            context.l10n.inboxAccept,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
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
    final l10n = context.l10n;
    final payload = jsonDecode(item.payloadJson);
    if (payload is! Map<String, dynamic>) {
      return;
    }
    final stock = await _copy(store, item.type, payload, l10n);
    await store.deleteInboxItem(item.id);
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(stock)));
    }
  }

  Future<String> _copy(
    UserStore store,
    SharedItemType type,
    Map<String, dynamic> payload,
    AppLocalizations l10n,
  ) async {
    final id = const Uuid().v4();
    switch (type) {
      case SharedItemType.filament:
        await store.saveFilament(
          FilamentSpool.fromJson({...payload, 'id': id}),
        );
        return l10n.inboxAddedFilament;
      case SharedItemType.customer:
        await store.saveCustomer(Customer.fromJson({...payload, 'id': id}));
        return l10n.inboxAddedCustomer;
      case SharedItemType.printer:
        await store.savePrinter(
          PrinterProfile.fromJson({...payload, 'id': id}),
        );
        return l10n.inboxAddedPrinter;
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
        return l10n.inboxAddedQuote;
    }
  }
}

String _inboxSentLine(AppLocalizations l10n, InboxItem item) {
  final sender = item.senderName;
  return switch (item.type) {
    SharedItemType.filament => l10n.inboxSentFilament(sender),
    SharedItemType.customer => l10n.inboxSentCustomer(sender),
    SharedItemType.printer => l10n.inboxSentPrinter(sender),
    SharedItemType.order => l10n.inboxSentOrder(sender),
  };
}

final _inboxProvider = StreamProvider.family<List<InboxItem>, UserStore>(
  (ref, store) => store.watchInbox(),
);
