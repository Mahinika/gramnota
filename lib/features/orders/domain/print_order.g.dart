// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'print_order.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_FilamentUsage _$FilamentUsageFromJson(Map<String, dynamic> json) =>
    _FilamentUsage(
      filamentId: json['filamentId'] as String? ?? '',
      grams: (json['grams'] as num).toDouble(),
      material: json['material'] as String? ?? '',
      colorHex: json['colorHex'] as String? ?? '',
    );

Map<String, dynamic> _$FilamentUsageToJson(_FilamentUsage instance) =>
    <String, dynamic>{
      'filamentId': instance.filamentId,
      'grams': instance.grams,
      'material': instance.material,
      'colorHex': instance.colorHex,
    };

_ExtraCost _$ExtraCostFromJson(Map<String, dynamic> json) => _ExtraCost(
  name: json['name'] as String,
  costMinor: (json['costMinor'] as num).toInt(),
);

Map<String, dynamic> _$ExtraCostToJson(_ExtraCost instance) =>
    <String, dynamic>{'name': instance.name, 'costMinor': instance.costMinor};

_PrintOrder _$PrintOrderFromJson(Map<String, dynamic> json) => _PrintOrder(
  id: json['id'] as String,
  quoteNumber: (json['quoteNumber'] as num).toInt(),
  customerId: json['customerId'] as String? ?? '',
  title: json['title'] as String,
  status: $enumDecode(_$OrderStatusEnumMap, json['status']),
  validUntil: json['validUntil'] as String,
  quantity: (json['quantity'] as num).toInt(),
  printerId: json['printerId'] as String? ?? '',
  printTimeSeconds: (json['printTimeSeconds'] as num).toInt(),
  filaments: (json['filaments'] as List<dynamic>)
      .map((e) => FilamentUsage.fromJson(e as Map<String, dynamic>))
      .toList(),
  prepMinutes: (json['prepMinutes'] as num?)?.toInt() ?? 0,
  postMinutes: (json['postMinutes'] as num?)?.toInt() ?? 0,
  extras:
      (json['extras'] as List<dynamic>?)
          ?.map((e) => ExtraCost.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  markupBasisPoints: (json['markupBasisPoints'] as num).toInt(),
  failureBasisPoints: (json['failureBasisPoints'] as num).toInt(),
  vatBasisPoints: (json['vatBasisPoints'] as num).toInt(),
  currencyCode: json['currencyCode'] as String,
  breakdown: PriceBreakdown.fromJson(json['breakdown'] as Map<String, dynamic>),
  stockDeducted: json['stockDeducted'] as bool? ?? false,
  deductedGrams:
      (json['deductedGrams'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ) ??
      const <String, double>{},
  stockWarning: json['stockWarning'] as String? ?? '',
  sourceUrl: json['sourceUrl'] as String? ?? '',
  sourceModelTitle: json['sourceModelTitle'] as String? ?? '',
  sourceProfileTitle: json['sourceProfileTitle'] as String? ?? '',
  createdAt: json['createdAt'] as String,
  updatedAt: json['updatedAt'] as String,
);

Map<String, dynamic> _$PrintOrderToJson(_PrintOrder instance) =>
    <String, dynamic>{
      'id': instance.id,
      'quoteNumber': instance.quoteNumber,
      'customerId': instance.customerId,
      'title': instance.title,
      'status': _$OrderStatusEnumMap[instance.status]!,
      'validUntil': instance.validUntil,
      'quantity': instance.quantity,
      'printerId': instance.printerId,
      'printTimeSeconds': instance.printTimeSeconds,
      'filaments': instance.filaments.map((e) => e.toJson()).toList(),
      'prepMinutes': instance.prepMinutes,
      'postMinutes': instance.postMinutes,
      'extras': instance.extras.map((e) => e.toJson()).toList(),
      'markupBasisPoints': instance.markupBasisPoints,
      'failureBasisPoints': instance.failureBasisPoints,
      'vatBasisPoints': instance.vatBasisPoints,
      'currencyCode': instance.currencyCode,
      'breakdown': instance.breakdown.toJson(),
      'stockDeducted': instance.stockDeducted,
      'deductedGrams': instance.deductedGrams,
      'stockWarning': instance.stockWarning,
      'sourceUrl': instance.sourceUrl,
      'sourceModelTitle': instance.sourceModelTitle,
      'sourceProfileTitle': instance.sourceProfileTitle,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

const _$OrderStatusEnumMap = {
  OrderStatus.quote: 'quote',
  OrderStatus.accepted: 'accepted',
  OrderStatus.printed: 'printed',
  OrderStatus.delivered: 'delivered',
  OrderStatus.cancelled: 'cancelled',
};
