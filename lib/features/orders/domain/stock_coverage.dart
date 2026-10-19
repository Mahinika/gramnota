import '../../../core/format.dart';
import '../../filaments/domain/filament_spool.dart';
import 'print_order.dart';

class SpoolCoverage {
  const SpoolCoverage({
    required this.filamentId,
    required this.label,
    required this.neededGrams,
    required this.reservedGrams,
    required this.remainingGrams,
    required this.missingSpool,
  });

  final String filamentId;
  final String label;
  final double neededGrams;
  final double reservedGrams;
  final double remainingGrams;
  final bool missingSpool;

  double get committedGrams => neededGrams + reservedGrams;

  double get shortfallGrams {
    final short = committedGrams - remainingGrams;
    return short < 0 ? 0 : short;
  }

  bool get isShort => missingSpool || shortfallGrams > 0.0001;

  String get message {
    if (missingSpool) {
      return '$label needs ${formatGrams(neededGrams)} on this quote, but that spool is no longer in the workshop.';
    }
    final reserved = reservedGrams > 0.0001
        ? ' Another ${formatGrams(reservedGrams)} is reserved on accepted quotes.'
        : '';
    return '$label needs ${formatGrams(neededGrams)} for this quote.$reserved '
        '${formatGrams(remainingGrams)} is left, so it is short by ${formatGrams(shortfallGrams)} '
        'before this order is marked Printed.';
  }
}

/// Grams this quote needs, plus other Accepted quotes that have not taken stock yet.
///
/// Printed and Paid orders are already reflected in [FilamentSpool.remainingGrams].
/// Sent and Quote orders are not reserved.
List<SpoolCoverage> quoteSpoolCoverage({
  required PrintOrder order,
  required List<PrintOrder> orders,
  required List<FilamentSpool> spools,
}) {
  if (order.stockDeducted) {
    return const [];
  }
  final needed = _gramsBySpool(order);
  if (needed.isEmpty) {
    return const [];
  }
  final reserved = <String, double>{};
  for (final other in orders) {
    if (other.id == order.id || other.status != OrderStatus.accepted) {
      continue;
    }
    if (other.stockDeducted) {
      continue;
    }
    for (final entry in _gramsBySpool(other).entries) {
      reserved[entry.key] = (reserved[entry.key] ?? 0) + entry.value;
    }
  }
  final result = <SpoolCoverage>[];
  final ids = needed.keys.toList()..sort();
  for (final id in ids) {
    final grams = needed[id]!;
    if (grams <= 0.0001) {
      continue;
    }
    FilamentSpool? spool;
    for (final candidate in spools) {
      if (candidate.id == id) {
        spool = candidate;
      }
    }
    final label = spool == null
        ? 'A missing spool'
        : '${spool.brand} ${spool.material}'.trim();
    final remaining = spool == null
        ? 0.0
        : (spool.remainingGrams < 0 ? 0.0 : spool.remainingGrams);
    result.add(
      SpoolCoverage(
        filamentId: id,
        label: label.isEmpty ? 'Spool' : label,
        neededGrams: grams,
        reservedGrams: reserved[id] ?? 0,
        remainingGrams: remaining,
        missingSpool: spool == null,
      ),
    );
  }
  return result.where((item) => item.isShort).toList();
}

Map<String, double> _gramsBySpool(PrintOrder order) {
  final grams = <String, double>{};
  for (final line in orderPrints(order)) {
    for (final usage in line.filaments) {
      if (usage.filamentId.isEmpty || usage.grams <= 0) {
        continue;
      }
      grams[usage.filamentId] =
          (grams[usage.filamentId] ?? 0) + usage.grams * line.quantity;
    }
  }
  return grams;
}
