// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'printer_profile.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PrinterProfile {

 String get id; String get name; int get powerWatts; int get purchasePriceMinor; double get lifetimeHours; int get maintenanceMinorPerHour;
/// Create a copy of PrinterProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrinterProfileCopyWith<PrinterProfile> get copyWith => _$PrinterProfileCopyWithImpl<PrinterProfile>(this as PrinterProfile, _$identity);

  /// Serializes this PrinterProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrinterProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.powerWatts, powerWatts) || other.powerWatts == powerWatts)&&(identical(other.purchasePriceMinor, purchasePriceMinor) || other.purchasePriceMinor == purchasePriceMinor)&&(identical(other.lifetimeHours, lifetimeHours) || other.lifetimeHours == lifetimeHours)&&(identical(other.maintenanceMinorPerHour, maintenanceMinorPerHour) || other.maintenanceMinorPerHour == maintenanceMinorPerHour));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,powerWatts,purchasePriceMinor,lifetimeHours,maintenanceMinorPerHour);

@override
String toString() {
  return 'PrinterProfile(id: $id, name: $name, powerWatts: $powerWatts, purchasePriceMinor: $purchasePriceMinor, lifetimeHours: $lifetimeHours, maintenanceMinorPerHour: $maintenanceMinorPerHour)';
}


}

/// @nodoc
abstract mixin class $PrinterProfileCopyWith<$Res>  {
  factory $PrinterProfileCopyWith(PrinterProfile value, $Res Function(PrinterProfile) _then) = _$PrinterProfileCopyWithImpl;
@useResult
$Res call({
 String id, String name, int powerWatts, int purchasePriceMinor, double lifetimeHours, int maintenanceMinorPerHour
});




}
/// @nodoc
class _$PrinterProfileCopyWithImpl<$Res>
    implements $PrinterProfileCopyWith<$Res> {
  _$PrinterProfileCopyWithImpl(this._self, this._then);

  final PrinterProfile _self;
  final $Res Function(PrinterProfile) _then;

/// Create a copy of PrinterProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? powerWatts = null,Object? purchasePriceMinor = null,Object? lifetimeHours = null,Object? maintenanceMinorPerHour = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,powerWatts: null == powerWatts ? _self.powerWatts : powerWatts // ignore: cast_nullable_to_non_nullable
as int,purchasePriceMinor: null == purchasePriceMinor ? _self.purchasePriceMinor : purchasePriceMinor // ignore: cast_nullable_to_non_nullable
as int,lifetimeHours: null == lifetimeHours ? _self.lifetimeHours : lifetimeHours // ignore: cast_nullable_to_non_nullable
as double,maintenanceMinorPerHour: null == maintenanceMinorPerHour ? _self.maintenanceMinorPerHour : maintenanceMinorPerHour // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [PrinterProfile].
extension PrinterProfilePatterns on PrinterProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrinterProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrinterProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrinterProfile value)  $default,){
final _that = this;
switch (_that) {
case _PrinterProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrinterProfile value)?  $default,){
final _that = this;
switch (_that) {
case _PrinterProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  int powerWatts,  int purchasePriceMinor,  double lifetimeHours,  int maintenanceMinorPerHour)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrinterProfile() when $default != null:
return $default(_that.id,_that.name,_that.powerWatts,_that.purchasePriceMinor,_that.lifetimeHours,_that.maintenanceMinorPerHour);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  int powerWatts,  int purchasePriceMinor,  double lifetimeHours,  int maintenanceMinorPerHour)  $default,) {final _that = this;
switch (_that) {
case _PrinterProfile():
return $default(_that.id,_that.name,_that.powerWatts,_that.purchasePriceMinor,_that.lifetimeHours,_that.maintenanceMinorPerHour);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  int powerWatts,  int purchasePriceMinor,  double lifetimeHours,  int maintenanceMinorPerHour)?  $default,) {final _that = this;
switch (_that) {
case _PrinterProfile() when $default != null:
return $default(_that.id,_that.name,_that.powerWatts,_that.purchasePriceMinor,_that.lifetimeHours,_that.maintenanceMinorPerHour);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PrinterProfile implements PrinterProfile {
  const _PrinterProfile({required this.id, required this.name, this.powerWatts = 0, this.purchasePriceMinor = 0, this.lifetimeHours = 0, this.maintenanceMinorPerHour = 0});
  factory _PrinterProfile.fromJson(Map<String, dynamic> json) => _$PrinterProfileFromJson(json);

@override final  String id;
@override final  String name;
@override@JsonKey() final  int powerWatts;
@override@JsonKey() final  int purchasePriceMinor;
@override@JsonKey() final  double lifetimeHours;
@override@JsonKey() final  int maintenanceMinorPerHour;

/// Create a copy of PrinterProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrinterProfileCopyWith<_PrinterProfile> get copyWith => __$PrinterProfileCopyWithImpl<_PrinterProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PrinterProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrinterProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.powerWatts, powerWatts) || other.powerWatts == powerWatts)&&(identical(other.purchasePriceMinor, purchasePriceMinor) || other.purchasePriceMinor == purchasePriceMinor)&&(identical(other.lifetimeHours, lifetimeHours) || other.lifetimeHours == lifetimeHours)&&(identical(other.maintenanceMinorPerHour, maintenanceMinorPerHour) || other.maintenanceMinorPerHour == maintenanceMinorPerHour));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,powerWatts,purchasePriceMinor,lifetimeHours,maintenanceMinorPerHour);

@override
String toString() {
  return 'PrinterProfile(id: $id, name: $name, powerWatts: $powerWatts, purchasePriceMinor: $purchasePriceMinor, lifetimeHours: $lifetimeHours, maintenanceMinorPerHour: $maintenanceMinorPerHour)';
}


}

/// @nodoc
abstract mixin class _$PrinterProfileCopyWith<$Res> implements $PrinterProfileCopyWith<$Res> {
  factory _$PrinterProfileCopyWith(_PrinterProfile value, $Res Function(_PrinterProfile) _then) = __$PrinterProfileCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, int powerWatts, int purchasePriceMinor, double lifetimeHours, int maintenanceMinorPerHour
});




}
/// @nodoc
class __$PrinterProfileCopyWithImpl<$Res>
    implements _$PrinterProfileCopyWith<$Res> {
  __$PrinterProfileCopyWithImpl(this._self, this._then);

  final _PrinterProfile _self;
  final $Res Function(_PrinterProfile) _then;

/// Create a copy of PrinterProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? powerWatts = null,Object? purchasePriceMinor = null,Object? lifetimeHours = null,Object? maintenanceMinorPerHour = null,}) {
  return _then(_PrinterProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,powerWatts: null == powerWatts ? _self.powerWatts : powerWatts // ignore: cast_nullable_to_non_nullable
as int,purchasePriceMinor: null == purchasePriceMinor ? _self.purchasePriceMinor : purchasePriceMinor // ignore: cast_nullable_to_non_nullable
as int,lifetimeHours: null == lifetimeHours ? _self.lifetimeHours : lifetimeHours // ignore: cast_nullable_to_non_nullable
as double,maintenanceMinorPerHour: null == maintenanceMinorPerHour ? _self.maintenanceMinorPerHour : maintenanceMinorPerHour // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
