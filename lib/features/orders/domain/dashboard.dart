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
  });

  final String id;
  final String label;
  final int totalMinor;
  final int count;
}

class DashboardOrderRow {
  const DashboardOrderRow({
    required this.id,
    required this.title,
    required this.status,
    required this.totalMinor,
    required this.customerLabel,
  });

  final String id;
  final String title;
  final OrderStatus status;
  final int totalMinor;
  final String customerLabel;
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
    required this.materials,
    required this.topCustomers,
    required this.topProducts,
    required this.revenueOrders,
    required this.lowSpools,
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
  final List<DashboardMaterial> materials;
  final List<DashboardRank> topCustomers;
  final List<DashboardRank> topProducts;
  final List<DashboardOrderRow> revenueOrders;
  final List<LowSpoolNotice> lowSpools;

  String get monthLabel {
    final index = month < 1 || month > 12 ? 0 : month - 1;
    return '${dashboardMonthNames[index]} $year';
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
/// Revenue, cost, profit, filament, customers, and products use the selected
/// month. Pipeline and open deposits are everything still open, so an empty
/// month can still show work that is not finished. Profit is revenue excl.
/// VAT minus cost.
DashboardSnapshot buildDashboard({
  required List<PrintOrder> orders,
  required List<FilamentSpool> spools,
  required int year,
  required int month,
  Map<String, String> customerNames = const {},
  double workshopLowStockGrams = 100,
  InstantLocal toLocal = _deviceLocal,
}) {
  var orderCount = 0;
  var incl = 0;
  var excl = 0;
  var cost = 0;
  var pipelineCount = 0;
  var pipelineIncl = 0;
  var openDeposit = 0;
  final materials = <String, _GramBucket>{};
  final customers = <String, _MoneyBucket>{};
  final products = <String, _MoneyBucket>{};
  final rows = <DashboardOrderRow>[];

  for (final order in orders) {
    if (statusIsPipeline(order.status)) {
      pipelineCount += 1;
      pipelineIncl += order.breakdown.totalMinor;
    }
    if (_holdsOpenDeposit(order)) {
      openDeposit += order.depositMinor < 0 ? 0 : order.depositMinor;
    }
    if (!statusCountsAsRevenue(order.status)) {
      continue;
    }
    if (!_inMonth(revenueRecognizedAt(order), year, month, toLocal)) {
      continue;
    }
    orderCount += 1;
    incl += order.breakdown.totalMinor;
    excl += order.breakdown.netMinor;
    cost += order.breakdown.costMinor;
    final customerLabel = _customerLabel(order.customerId, customerNames);
    rows.add(
      DashboardOrderRow(
        id: order.id,
        title: order.title.trim().isEmpty ? 'Untitled' : order.title.trim(),
        status: order.status,
        totalMinor: order.breakdown.totalMinor,
        customerLabel: customerLabel,
      ),
    );
    _addCustomer(customers, order, customerLabel);
    for (final line in orderPrints(order)) {
      _addProduct(products, line, order.title);
      for (final usage in line.filaments) {
        final grams = usage.grams * line.quantity;
        if (grams <= 0) {
          continue;
        }
        final label = _materialLabel(usage.material);
        final key = label.toLowerCase();
        final bucket = materials.putIfAbsent(
          key,
          () => _GramBucket(label),
        );
        bucket.grams += grams;
      }
    }
  }

  rows.sort((a, b) => b.totalMinor.compareTo(a.totalMinor));
  final materialRows = [
    for (final bucket in materials.values)
      DashboardMaterial(material: bucket.label, grams: bucket.grams),
  ]..sort((a, b) => b.grams.compareTo(a.grams));

  return DashboardSnapshot(
    year: year,
    month: month,
    orderCount: orderCount,
    revenueInclVatMinor: incl,
    revenueExclVatMinor: excl,
    costMinor: cost,
    profitMinor: excl - cost,
    pipelineOrderCount: pipelineCount,
    pipelineInclVatMinor: pipelineIncl,
    openDepositMinor: openDeposit,
    materials: materialRows,
    topCustomers: _topMoney(customers),
    topProducts: _topMoney(products),
    revenueOrders: rows,
    lowSpools: lowSpoolNotices(spools, workshopLowStockGrams),
  );
}

List<LowSpoolNotice> lowSpoolNotices(
  List<FilamentSpool> spools,
  double workshopLowStockGrams,
) {
  final notices = <LowSpoolNotice>[];
  for (final spool in spools) {
    if (!spool.isLowAt(workshopLowStockGrams)) {
      continue;
    }
    final label = '${spool.brand} ${spool.material}'.trim();
    notices.add(
      LowSpoolNotice(
        id: spool.id,
        label: label.isEmpty ? 'Spool' : label,
        remainingGrams: spool.remainingGrams,
        thresholdGrams: spool.lowStockThreshold(workshopLowStockGrams),
      ),
    );
  }
  notices.sort((a, b) => a.remainingGrams.compareTo(b.remainingGrams));
  return notices;
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

String _customerLabel(String customerId, Map<String, String> names) {
  if (customerId.isEmpty) {
    return 'No customer';
  }
  final name = names[customerId]?.trim() ?? '';
  return name.isEmpty ? 'Customer' : name;
}

void _addCustomer(
  Map<String, _MoneyBucket> buckets,
  PrintOrder order,
  String label,
) {
  final key = order.customerId.isEmpty ? '' : order.customerId;
  final bucket = buckets.putIfAbsent(key, () => _MoneyBucket(key, label));
  bucket.totalMinor += order.breakdown.totalMinor;
  bucket.count += 1;
}

void _addProduct(Map<String, _MoneyBucket> buckets, QuoteLine line, String fallback) {
  final title = line.title.trim().isEmpty ? fallback.trim() : line.title.trim();
  final label = title.isEmpty ? 'Untitled' : title;
  final key = label.toLowerCase();
  final bucket = buckets.putIfAbsent(key, () => _MoneyBucket(key, label));
  bucket.totalMinor += line.breakdown.totalMinor;
  bucket.count += line.quantity < 1 ? 1 : line.quantity;
}

String _materialLabel(String material) {
  final trimmed = material.trim();
  return trimmed.isEmpty ? 'Unspecified' : trimmed;
}

List<DashboardRank> _topMoney(Map<String, _MoneyBucket> buckets) {
  final ranks = [
    for (final bucket in buckets.values)
      DashboardRank(
        id: bucket.id,
        label: bucket.label,
        totalMinor: bucket.totalMinor,
        count: bucket.count,
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
  _MoneyBucket(this.id, this.label);

  final String id;
  final String label;
  int totalMinor = 0;
  int count = 0;
}
