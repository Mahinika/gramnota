import '../../filaments/domain/filament_spool.dart';
import '../../settings/domain/workshop_settings.dart';
import '../domain/print_order.dart';
import '../../../core/user_store.dart';

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
      final holdsNow = statusHoldsStock(order.status) && order.stockDeducted;
      final holdsNext = statusHoldsStock(next);
      var updated = order.copyWith(
        status: next,
        updatedAt: DateTime.now().toUtc().toIso8601String(),
      );
      var warning = '';

      if (!holdsNow && holdsNext) {
        final requested = <String, double>{};
        for (final line in orderPrints(order)) {
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
            shortfalls.add('${entry.value} g (missing spool)');
            continue;
          }
          final spool = FilamentSpool.fromJson({
            ...snapshot.data()!,
            'id': snapshot.id,
          });
          final take = entry.value > spool.remainingGrams
              ? spool.remainingGrams
              : entry.value;
          final short = entry.value - take;
          deducted[entry.key] = take;
          transaction.update(ref, {
            'remainingGrams': spool.remainingGrams - take,
          });
          if (short > 0.0001) {
            final label = '${spool.brand} ${spool.material}'.trim();
            shortfalls.add('${short.toStringAsFixed(1)} g of $label');
          }
        }
        warning = shortfalls.isEmpty
            ? ''
            : 'Stock was short: ${shortfalls.join(', ')}. Remaining was set to 0 g.';
        updated = updated.copyWith(
          stockDeducted: true,
          deductedGrams: deducted,
          stockWarning: warning,
        );
      } else if (holdsNow && !holdsNext) {
        for (final entry in order.deductedGrams.entries) {
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
        );
      }

      transaction.set(store.orders.doc(order.id), updated.toJson());
      return StockChange(order: updated, warning: warning);
    });
  }
}
