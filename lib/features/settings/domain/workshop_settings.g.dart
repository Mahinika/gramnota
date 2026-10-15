// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workshop_settings.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_WorkshopSettings _$WorkshopSettingsFromJson(Map<String, dynamic> json) =>
    _WorkshopSettings(
      currencyCode: json['currencyCode'] as String? ?? 'SEK',
      electricityMinorPerKwh:
          (json['electricityMinorPerKwh'] as num?)?.toInt() ?? 0,
      laborMinorPerHour: (json['laborMinorPerHour'] as num?)?.toInt() ?? 0,
      defaultMarkupBasisPoints:
          (json['defaultMarkupBasisPoints'] as num?)?.toInt() ?? 3000,
      vatBasisPoints: (json['vatBasisPoints'] as num?)?.toInt() ?? 2500,
      defaultFailureBasisPoints:
          (json['defaultFailureBasisPoints'] as num?)?.toInt() ?? 0,
      businessName: json['businessName'] as String? ?? '',
      street: json['street'] as String? ?? '',
      postalCode: json['postalCode'] as String? ?? '',
      city: json['city'] as String? ?? '',
      orgNumber: json['orgNumber'] as String? ?? '',
      phone: json['phone'] as String? ?? '',
      email: json['email'] as String? ?? '',
      nextQuoteNumber: (json['nextQuoteNumber'] as num?)?.toInt() ?? 1,
      quoteValidityDays: (json['quoteValidityDays'] as num?)?.toInt() ?? 14,
    );

Map<String, dynamic> _$WorkshopSettingsToJson(_WorkshopSettings instance) =>
    <String, dynamic>{
      'currencyCode': instance.currencyCode,
      'electricityMinorPerKwh': instance.electricityMinorPerKwh,
      'laborMinorPerHour': instance.laborMinorPerHour,
      'defaultMarkupBasisPoints': instance.defaultMarkupBasisPoints,
      'vatBasisPoints': instance.vatBasisPoints,
      'defaultFailureBasisPoints': instance.defaultFailureBasisPoints,
      'businessName': instance.businessName,
      'street': instance.street,
      'postalCode': instance.postalCode,
      'city': instance.city,
      'orgNumber': instance.orgNumber,
      'phone': instance.phone,
      'email': instance.email,
      'nextQuoteNumber': instance.nextQuoteNumber,
      'quoteValidityDays': instance.quoteValidityDays,
    };
