// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'inbox_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$InboxItem {

 String get id; SharedItemType get type; String get payloadJson; String get senderUid; String get senderName; String get senderEmail; String get createdAt;
/// Create a copy of InboxItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InboxItemCopyWith<InboxItem> get copyWith => _$InboxItemCopyWithImpl<InboxItem>(this as InboxItem, _$identity);

  /// Serializes this InboxItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InboxItem&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.payloadJson, payloadJson) || other.payloadJson == payloadJson)&&(identical(other.senderUid, senderUid) || other.senderUid == senderUid)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.senderEmail, senderEmail) || other.senderEmail == senderEmail)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,payloadJson,senderUid,senderName,senderEmail,createdAt);

@override
String toString() {
  return 'InboxItem(id: $id, type: $type, payloadJson: $payloadJson, senderUid: $senderUid, senderName: $senderName, senderEmail: $senderEmail, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $InboxItemCopyWith<$Res>  {
  factory $InboxItemCopyWith(InboxItem value, $Res Function(InboxItem) _then) = _$InboxItemCopyWithImpl;
@useResult
$Res call({
 String id, SharedItemType type, String payloadJson, String senderUid, String senderName, String senderEmail, String createdAt
});




}
/// @nodoc
class _$InboxItemCopyWithImpl<$Res>
    implements $InboxItemCopyWith<$Res> {
  _$InboxItemCopyWithImpl(this._self, this._then);

  final InboxItem _self;
  final $Res Function(InboxItem) _then;

/// Create a copy of InboxItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? type = null,Object? payloadJson = null,Object? senderUid = null,Object? senderName = null,Object? senderEmail = null,Object? createdAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SharedItemType,payloadJson: null == payloadJson ? _self.payloadJson : payloadJson // ignore: cast_nullable_to_non_nullable
as String,senderUid: null == senderUid ? _self.senderUid : senderUid // ignore: cast_nullable_to_non_nullable
as String,senderName: null == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String,senderEmail: null == senderEmail ? _self.senderEmail : senderEmail // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [InboxItem].
extension InboxItemPatterns on InboxItem {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _InboxItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _InboxItem() when $default != null:
return $default(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _InboxItem value)  $default,){
final _that = this;
switch (_that) {
case _InboxItem():
return $default(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _InboxItem value)?  $default,){
final _that = this;
switch (_that) {
case _InboxItem() when $default != null:
return $default(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  SharedItemType type,  String payloadJson,  String senderUid,  String senderName,  String senderEmail,  String createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _InboxItem() when $default != null:
return $default(_that.id,_that.type,_that.payloadJson,_that.senderUid,_that.senderName,_that.senderEmail,_that.createdAt);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  SharedItemType type,  String payloadJson,  String senderUid,  String senderName,  String senderEmail,  String createdAt)  $default,) {final _that = this;
switch (_that) {
case _InboxItem():
return $default(_that.id,_that.type,_that.payloadJson,_that.senderUid,_that.senderName,_that.senderEmail,_that.createdAt);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  SharedItemType type,  String payloadJson,  String senderUid,  String senderName,  String senderEmail,  String createdAt)?  $default,) {final _that = this;
switch (_that) {
case _InboxItem() when $default != null:
return $default(_that.id,_that.type,_that.payloadJson,_that.senderUid,_that.senderName,_that.senderEmail,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _InboxItem implements InboxItem {
  const _InboxItem({required this.id, required this.type, required this.payloadJson, required this.senderUid, required this.senderName, required this.senderEmail, required this.createdAt});
  factory _InboxItem.fromJson(Map<String, dynamic> json) => _$InboxItemFromJson(json);

@override final  String id;
@override final  SharedItemType type;
@override final  String payloadJson;
@override final  String senderUid;
@override final  String senderName;
@override final  String senderEmail;
@override final  String createdAt;

/// Create a copy of InboxItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$InboxItemCopyWith<_InboxItem> get copyWith => __$InboxItemCopyWithImpl<_InboxItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$InboxItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _InboxItem&&(identical(other.id, id) || other.id == id)&&(identical(other.type, type) || other.type == type)&&(identical(other.payloadJson, payloadJson) || other.payloadJson == payloadJson)&&(identical(other.senderUid, senderUid) || other.senderUid == senderUid)&&(identical(other.senderName, senderName) || other.senderName == senderName)&&(identical(other.senderEmail, senderEmail) || other.senderEmail == senderEmail)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,type,payloadJson,senderUid,senderName,senderEmail,createdAt);

@override
String toString() {
  return 'InboxItem(id: $id, type: $type, payloadJson: $payloadJson, senderUid: $senderUid, senderName: $senderName, senderEmail: $senderEmail, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$InboxItemCopyWith<$Res> implements $InboxItemCopyWith<$Res> {
  factory _$InboxItemCopyWith(_InboxItem value, $Res Function(_InboxItem) _then) = __$InboxItemCopyWithImpl;
@override @useResult
$Res call({
 String id, SharedItemType type, String payloadJson, String senderUid, String senderName, String senderEmail, String createdAt
});




}
/// @nodoc
class __$InboxItemCopyWithImpl<$Res>
    implements _$InboxItemCopyWith<$Res> {
  __$InboxItemCopyWithImpl(this._self, this._then);

  final _InboxItem _self;
  final $Res Function(_InboxItem) _then;

/// Create a copy of InboxItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? type = null,Object? payloadJson = null,Object? senderUid = null,Object? senderName = null,Object? senderEmail = null,Object? createdAt = null,}) {
  return _then(_InboxItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as SharedItemType,payloadJson: null == payloadJson ? _self.payloadJson : payloadJson // ignore: cast_nullable_to_non_nullable
as String,senderUid: null == senderUid ? _self.senderUid : senderUid // ignore: cast_nullable_to_non_nullable
as String,senderName: null == senderName ? _self.senderName : senderName // ignore: cast_nullable_to_non_nullable
as String,senderEmail: null == senderEmail ? _self.senderEmail : senderEmail // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
