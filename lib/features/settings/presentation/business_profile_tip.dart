import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../core/providers.dart';
import '../../../l10n/l10n.dart';
import '../../orders/data/orders_providers.dart';

const businessProfileTipDismissedKey = 'gramnota_business_profile_tip_dismissed';

/// True after the seller closes the PDF business-details tip.
class BusinessProfileTipDismissed extends AsyncNotifier<bool> {
  @override
  Future<bool> build() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(businessProfileTipDismissedKey) ?? false;
  }

  Future<void> dismiss() async {
    state = const AsyncData(true);
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(businessProfileTipDismissedKey, true);
  }
}

final businessProfileTipDismissedProvider =
    AsyncNotifierProvider<BusinessProfileTipDismissed, bool>(
      BusinessProfileTipDismissed.new,
    );

/// Small card on Home and the calculator until the workshop has a name
/// on the quote PDF, or the seller dismisses it.
class BusinessProfileTip extends ConsumerWidget {
  const BusinessProfileTip({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final store = ref.watch(userStoreProvider);
    if (store == null) {
      return const SizedBox.shrink();
    }
    final settings = ref.watch(settingsProvider(store)).asData?.value;
    if (settings == null ||
        !settings.setupCompleted ||
        settings.businessName.trim().isNotEmpty) {
      return const SizedBox.shrink();
    }
    final dismissed = ref.watch(businessProfileTipDismissedProvider);
    if (dismissed.asData?.value != false) {
      return const SizedBox.shrink();
    }
    final l10n = context.l10n;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(16, 12, 8, 8),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: Text(l10n.businessProfileTip)),
                IconButton(
                  tooltip: l10n.actionClose,
                  onPressed: () => ref
                      .read(businessProfileTipDismissedProvider.notifier)
                      .dismiss(),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
            Align(
              alignment: Alignment.centerLeft,
              child: TextButton(
                onPressed: () => context.go('/more/settings'),
                child: Text(l10n.moreSettings),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
