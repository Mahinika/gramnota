import 'package:intl/intl.dart';

import '../../../core/currencies.dart';
import '../../../core/format.dart';
import '../../../l10n/l10n.dart';
import '../../filaments/domain/filament_spool.dart';
import 'print_order.dart';

/// Turns a UTC instant into the calendar time used for month boundaries.
typedef InstantLocal = DateTime Function(DateTime instant);

DateTime _deviceLocal(DateTime instant) => instant.toUtc().toLocal();

const dashboardMonthNames = [
  'January',
  'February',
  'March',
  'April',
  'May',
  'June',
  'July',
  'August',
  'September',
  'October',
  'November',
  'December',
];

class DashboardMaterial {
  const DashboardMaterial({required this.material, required this.grams});

  final String material;
  final double grams;
}

class DashboardRank {
  const DashboardRank({
    required this.id,
    required this.label,
    required this.totalMinor,
    required this.count,
    this.currencyCode = defaultCurrencyCode,
  });

  final String id;
  final String label;
  final int totalMinor;
  final int count;
  final String currencyCode;
}

class DashboardOrderRow {
  const DashboardOrderRow({
    required this.id,
    required this.title,
    required this.status,
    required this.totalMinor,
    required this.customerLabel,
    this.currencyCode = defaultCurrencyCode,
  });

  final String id;
  final String title;
  final OrderStatus status;
  final int totalMinor;
  final String customerLabel;
  final String currencyCode;
}

/// Money totals for one currency. Home shows one block per currency so
/// SEK and EUR orders are never added together.
class CurrencyTotals {
  const CurrencyTotals({
    required this.currencyCode,
    required this.orderCount,
    required this.revenueInclVatMinor,
    required this.revenueExclVatMinor,
    required this.costMinor,
    required this.profitMinor,
    required this.pipelineOrderCount,
    required this.pipelineInclVatMinor,
    required this.openDepositMinor,
    required this.depositsReceivedMinor,
    required this.finalPaymentsMinor,
  });

  final String currencyCode;
  final int orderCount;
  final int revenueInclVatMinor;
  final int revenueExclVatMinor;
  final int costMinor;
  final int profitMinor;
  final int pipelineOrderCount;
  final int pipelineInclVatMinor;
  final int openDepositMinor;
  final int depositsReceivedMinor;
  final int finalPaymentsMinor;
}

class LowSpoolNotice {
  const LowSpoolNotice({
    required this.id,
    required this.label,
    required this.remainingGrams,
    required this.thresholdGrams,
  });

  final String id;
  final String label;
  final double remainingGrams;
  final double thresholdGrams;
}

class DashboardSnapshot {
  const DashboardSnapshot({
    required this.year,
    required this.month,
    required this.orderCount,
    required this.revenueInclVatMinor,
    required this.revenueExclVatMinor,
    required this.costMinor,
    required this.profitMinor,
    required this.pipelineOrderCount,
    required this.pipelineInclVatMinor,
    required this.openDepositMinor,
    this.depositsReceivedMinor = 0,
    this.finalPaymentsMinor = 0,
    this.overdueCount = 0,
    required this.materials,
    required this.topCustomers,
    required this.topProducts,
    required this.revenueOrders,
    required this.lowSpools,
    this.currencyTotals = const [],
  });

  final int year;
  final int month;
  final int orderCount;
  final int revenueInclVatMinor;
  final int revenueExclVatMinor;
  final int costMinor;
  final int profitMinor;
  final int pipelineOrderCount;
  final int pipelineInclVatMinor;
  final int openDepositMinor;

  /// Deposits whose receipt date falls in this month.
  final int depositsReceivedMinor;

  /// The rest of a printed or paid order, after a dated deposit.
  final int finalPaymentsMinor;

  /// Quote and Sent orders past their valid-until date. Not limited to the month.
  final int overdueCount;
  final List<DashboardMaterial> materials;
  final List<DashboardRank> topCustomers;
  final List<DashboardRank> topProducts;
  final List<DashboardOrderRow> revenueOrders;
  final List<LowSpoolNotice> lowSpools;

  /// One entry per currency that contributed money. Empty on snapshots built
  /// by tests that only set the scalar fields.
  final List<CurrencyTotals> currencyTotals;

  /// English month name when [locale] is omitted, so existing tests stay stable.
  /// The home screen passes the app locale.
  String monthLabel([String? locale]) {
    if (locale == null || locale.trim().isEmpty) {
      final index = month < 1 || month > 12 ? 0 : month - 1;
      return '${dashboardMonthNames[index]} $year';
    }
    final safeMonth = month < 1 || month > 12 ? 1 : month;
    ensureGramnotaDateFormatting();
    return DateFormat.yMMMM(locale).format(DateTime(year, safeMonth));
  }

  bool get hasRevenueMoney =>
      revenueInclVatMinor != 0 ||
      revenueExclVatMinor != 0 ||
      costMinor != 0 ||
      profitMinor != 0;
}

/// When a printed or paid order counts for a month.
///
/// [PrintOrder.revenueAt] is set the first time stock is taken. Older orders
/// that have no stamp use [PrintOrder.updatedAt], then [PrintOrder.createdAt].
String revenueRecognizedAt(PrintOrder order) {
  if (order.revenueAt.isNotEmpty) {
    return order.revenueAt;
  }
  if (order.updatedAt.isNotEmpty) {
    return order.updatedAt;
  }
  return order.createdAt;
}

/// Month figures for printed and paid orders, plus the live pipeline.
///
/// Revenue, cost, profit, customers, and products use the selected month.
/// A dated deposit counts in the month it was received. The rest of a
/// printed or paid order counts in the month the work was first finished, so
/// a deposit and the final payment can fall in different months. An order
/// with no deposit date keeps its whole total in the finish month. Cost is
/// split in that same proportion, so each month's profit uses the cost that
/// belongs to the revenue counted there. Customer and product totals use
/// those same amounts. Filament grams stay on the finish month.
///
/// Pipeline, open deposits, and overdue quotes are everything still open, so
/// an empty month can still show work that is not finished. Profit is the
/// month's revenue excl. VAT minus the cost attributed to that month.
DashboardSnapshot buildDashboard({
  required List<PrintOrder> orders,
  required List<FilamentSpool> spools,
  required int year,
  required int month,
  Map<String, String> customerNames = const {},
  Map<String, String> productNames = const {},
  double workshopLowStockGrams = 100,
  InstantLocal toLocal = _deviceLocal,
  DateTime? now,
  AppLocalizations? l10n,
}) {
  final strings = l10n ?? activeGramnotaL10n;
  final today = now ?? DateTime.now();
  var overdueCount = 0;
  final materials = <String, _GramBucket>{};
  final customers = <String, _MoneyBucket>{};
  final products = <String, _MoneyBucket>{};
  final rows = <DashboardOrderRow>[];
  final currencies = <String, _CurrencyAccum>{};

  _CurrencyAccum accumFor(PrintOrder order) {
    final code = normalizeCurrencyCode(order.currencyCode);
    return currencies.putIfAbsent(code, () => _CurrencyAccum(code));
  }

  for (final order in orders) {
    final accum = accumFor(order);
    if (quoteIsExpired(order, today)) {
      overdueCount += 1;
    }
    if (statusIsPipeline(order.status)) {
      accum.pipelineCount += 1;
      accum.pipelineIncl += order.breakdown.totalMinor;
    }
    if (_holdsOpenDeposit(order)) {
      final depositMinor = order.depositMinor < 0 ? 0 : order.depositMinor;
      accum.openDeposit += depositMinor;
    }
    final deposit = recognizedDepositMinor(order);
    final totalForShare = order.breakdown.totalMinor;
    final netForShare = order.breakdown.netMinor;
    final costForShare = order.breakdown.costMinor;
    final sharedNet = _shareMinor(netForShare, deposit, totalForShare);
    final depositNet = sharedNet > netForShare ? netForShare : sharedNet;
    final counts = statusCountsAsRevenue(order.status);
    final depositInMonth =
        deposit > 0 && _inMonth(order.depositAt, year, month, toLocal);
    final finishInMonth =
        counts && _inMonth(revenueRecognizedAt(order), year, month, toLocal);
    if (depositInMonth) {
      accum.depositsReceived += deposit;
      accum.incl += deposit;
      accum.excl += depositNet;
    }
    if (counts) {
      accum.cost += _monthPortion(
        amount: costForShare,
        deposit: deposit,
        whole: totalForShare,
        depositInMonth: depositInMonth,
        finishInMonth: finishInMonth,
      );
    }
    if (!depositInMonth && !finishInMonth) {
      continue;
    }
    final customerLabel = _customerLabel(
      order.customerId,
      customerNames,
      strings,
    );
    if (finishInMonth) {
      final remainder = totalForShare - deposit;
      final remainderNet = netForShare - depositNet;
      accum.orderCount += 1;
      accum.incl += remainder;
      accum.excl += remainderNet;
      accum.finalPayments += remainder;
      rows.add(
        DashboardOrderRow(
          id: order.id,
          title: order.title.trim().isEmpty
              ? strings.dashUntitled
              : order.title.trim(),
          status: order.status,
          totalMinor: remainder,
          customerLabel: customerLabel,
          currencyCode: accum.currencyCode,
        ),
      );
    }
    _addCustomer(
      customers,
      order,
      customerLabel,
      accum.currencyCode,
      _monthPortion(
        amount: totalForShare,
        deposit: deposit,
        whole: totalForShare,
        depositInMonth: depositInMonth,
        finishInMonth: finishInMonth,
      ),
    );
    for (final line in orderPrints(order)) {
      _addProduct(
        products,
        line,
        order.title,
        productNames,
        accum.currencyCode,
        strings,
        _monthPortion(
          amount: line.breakdown.totalMinor,
          deposit: deposit,
          whole: totalForShare,
          depositInMonth: depositInMonth,
          finishInMonth: finishInMonth,
        ),
      );
      if (!finishInMonth) {
        continue;
      }
      for (final usage in line.filaments) {
        final grams = usage.grams * line.quantity;
        if (grams <= 0) {
          continue;
        }
        final label = _materialLabel(usage.material, strings);
        final key = label.toLowerCase();
        final bucket = materials.putIfAbsent(key, () => _GramBucket(label));
        bucket.grams += grams;
      }
    }
  }

  rows.sort((a, b) => b.totalMinor.compareTo(a.totalMinor));
  final materialRows = [
    for (final bucket in materials.values)
      DashboardMaterial(material: bucket.label, grams: bucket.grams),
  ]..sort((a, b) => b.grams.compareTo(a.grams));

  final currencyTotals = [
    for (final accum in currencies.values) accum.toTotals(),
  ]..sort((a, b) => a.currencyCode.compareTo(b.currencyCode));
  // Scalar fields stay the single-currency totals. Mixed months keep those
  // fields on the first currency only; [currencyTotals] has every currency.
  final primary = currencyTotals.isEmpty ? null : currencyTotals.first;

  return DashboardSnapshot(
    year: year,
    month: month,
    orderCount: currencyTotals.fold<int>(
      0,
      (sum, item) => sum + item.orderCount,
    ),
    revenueInclVatMinor: primary?.revenueInclVatMinor ?? 0,
    revenueExclVatMinor: primary?.revenueExclVatMinor ?? 0,
    costMinor: primary?.costMinor ?? 0,
    profitMinor: primary?.profitMinor ?? 0,
    pipelineOrderCount: currencyTotals.fold(
      0,
      (sum, item) => sum + item.pipelineOrderCount,
    ),
    pipelineInclVatMinor: primary?.pipelineInclVatMinor ?? 0,
    openDepositMinor: primary?.openDepositMinor ?? 0,
    depositsReceivedMinor: primary?.depositsReceivedMinor ?? 0,
    finalPaymentsMinor: primary?.finalPaymentsMinor ?? 0,
    overdueCount: overdueCount,
    materials: materialRows,
    topCustomers: _topMoney(customers),
    topProducts: _topMoney(products),
    revenueOrders: rows,
    lowSpools: lowSpoolNotices(spools, workshopLowStockGrams, l10n: strings),
    currencyTotals: currencyTotals,
  );
}

List<LowSpoolNotice> lowSpoolNotices(
  List<FilamentSpool> spools,
  double workshopLowStockGrams, {
  AppLocalizations? l10n,
}) {
  final strings = l10n ?? activeGramnotaL10n;
  final notices = <LowSpoolNotice>[];
  for (final spool in spools) {
    if (!spool.isLowAt(workshopLowStockGrams)) {
      continue;
    }
    final label = '${spool.brand} ${spool.material}'.trim();
    notices.add(
      LowSpoolNotice(
        id: spool.id,
        label: label.isEmpty ? strings.dashSpool : label,
        remainingGrams: spool.remainingGrams,
        thresholdGrams: spool.lowStockThreshold(workshopLowStockGrams),
      ),
    );
  }
  notices.sort((a, b) => a.remainingGrams.compareTo(b.remainingGrams));
  return notices;
}

/// Deposit cash that Home can place in [PrintOrder.depositAt]'s month.
///
/// Declined and cancelled orders contribute nothing. A missing date keeps
/// the old behaviour: the whole total stays in the finish month. A deposit
/// larger than the quote is capped at the total.
int recognizedDepositMinor(PrintOrder order) {
  if (order.status == OrderStatus.declined ||
      order.status == OrderStatus.cancelled) {
    return 0;
  }
  if (order.depositAt.trim().isEmpty) {
    return 0;
  }
  final total = order.breakdown.totalMinor;
  if (total <= 0) {
    return 0;
  }
  final deposit = order.depositMinor < 0 ? 0 : order.depositMinor;
  if (deposit > total) {
    return total;
  }
  return deposit;
}

/// The part of [amount] that belongs to this month.
///
/// A dated deposit takes the same share as the cash. The finish month
/// takes the rest. Both months together add back to [amount].
int _monthPortion({
  required int amount,
  required int deposit,
  required int whole,
  required bool depositInMonth,
  required bool finishInMonth,
}) {
  if (!depositInMonth && !finishInMonth) {
    return 0;
  }
  final depositPart = deposit <= 0 ? 0 : _shareMinor(amount, deposit, whole);
  final capped = depositPart > amount ? amount : depositPart;
  var sum = 0;
  if (depositInMonth) {
    sum += capped;
  }
  if (finishInMonth) {
    sum += amount - capped;
  }
  return sum;
}

int _shareMinor(int amount, int part, int whole) {
  if (amount <= 0 || part <= 0 || whole <= 0) {
    return 0;
  }
  if (part >= whole) {
    return amount;
  }
  return ((amount * part) + whole ~/ 2) ~/ whole;
}

bool _holdsOpenDeposit(PrintOrder order) {
  if (order.depositMinor <= 0) {
    return false;
  }
  return order.status == OrderStatus.quote ||
      order.status == OrderStatus.sent ||
      order.status == OrderStatus.accepted ||
      order.status == OrderStatus.printed;
}

bool _inMonth(String iso, int year, int month, InstantLocal toLocal) {
  final parsed = DateTime.tryParse(iso);
  if (parsed == null) {
    return false;
  }
  final local = toLocal(parsed);
  return local.year == year && local.month == month;
}

String _customerLabel(
  String customerId,
  Map<String, String> names,
  AppLocalizations l10n,
) {
  if (customerId.isEmpty) {
    return l10n.noCustomer;
  }
  final name = names[customerId]?.trim() ?? '';
  return name.isEmpty ? l10n.dashCustomer : name;
}

void _addCustomer(
  Map<String, _MoneyBucket> buckets,
  PrintOrder order,
  String label,
  String currencyCode,
  int amountMinor,
) {
  final id = order.customerId.isEmpty ? '' : order.customerId;
  final key = '$currencyCode:$id';
  final bucket = buckets.putIfAbsent(
    key,
    () => _MoneyBucket(id, label, currencyCode),
  );
  bucket.totalMinor += amountMinor;
  bucket.count += 1;
}

void _addProduct(
  Map<String, _MoneyBucket> buckets,
  QuoteLine line,
  String fallback,
  Map<String, String> productNames,
  String currencyCode,
  AppLocalizations l10n,
  int amountMinor,
) {
  final title = line.title.trim().isEmpty ? fallback.trim() : line.title.trim();
  final titleLabel = title.isEmpty ? l10n.dashUntitled : title;
  final productId = line.productId.trim();
  final catalog = productId.isEmpty
      ? ''
      : (productNames[productId]?.trim() ?? '');
  final label = catalog.isEmpty ? titleLabel : catalog;
  final key = productId.isEmpty
      ? '$currencyCode:title:${titleLabel.toLowerCase()}'
      : '$currencyCode:product:$productId';
  final bucket = buckets.putIfAbsent(
    key,
    () => _MoneyBucket(key, label, currencyCode),
  );
  if (catalog.isNotEmpty) {
    bucket.label = catalog;
  }
  bucket.totalMinor += amountMinor;
  bucket.count += line.quantity < 1 ? 1 : line.quantity;
}

String _materialLabel(String material, AppLocalizations l10n) {
  final trimmed = material.trim();
  return trimmed.isEmpty ? l10n.dashUnspecified : trimmed;
}

List<DashboardRank> _topMoney(Map<String, _MoneyBucket> buckets) {
  final ranks =
      [
        for (final bucket in buckets.values)
          DashboardRank(
            id: bucket.id,
            label: bucket.label,
            totalMinor: bucket.totalMinor,
            count: bucket.count,
            currencyCode: bucket.currencyCode,
          ),
      ]..sort((a, b) {
        final money = b.totalMinor.compareTo(a.totalMinor);
        if (money != 0) {
          return money;
        }
        return a.label.compareTo(b.label);
      });
  if (ranks.length <= 5) {
    return ranks;
  }
  return ranks.sublist(0, 5);
}

class _GramBucket {
  _GramBucket(this.label);

  final String label;
  double grams = 0;
}

class _MoneyBucket {
  _MoneyBucket(this.id, this.label, this.currencyCode);

  final String id;
  final String currencyCode;
  String label;
  int totalMinor = 0;
  int count = 0;
}

class _CurrencyAccum {
  _CurrencyAccum(this.currencyCode);

  final String currencyCode;
  int orderCount = 0;
  int incl = 0;
  int excl = 0;
  int cost = 0;
  int pipelineCount = 0;
  int pipelineIncl = 0;
  int openDeposit = 0;
  int depositsReceived = 0;
  int finalPayments = 0;

  CurrencyTotals toTotals() {
    return CurrencyTotals(
      currencyCode: currencyCode,
      orderCount: orderCount,
      revenueInclVatMinor: incl,
      revenueExclVatMinor: excl,
      costMinor: cost,
      profitMinor: excl - cost,
      pipelineOrderCount: pipelineCount,
      pipelineInclVatMinor: pipelineIncl,
      openDepositMinor: openDeposit,
      depositsReceivedMinor: depositsReceived,
      finalPaymentsMinor: finalPayments,
    );
  }
}
