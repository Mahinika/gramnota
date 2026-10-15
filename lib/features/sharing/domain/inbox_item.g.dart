// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'inbox_item.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_InboxItem _$InboxItemFromJson(Map<String, dynamic> json) => _InboxItem(
  id: json['id'] as String,
  type: $enumDecode(_$SharedItemTypeEnumMap, json['type']),
  payloadJson: json['payloadJson'] as String,
  senderUid: json['senderUid'] as String,
  senderName: json['senderName'] as String,
  senderEmail: json['senderEmail'] as String,
  createdAt: json['createdAt'] as String,
);

Map<String, dynamic> _$InboxItemToJson(_InboxItem instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$SharedItemTypeEnumMap[instance.type]!,
      'payloadJson': instance.payloadJson,
      'senderUid': instance.senderUid,
      'senderName': instance.senderName,
      'senderEmail': instance.senderEmail,
      'createdAt': instance.createdAt,
    };

const _$SharedItemTypeEnumMap = {
  SharedItemType.filament: 'filament',
  SharedItemType.customer: 'customer',
  SharedItemType.printer: 'printer',
  SharedItemType.order: 'order',
};
