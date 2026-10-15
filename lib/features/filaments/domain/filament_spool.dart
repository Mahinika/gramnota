import 'package:freezed_annotation/freezed_annotation.dart';

part 'filament_spool.freezed.dart';
part 'filament_spool.g.dart';

@freezed
abstract class FilamentSpool with _$FilamentSpool {
  const FilamentSpool._();

  const factory FilamentSpool({
    required String id,
    required String brand,
    required String material,
    @Default('#808080') String colorHex,
    @Default(1.75) double diameterMm,
    @Default(1000) double spoolWeightGrams,
    @Default(1000) double remainingGrams,
    @Default(0) int pricePerSpoolMinor,
    @Default(100) double lowStockGrams,
    @Default('') String notes,
  }) = _FilamentSpool;

  factory FilamentSpool.fromJson(Map<String, dynamic> json) =>
      _$FilamentSpoolFromJson(json);

  int get pricePerKgMinor {
    if (spoolWeightGrams <= 0) {
      return 0;
    }
    return (pricePerSpoolMinor / (spoolWeightGrams / 1000)).round();
  }

  bool get isLowStock => remainingGrams <= lowStockGrams;
}
