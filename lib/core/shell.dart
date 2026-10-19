import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gramnota/l10n/l10n.dart';

import 'brand_icon.dart';
import 'gate_scaffold.dart';

class AppShell extends StatelessWidget {
  const AppShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  void _selectBranch(int index) {
    navigationShell.goBranch(
      index,
      initialLocation: index == navigationShell.currentIndex,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    final destinations = <({String label, String icon})>[
      (label: l10n.navHome, icon: 'home'),
      (label: l10n.navCalculator, icon: 'calculator'),
      (label: l10n.navOrders, icon: 'orders'),
      (label: l10n.navCustomers, icon: 'customers'),
      (label: l10n.navFilament, icon: 'filament'),
      (label: l10n.navMore, icon: 'more'),
    ];
    final wide = MediaQuery.sizeOf(context).width >= 840;
    if (wide) {
      return Scaffold(
        body: Row(
          children: [
            NavigationRail(
              selectedIndex: navigationShell.currentIndex,
              onDestinationSelected: _selectBranch,
              labelType: NavigationRailLabelType.all,
              groupAlignment: -1,
              leading: const Padding(
                padding: EdgeInsets.symmetric(vertical: 16),
                child: GramnotaBrandMark(size: 40),
              ),
              destinations: [
                for (final destination in destinations)
                  NavigationRailDestination(
                    icon: GramnotaSvgIcon(destination.icon),
                    selectedIcon: GramnotaSvgIcon('${destination.icon}_filled'),
                    label: Text(
                      destination.label,
                      softWrap: true,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ),
              ],
            ),
            const VerticalDivider(width: 1),
            Expanded(child: navigationShell),
          ],
        ),
      );
    }
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: NavigationBar(
        selectedIndex: navigationShell.currentIndex,
        onDestinationSelected: _selectBranch,
        destinations: [
          for (final destination in destinations)
            NavigationDestination(
              icon: GramnotaSvgIcon(destination.icon),
              selectedIcon: GramnotaSvgIcon('${destination.icon}_filled'),
              label: destination.label,
              // Labels are already under the icons. The default tooltip
              // floats over the form (the quantity field sits just above).
              tooltip: '',
            ),
        ],
      ),
    );
  }
}

Future<bool> confirmDelete(
  BuildContext context, {
  required String title,
  required String message,
}) async {
  final confirmed = await showDialog<bool>(
    context: context,
    builder: (context) => AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context, false),
          child: Text(context.l10n.actionCancel),
        ),
        FilledButton(
          onPressed: () => Navigator.pop(context, true),
          child: Text(context.l10n.actionDelete),
        ),
      ],
    ),
  );
  return confirmed == true;
}

class EmptyView extends StatelessWidget {
  const EmptyView({required this.message, this.action, super.key});

  final String message;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: scheme.primary,
                shape: BoxShape.circle,
              ),
              child: Image.asset(
                'assets/brand/gramnota_mark.png',
                fit: BoxFit.contain,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              textAlign: TextAlign.center,
              style: Theme.of(
                context,
              ).textTheme.bodyLarge?.copyWith(color: scheme.onSurfaceVariant),
            ),
            if (action != null) ...[const SizedBox(height: 16), action!],
          ],
        ),
      ),
    );
  }
}
