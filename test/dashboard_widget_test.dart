import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:gramnota/core/format.dart';
import 'package:gramnota/features/orders/domain/dashboard.dart';
import 'package:gramnota/features/orders/domain/print_order.dart';
import 'package:gramnota/features/orders/presentation/dashboard_screen.dart';
import 'package:gramnota/features/orders/presentation/order_status_style.dart';
import 'package:gramnota/l10n/l10n.dart';

Widget _localized(Widget home) {
  return MaterialApp(
    locale: const Locale('en'),
    localizationsDelegates: AppLocalizations.localizationsDelegates,
    supportedLocales: AppLocalizations.supportedLocales,
    home: home,
  );
}

void main() {
  testWidgets('empty month shows pipeline and no revenue chart', (
    tester,
  ) async {
    const snapshot = DashboardSnapshot(
      year: 2026,
      month: 4,
      orderCount: 0,
      revenueInclVatMinor: 0,
      revenueExclVatMinor: 0,
      costMinor: 0,
      profitMinor: 0,
      pipelineOrderCount: 2,
      pipelineInclVatMinor: 15000,
      openDepositMinor: 5000,
      materials: [],
      topCustomers: [],
      topProducts: [],
      revenueOrders: [],
      lowSpools: [],
    );

    await tester.pumpWidget(
      _localized(
        Scaffold(
          body: DashboardView(
            snapshot: snapshot,
            currencyCode: 'SEK',
            onPreviousMonth: () {},
            onNextMonth: () {},
          ),
        ),
      ),
    );

    expect(find.text('April 2026'), findsOneWidget);
    expect(find.text('No printed or paid orders this month.'), findsOneWidget);
    expect(find.text('Nothing to chart this month.'), findsOneWidget);
    expect(find.text('Open pipeline'), findsOneWidget);
    expect(find.textContaining('150'), findsWidgets);
    await tester.scrollUntilVisible(
      find.text('No spool is at or under its warning threshold.'),
      200,
    );
    expect(
      find.text('No spool is at or under its warning threshold.'),
      findsOneWidget,
    );
  });

  testWidgets('revenue month shows VAT split and a low spool', (tester) async {
    const snapshot = DashboardSnapshot(
      year: 2026,
      month: 3,
      orderCount: 1,
      revenueInclVatMinor: 16250,
      revenueExclVatMinor: 13000,
      costMinor: 10000,
      profitMinor: 3000,
      pipelineOrderCount: 0,
      pipelineInclVatMinor: 0,
      openDepositMinor: 0,
      materials: [DashboardMaterial(material: 'PLA', grams: 25)],
      topCustomers: [
        DashboardRank(id: 'anna', label: 'Anna', totalMinor: 16250, count: 1),
      ],
      topProducts: [
        DashboardRank(
          id: 'dragon',
          label: 'Dragon',
          totalMinor: 16250,
          count: 2,
        ),
      ],
      revenueOrders: [
        DashboardOrderRow(
          id: 'order',
          title: 'Dragon',
          status: OrderStatus.paid,
          totalMinor: 16250,
          customerLabel: 'Anna',
        ),
      ],
      lowSpools: [
        LowSpoolNotice(
          id: 'spool',
          label: 'Prusa PLA',
          remainingGrams: 100,
          thresholdGrams: 100,
        ),
      ],
    );

    await tester.pumpWidget(
      _localized(
        Scaffold(
          body: DashboardView(
            snapshot: snapshot,
            currencyCode: 'SEK',
            onPreviousMonth: () {},
            onNextMonth: () {},
          ),
        ),
      ),
    );

    expect(find.text('Revenue incl. VAT'), findsOneWidget);
    expect(find.text('Revenue excl. VAT'), findsOneWidget);
    expect(find.text(formatMoney(16250, 'SEK', locale: 'en')), findsWidgets);
    expect(find.text(formatMoney(13000, 'SEK', locale: 'en')), findsWidgets);
    expect(find.text('Profit'), findsWidgets);
    expect(find.text(formatMoney(3000, 'SEK', locale: 'en')), findsWidgets);
    await tester.scrollUntilVisible(find.text('PLA'), 200);
    expect(find.text('PLA'), findsOneWidget);
    expect(find.text('25 g'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Paid'), 200);
    expect(find.text('Paid'), findsOneWidget);
    await tester.scrollUntilVisible(find.text('Prusa PLA'), 200);
    expect(find.text('Prusa PLA'), findsOneWidget);
    expect(find.textContaining('warns at 100 g'), findsOneWidget);
    expect(find.text('Nothing to chart this month.'), findsNothing);
  });

  testWidgets('status choices name the workflow and the stock rule', (
    tester,
  ) async {
    await tester.pumpWidget(
      _localized(
        Scaffold(
          body: OrderStatusSection(
            selected: OrderStatus.quote,
            onSelected: (_) {},
          ),
        ),
      ),
    );

    expect(find.text('Sent'), findsOneWidget);
    expect(find.text('Accepted'), findsOneWidget);
    expect(find.text('Printed'), findsOneWidget);
    expect(find.text('Paid'), findsOneWidget);
    expect(find.text('Declined'), findsOneWidget);
    expect(find.text('Cancelled'), findsOneWidget);
    expect(find.textContaining('taken once'), findsOneWidget);
  });

  testWidgets('coverage warning is visible before printing', (tester) async {
    await tester.pumpWidget(
      _localized(
        const Scaffold(
          body: StockWarningBanner(
            messages: [
              'Prusa PLA needs 60 g for this quote. Another 50 g is reserved on accepted quotes. 100 g is left, so it is short by 10 g before this order is marked Printed.',
            ],
          ),
        ),
      ),
    );

    expect(find.textContaining('short by 10 g'), findsOneWidget);
    expect(find.byIcon(Icons.warning_amber_outlined), findsOneWidget);
  });
}
