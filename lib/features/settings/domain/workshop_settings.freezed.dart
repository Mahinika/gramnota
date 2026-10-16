// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'workshop_settings.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$WorkshopSettings {

@JsonKey(readValue: readSetupCompleted) bool get setupCompleted; String get currencyCode; int get electricityMinorPerKwh; int get laborMinorPerHour; int get defaultMarkupBasisPoints; int get vatBasisPoints; int get defaultFailureBasisPoints; String get businessName; String get street; String get postalCode; String get city; String get orgNumber; String get phone; String get email; int get nextQuoteNumber; int get quoteValidityDays;
/// Create a copy of WorkshopSettings
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkshopSettingsCopyWith<WorkshopSettings> get copyWith => _$WorkshopSettingsCopyWithImpl<WorkshopSettings>(this as WorkshopSettings, _$identity);

  /// Serializes this WorkshopSettings to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkshopSettings&&(identical(other.setupCompleted, setupCompleted) || other.setupCompleted == setupCompleted)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.electricityMinorPerKwh, electricityMinorPerKwh) || other.electricityMinorPerKwh == electricityMinorPerKwh)&&(identical(other.laborMinorPerHour, laborMinorPerHour) || other.laborMinorPerHour == laborMinorPerHour)&&(identical(other.defaultMarkupBasisPoints, defaultMarkupBasisPoints) || other.defaultMarkupBasisPoints == defaultMarkupBasisPoints)&&(identical(other.vatBasisPoints, vatBasisPoints) || other.vatBasisPoints == vatBasisPoints)&&(identical(other.defaultFailureBasisPoints, defaultFailureBasisPoints) || other.defaultFailureBasisPoints == defaultFailureBasisPoints)&&(identical(other.businessName, businessName) || other.businessName == businessName)&&(identical(other.street, street) || other.street == street)&&(identical(other.postalCode, postalCode) || other.postalCode == postalCode)&&(identical(other.city, city) || other.city == city)&&(identical(other.orgNumber, orgNumber) || other.orgNumber == orgNumber)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.nextQuoteNumber, nextQuoteNumber) || other.nextQuoteNumber == nextQuoteNumber)&&(identical(other.quoteValidityDays, quoteValidityDays) || other.quoteValidityDays == quoteValidityDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,setupCompleted,currencyCode,electricityMinorPerKwh,laborMinorPerHour,defaultMarkupBasisPoints,vatBasisPoints,defaultFailureBasisPoints,businessName,street,postalCode,city,orgNumber,phone,email,nextQuoteNumber,quoteValidityDays);

@override
String toString() {
  return 'WorkshopSettings(setupCompleted: $setupCompleted, currencyCode: $currencyCode, electricityMinorPerKwh: $electricityMinorPerKwh, laborMinorPerHour: $laborMinorPerHour, defaultMarkupBasisPoints: $defaultMarkupBasisPoints, vatBasisPoints: $vatBasisPoints, defaultFailureBasisPoints: $defaultFailureBasisPoints, businessName: $businessName, street: $street, postalCode: $postalCode, city: $city, orgNumber: $orgNumber, phone: $phone, email: $email, nextQuoteNumber: $nextQuoteNumber, quoteValidityDays: $quoteValidityDays)';
}


}

/// @nodoc
abstract mixin class $WorkshopSettingsCopyWith<$Res>  {
  factory $WorkshopSettingsCopyWith(WorkshopSettings value, $Res Function(WorkshopSettings) _then) = _$WorkshopSettingsCopyWithImpl;
@useResult
$Res call({
@JsonKey(readValue: readSetupCompleted) bool setupCompleted, String currencyCode, int electricityMinorPerKwh, int laborMinorPerHour, int defaultMarkupBasisPoints, int vatBasisPoints, int defaultFailureBasisPoints, String businessName, String street, String postalCode, String city, String orgNumber, String phone, String email, int nextQuoteNumber, int quoteValidityDays
});




}
/// @nodoc
class _$WorkshopSettingsCopyWithImpl<$Res>
    implements $WorkshopSettingsCopyWith<$Res> {
  _$WorkshopSettingsCopyWithImpl(this._self, this._then);

  final WorkshopSettings _self;
  final $Res Function(WorkshopSettings) _then;

/// Create a copy of WorkshopSettings
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? setupCompleted = null,Object? currencyCode = null,Object? electricityMinorPerKwh = null,Object? laborMinorPerHour = null,Object? defaultMarkupBasisPoints = null,Object? vatBasisPoints = null,Object? defaultFailureBasisPoints = null,Object? businessName = null,Object? street = null,Object? postalCode = null,Object? city = null,Object? orgNumber = null,Object? phone = null,Object? email = null,Object? nextQuoteNumber = null,Object? quoteValidityDays = null,}) {
  return _then(_self.copyWith(
setupCompleted: null == setupCompleted ? _self.setupCompleted : setupCompleted // ignore: cast_nullable_to_non_nullable
as bool,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,electricityMinorPerKwh: null == electricityMinorPerKwh ? _self.electricityMinorPerKwh : electricityMinorPerKwh // ignore: cast_nullable_to_non_nullable
as int,laborMinorPerHour: null == laborMinorPerHour ? _self.laborMinorPerHour : laborMinorPerHour // ignore: cast_nullable_to_non_nullable
as int,defaultMarkupBasisPoints: null == defaultMarkupBasisPoints ? _self.defaultMarkupBasisPoints : defaultMarkupBasisPoints // ignore: cast_nullable_to_non_nullable
as int,vatBasisPoints: null == vatBasisPoints ? _self.vatBasisPoints : vatBasisPoints // ignore: cast_nullable_to_non_nullable
as int,defaultFailureBasisPoints: null == defaultFailureBasisPoints ? _self.defaultFailureBasisPoints : defaultFailureBasisPoints // ignore: cast_nullable_to_non_nullable
as int,businessName: null == businessName ? _self.businessName : businessName // ignore: cast_nullable_to_non_nullable
as String,street: null == street ? _self.street : street // ignore: cast_nullable_to_non_nullable
as String,postalCode: null == postalCode ? _self.postalCode : postalCode // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,orgNumber: null == orgNumber ? _self.orgNumber : orgNumber // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,nextQuoteNumber: null == nextQuoteNumber ? _self.nextQuoteNumber : nextQuoteNumber // ignore: cast_nullable_to_non_nullable
as int,quoteValidityDays: null == quoteValidityDays ? _self.quoteValidityDays : quoteValidityDays // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkshopSettings].
extension WorkshopSettingsPatterns on WorkshopSettings {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkshopSettings value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkshopSettings() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkshopSettings value)  $default,){
final _that = this;
switch (_that) {
case _WorkshopSettings():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkshopSettings value)?  $default,){
final _that = this;
switch (_that) {
case _WorkshopSettings() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(readValue: readSetupCompleted)  bool setupCompleted,  String currencyCode,  int electricityMinorPerKwh,  int laborMinorPerHour,  int defaultMarkupBasisPoints,  int vatBasisPoints,  int defaultFailureBasisPoints,  String businessName,  String street,  String postalCode,  String city,  String orgNumber,  String phone,  String email,  int nextQuoteNumber,  int quoteValidityDays)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkshopSettings() when $default != null:
return $default(_that.setupCompleted,_that.currencyCode,_that.electricityMinorPerKwh,_that.laborMinorPerHour,_that.defaultMarkupBasisPoints,_that.vatBasisPoints,_that.defaultFailureBasisPoints,_that.businessName,_that.street,_that.postalCode,_that.city,_that.orgNumber,_that.phone,_that.email,_that.nextQuoteNumber,_that.quoteValidityDays);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(readValue: readSetupCompleted)  bool setupCompleted,  String currencyCode,  int electricityMinorPerKwh,  int laborMinorPerHour,  int defaultMarkupBasisPoints,  int vatBasisPoints,  int defaultFailureBasisPoints,  String businessName,  String street,  String postalCode,  String city,  String orgNumber,  String phone,  String email,  int nextQuoteNumber,  int quoteValidityDays)  $default,) {final _that = this;
switch (_that) {
case _WorkshopSettings():
return $default(_that.setupCompleted,_that.currencyCode,_that.electricityMinorPerKwh,_that.laborMinorPerHour,_that.defaultMarkupBasisPoints,_that.vatBasisPoints,_that.defaultFailureBasisPoints,_that.businessName,_that.street,_that.postalCode,_that.city,_that.orgNumber,_that.phone,_that.email,_that.nextQuoteNumber,_that.quoteValidityDays);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(readValue: readSetupCompleted)  bool setupCompleted,  String currencyCode,  int electricityMinorPerKwh,  int laborMinorPerHour,  int defaultMarkupBasisPoints,  int vatBasisPoints,  int defaultFailureBasisPoints,  String businessName,  String street,  String postalCode,  String city,  String orgNumber,  String phone,  String email,  int nextQuoteNumber,  int quoteValidityDays)?  $default,) {final _that = this;
switch (_that) {
case _WorkshopSettings() when $default != null:
return $default(_that.setupCompleted,_that.currencyCode,_that.electricityMinorPerKwh,_that.laborMinorPerHour,_that.defaultMarkupBasisPoints,_that.vatBasisPoints,_that.defaultFailureBasisPoints,_that.businessName,_that.street,_that.postalCode,_that.city,_that.orgNumber,_that.phone,_that.email,_that.nextQuoteNumber,_that.quoteValidityDays);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WorkshopSettings implements WorkshopSettings {
  const _WorkshopSettings({@JsonKey(readValue: readSetupCompleted) this.setupCompleted = false, this.currencyCode = 'SEK', this.electricityMinorPerKwh = 0, this.laborMinorPerHour = 0, this.defaultMarkupBasisPoints = 3000, this.vatBasisPoints = 2500, this.defaultFailureBasisPoints = 0, this.businessName = '', this.street = '', this.postalCode = '', this.city = '', this.orgNumber = '', this.phone = '', this.email = '', this.nextQuoteNumber = 1, this.quoteValidityDays = 14});
  factory _WorkshopSettings.fromJson(Map<String, dynamic> json) => _$WorkshopSettingsFromJson(json);

@override@JsonKey(readValue: readSetupCompleted) final  bool setupCompleted;
@override@JsonKey() final  String currencyCode;
@override@JsonKey() final  int electricityMinorPerKwh;
@override@JsonKey() final  int laborMinorPerHour;
@override@JsonKey() final  int defaultMarkupBasisPoints;
@override@JsonKey() final  int vatBasisPoints;
@override@JsonKey() final  int defaultFailureBasisPoints;
@override@JsonKey() final  String businessName;
@override@JsonKey() final  String street;
@override@JsonKey() final  String postalCode;
@override@JsonKey() final  String city;
@override@JsonKey() final  String orgNumber;
@override@JsonKey() final  String phone;
@override@JsonKey() final  String email;
@override@JsonKey() final  int nextQuoteNumber;
@override@JsonKey() final  int quoteValidityDays;

/// Create a copy of WorkshopSettings
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkshopSettingsCopyWith<_WorkshopSettings> get copyWith => __$WorkshopSettingsCopyWithImpl<_WorkshopSettings>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WorkshopSettingsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkshopSettings&&(identical(other.setupCompleted, setupCompleted) || other.setupCompleted == setupCompleted)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.electricityMinorPerKwh, electricityMinorPerKwh) || other.electricityMinorPerKwh == electricityMinorPerKwh)&&(identical(other.laborMinorPerHour, laborMinorPerHour) || other.laborMinorPerHour == laborMinorPerHour)&&(identical(other.defaultMarkupBasisPoints, defaultMarkupBasisPoints) || other.defaultMarkupBasisPoints == defaultMarkupBasisPoints)&&(identical(other.vatBasisPoints, vatBasisPoints) || other.vatBasisPoints == vatBasisPoints)&&(identical(other.defaultFailureBasisPoints, defaultFailureBasisPoints) || other.defaultFailureBasisPoints == defaultFailureBasisPoints)&&(identical(other.businessName, businessName) || other.businessName == businessName)&&(identical(other.street, street) || other.street == street)&&(identical(other.postalCode, postalCode) || other.postalCode == postalCode)&&(identical(other.city, city) || other.city == city)&&(identical(other.orgNumber, orgNumber) || other.orgNumber == orgNumber)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.email, email) || other.email == email)&&(identical(other.nextQuoteNumber, nextQuoteNumber) || other.nextQuoteNumber == nextQuoteNumber)&&(identical(other.quoteValidityDays, quoteValidityDays) || other.quoteValidityDays == quoteValidityDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,setupCompleted,currencyCode,electricityMinorPerKwh,laborMinorPerHour,defaultMarkupBasisPoints,vatBasisPoints,defaultFailureBasisPoints,businessName,street,postalCode,city,orgNumber,phone,email,nextQuoteNumber,quoteValidityDays);

@override
String toString() {
  return 'WorkshopSettings(setupCompleted: $setupCompleted, currencyCode: $currencyCode, electricityMinorPerKwh: $electricityMinorPerKwh, laborMinorPerHour: $laborMinorPerHour, defaultMarkupBasisPoints: $defaultMarkupBasisPoints, vatBasisPoints: $vatBasisPoints, defaultFailureBasisPoints: $defaultFailureBasisPoints, businessName: $businessName, street: $street, postalCode: $postalCode, city: $city, orgNumber: $orgNumber, phone: $phone, email: $email, nextQuoteNumber: $nextQuoteNumber, quoteValidityDays: $quoteValidityDays)';
}


}

/// @nodoc
abstract mixin class _$WorkshopSettingsCopyWith<$Res> implements $WorkshopSettingsCopyWith<$Res> {
  factory _$WorkshopSettingsCopyWith(_WorkshopSettings value, $Res Function(_WorkshopSettings) _then) = __$WorkshopSettingsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(readValue: readSetupCompleted) bool setupCompleted, String currencyCode, int electricityMinorPerKwh, int laborMinorPerHour, int defaultMarkupBasisPoints, int vatBasisPoints, int defaultFailureBasisPoints, String businessName, String street, String postalCode, String city, String orgNumber, String phone, String email, int nextQuoteNumber, int quoteValidityDays
});




}
/// @nodoc
class __$WorkshopSettingsCopyWithImpl<$Res>
    implements _$WorkshopSettingsCopyWith<$Res> {
  __$WorkshopSettingsCopyWithImpl(this._self, this._then);

  final _WorkshopSettings _self;
  final $Res Function(_WorkshopSettings) _then;

/// Create a copy of WorkshopSettings
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? setupCompleted = null,Object? currencyCode = null,Object? electricityMinorPerKwh = null,Object? laborMinorPerHour = null,Object? defaultMarkupBasisPoints = null,Object? vatBasisPoints = null,Object? defaultFailureBasisPoints = null,Object? businessName = null,Object? street = null,Object? postalCode = null,Object? city = null,Object? orgNumber = null,Object? phone = null,Object? email = null,Object? nextQuoteNumber = null,Object? quoteValidityDays = null,}) {
  return _then(_WorkshopSettings(
setupCompleted: null == setupCompleted ? _self.setupCompleted : setupCompleted // ignore: cast_nullable_to_non_nullable
as bool,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,electricityMinorPerKwh: null == electricityMinorPerKwh ? _self.electricityMinorPerKwh : electricityMinorPerKwh // ignore: cast_nullable_to_non_nullable
as int,laborMinorPerHour: null == laborMinorPerHour ? _self.laborMinorPerHour : laborMinorPerHour // ignore: cast_nullable_to_non_nullable
as int,defaultMarkupBasisPoints: null == defaultMarkupBasisPoints ? _self.defaultMarkupBasisPoints : defaultMarkupBasisPoints // ignore: cast_nullable_to_non_nullable
as int,vatBasisPoints: null == vatBasisPoints ? _self.vatBasisPoints : vatBasisPoints // ignore: cast_nullable_to_non_nullable
as int,defaultFailureBasisPoints: null == defaultFailureBasisPoints ? _self.defaultFailureBasisPoints : defaultFailureBasisPoints // ignore: cast_nullable_to_non_nullable
as int,businessName: null == businessName ? _self.businessName : businessName // ignore: cast_nullable_to_non_nullable
as String,street: null == street ? _self.street : street // ignore: cast_nullable_to_non_nullable
as String,postalCode: null == postalCode ? _self.postalCode : postalCode // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,orgNumber: null == orgNumber ? _self.orgNumber : orgNumber // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,nextQuoteNumber: null == nextQuoteNumber ? _self.nextQuoteNumber : nextQuoteNumber // ignore: cast_nullable_to_non_nullable
as int,quoteValidityDays: null == quoteValidityDays ? _self.quoteValidityDays : quoteValidityDays // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
