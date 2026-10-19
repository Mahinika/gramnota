import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../core/currencies.dart';
import '../../../l10n/l10n.dart';
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

String orderStatusLabel(OrderStatus status, AppLocalizations l10n) =>
    switch (status) {
      OrderStatus.quote => l10n.statusQuote,
      OrderStatus.sent => l10n.statusSent,
      OrderStatus.accepted => l10n.statusAccepted,
      OrderStatus.printed => l10n.statusPrinted,
      OrderStatus.paid => l10n.statusPaid,
      OrderStatus.declined => l10n.statusDeclined,
      OrderStatus.cancelled => l10n.statusCancelled,
    };

String stockRuleSummary(AppLocalizations l10n) => l10n.stockRuleSummary;

String stockTakenOnPrintExplanation(AppLocalizations l10n) =>
    l10n.stockTakenOnPrint;

String stockReturnedOnCloseExplanation(AppLocalizations l10n) =>
    l10n.stockReturnedOnClose;

String stockReturnedOnRevertExplanation(AppLocalizations l10n) =>
    l10n.stockReturnedOnRevert;

String stockStaysDeductedExplanation(AppLocalizations l10n) =>
    l10n.stockStaysDeducted;

String printsLockedMessage(AppLocalizations l10n) => l10n.stockPrintsLocked;

/// What a status change does to filament, or null when stock does not move
/// and needs no extra explanation.
String? stockChangeExplanation(
  OrderStatus from,
  OrderStatus to,
  AppLocalizations l10n,
) {
  if (from == to) {
    return null;
  }
  final fromHolds = statusHoldsStock(from);
  final toHolds = statusHoldsStock(to);
  if (!fromHolds && toHolds) {
    return stockTakenOnPrintExplanation(l10n);
  }
  if (fromHolds && !toHolds) {
    if (to == OrderStatus.cancelled || to == OrderStatus.declined) {
      return stockReturnedOnCloseExplanation(l10n);
    }
    return stockReturnedOnRevertExplanation(l10n);
  }
  if (fromHolds && toHolds) {
    return stockStaysDeductedExplanation(l10n);
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

    /// Catalog product this print was taken from. Empty on older quotes and
    /// on prints that were never saved as a product. Home groups by this id
    /// so a renamed title still counts as the same product.
    @Default('') String productId,
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

    /// Missing on older orders. Those quotes stay in SEK. No conversion.
    @JsonKey(readValue: readCurrencyCode) @Default('SEK') String currencyCode,

    /// Customer PDF language. Empty follows the app language at preview time.
    @Default('') String quoteLanguage,
    required PriceBreakdown breakdown,
    @Default(false) bool stockDeducted,
    @Default(<String, double>{}) Map<String, double> deductedGrams,
    @Default('') String stockWarning,
    @Default(0) int depositMinor,

    /// When the deposit was received, as a UTC timestamp. Empty on older
    /// orders: Home then keeps the whole total in the print month.
    @Default('') String depositAt,
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
  final breakdown = sumBreakdowns([for (final line in lines) line.breakdown]);
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
