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
    required String createdAt,
    required String updatedAt,
  }) = _PrintOrder;

  factory PrintOrder.fromJson(Map<String, dynamic> json) =>
      _$PrintOrderFromJson(json);
}
