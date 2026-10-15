// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'printer_profile.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_PrinterProfile _$PrinterProfileFromJson(Map<String, dynamic> json) =>
    _PrinterProfile(
      id: json['id'] as String,
      name: json['name'] as String,
      powerWatts: (json['powerWatts'] as num?)?.toInt() ?? 0,
      purchasePriceMinor: (json['purchasePriceMinor'] as num?)?.toInt() ?? 0,
      lifetimeHours: (json['lifetimeHours'] as num?)?.toDouble() ?? 0,
      maintenanceMinorPerHour:
          (json['maintenanceMinorPerHour'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$PrinterProfileToJson(_PrinterProfile instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'powerWatts': instance.powerWatts,
      'purchasePriceMinor': instance.purchasePriceMinor,
      'lifetimeHours': instance.lifetimeHours,
      'maintenanceMinorPerHour': instance.maintenanceMinorPerHour,
    };
