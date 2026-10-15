// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'price_breakdown.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PriceBreakdown {

 int get materialMinor; int get electricityMinor; int get machineMinor; int get failureMinor; int get laborMinor; int get extrasMinor; int get costMinor; int get markupMinor; int get netMinor; int get vatMinor; int get totalMinor; int get perUnitMinor; int get quantity;
/// Create a copy of PriceBreakdown
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PriceBreakdownCopyWith<PriceBreakdown> get copyWith => _$PriceBreakdownCopyWithImpl<PriceBreakdown>(this as PriceBreakdown, _$identity);

  /// Serializes this PriceBreakdown to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PriceBreakdown&&(identical(other.materialMinor, materialMinor) || other.materialMinor == materialMinor)&&(identical(other.electricityMinor, electricityMinor) || other.electricityMinor == electricityMinor)&&(identical(other.machineMinor, machineMinor) || other.machineMinor == machineMinor)&&(identical(other.failureMinor, failureMinor) || other.failureMinor == failureMinor)&&(identical(other.laborMinor, laborMinor) || other.laborMinor == laborMinor)&&(identical(other.extrasMinor, extrasMinor) || other.extrasMinor == extrasMinor)&&(identical(other.costMinor, costMinor) || other.costMinor == costMinor)&&(identical(other.markupMinor, markupMinor) || other.markupMinor == markupMinor)&&(identical(other.netMinor, netMinor) || other.netMinor == netMinor)&&(identical(other.vatMinor, vatMinor) || other.vatMinor == vatMinor)&&(identical(other.totalMinor, totalMinor) || other.totalMinor == totalMinor)&&(identical(other.perUnitMinor, perUnitMinor) || other.perUnitMinor == perUnitMinor)&&(identical(other.quantity, quantity) || other.quantity == quantity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,materialMinor,electricityMinor,machineMinor,failureMinor,laborMinor,extrasMinor,costMinor,markupMinor,netMinor,vatMinor,totalMinor,perUnitMinor,quantity);

@override
String toString() {
  return 'PriceBreakdown(materialMinor: $materialMinor, electricityMinor: $electricityMinor, machineMinor: $machineMinor, failureMinor: $failureMinor, laborMinor: $laborMinor, extrasMinor: $extrasMinor, costMinor: $costMinor, markupMinor: $markupMinor, netMinor: $netMinor, vatMinor: $vatMinor, totalMinor: $totalMinor, perUnitMinor: $perUnitMinor, quantity: $quantity)';
}


}

/// @nodoc
abstract mixin class $PriceBreakdownCopyWith<$Res>  {
  factory $PriceBreakdownCopyWith(PriceBreakdown value, $Res Function(PriceBreakdown) _then) = _$PriceBreakdownCopyWithImpl;
@useResult
$Res call({
 int materialMinor, int electricityMinor, int machineMinor, int failureMinor, int laborMinor, int extrasMinor, int costMinor, int markupMinor, int netMinor, int vatMinor, int totalMinor, int perUnitMinor, int quantity
});




}
/// @nodoc
class _$PriceBreakdownCopyWithImpl<$Res>
    implements $PriceBreakdownCopyWith<$Res> {
  _$PriceBreakdownCopyWithImpl(this._self, this._then);

  final PriceBreakdown _self;
  final $Res Function(PriceBreakdown) _then;

/// Create a copy of PriceBreakdown
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? materialMinor = null,Object? electricityMinor = null,Object? machineMinor = null,Object? failureMinor = null,Object? laborMinor = null,Object? extrasMinor = null,Object? costMinor = null,Object? markupMinor = null,Object? netMinor = null,Object? vatMinor = null,Object? totalMinor = null,Object? perUnitMinor = null,Object? quantity = null,}) {
  return _then(_self.copyWith(
materialMinor: null == materialMinor ? _self.materialMinor : materialMinor // ignore: cast_nullable_to_non_nullable
as int,electricityMinor: null == electricityMinor ? _self.electricityMinor : electricityMinor // ignore: cast_nullable_to_non_nullable
as int,machineMinor: null == machineMinor ? _self.machineMinor : machineMinor // ignore: cast_nullable_to_non_nullable
as int,failureMinor: null == failureMinor ? _self.failureMinor : failureMinor // ignore: cast_nullable_to_non_nullable
as int,laborMinor: null == laborMinor ? _self.laborMinor : laborMinor // ignore: cast_nullable_to_non_nullable
as int,extrasMinor: null == extrasMinor ? _self.extrasMinor : extrasMinor // ignore: cast_nullable_to_non_nullable
as int,costMinor: null == costMinor ? _self.costMinor : costMinor // ignore: cast_nullable_to_non_nullable
as int,markupMinor: null == markupMinor ? _self.markupMinor : markupMinor // ignore: cast_nullable_to_non_nullable
as int,netMinor: null == netMinor ? _self.netMinor : netMinor // ignore: cast_nullable_to_non_nullable
as int,vatMinor: null == vatMinor ? _self.vatMinor : vatMinor // ignore: cast_nullable_to_non_nullable
as int,totalMinor: null == totalMinor ? _self.totalMinor : totalMinor // ignore: cast_nullable_to_non_nullable
as int,perUnitMinor: null == perUnitMinor ? _self.perUnitMinor : perUnitMinor // ignore: cast_nullable_to_non_nullable
as int,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PriceBreakdown].
extension PriceBreakdownPatterns on PriceBreakdown {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PriceBreakdown value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PriceBreakdown() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PriceBreakdown value)  $default,){
final _that = this;
switch (_that) {
case _PriceBreakdown():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PriceBreakdown value)?  $default,){
final _that = this;
switch (_that) {
case _PriceBreakdown() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int materialMinor,  int electricityMinor,  int machineMinor,  int failureMinor,  int laborMinor,  int extrasMinor,  int costMinor,  int markupMinor,  int netMinor,  int vatMinor,  int totalMinor,  int perUnitMinor,  int quantity)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PriceBreakdown() when $default != null:
return $default(_that.materialMinor,_that.electricityMinor,_that.machineMinor,_that.failureMinor,_that.laborMinor,_that.extrasMinor,_that.costMinor,_that.markupMinor,_that.netMinor,_that.vatMinor,_that.totalMinor,_that.perUnitMinor,_that.quantity);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int materialMinor,  int electricityMinor,  int machineMinor,  int failureMinor,  int laborMinor,  int extrasMinor,  int costMinor,  int markupMinor,  int netMinor,  int vatMinor,  int totalMinor,  int perUnitMinor,  int quantity)  $default,) {final _that = this;
switch (_that) {
case _PriceBreakdown():
return $default(_that.materialMinor,_that.electricityMinor,_that.machineMinor,_that.failureMinor,_that.laborMinor,_that.extrasMinor,_that.costMinor,_that.markupMinor,_that.netMinor,_that.vatMinor,_that.totalMinor,_that.perUnitMinor,_that.quantity);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int materialMinor,  int electricityMinor,  int machineMinor,  int failureMinor,  int laborMinor,  int extrasMinor,  int costMinor,  int markupMinor,  int netMinor,  int vatMinor,  int totalMinor,  int perUnitMinor,  int quantity)?  $default,) {final _that = this;
switch (_that) {
case _PriceBreakdown() when $default != null:
return $default(_that.materialMinor,_that.electricityMinor,_that.machineMinor,_that.failureMinor,_that.laborMinor,_that.extrasMinor,_that.costMinor,_that.markupMinor,_that.netMinor,_that.vatMinor,_that.totalMinor,_that.perUnitMinor,_that.quantity);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PriceBreakdown implements PriceBreakdown {
  const _PriceBreakdown({required this.materialMinor, required this.electricityMinor, required this.machineMinor, required this.failureMinor, required this.laborMinor, required this.extrasMinor, required this.costMinor, required this.markupMinor, required this.netMinor, required this.vatMinor, required this.totalMinor, required this.perUnitMinor, required this.quantity});
  factory _PriceBreakdown.fromJson(Map<String, dynamic> json) => _$PriceBreakdownFromJson(json);

@override final  int materialMinor;
@override final  int electricityMinor;
@override final  int machineMinor;
@override final  int failureMinor;
@override final  int laborMinor;
@override final  int extrasMinor;
@override final  int costMinor;
@override final  int markupMinor;
@override final  int netMinor;
@override final  int vatMinor;
@override final  int totalMinor;
@override final  int perUnitMinor;
@override final  int quantity;

/// Create a copy of PriceBreakdown
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PriceBreakdownCopyWith<_PriceBreakdown> get copyWith => __$PriceBreakdownCopyWithImpl<_PriceBreakdown>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PriceBreakdownToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PriceBreakdown&&(identical(other.materialMinor, materialMinor) || other.materialMinor == materialMinor)&&(identical(other.electricityMinor, electricityMinor) || other.electricityMinor == electricityMinor)&&(identical(other.machineMinor, machineMinor) || other.machineMinor == machineMinor)&&(identical(other.failureMinor, failureMinor) || other.failureMinor == failureMinor)&&(identical(other.laborMinor, laborMinor) || other.laborMinor == laborMinor)&&(identical(other.extrasMinor, extrasMinor) || other.extrasMinor == extrasMinor)&&(identical(other.costMinor, costMinor) || other.costMinor == costMinor)&&(identical(other.markupMinor, markupMinor) || other.markupMinor == markupMinor)&&(identical(other.netMinor, netMinor) || other.netMinor == netMinor)&&(identical(other.vatMinor, vatMinor) || other.vatMinor == vatMinor)&&(identical(other.totalMinor, totalMinor) || other.totalMinor == totalMinor)&&(identical(other.perUnitMinor, perUnitMinor) || other.perUnitMinor == perUnitMinor)&&(identical(other.quantity, quantity) || other.quantity == quantity));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,materialMinor,electricityMinor,machineMinor,failureMinor,laborMinor,extrasMinor,costMinor,markupMinor,netMinor,vatMinor,totalMinor,perUnitMinor,quantity);

@override
String toString() {
  return 'PriceBreakdown(materialMinor: $materialMinor, electricityMinor: $electricityMinor, machineMinor: $machineMinor, failureMinor: $failureMinor, laborMinor: $laborMinor, extrasMinor: $extrasMinor, costMinor: $costMinor, markupMinor: $markupMinor, netMinor: $netMinor, vatMinor: $vatMinor, totalMinor: $totalMinor, perUnitMinor: $perUnitMinor, quantity: $quantity)';
}


}

/// @nodoc
abstract mixin class _$PriceBreakdownCopyWith<$Res> implements $PriceBreakdownCopyWith<$Res> {
  factory _$PriceBreakdownCopyWith(_PriceBreakdown value, $Res Function(_PriceBreakdown) _then) = __$PriceBreakdownCopyWithImpl;
@override @useResult
$Res call({
 int materialMinor, int electricityMinor, int machineMinor, int failureMinor, int laborMinor, int extrasMinor, int costMinor, int markupMinor, int netMinor, int vatMinor, int totalMinor, int perUnitMinor, int quantity
});




}
/// @nodoc
class __$PriceBreakdownCopyWithImpl<$Res>
    implements _$PriceBreakdownCopyWith<$Res> {
  __$PriceBreakdownCopyWithImpl(this._self, this._then);

  final _PriceBreakdown _self;
  final $Res Function(_PriceBreakdown) _then;

/// Create a copy of PriceBreakdown
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? materialMinor = null,Object? electricityMinor = null,Object? machineMinor = null,Object? failureMinor = null,Object? laborMinor = null,Object? extrasMinor = null,Object? costMinor = null,Object? markupMinor = null,Object? netMinor = null,Object? vatMinor = null,Object? totalMinor = null,Object? perUnitMinor = null,Object? quantity = null,}) {
  return _then(_PriceBreakdown(
materialMinor: null == materialMinor ? _self.materialMinor : materialMinor // ignore: cast_nullable_to_non_nullable
as int,electricityMinor: null == electricityMinor ? _self.electricityMinor : electricityMinor // ignore: cast_nullable_to_non_nullable
as int,machineMinor: null == machineMinor ? _self.machineMinor : machineMinor // ignore: cast_nullable_to_non_nullable
as int,failureMinor: null == failureMinor ? _self.failureMinor : failureMinor // ignore: cast_nullable_to_non_nullable
as int,laborMinor: null == laborMinor ? _self.laborMinor : laborMinor // ignore: cast_nullable_to_non_nullable
as int,extrasMinor: null == extrasMinor ? _self.extrasMinor : extrasMinor // ignore: cast_nullable_to_non_nullable
as int,costMinor: null == costMinor ? _self.costMinor : costMinor // ignore: cast_nullable_to_non_nullable
as int,markupMinor: null == markupMinor ? _self.markupMinor : markupMinor // ignore: cast_nullable_to_non_nullable
as int,netMinor: null == netMinor ? _self.netMinor : netMinor // ignore: cast_nullable_to_non_nullable
as int,vatMinor: null == vatMinor ? _self.vatMinor : vatMinor // ignore: cast_nullable_to_non_nullable
as int,totalMinor: null == totalMinor ? _self.totalMinor : totalMinor // ignore: cast_nullable_to_non_nullable
as int,perUnitMinor: null == perUnitMinor ? _self.perUnitMinor : perUnitMinor // ignore: cast_nullable_to_non_nullable
as int,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
