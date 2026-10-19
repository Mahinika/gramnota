import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:gramnota/core/app_languages.dart';
import 'package:gramnota/core/currencies.dart';
import 'package:gramnota/core/format.dart';
import 'package:gramnota/features/orders/domain/dashboard.dart';
import 'package:gramnota/features/orders/domain/print_order.dart';
import 'package:gramnota/features/orders/presentation/quote_pdf.dart';
import 'package:gramnota/features/pricing/domain/price_breakdown.dart';
import 'package:gramnota/features/settings/domain/workshop_settings.dart';
import 'package:gramnota/l10n/l10n.dart';

void main() {
  test('every language catalog has the English keys and placeholders', () {
    final en = _messages('en');
    final placeholder = RegExp(r'\{(\w+)\}');
    for (final code in supportedLanguageCodes) {
      final messages = _messages(code);
      expect(messages.keys.toSet(), en.keys.toSet(), reason: code);
      for (final entry in en.entries) {
        final translated = messages[entry.key]!;
        expect(translated.trim(), isNotEmpty, reason: '$code.${entry.key}');
        expect(
          placeholder.allMatches(translated).map((m) => m[1]).toSet(),
          placeholder.allMatches(entry.value).map((m) => m[1]).toSet(),
          reason: '$code.${entry.key}',
        );
      }
    }
  });

  test('missing language stays Swedish and system is explicit', () {
    expect(readLanguageCode({}, 'languageCode'), 'sv');
    expect(readLanguageCode({'languageCode': ''}, 'languageCode'), 'sv');
    expect(readLanguageCode({'languageCode': 'system'}, 'languageCode'), 'system');
    expect(readLanguageCode({'languageCode': 'no'}, 'languageCode'), 'nb');
    expect(readLanguageCode({'languageCode': 'nn'}, 'languageCode'), 'nb');
    expect(readLanguageCode({'languageCode': 'xx'}, 'languageCode'), 'sv');
    expect(localeForLanguageSetting('system'), isNull);
    expect(localeForLanguageSetting('de'), const Locale('de'));
    expect(
      resolveSupportedLocale(const Locale('ja'), const [Locale('sv'), Locale('en')]),
      const Locale('sv'),
    );
    expect(
      resolveSupportedLocale(const Locale('fr'), const [Locale('sv'), Locale('fr')]),
      const Locale('fr'),
    );
  });

  test('missing or unknown currency stays SEK', () {
    expect(readCurrencyCode({}, 'currencyCode'), 'SEK');
    expect(readCurrencyCode({'currencyCode': ''}, 'currencyCode'), 'SEK');
    expect(readCurrencyCode({'currencyCode': 'eur'}, 'currencyCode'), 'EUR');
    expect(readCurrencyCode({'currencyCode': 'btc'}, 'currencyCode'), 'SEK');
    expect(isIsoCurrency('SEK'), isTrue);
    expect(currencyFractionDigits('JPY'), 0);
    expect(currencyFractionDigits('SEK'), 2);
    expect(currencyCodesInPickerOrder().take(8), featuredCurrencyCodes);
  });

  test('money follows the locale without converting the amount', () {
    expect(formatMoney(0, 'EUR', locale: 'de'), '0,00\u00a0€');
    expect(formatMoney(1999, 'EUR', locale: 'de'), '19,99\u00a0€');
    expect(formatMoney(123450, 'EUR', locale: 'de'), '1.234,50\u00a0€');
    expect(formatMoney(1999, 'USD', locale: 'en'), r'$19.99');
    expect(formatMoney(0, 'SEK', locale: 'en'), 'kr0.00');
    expect(formatMoney(999999999, 'SEK', locale: 'sv'), '9\u00a0999\u00a0999,99\u00a0kr');
    // Stored hundredths. JPY displays with 0 fraction digits.
    expect(formatMoney(2000, 'JPY', locale: 'en'), '¥20');
    expect(formatMoney(-150, 'EUR', locale: 'en'), '-€1.50');
    final swedish = DateTime.parse('2026-11-02T12:00:00.000Z').toLocal();
    expect(
      formatIsoDate('2026-11-02T12:00:00.000Z', locale: 'sv'),
      DateFormat.yMMMd('sv').format(swedish),
    );
    expect(
      formatIsoDate('2026-11-02T12:00:00.000Z', locale: 'de'),
      DateFormat.yMMMd('de').format(swedish),
    );
  });

  test('old settings and quotes migrate to Swedish and SEK', () {
    final settings = WorkshopSettings.fromJson({
      'electricityMinorPerKwh': 150,
      'businessName': 'Verkstad',
    });
    expect(settings.languageCode, 'sv');
    expect(settings.currencyCode, 'SEK');
    final saved = settings.copyWith(languageCode: 'de', currencyCode: 'EUR').toJson();
    final again = WorkshopSettings.fromJson(saved);
    expect(again.languageCode, 'de');
    expect(again.currencyCode, 'EUR');

    final order = PrintOrder.fromJson({
      'id': 'old',
      'quoteNumber': 3,
      'title': 'Klämma',
      'status': 'sent',
      'validUntil': '2026-12-01T00:00:00.000Z',
      'quantity': 1,
      'printTimeSeconds': 60,
      'filaments': <Map<String, dynamic>>[],
      'markupBasisPoints': 3000,
      'failureBasisPoints': 0,
      'vatBasisPoints': 2500,
      'breakdown': _breakdownJson(total: 10000),
      'createdAt': '2026-01-01T00:00:00.000Z',
      'updatedAt': '2026-01-01T00:00:00.000Z',
    });
    expect(order.currencyCode, 'SEK');
    expect(order.quoteLanguage, '');
    final roundTrip = PrintOrder.fromJson(
      order.copyWith(currencyCode: 'EUR', quoteLanguage: 'de').toJson(),
    );
    expect(roundTrip.currencyCode, 'EUR');
    expect(roundTrip.quoteLanguage, 'de');
  });

  test('a pinned quote language wins over the app locale', () {
    final order = _order(currency: 'EUR', language: 'de');
    final l10n = quoteDocumentL10n(order, 'en');
    expect(l10n.localeName, 'de');
    expect(l10n.pdfTotal, lookupAppLocalizations(const Locale('de')).pdfTotal);
    expect(l10n.pdfTotal, isNot('Total'));

    final followsApp = quoteDocumentL10n(_order(currency: 'SEK', language: ''), 'sv');
    expect(followsApp.localeName, 'sv');
    expect(followsApp.navHome, 'Hem');
  });

  test('a mixed-currency month is not added together', () {
    final sek = _order(currency: 'SEK', language: '', total: 10000, id: 'sek');
    final eur = _order(currency: 'EUR', language: 'de', total: 5000, id: 'eur');
    final snapshot = buildDashboard(
      orders: [sek, eur],
      spools: const [],
      year: 2026,
      month: 3,
      now: DateTime(2026, 3, 20),
    );
    expect(snapshot.currencyTotals.map((t) => t.currencyCode), ['EUR', 'SEK']);
    expect(snapshot.orderCount, 2);
    final eurTotals = snapshot.currencyTotals.first;
    final sekTotals = snapshot.currencyTotals.last;
    expect(eurTotals.revenueInclVatMinor, 5000);
    expect(sekTotals.revenueInclVatMinor, 10000);
    expect(snapshot.revenueInclVatMinor, 5000);
    expect(
      snapshot.revenueInclVatMinor,
      isNot(eurTotals.revenueInclVatMinor + sekTotals.revenueInclVatMinor),
    );
  });

  testWidgets('the app locale switches Swedish, English, and German', (tester) async {
    Future<void> expectHome(String code, String label) async {
      await tester.pumpWidget(
        MaterialApp(
          locale: Locale(code),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Builder(builder: (context) => Text(context.l10n.navHome)),
        ),
      );
      expect(find.text(label), findsOneWidget);
    }

    await expectHome('sv', 'Hem');
    await expectHome('en', 'Home');
    await expectHome('de', 'Start');
  });

  testWidgets('long navigation labels fit a narrow bar', (tester) async {
    tester.view.physicalSize = const Size(360, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('pl'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) {
            final l10n = context.l10n;
            return Scaffold(
              bottomNavigationBar: NavigationBar(
                selectedIndex: 2,
                destinations: [
                  NavigationDestination(icon: const Icon(Icons.home), label: l10n.navHome),
                  NavigationDestination(
                    icon: const Icon(Icons.calculate),
                    label: l10n.navCalculator,
                  ),
                  NavigationDestination(icon: const Icon(Icons.list), label: l10n.navOrders),
                  NavigationDestination(
                    icon: const Icon(Icons.people),
                    label: l10n.navCustomers,
                  ),
                  NavigationDestination(
                    icon: const Icon(Icons.circle),
                    label: l10n.navFilament,
                  ),
                  NavigationDestination(icon: const Icon(Icons.more_horiz), label: l10n.navMore),
                ],
              ),
              body: const SizedBox.shrink(),
            );
          },
        ),
      ),
    );
    await tester.pumpAndSettle();
    expect(tester.takeException(), isNull);
    expect(find.text('Zamówienia'), findsOneWidget);
  });
}

Map<String, String> _messages(String code) {
  final file = File('lib/l10n/app_$code.arb');
  final json = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;
  return {
    for (final entry in json.entries)
      if (!entry.key.startsWith('@')) entry.key: entry.value as String,
  };
}

Map<String, dynamic> _breakdownJson({required int total}) => {
  'materialMinor': total,
  'electricityMinor': 0,
  'machineMinor': 0,
  'failureMinor': 0,
  'laborMinor': 0,
  'extrasMinor': 0,
  'costMinor': total,
  'markupMinor': 0,
  'netMinor': total,
  'vatMinor': 0,
  'totalMinor': total,
  'perUnitMinor': total,
  'quantity': 1,
};

PrintOrder _order({
  required String currency,
  required String language,
  int total = 10000,
  String id = 'q',
}) {
  return PrintOrder(
    id: id,
    quoteNumber: 1,
    title: 'Clip',
    status: OrderStatus.paid,
    validUntil: '2026-12-01T00:00:00.000Z',
    quantity: 1,
    printTimeSeconds: 60,
    filaments: const [],
    markupBasisPoints: 0,
    failureBasisPoints: 0,
    vatBasisPoints: 0,
    currencyCode: currency,
    quoteLanguage: language,
    breakdown: PriceBreakdown(
      materialMinor: total,
      electricityMinor: 0,
      machineMinor: 0,
      failureMinor: 0,
      laborMinor: 0,
      extrasMinor: 0,
      costMinor: total,
      markupMinor: 0,
      netMinor: total,
      vatMinor: 0,
      totalMinor: total,
      perUnitMinor: total,
      quantity: 1,
    ),
    revenueAt: '2026-03-15T12:00:00.000Z',
    createdAt: '2026-03-15T12:00:00.000Z',
    updatedAt: '2026-03-15T12:00:00.000Z',
  );
}
