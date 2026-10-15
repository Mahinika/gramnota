// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'price_breakdown.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PriceBreakdown _$PriceBreakdownFromJson(Map<String, dynamic> json) =>
    _PriceBreakdown(
      materialMinor: (json['materialMinor'] as num).toInt(),
      electricityMinor: (json['electricityMinor'] as num).toInt(),
      machineMinor: (json['machineMinor'] as num).toInt(),
      failureMinor: (json['failureMinor'] as num).toInt(),
      laborMinor: (json['laborMinor'] as num).toInt(),
      extrasMinor: (json['extrasMinor'] as num).toInt(),
      costMinor: (json['costMinor'] as num).toInt(),
      markupMinor: (json['markupMinor'] as num).toInt(),
      netMinor: (json['netMinor'] as num).toInt(),
      vatMinor: (json['vatMinor'] as num).toInt(),
      totalMinor: (json['totalMinor'] as num).toInt(),
      perUnitMinor: (json['perUnitMinor'] as num).toInt(),
      quantity: (json['quantity'] as num).toInt(),
    );

Map<String, dynamic> _$PriceBreakdownToJson(_PriceBreakdown instance) =>
    <String, dynamic>{
      'materialMinor': instance.materialMinor,
      'electricityMinor': instance.electricityMinor,
      'machineMinor': instance.machineMinor,
      'failureMinor': instance.failureMinor,
      'laborMinor': instance.laborMinor,
      'extrasMinor': instance.extrasMinor,
      'costMinor': instance.costMinor,
      'markupMinor': instance.markupMinor,
      'netMinor': instance.netMinor,
      'vatMinor': instance.vatMinor,
      'totalMinor': instance.totalMinor,
      'perUnitMinor': instance.perUnitMinor,
      'quantity': instance.quantity,
    };
