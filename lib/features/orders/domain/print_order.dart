import 'package:freezed_annotation/freezed_annotation.dart';

import '../../pricing/domain/price_breakdown.dart';

part 'print_order.freezed.dart';
part 'print_order.g.dart';

enum OrderStatus { quote, sent, accepted, printed, paid, declined, cancelled }

/// Printed and Paid have already consumed filament. Sent, Accepted, Quote,
/// Declined, and Cancelled have not.
bool statusHoldsStock(OrderStatus status) =>
    status == OrderStatus.printed || status == OrderStatus.paid;

/// Printed and Paid are finished work and count as revenue for the month
/// they were first marked printed.
bool statusCountsAsRevenue(OrderStatus status) => statusHoldsStock(status);

/// Sent and Accepted are promised work that is not revenue yet.
bool statusIsPipeline(OrderStatus status) =>
    status == OrderStatus.sent || status == OrderStatus.accepted;

bool statusIsInProgress(OrderStatus status) =>
    status == OrderStatus.quote ||
    status == OrderStatus.sent ||
    status == OrderStatus.accepted ||
    status == OrderStatus.printed;

/// Reads a stored status. `delivered` from older orders becomes Paid.
/// Anything else unknown stays a Quote so the order is not dropped.
OrderStatus orderStatusFromJson(Object? raw) {
  final value = raw is String ? raw.trim().toLowerCase() : '';
  return switch (value) {
    'sent' => OrderStatus.sent,
    'accepted' => OrderStatus.accepted,
    'printed' => OrderStatus.printed,
    'paid' => OrderStatus.paid,
    'delivered' => OrderStatus.paid,
    'declined' => OrderStatus.declined,
    'cancelled' || 'canceled' => OrderStatus.cancelled,
    _ => OrderStatus.quote,
  };
}

String orderStatusToJson(OrderStatus status) => status.name;

String orderStatusLabel(OrderStatus status) => switch (status) {
  OrderStatus.quote => 'Quote',
  OrderStatus.sent => 'Sent',
  OrderStatus.accepted => 'Accepted',
  OrderStatus.printed => 'Printed',
  OrderStatus.paid => 'Paid',
  OrderStatus.declined => 'Declined',
  OrderStatus.cancelled => 'Cancelled',
};

const stockRuleSummary =
    'Filament is taken once, when the order is marked Printed or Paid. '
    'Moving from Printed to Paid does not take it again. '
    'Cancelling, declining, or moving the order back before Printed puts the taken grams back on the spool.';

const stockTakenOnPrintExplanation =
    'Marking this order Printed or Paid takes filament off the spool once. '
    'A later change between Printed and Paid does not take filament again. '
    'If the spool is short, only what is left is taken and the order keeps a warning.';

const stockReturnedOnCloseExplanation =
    'Cancelling or declining returns the filament that was taken for this order back onto the spool. '
    'Only the grams that were actually deducted are returned, including when the spool was short.';

const stockReturnedOnRevertExplanation =
    'Moving this order back before Printed returns the filament that was taken onto the spool. '
    'Only the grams that were actually deducted are returned.';

const stockStaysDeductedExplanation =
    'Printed and Paid both keep the filament deducted. This change does not move stock.';

const printsLockedMessage =
    'This order has already taken filament from the spool. '
    'Move it back before Printed to change prints. The grams that were taken go back on the spool.';

/// What a status change does to filament, or null when stock does not move
/// and needs no extra explanation.
String? stockChangeExplanation(OrderStatus from, OrderStatus to) {
  if (from == to) {
    return null;
  }
  final fromHolds = statusHoldsStock(from);
  final toHolds = statusHoldsStock(to);
  if (!fromHolds && toHolds) {
    return stockTakenOnPrintExplanation;
  }
  if (fromHolds && !toHolds) {
    if (to == OrderStatus.cancelled || to == OrderStatus.declined) {
      return stockReturnedOnCloseExplanation;
    }
    return stockReturnedOnRevertExplanation;
  }
  if (fromHolds && toHolds) {
    return stockStaysDeductedExplanation;
  }
  return null;
}

/// A Quote or Sent order whose validity date is before [now]'s local day.
bool quoteIsExpired(PrintOrder order, DateTime now) {
  if (order.status != OrderStatus.quote && order.status != OrderStatus.sent) {
    return false;
  }
  final until = DateTime.tryParse(order.validUntil);
  if (until == null) {
    return false;
  }
  final local = until.toLocal();
  final end = DateTime(local.year, local.month, local.day);
  final today = DateTime(now.year, now.month, now.day);
  return end.isBefore(today);
}

@freezed
abstract class FilamentUsage with _$FilamentUsage {
  const factory FilamentUsage({
    @Default('') String filamentId,
    required double grams,
    @Default('') String material,
    @Default('') String colorHex,
  }) = _FilamentUsage;

  factory FilamentUsage.fromJson(Map<String, dynamic> json) =>
      _$FilamentUsageFromJson(json);
}

@freezed
abstract class ExtraCost with _$ExtraCost {
  const factory ExtraCost({required String name, required int costMinor}) =
      _ExtraCost;

  factory ExtraCost.fromJson(Map<String, dynamic> json) =>
      _$ExtraCostFromJson(json);
}

@freezed
abstract class QuoteLine with _$QuoteLine {
  const factory QuoteLine({
    required String id,
    required String title,
    required int quantity,
    @Default('') String printerId,
    required int printTimeSeconds,
    required List<FilamentUsage> filaments,
    @Default(0) int prepMinutes,
    @Default(0) int postMinutes,
    @Default([]) List<ExtraCost> extras,
    required int markupBasisPoints,
    required int failureBasisPoints,
    required int vatBasisPoints,
    required PriceBreakdown breakdown,
    @Default('') String sourceUrl,
    @Default('') String sourceModelTitle,
    @Default('') String sourceProfileTitle,
  }) = _QuoteLine;

  factory QuoteLine.fromJson(Map<String, dynamic> json) =>
      _$QuoteLineFromJson(json);
}

@freezed
abstract class PrintOrder with _$PrintOrder {
  const factory PrintOrder({
    required String id,
    required int quoteNumber,
    @Default('') String customerId,
    required String title,
    @JsonKey(fromJson: orderStatusFromJson, toJson: orderStatusToJson)
    required OrderStatus status,
    required String validUntil,
    required int quantity,
    @Default('') String printerId,
    required int printTimeSeconds,
    required List<FilamentUsage> filaments,
    @Default(0) int prepMinutes,
    @Default(0) int postMinutes,
    @Default([]) List<ExtraCost> extras,
    required int markupBasisPoints,
    required int failureBasisPoints,
    required int vatBasisPoints,
    required String currencyCode,
    required PriceBreakdown breakdown,
    @Default(false) bool stockDeducted,
    @Default(<String, double>{}) Map<String, double> deductedGrams,
    @Default('') String stockWarning,
    @Default(0) int depositMinor,
    @Default('') String revenueAt,
    @Default('') String sourceUrl,
    @Default('') String sourceModelTitle,
    @Default('') String sourceProfileTitle,
    @Default('') String note,
    @Default([]) List<QuoteLine> lines,
    required String createdAt,
    required String updatedAt,
  }) = _PrintOrder;

  factory PrintOrder.fromJson(Map<String, dynamic> json) =>
      _$PrintOrderFromJson(json);
}

/// Prints on a quote. An order saved before lines existed is one print.
List<QuoteLine> orderPrints(PrintOrder order) {
  if (order.lines.isNotEmpty) {
    return order.lines;
  }
  return [
    QuoteLine(
      id: order.id,
      title: order.title,
      quantity: order.quantity,
      printerId: order.printerId,
      printTimeSeconds: order.printTimeSeconds,
      filaments: order.filaments,
      prepMinutes: order.prepMinutes,
      postMinutes: order.postMinutes,
      extras: order.extras,
      markupBasisPoints: order.markupBasisPoints,
      failureBasisPoints: order.failureBasisPoints,
      vatBasisPoints: order.vatBasisPoints,
      breakdown: order.breakdown,
      sourceUrl: order.sourceUrl,
      sourceModelTitle: order.sourceModelTitle,
      sourceProfileTitle: order.sourceProfileTitle,
    ),
  ];
}

/// Keeps a quote title that still matches its prints in step with those prints.
String quoteTitleFor(PrintOrder order, List<QuoteLine> next) {
  if (next.isEmpty) {
    return order.title;
  }
  final current = orderPrints(order);
  final joined = current.map((line) => line.title).join(' + ');
  final followsLines =
      order.title == current.first.title || order.title == joined;
  if (!followsLines) {
    return order.title;
  }
  if (next.length == 1) {
    return next.single.title;
  }
  return next.map((line) => line.title).join(' + ');
}

/// Stores [lines] and the summed breakdown. One print is also mirrored onto
/// the older order fields. Several prints leave those filament fields empty.
PrintOrder orderWithPrints(PrintOrder order, List<QuoteLine> lines) {
  if (lines.isEmpty) {
    return order;
  }
  final breakdown = sumBreakdowns([
    for (final line in lines) line.breakdown,
  ]);
  final first = lines.first;
  if (lines.length == 1) {
    return order.copyWith(
      lines: lines,
      breakdown: breakdown,
      quantity: first.quantity,
      printerId: first.printerId,
      printTimeSeconds: first.printTimeSeconds,
      filaments: first.filaments,
      prepMinutes: first.prepMinutes,
      postMinutes: first.postMinutes,
      extras: first.extras,
      markupBasisPoints: first.markupBasisPoints,
      failureBasisPoints: first.failureBasisPoints,
      vatBasisPoints: first.vatBasisPoints,
      sourceUrl: first.sourceUrl,
      sourceModelTitle: first.sourceModelTitle,
      sourceProfileTitle: first.sourceProfileTitle,
    );
  }
  return order.copyWith(
    lines: lines,
    breakdown: breakdown,
    quantity: 1,
    printerId: '',
    printTimeSeconds: 0,
    filaments: const [],
    prepMinutes: 0,
    postMinutes: 0,
    extras: const [],
    markupBasisPoints: first.markupBasisPoints,
    failureBasisPoints: first.failureBasisPoints,
    vatBasisPoints: first.vatBasisPoints,
    sourceUrl: '',
    sourceModelTitle: '',
    sourceProfileTitle: '',
  );
}
