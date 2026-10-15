// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'customer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Customer _$CustomerFromJson(Map<String, dynamic> json) => _Customer(
  id: json['id'] as String,
  name: json['name'] as String,
  street: json['street'] as String? ?? '',
  postalCode: json['postalCode'] as String? ?? '',
  city: json['city'] as String? ?? '',
  country: json['country'] as String? ?? '',
  phone: json['phone'] as String? ?? '',
  email: json['email'] as String? ?? '',
  notes: json['notes'] as String? ?? '',
);

Map<String, dynamic> _$CustomerToJson(_Customer instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'street': instance.street,
  'postalCode': instance.postalCode,
  'city': instance.city,
  'country': instance.country,
  'phone': instance.phone,
  'email': instance.email,
  'notes': instance.notes,
};
