// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'catalog_product.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_CatalogProduct _$CatalogProductFromJson(Map<String, dynamic> json) =>
    _CatalogProduct(
      id: json['id'] as String,
      name: json['name'] as String,
      printerId: json['printerId'] as String? ?? '',
      printTimeSeconds: (json['printTimeSeconds'] as num?)?.toInt() ?? 0,
      filaments:
          (json['filaments'] as List<dynamic>?)
              ?.map((e) => FilamentUsage.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <FilamentUsage>[],
      prepMinutes: (json['prepMinutes'] as num?)?.toInt() ?? 0,
      postMinutes: (json['postMinutes'] as num?)?.toInt() ?? 0,
      extras:
          (json['extras'] as List<dynamic>?)
              ?.map((e) => ExtraCost.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <ExtraCost>[],
      markupBasisPoints: (json['markupBasisPoints'] as num?)?.toInt() ?? 3000,
      failureBasisPoints: (json['failureBasisPoints'] as num?)?.toInt() ?? 0,
      vatBasisPoints: (json['vatBasisPoints'] as num?)?.toInt() ?? 2500,
      sourceUrl: json['sourceUrl'] as String? ?? '',
      notes: json['notes'] as String? ?? '',
      createdAt: json['createdAt'] as String? ?? '',
      updatedAt: json['updatedAt'] as String? ?? '',
    );

Map<String, dynamic> _$CatalogProductToJson(_CatalogProduct instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'printerId': instance.printerId,
      'printTimeSeconds': instance.printTimeSeconds,
      'filaments': instance.filaments.map((e) => e.toJson()).toList(),
      'prepMinutes': instance.prepMinutes,
      'postMinutes': instance.postMinutes,
      'extras': instance.extras.map((e) => e.toJson()).toList(),
      'markupBasisPoints': instance.markupBasisPoints,
      'failureBasisPoints': instance.failureBasisPoints,
      'vatBasisPoints': instance.vatBasisPoints,
      'sourceUrl': instance.sourceUrl,
      'notes': instance.notes,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };
