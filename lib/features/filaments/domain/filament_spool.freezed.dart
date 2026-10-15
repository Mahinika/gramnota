// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'filament_spool.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FilamentSpool {

 String get id; String get brand; String get material; String get colorHex; double get diameterMm; double get spoolWeightGrams; double get remainingGrams; int get pricePerSpoolMinor; double get lowStockGrams; String get notes;
/// Create a copy of FilamentSpool
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FilamentSpoolCopyWith<FilamentSpool> get copyWith => _$FilamentSpoolCopyWithImpl<FilamentSpool>(this as FilamentSpool, _$identity);

  /// Serializes this FilamentSpool to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FilamentSpool&&(identical(other.id, id) || other.id == id)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.material, material) || other.material == material)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex)&&(identical(other.diameterMm, diameterMm) || other.diameterMm == diameterMm)&&(identical(other.spoolWeightGrams, spoolWeightGrams) || other.spoolWeightGrams == spoolWeightGrams)&&(identical(other.remainingGrams, remainingGrams) || other.remainingGrams == remainingGrams)&&(identical(other.pricePerSpoolMinor, pricePerSpoolMinor) || other.pricePerSpoolMinor == pricePerSpoolMinor)&&(identical(other.lowStockGrams, lowStockGrams) || other.lowStockGrams == lowStockGrams)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,brand,material,colorHex,diameterMm,spoolWeightGrams,remainingGrams,pricePerSpoolMinor,lowStockGrams,notes);

@override
String toString() {
  return 'FilamentSpool(id: $id, brand: $brand, material: $material, colorHex: $colorHex, diameterMm: $diameterMm, spoolWeightGrams: $spoolWeightGrams, remainingGrams: $remainingGrams, pricePerSpoolMinor: $pricePerSpoolMinor, lowStockGrams: $lowStockGrams, notes: $notes)';
}


}

/// @nodoc
abstract mixin class $FilamentSpoolCopyWith<$Res>  {
  factory $FilamentSpoolCopyWith(FilamentSpool value, $Res Function(FilamentSpool) _then) = _$FilamentSpoolCopyWithImpl;
@useResult
$Res call({
 String id, String brand, String material, String colorHex, double diameterMm, double spoolWeightGrams, double remainingGrams, int pricePerSpoolMinor, double lowStockGrams, String notes
});




}
/// @nodoc
class _$FilamentSpoolCopyWithImpl<$Res>
    implements $FilamentSpoolCopyWith<$Res> {
  _$FilamentSpoolCopyWithImpl(this._self, this._then);

  final FilamentSpool _self;
  final $Res Function(FilamentSpool) _then;

/// Create a copy of FilamentSpool
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? brand = null,Object? material = null,Object? colorHex = null,Object? diameterMm = null,Object? spoolWeightGrams = null,Object? remainingGrams = null,Object? pricePerSpoolMinor = null,Object? lowStockGrams = null,Object? notes = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,brand: null == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String,material: null == material ? _self.material : material // ignore: cast_nullable_to_non_nullable
as String,colorHex: null == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String,diameterMm: null == diameterMm ? _self.diameterMm : diameterMm // ignore: cast_nullable_to_non_nullable
as double,spoolWeightGrams: null == spoolWeightGrams ? _self.spoolWeightGrams : spoolWeightGrams // ignore: cast_nullable_to_non_nullable
as double,remainingGrams: null == remainingGrams ? _self.remainingGrams : remainingGrams // ignore: cast_nullable_to_non_nullable
as double,pricePerSpoolMinor: null == pricePerSpoolMinor ? _self.pricePerSpoolMinor : pricePerSpoolMinor // ignore: cast_nullable_to_non_nullable
as int,lowStockGrams: null == lowStockGrams ? _self.lowStockGrams : lowStockGrams // ignore: cast_nullable_to_non_nullable
as double,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FilamentSpool].
extension FilamentSpoolPatterns on FilamentSpool {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FilamentSpool value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FilamentSpool() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FilamentSpool value)  $default,){
final _that = this;
switch (_that) {
case _FilamentSpool():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FilamentSpool value)?  $default,){
final _that = this;
switch (_that) {
case _FilamentSpool() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String brand,  String material,  String colorHex,  double diameterMm,  double spoolWeightGrams,  double remainingGrams,  int pricePerSpoolMinor,  double lowStockGrams,  String notes)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FilamentSpool() when $default != null:
return $default(_that.id,_that.brand,_that.material,_that.colorHex,_that.diameterMm,_that.spoolWeightGrams,_that.remainingGrams,_that.pricePerSpoolMinor,_that.lowStockGrams,_that.notes);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String brand,  String material,  String colorHex,  double diameterMm,  double spoolWeightGrams,  double remainingGrams,  int pricePerSpoolMinor,  double lowStockGrams,  String notes)  $default,) {final _that = this;
switch (_that) {
case _FilamentSpool():
return $default(_that.id,_that.brand,_that.material,_that.colorHex,_that.diameterMm,_that.spoolWeightGrams,_that.remainingGrams,_that.pricePerSpoolMinor,_that.lowStockGrams,_that.notes);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String brand,  String material,  String colorHex,  double diameterMm,  double spoolWeightGrams,  double remainingGrams,  int pricePerSpoolMinor,  double lowStockGrams,  String notes)?  $default,) {final _that = this;
switch (_that) {
case _FilamentSpool() when $default != null:
return $default(_that.id,_that.brand,_that.material,_that.colorHex,_that.diameterMm,_that.spoolWeightGrams,_that.remainingGrams,_that.pricePerSpoolMinor,_that.lowStockGrams,_that.notes);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FilamentSpool extends FilamentSpool {
  const _FilamentSpool({required this.id, required this.brand, required this.material, this.colorHex = '#808080', this.diameterMm = 1.75, this.spoolWeightGrams = 1000, this.remainingGrams = 1000, this.pricePerSpoolMinor = 0, this.lowStockGrams = 100, this.notes = ''}): super._();
  factory _FilamentSpool.fromJson(Map<String, dynamic> json) => _$FilamentSpoolFromJson(json);

@override final  String id;
@override final  String brand;
@override final  String material;
@override@JsonKey() final  String colorHex;
@override@JsonKey() final  double diameterMm;
@override@JsonKey() final  double spoolWeightGrams;
@override@JsonKey() final  double remainingGrams;
@override@JsonKey() final  int pricePerSpoolMinor;
@override@JsonKey() final  double lowStockGrams;
@override@JsonKey() final  String notes;

/// Create a copy of FilamentSpool
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FilamentSpoolCopyWith<_FilamentSpool> get copyWith => __$FilamentSpoolCopyWithImpl<_FilamentSpool>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FilamentSpoolToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FilamentSpool&&(identical(other.id, id) || other.id == id)&&(identical(other.brand, brand) || other.brand == brand)&&(identical(other.material, material) || other.material == material)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex)&&(identical(other.diameterMm, diameterMm) || other.diameterMm == diameterMm)&&(identical(other.spoolWeightGrams, spoolWeightGrams) || other.spoolWeightGrams == spoolWeightGrams)&&(identical(other.remainingGrams, remainingGrams) || other.remainingGrams == remainingGrams)&&(identical(other.pricePerSpoolMinor, pricePerSpoolMinor) || other.pricePerSpoolMinor == pricePerSpoolMinor)&&(identical(other.lowStockGrams, lowStockGrams) || other.lowStockGrams == lowStockGrams)&&(identical(other.notes, notes) || other.notes == notes));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,brand,material,colorHex,diameterMm,spoolWeightGrams,remainingGrams,pricePerSpoolMinor,lowStockGrams,notes);

@override
String toString() {
  return 'FilamentSpool(id: $id, brand: $brand, material: $material, colorHex: $colorHex, diameterMm: $diameterMm, spoolWeightGrams: $spoolWeightGrams, remainingGrams: $remainingGrams, pricePerSpoolMinor: $pricePerSpoolMinor, lowStockGrams: $lowStockGrams, notes: $notes)';
}


}

/// @nodoc
abstract mixin class _$FilamentSpoolCopyWith<$Res> implements $FilamentSpoolCopyWith<$Res> {
  factory _$FilamentSpoolCopyWith(_FilamentSpool value, $Res Function(_FilamentSpool) _then) = __$FilamentSpoolCopyWithImpl;
@override @useResult
$Res call({
 String id, String brand, String material, String colorHex, double diameterMm, double spoolWeightGrams, double remainingGrams, int pricePerSpoolMinor, double lowStockGrams, String notes
});




}
/// @nodoc
class __$FilamentSpoolCopyWithImpl<$Res>
    implements _$FilamentSpoolCopyWith<$Res> {
  __$FilamentSpoolCopyWithImpl(this._self, this._then);

  final _FilamentSpool _self;
  final $Res Function(_FilamentSpool) _then;

/// Create a copy of FilamentSpool
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? brand = null,Object? material = null,Object? colorHex = null,Object? diameterMm = null,Object? spoolWeightGrams = null,Object? remainingGrams = null,Object? pricePerSpoolMinor = null,Object? lowStockGrams = null,Object? notes = null,}) {
  return _then(_FilamentSpool(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,brand: null == brand ? _self.brand : brand // ignore: cast_nullable_to_non_nullable
as String,material: null == material ? _self.material : material // ignore: cast_nullable_to_non_nullable
as String,colorHex: null == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String,diameterMm: null == diameterMm ? _self.diameterMm : diameterMm // ignore: cast_nullable_to_non_nullable
as double,spoolWeightGrams: null == spoolWeightGrams ? _self.spoolWeightGrams : spoolWeightGrams // ignore: cast_nullable_to_non_nullable
as double,remainingGrams: null == remainingGrams ? _self.remainingGrams : remainingGrams // ignore: cast_nullable_to_non_nullable
as double,pricePerSpoolMinor: null == pricePerSpoolMinor ? _self.pricePerSpoolMinor : pricePerSpoolMinor // ignore: cast_nullable_to_non_nullable
as int,lowStockGrams: null == lowStockGrams ? _self.lowStockGrams : lowStockGrams // ignore: cast_nullable_to_non_nullable
as double,notes: null == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
