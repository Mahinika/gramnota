import 'package:freezed_annotation/freezed_annotation.dart';

part 'inbox_item.freezed.dart';
part 'inbox_item.g.dart';

enum SharedItemType { filament, customer, printer, order }

@freezed
abstract class InboxItem with _$InboxItem {
  const factory InboxItem({
    required String id,
    required SharedItemType type,
    required String payloadJson,
    required String senderUid,
    required String senderName,
    required String senderEmail,
    required String createdAt,
  }) = _InboxItem;

  factory InboxItem.fromJson(Map<String, dynamic> json) =>
      _$InboxItemFromJson(json);
}
