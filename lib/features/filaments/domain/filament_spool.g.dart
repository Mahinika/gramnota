// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'filament_spool.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FilamentSpool _$FilamentSpoolFromJson(Map<String, dynamic> json) =>
    _FilamentSpool(
      id: json['id'] as String,
      brand: json['brand'] as String,
      material: json['material'] as String,
      colorHex: json['colorHex'] as String? ?? '#808080',
      diameterMm: (json['diameterMm'] as num?)?.toDouble() ?? 1.75,
      spoolWeightGrams: (json['spoolWeightGrams'] as num?)?.toDouble() ?? 1000,
      remainingGrams: (json['remainingGrams'] as num?)?.toDouble() ?? 1000,
      pricePerSpoolMinor: (json['pricePerSpoolMinor'] as num?)?.toInt() ?? 0,
      lowStockGrams: (json['lowStockGrams'] as num?)?.toDouble() ?? 100,
      lowStockUsesDefault: json['lowStockUsesDefault'] as bool? ?? false,
      notes: json['notes'] as String? ?? '',
    );

Map<String, dynamic> _$FilamentSpoolToJson(_FilamentSpool instance) =>
    <String, dynamic>{
      'id': instance.id,
      'brand': instance.brand,
      'material': instance.material,
      'colorHex': instance.colorHex,
      'diameterMm': instance.diameterMm,
      'spoolWeightGrams': instance.spoolWeightGrams,
      'remainingGrams': instance.remainingGrams,
      'pricePerSpoolMinor': instance.pricePerSpoolMinor,
      'lowStockGrams': instance.lowStockGrams,
      'lowStockUsesDefault': instance.lowStockUsesDefault,
      'notes': instance.notes,
    };
