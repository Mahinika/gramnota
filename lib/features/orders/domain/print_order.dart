import 'package:freezed_annotation/freezed_annotation.dart';

import '../../pricing/domain/price_breakdown.dart';

part 'print_order.freezed.dart';
part 'print_order.g.dart';

enum OrderStatus { quote, accepted, printed, delivered, cancelled }

bool statusHoldsStock(OrderStatus status) =>
    status == OrderStatus.printed || status == OrderStatus.delivered;

String orderStatusLabel(OrderStatus status) {
  final name = status.name;
  return '${name[0].toUpperCase()}${name.substring(1)}';
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
    @Default('') String sourceUrl,
    @Default('') String sourceModelTitle,
    @Default('') String sourceProfileTitle,
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
