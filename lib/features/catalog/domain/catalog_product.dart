import 'package:freezed_annotation/freezed_annotation.dart';

import '../../orders/domain/print_order.dart';

part 'catalog_product.freezed.dart';
part 'catalog_product.g.dart';

/// A print that can be added to later quotes.
///
/// Money is not stored. Spool price, printer cost, electricity, and labor are
/// read again when the product is quoted. Markup, failure, and VAT stay on the
/// product because they are part of that print.
@freezed
abstract class CatalogProduct with _$CatalogProduct {
  const factory CatalogProduct({
    required String id,
    required String name,
    @Default('') String printerId,
    @Default(0) int printTimeSeconds,
    @Default(<FilamentUsage>[]) List<FilamentUsage> filaments,
    @Default(0) int prepMinutes,
    @Default(0) int postMinutes,
    @Default(<ExtraCost>[]) List<ExtraCost> extras,
    @Default(3000) int markupBasisPoints,
    @Default(0) int failureBasisPoints,
    @Default(2500) int vatBasisPoints,
    @Default('') String sourceUrl,
    @Default('') String notes,
    @Default('') String createdAt,
    @Default('') String updatedAt,
  }) = _CatalogProduct;

  factory CatalogProduct.fromJson(Map<String, dynamic> json) =>
      _$CatalogProductFromJson(json);
}
