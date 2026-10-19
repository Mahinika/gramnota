import '../../../core/format.dart';
import '../../../core/user_store.dart';
import '../../filaments/domain/filament_spool.dart';
import '../../settings/domain/workshop_settings.dart';
import '../domain/print_order.dart';

class StockChange {
  const StockChange({required this.order, required this.warning});

  final PrintOrder order;
  final String warning;
}

class OrderStock {
  const OrderStock(this.store);

  final UserStore store;

  Future<int> allocateQuoteNumber() {
    return store.db.runTransaction((transaction) async {
      final snapshot = await transaction.get(store.settingsDoc);
      final settings = snapshot.exists && snapshot.data() != null
          ? WorkshopSettings.fromJson(snapshot.data()!)
          : const WorkshopSettings();
      final number = settings.nextQuoteNumber < 1 ? 1 : settings.nextQuoteNumber;
      transaction.set(
        store.settingsDoc,
        settings.copyWith(nextQuoteNumber: number + 1).toJson(),
      );
      return number;
    });
  }

  Future<StockChange> setStatus({
    required PrintOrder order,
    required OrderStatus next,
  }) {
    return store.db.runTransaction((transaction) async {
      final orderRef = store.orders.doc(order.id);
      final orderSnap = await transaction.get(orderRef);
      final current = orderSnap.exists && orderSnap.data() != null
          ? PrintOrder.fromJson({...orderSnap.data()!, 'id': order.id})
          : order;
      if (current.status == next) {
        return StockChange(order: current, warning: '');
      }
      final holdsNow = statusHoldsStock(current.status) && current.stockDeducted;
      final holdsNext = statusHoldsStock(next);
      final now = DateTime.now().toUtc().toIso8601String();
      var updated = current.copyWith(status: next, updatedAt: now);
      var warning = '';

      if (!holdsNow && holdsNext) {
        final requested = <String, double>{};
        for (final line in orderPrints(current)) {
          for (final usage in line.filaments) {
            if (usage.filamentId.isEmpty) {
              continue;
            }
            requested[usage.filamentId] =
                (requested[usage.filamentId] ?? 0) + usage.grams * line.quantity;
          }
        }
        final deducted = <String, double>{};
        final shortfalls = <String>[];
        for (final entry in requested.entries) {
          final ref = store.filaments.doc(entry.key);
          final snapshot = await transaction.get(ref);
          if (!snapshot.exists || snapshot.data() == null) {
            shortfalls.add('${formatGrams(entry.value)} (missing spool)');
            continue;
          }
          final spool = FilamentSpool.fromJson({
            ...snapshot.data()!,
            'id': snapshot.id,
          });
          final available = spool.remainingGrams < 0
              ? 0.0
              : spool.remainingGrams;
          final take = entry.value > available ? available : entry.value;
          final short = entry.value - take;
          deducted[entry.key] = take;
          final nextRemaining = available - take;
          if (nextRemaining != spool.remainingGrams) {
            transaction.update(ref, {'remainingGrams': nextRemaining});
          }
          if (short > 0.0001) {
            final label = '${spool.brand} ${spool.material}'.trim();
            shortfalls.add('${formatGrams(short)} of $label');
          }
        }
        warning = shortfalls.isEmpty
            ? ''
            : 'Stock was short: ${shortfalls.join(', ')}. Remaining was set to 0 g.';
        updated = updated.copyWith(
          stockDeducted: true,
          deductedGrams: deducted,
          stockWarning: warning,
          revenueAt: now,
        );
      } else if (holdsNow && !holdsNext) {
        for (final entry in current.deductedGrams.entries) {
          final ref = store.filaments.doc(entry.key);
          final snapshot = await transaction.get(ref);
          if (!snapshot.exists || snapshot.data() == null) {
            continue;
          }
          final spool = FilamentSpool.fromJson({
            ...snapshot.data()!,
            'id': snapshot.id,
          });
          transaction.update(ref, {
            'remainingGrams': spool.remainingGrams + entry.value,
          });
        }
        updated = updated.copyWith(
          stockDeducted: false,
          deductedGrams: const {},
          stockWarning: '',
          revenueAt: '',
        );
      } else if (holdsNow && holdsNext && current.revenueAt.isEmpty) {
        final prior = current.updatedAt.isNotEmpty
            ? current.updatedAt
            : current.createdAt;
        updated = updated.copyWith(revenueAt: prior);
      }

      transaction.set(orderRef, updated.toJson());
      return StockChange(order: updated, warning: warning);
    });
  }
}
