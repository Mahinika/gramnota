// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'catalog_product.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CatalogProduct {

 String get id; String get name; String get printerId; int get printTimeSeconds; List<FilamentUsage> get filaments; int get prepMinutes; int get postMinutes; List<ExtraCost> get extras; int get markupBasisPoints; int get failureBasisPoints; int get vatBasisPoints; String get sourceUrl; String get notes; String get createdAt; String get updatedAt;
/// Create a copy of CatalogProduct
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CatalogProductCopyWith<CatalogProduct> get copyWith => _$CatalogProductCopyWithImpl<CatalogProduct>(this as CatalogProduct, _$identity);

  /// Serializes this CatalogProduct to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CatalogProduct&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.printerId, printerId) || other.printerId == printerId)&&(identical(other.printTimeSeconds, printTimeSeconds) || other.printTimeSeconds == printTimeSeconds)&&const DeepCollectionEquality().equals(other.filaments, filaments)&&(identical(other.prepMinutes, prepMinutes) || other.prepMinutes == prepMinutes)&&(identical(other.postMinutes, postMinutes) || other.postMinutes == postMinutes)&&const DeepCollectionEquality().equals(other.extras, extras)&&(identical(other.markupBasisPoints, markupBasisPoints) || other.markupBasisPoints == markupBasisPoints)&&(identical(other.failureBasisPoints, failureBasisPoints) || other.failureBasisPoints == failureBasisPoints)&&(identical(other.vatBasisPoints, vatBasisPoints) || other.vatBasisPoints == vatBasisPoints)&&(identical(other.sourceUrl, sourceUrl) || other.sourceUrl == sourceUrl)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,printerId,printTimeSeconds,const DeepCollectionEquality().hash(filaments),prepMinutes,postMinutes,const DeepCollectionEquality().hash(extras),markupBasisPoints,failureBasisPoints,vatBasisPoints,sourceUrl,notes,createdAt,updatedAt);

@override
String toString() {
  return 'CatalogProduct(id: $id, name: $name, printerId: $printerId, printTimeSeconds: $printTimeSeconds, filaments: $filaments, prepMinutes: $prepMinutes, postMinutes: $postMinutes, extras: $extras, markupBasisPoints: $markupBasisPoints, failureBasisPoints: $failureBasisPoints, vatBasisPoints: $vatBasisPoints, sourceUrl: $sourceUrl, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $CatalogProductCopyWith<$Res>  {
  factory $CatalogProductCopyWith(CatalogProduct value, $Res Function(CatalogProduct) _then) = _$CatalogProductCopyWithImpl;
@useResult
$Res call({
 String id, String name, String printerId, int printTimeSeconds, List<FilamentUsage> filaments, int prepMinutes, int postMinutes, List<ExtraCost> extras, int markupBasisPoints, int failureBasisPoints, int vatBasisPoints, String sourceUrl, String notes, String createdAt, String updatedAt
});




}
/// @nodoc
class _$CatalogProductCopyWithImpl<$Res>
    implements $CatalogProductCopyWith<$Res> {
  _$CatalogProductCopyWithImpl(this._self, this._then);

  final CatalogProduct _self;
  final $Res Function(CatalogProduct) _then;

/// Create a copy of CatalogProduct
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? printerId = null,Object? printTimeSeconds = null,Object? filaments = null,Object? prepMinutes = null,Object? postMinutes = null,Object? extras = null,Object? markupBasisPoints = null,Object? failureBasisPoints = null,Object? vatBasisPoints = null,Object? sourceUrl = null,Object? notes = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,printerId: null == printerId ? _self.printerId : printerId // ignore: cast_nullable_to_non_nullable
as String,printTimeSeconds: null == printTimeSeconds ? _self.printTimeSeconds : printTimeSeconds // ignore: cast_nullable_to_non_nullable
as int,filaments: null == filaments ? _self.filaments : filaments // ignore: cast_nullable_to_non_nullable
as List<FilamentUsage>,prepMinutes: null == prepMinutes ? _self.prepMinutes : prepMinutes // ignore: cast_nullable_to_non_nullable
as int,postMinutes: null == postMinutes ? _self.postMinutes : postMinutes // ignore: cast_nullable_to_non_nullable
as int,extras: null == extras ? _self.extras : extras // ignore: cast_nullable_to_non_nullable
as List<ExtraCost>,markupBasisPoints: null == markupBasisPoints ? _self.markupBasisPoints : markupBasisPoints // ignore: cast_nullable_to_non_nullable
as int,failureBasisPoints: null == failureBasisPoints ? _self.failureBasisPoints : failureBasisPoints // ignore: cast_nullable_to_non_nullable
as int,vatBasisPoints: null == vatBasisPoints ? _self.vatBasisPoints : vatBasisPoints // ignore: cast_nullable_to_non_nullable
as int,sourceUrl: null == sourceUrl ? _self.sourceUrl : sourceUrl // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [CatalogProduct].
extension CatalogProductPatterns on CatalogProduct {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CatalogProduct value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CatalogProduct() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CatalogProduct value)  $default,){
final _that = this;
switch (_that) {
case _CatalogProduct():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CatalogProduct value)?  $default,){
final _that = this;
switch (_that) {
case _CatalogProduct() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String printerId,  int printTimeSeconds,  List<FilamentUsage> filaments,  int prepMinutes,  int postMinutes,  List<ExtraCost> extras,  int markupBasisPoints,  int failureBasisPoints,  int vatBasisPoints,  String sourceUrl,  String notes,  String createdAt,  String updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CatalogProduct() when $default != null:
return $default(_that.id,_that.name,_that.printerId,_that.printTimeSeconds,_that.filaments,_that.prepMinutes,_that.postMinutes,_that.extras,_that.markupBasisPoints,_that.failureBasisPoints,_that.vatBasisPoints,_that.sourceUrl,_that.notes,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String printerId,  int printTimeSeconds,  List<FilamentUsage> filaments,  int prepMinutes,  int postMinutes,  List<ExtraCost> extras,  int markupBasisPoints,  int failureBasisPoints,  int vatBasisPoints,  String sourceUrl,  String notes,  String createdAt,  String updatedAt)  $default,) {final _that = this;
switch (_that) {
case _CatalogProduct():
return $default(_that.id,_that.name,_that.printerId,_that.printTimeSeconds,_that.filaments,_that.prepMinutes,_that.postMinutes,_that.extras,_that.markupBasisPoints,_that.failureBasisPoints,_that.vatBasisPoints,_that.sourceUrl,_that.notes,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String printerId,  int printTimeSeconds,  List<FilamentUsage> filaments,  int prepMinutes,  int postMinutes,  List<ExtraCost> extras,  int markupBasisPoints,  int failureBasisPoints,  int vatBasisPoints,  String sourceUrl,  String notes,  String createdAt,  String updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _CatalogProduct() when $default != null:
return $default(_that.id,_that.name,_that.printerId,_that.printTimeSeconds,_that.filaments,_that.prepMinutes,_that.postMinutes,_that.extras,_that.markupBasisPoints,_that.failureBasisPoints,_that.vatBasisPoints,_that.sourceUrl,_that.notes,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CatalogProduct implements CatalogProduct {
  const _CatalogProduct({required this.id, required this.name, this.printerId = '', this.printTimeSeconds = 0, final  List<FilamentUsage> filaments = const <FilamentUsage>[], this.prepMinutes = 0, this.postMinutes = 0, final  List<ExtraCost> extras = const <ExtraCost>[], this.markupBasisPoints = 3000, this.failureBasisPoints = 0, this.vatBasisPoints = 2500, this.sourceUrl = '', this.notes = '', this.createdAt = '', this.updatedAt = ''}): _filaments = filaments,_extras = extras;
  factory _CatalogProduct.fromJson(Map<String, dynamic> json) => _$CatalogProductFromJson(json);

@override final  String id;
@override final  String name;
@override@JsonKey() final  String printerId;
@override@JsonKey() final  int printTimeSeconds;
 final  List<FilamentUsage> _filaments;
@override@JsonKey() List<FilamentUsage> get filaments {
  if (_filaments is EqualUnmodifiableListView) return _filaments;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_filaments);
}

@override@JsonKey() final  int prepMinutes;
@override@JsonKey() final  int postMinutes;
 final  List<ExtraCost> _extras;
@override@JsonKey() List<ExtraCost> get extras {
  if (_extras is EqualUnmodifiableListView) return _extras;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_extras);
}

@override@JsonKey() final  int markupBasisPoints;
@override@JsonKey() final  int failureBasisPoints;
@override@JsonKey() final  int vatBasisPoints;
@override@JsonKey() final  String sourceUrl;
@override@JsonKey() final  String notes;
@override@JsonKey() final  String createdAt;
@override@JsonKey() final  String updatedAt;

/// Create a copy of CatalogProduct
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CatalogProductCopyWith<_CatalogProduct> get copyWith => __$CatalogProductCopyWithImpl<_CatalogProduct>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CatalogProductToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CatalogProduct&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.printerId, printerId) || other.printerId == printerId)&&(identical(other.printTimeSeconds, printTimeSeconds) || other.printTimeSeconds == printTimeSeconds)&&const DeepCollectionEquality().equals(other._filaments, _filaments)&&(identical(other.prepMinutes, prepMinutes) || other.prepMinutes == prepMinutes)&&(identical(other.postMinutes, postMinutes) || other.postMinutes == postMinutes)&&const DeepCollectionEquality().equals(other._extras, _extras)&&(identical(other.markupBasisPoints, markupBasisPoints) || other.markupBasisPoints == markupBasisPoints)&&(identical(other.failureBasisPoints, failureBasisPoints) || other.failureBasisPoints == failureBasisPoints)&&(identical(other.vatBasisPoints, vatBasisPoints) || other.vatBasisPoints == vatBasisPoints)&&(identical(other.sourceUrl, sourceUrl) || other.sourceUrl == sourceUrl)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,printerId,printTimeSeconds,const DeepCollectionEquality().hash(_filaments),prepMinutes,postMinutes,const DeepCollectionEquality().hash(_extras),markupBasisPoints,failureBasisPoints,vatBasisPoints,sourceUrl,notes,createdAt,updatedAt);

@override
String toString() {
  return 'CatalogProduct(id: $id, name: $name, printerId: $printerId, printTimeSeconds: $printTimeSeconds, filaments: $filaments, prepMinutes: $prepMinutes, postMinutes: $postMinutes, extras: $extras, markupBasisPoints: $markupBasisPoints, failureBasisPoints: $failureBasisPoints, vatBasisPoints: $vatBasisPoints, sourceUrl: $sourceUrl, notes: $notes, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$CatalogProductCopyWith<$Res> implements $CatalogProductCopyWith<$Res> {
  factory _$CatalogProductCopyWith(_CatalogProduct value, $Res Function(_CatalogProduct) _then) = __$CatalogProductCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String printerId, int printTimeSeconds, List<FilamentUsage> filaments, int prepMinutes, int postMinutes, List<ExtraCost> extras, int markupBasisPoints, int failureBasisPoints, int vatBasisPoints, String sourceUrl, String notes, String createdAt, String updatedAt
});




}
/// @nodoc
class __$CatalogProductCopyWithImpl<$Res>
    implements _$CatalogProductCopyWith<$Res> {
  __$CatalogProductCopyWithImpl(this._self, this._then);

  final _CatalogProduct _self;
  final $Res Function(_CatalogProduct) _then;

/// Create a copy of CatalogProduct
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? printerId = null,Object? printTimeSeconds = null,Object? filaments = null,Object? prepMinutes = null,Object? postMinutes = null,Object? extras = null,Object? markupBasisPoints = null,Object? failureBasisPoints = null,Object? vatBasisPoints = null,Object? sourceUrl = null,Object? notes = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_CatalogProduct(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,printerId: null == printerId ? _self.printerId : printerId // ignore: cast_nullable_to_non_nullable
as String,printTimeSeconds: null == printTimeSeconds ? _self.printTimeSeconds : printTimeSeconds // ignore: cast_nullable_to_non_nullable
as int,filaments: null == filaments ? _self._filaments : filaments // ignore: cast_nullable_to_non_nullable
as List<FilamentUsage>,prepMinutes: null == prepMinutes ? _self.prepMinutes : prepMinutes // ignore: cast_nullable_to_non_nullable
as int,postMinutes: null == postMinutes ? _self.postMinutes : postMinutes // ignore: cast_nullable_to_non_nullable
as int,extras: null == extras ? _self._extras : extras // ignore: cast_nullable_to_non_nullable
as List<ExtraCost>,markupBasisPoints: null == markupBasisPoints ? _self.markupBasisPoints : markupBasisPoints // ignore: cast_nullable_to_non_nullable
as int,failureBasisPoints: null == failureBasisPoints ? _self.failureBasisPoints : failureBasisPoints // ignore: cast_nullable_to_non_nullable
as int,vatBasisPoints: null == vatBasisPoints ? _self.vatBasisPoints : vatBasisPoints // ignore: cast_nullable_to_non_nullable
as int,sourceUrl: null == sourceUrl ? _self.sourceUrl : sourceUrl // ignore: cast_nullable_to_non_nullable
as String,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
