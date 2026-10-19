// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'print_order.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$FilamentUsage {

 String get filamentId; double get grams; String get material; String get colorHex;
/// Create a copy of FilamentUsage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$FilamentUsageCopyWith<FilamentUsage> get copyWith => _$FilamentUsageCopyWithImpl<FilamentUsage>(this as FilamentUsage, _$identity);

  /// Serializes this FilamentUsage to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is FilamentUsage&&(identical(other.filamentId, filamentId) || other.filamentId == filamentId)&&(identical(other.grams, grams) || other.grams == grams)&&(identical(other.material, material) || other.material == material)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,filamentId,grams,material,colorHex);

@override
String toString() {
  return 'FilamentUsage(filamentId: $filamentId, grams: $grams, material: $material, colorHex: $colorHex)';
}


}

/// @nodoc
abstract mixin class $FilamentUsageCopyWith<$Res>  {
  factory $FilamentUsageCopyWith(FilamentUsage value, $Res Function(FilamentUsage) _then) = _$FilamentUsageCopyWithImpl;
@useResult
$Res call({
 String filamentId, double grams, String material, String colorHex
});




}
/// @nodoc
class _$FilamentUsageCopyWithImpl<$Res>
    implements $FilamentUsageCopyWith<$Res> {
  _$FilamentUsageCopyWithImpl(this._self, this._then);

  final FilamentUsage _self;
  final $Res Function(FilamentUsage) _then;

/// Create a copy of FilamentUsage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? filamentId = null,Object? grams = null,Object? material = null,Object? colorHex = null,}) {
  return _then(_self.copyWith(
filamentId: null == filamentId ? _self.filamentId : filamentId // ignore: cast_nullable_to_non_nullable
as String,grams: null == grams ? _self.grams : grams // ignore: cast_nullable_to_non_nullable
as double,material: null == material ? _self.material : material // ignore: cast_nullable_to_non_nullable
as String,colorHex: null == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [FilamentUsage].
extension FilamentUsagePatterns on FilamentUsage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _FilamentUsage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _FilamentUsage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _FilamentUsage value)  $default,){
final _that = this;
switch (_that) {
case _FilamentUsage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _FilamentUsage value)?  $default,){
final _that = this;
switch (_that) {
case _FilamentUsage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String filamentId,  double grams,  String material,  String colorHex)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _FilamentUsage() when $default != null:
return $default(_that.filamentId,_that.grams,_that.material,_that.colorHex);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String filamentId,  double grams,  String material,  String colorHex)  $default,) {final _that = this;
switch (_that) {
case _FilamentUsage():
return $default(_that.filamentId,_that.grams,_that.material,_that.colorHex);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String filamentId,  double grams,  String material,  String colorHex)?  $default,) {final _that = this;
switch (_that) {
case _FilamentUsage() when $default != null:
return $default(_that.filamentId,_that.grams,_that.material,_that.colorHex);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _FilamentUsage implements FilamentUsage {
  const _FilamentUsage({this.filamentId = '', required this.grams, this.material = '', this.colorHex = ''});
  factory _FilamentUsage.fromJson(Map<String, dynamic> json) => _$FilamentUsageFromJson(json);

@override@JsonKey() final  String filamentId;
@override final  double grams;
@override@JsonKey() final  String material;
@override@JsonKey() final  String colorHex;

/// Create a copy of FilamentUsage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$FilamentUsageCopyWith<_FilamentUsage> get copyWith => __$FilamentUsageCopyWithImpl<_FilamentUsage>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$FilamentUsageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _FilamentUsage&&(identical(other.filamentId, filamentId) || other.filamentId == filamentId)&&(identical(other.grams, grams) || other.grams == grams)&&(identical(other.material, material) || other.material == material)&&(identical(other.colorHex, colorHex) || other.colorHex == colorHex));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,filamentId,grams,material,colorHex);

@override
String toString() {
  return 'FilamentUsage(filamentId: $filamentId, grams: $grams, material: $material, colorHex: $colorHex)';
}


}

/// @nodoc
abstract mixin class _$FilamentUsageCopyWith<$Res> implements $FilamentUsageCopyWith<$Res> {
  factory _$FilamentUsageCopyWith(_FilamentUsage value, $Res Function(_FilamentUsage) _then) = __$FilamentUsageCopyWithImpl;
@override @useResult
$Res call({
 String filamentId, double grams, String material, String colorHex
});




}
/// @nodoc
class __$FilamentUsageCopyWithImpl<$Res>
    implements _$FilamentUsageCopyWith<$Res> {
  __$FilamentUsageCopyWithImpl(this._self, this._then);

  final _FilamentUsage _self;
  final $Res Function(_FilamentUsage) _then;

/// Create a copy of FilamentUsage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? filamentId = null,Object? grams = null,Object? material = null,Object? colorHex = null,}) {
  return _then(_FilamentUsage(
filamentId: null == filamentId ? _self.filamentId : filamentId // ignore: cast_nullable_to_non_nullable
as String,grams: null == grams ? _self.grams : grams // ignore: cast_nullable_to_non_nullable
as double,material: null == material ? _self.material : material // ignore: cast_nullable_to_non_nullable
as String,colorHex: null == colorHex ? _self.colorHex : colorHex // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}


/// @nodoc
mixin _$ExtraCost {

 String get name; int get costMinor;
/// Create a copy of ExtraCost
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExtraCostCopyWith<ExtraCost> get copyWith => _$ExtraCostCopyWithImpl<ExtraCost>(this as ExtraCost, _$identity);

  /// Serializes this ExtraCost to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ExtraCost&&(identical(other.name, name) || other.name == name)&&(identical(other.costMinor, costMinor) || other.costMinor == costMinor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,costMinor);

@override
String toString() {
  return 'ExtraCost(name: $name, costMinor: $costMinor)';
}


}

/// @nodoc
abstract mixin class $ExtraCostCopyWith<$Res>  {
  factory $ExtraCostCopyWith(ExtraCost value, $Res Function(ExtraCost) _then) = _$ExtraCostCopyWithImpl;
@useResult
$Res call({
 String name, int costMinor
});




}
/// @nodoc
class _$ExtraCostCopyWithImpl<$Res>
    implements $ExtraCostCopyWith<$Res> {
  _$ExtraCostCopyWithImpl(this._self, this._then);

  final ExtraCost _self;
  final $Res Function(ExtraCost) _then;

/// Create a copy of ExtraCost
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? costMinor = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,costMinor: null == costMinor ? _self.costMinor : costMinor // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ExtraCost].
extension ExtraCostPatterns on ExtraCost {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ExtraCost value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ExtraCost() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ExtraCost value)  $default,){
final _that = this;
switch (_that) {
case _ExtraCost():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ExtraCost value)?  $default,){
final _that = this;
switch (_that) {
case _ExtraCost() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  int costMinor)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ExtraCost() when $default != null:
return $default(_that.name,_that.costMinor);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  int costMinor)  $default,) {final _that = this;
switch (_that) {
case _ExtraCost():
return $default(_that.name,_that.costMinor);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  int costMinor)?  $default,) {final _that = this;
switch (_that) {
case _ExtraCost() when $default != null:
return $default(_that.name,_that.costMinor);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ExtraCost implements ExtraCost {
  const _ExtraCost({required this.name, required this.costMinor});
  factory _ExtraCost.fromJson(Map<String, dynamic> json) => _$ExtraCostFromJson(json);

@override final  String name;
@override final  int costMinor;

/// Create a copy of ExtraCost
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExtraCostCopyWith<_ExtraCost> get copyWith => __$ExtraCostCopyWithImpl<_ExtraCost>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExtraCostToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ExtraCost&&(identical(other.name, name) || other.name == name)&&(identical(other.costMinor, costMinor) || other.costMinor == costMinor));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,costMinor);

@override
String toString() {
  return 'ExtraCost(name: $name, costMinor: $costMinor)';
}


}

/// @nodoc
abstract mixin class _$ExtraCostCopyWith<$Res> implements $ExtraCostCopyWith<$Res> {
  factory _$ExtraCostCopyWith(_ExtraCost value, $Res Function(_ExtraCost) _then) = __$ExtraCostCopyWithImpl;
@override @useResult
$Res call({
 String name, int costMinor
});




}
/// @nodoc
class __$ExtraCostCopyWithImpl<$Res>
    implements _$ExtraCostCopyWith<$Res> {
  __$ExtraCostCopyWithImpl(this._self, this._then);

  final _ExtraCost _self;
  final $Res Function(_ExtraCost) _then;

/// Create a copy of ExtraCost
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? costMinor = null,}) {
  return _then(_ExtraCost(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,costMinor: null == costMinor ? _self.costMinor : costMinor // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$QuoteLine {

 String get id;/// Catalog product this print was taken from. Empty on older quotes and
/// on prints that were never saved as a product. Home groups by this id
/// so a renamed title still counts as the same product.
 String get productId; String get title; int get quantity; String get printerId; int get printTimeSeconds; List<FilamentUsage> get filaments; int get prepMinutes; int get postMinutes; List<ExtraCost> get extras; int get markupBasisPoints; int get failureBasisPoints; int get vatBasisPoints; PriceBreakdown get breakdown; String get sourceUrl; String get sourceModelTitle; String get sourceProfileTitle;
/// Create a copy of QuoteLine
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$QuoteLineCopyWith<QuoteLine> get copyWith => _$QuoteLineCopyWithImpl<QuoteLine>(this as QuoteLine, _$identity);

  /// Serializes this QuoteLine to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is QuoteLine&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.title, title) || other.title == title)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.printerId, printerId) || other.printerId == printerId)&&(identical(other.printTimeSeconds, printTimeSeconds) || other.printTimeSeconds == printTimeSeconds)&&const DeepCollectionEquality().equals(other.filaments, filaments)&&(identical(other.prepMinutes, prepMinutes) || other.prepMinutes == prepMinutes)&&(identical(other.postMinutes, postMinutes) || other.postMinutes == postMinutes)&&const DeepCollectionEquality().equals(other.extras, extras)&&(identical(other.markupBasisPoints, markupBasisPoints) || other.markupBasisPoints == markupBasisPoints)&&(identical(other.failureBasisPoints, failureBasisPoints) || other.failureBasisPoints == failureBasisPoints)&&(identical(other.vatBasisPoints, vatBasisPoints) || other.vatBasisPoints == vatBasisPoints)&&(identical(other.breakdown, breakdown) || other.breakdown == breakdown)&&(identical(other.sourceUrl, sourceUrl) || other.sourceUrl == sourceUrl)&&(identical(other.sourceModelTitle, sourceModelTitle) || other.sourceModelTitle == sourceModelTitle)&&(identical(other.sourceProfileTitle, sourceProfileTitle) || other.sourceProfileTitle == sourceProfileTitle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,productId,title,quantity,printerId,printTimeSeconds,const DeepCollectionEquality().hash(filaments),prepMinutes,postMinutes,const DeepCollectionEquality().hash(extras),markupBasisPoints,failureBasisPoints,vatBasisPoints,breakdown,sourceUrl,sourceModelTitle,sourceProfileTitle);

@override
String toString() {
  return 'QuoteLine(id: $id, productId: $productId, title: $title, quantity: $quantity, printerId: $printerId, printTimeSeconds: $printTimeSeconds, filaments: $filaments, prepMinutes: $prepMinutes, postMinutes: $postMinutes, extras: $extras, markupBasisPoints: $markupBasisPoints, failureBasisPoints: $failureBasisPoints, vatBasisPoints: $vatBasisPoints, breakdown: $breakdown, sourceUrl: $sourceUrl, sourceModelTitle: $sourceModelTitle, sourceProfileTitle: $sourceProfileTitle)';
}


}

/// @nodoc
abstract mixin class $QuoteLineCopyWith<$Res>  {
  factory $QuoteLineCopyWith(QuoteLine value, $Res Function(QuoteLine) _then) = _$QuoteLineCopyWithImpl;
@useResult
$Res call({
 String id, String productId, String title, int quantity, String printerId, int printTimeSeconds, List<FilamentUsage> filaments, int prepMinutes, int postMinutes, List<ExtraCost> extras, int markupBasisPoints, int failureBasisPoints, int vatBasisPoints, PriceBreakdown breakdown, String sourceUrl, String sourceModelTitle, String sourceProfileTitle
});


$PriceBreakdownCopyWith<$Res> get breakdown;

}
/// @nodoc
class _$QuoteLineCopyWithImpl<$Res>
    implements $QuoteLineCopyWith<$Res> {
  _$QuoteLineCopyWithImpl(this._self, this._then);

  final QuoteLine _self;
  final $Res Function(QuoteLine) _then;

/// Create a copy of QuoteLine
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? productId = null,Object? title = null,Object? quantity = null,Object? printerId = null,Object? printTimeSeconds = null,Object? filaments = null,Object? prepMinutes = null,Object? postMinutes = null,Object? extras = null,Object? markupBasisPoints = null,Object? failureBasisPoints = null,Object? vatBasisPoints = null,Object? breakdown = null,Object? sourceUrl = null,Object? sourceModelTitle = null,Object? sourceProfileTitle = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,printerId: null == printerId ? _self.printerId : printerId // ignore: cast_nullable_to_non_nullable
as String,printTimeSeconds: null == printTimeSeconds ? _self.printTimeSeconds : printTimeSeconds // ignore: cast_nullable_to_non_nullable
as int,filaments: null == filaments ? _self.filaments : filaments // ignore: cast_nullable_to_non_nullable
as List<FilamentUsage>,prepMinutes: null == prepMinutes ? _self.prepMinutes : prepMinutes // ignore: cast_nullable_to_non_nullable
as int,postMinutes: null == postMinutes ? _self.postMinutes : postMinutes // ignore: cast_nullable_to_non_nullable
as int,extras: null == extras ? _self.extras : extras // ignore: cast_nullable_to_non_nullable
as List<ExtraCost>,markupBasisPoints: null == markupBasisPoints ? _self.markupBasisPoints : markupBasisPoints // ignore: cast_nullable_to_non_nullable
as int,failureBasisPoints: null == failureBasisPoints ? _self.failureBasisPoints : failureBasisPoints // ignore: cast_nullable_to_non_nullable
as int,vatBasisPoints: null == vatBasisPoints ? _self.vatBasisPoints : vatBasisPoints // ignore: cast_nullable_to_non_nullable
as int,breakdown: null == breakdown ? _self.breakdown : breakdown // ignore: cast_nullable_to_non_nullable
as PriceBreakdown,sourceUrl: null == sourceUrl ? _self.sourceUrl : sourceUrl // ignore: cast_nullable_to_non_nullable
as String,sourceModelTitle: null == sourceModelTitle ? _self.sourceModelTitle : sourceModelTitle // ignore: cast_nullable_to_non_nullable
as String,sourceProfileTitle: null == sourceProfileTitle ? _self.sourceProfileTitle : sourceProfileTitle // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of QuoteLine
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PriceBreakdownCopyWith<$Res> get breakdown {
  
  return $PriceBreakdownCopyWith<$Res>(_self.breakdown, (value) {
    return _then(_self.copyWith(breakdown: value));
  });
}
}


/// Adds pattern-matching-related methods to [QuoteLine].
extension QuoteLinePatterns on QuoteLine {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _QuoteLine value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _QuoteLine() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _QuoteLine value)  $default,){
final _that = this;
switch (_that) {
case _QuoteLine():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _QuoteLine value)?  $default,){
final _that = this;
switch (_that) {
case _QuoteLine() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String productId,  String title,  int quantity,  String printerId,  int printTimeSeconds,  List<FilamentUsage> filaments,  int prepMinutes,  int postMinutes,  List<ExtraCost> extras,  int markupBasisPoints,  int failureBasisPoints,  int vatBasisPoints,  PriceBreakdown breakdown,  String sourceUrl,  String sourceModelTitle,  String sourceProfileTitle)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _QuoteLine() when $default != null:
return $default(_that.id,_that.productId,_that.title,_that.quantity,_that.printerId,_that.printTimeSeconds,_that.filaments,_that.prepMinutes,_that.postMinutes,_that.extras,_that.markupBasisPoints,_that.failureBasisPoints,_that.vatBasisPoints,_that.breakdown,_that.sourceUrl,_that.sourceModelTitle,_that.sourceProfileTitle);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String productId,  String title,  int quantity,  String printerId,  int printTimeSeconds,  List<FilamentUsage> filaments,  int prepMinutes,  int postMinutes,  List<ExtraCost> extras,  int markupBasisPoints,  int failureBasisPoints,  int vatBasisPoints,  PriceBreakdown breakdown,  String sourceUrl,  String sourceModelTitle,  String sourceProfileTitle)  $default,) {final _that = this;
switch (_that) {
case _QuoteLine():
return $default(_that.id,_that.productId,_that.title,_that.quantity,_that.printerId,_that.printTimeSeconds,_that.filaments,_that.prepMinutes,_that.postMinutes,_that.extras,_that.markupBasisPoints,_that.failureBasisPoints,_that.vatBasisPoints,_that.breakdown,_that.sourceUrl,_that.sourceModelTitle,_that.sourceProfileTitle);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String productId,  String title,  int quantity,  String printerId,  int printTimeSeconds,  List<FilamentUsage> filaments,  int prepMinutes,  int postMinutes,  List<ExtraCost> extras,  int markupBasisPoints,  int failureBasisPoints,  int vatBasisPoints,  PriceBreakdown breakdown,  String sourceUrl,  String sourceModelTitle,  String sourceProfileTitle)?  $default,) {final _that = this;
switch (_that) {
case _QuoteLine() when $default != null:
return $default(_that.id,_that.productId,_that.title,_that.quantity,_that.printerId,_that.printTimeSeconds,_that.filaments,_that.prepMinutes,_that.postMinutes,_that.extras,_that.markupBasisPoints,_that.failureBasisPoints,_that.vatBasisPoints,_that.breakdown,_that.sourceUrl,_that.sourceModelTitle,_that.sourceProfileTitle);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _QuoteLine implements QuoteLine {
  const _QuoteLine({required this.id, this.productId = '', required this.title, required this.quantity, this.printerId = '', required this.printTimeSeconds, required final  List<FilamentUsage> filaments, this.prepMinutes = 0, this.postMinutes = 0, final  List<ExtraCost> extras = const [], required this.markupBasisPoints, required this.failureBasisPoints, required this.vatBasisPoints, required this.breakdown, this.sourceUrl = '', this.sourceModelTitle = '', this.sourceProfileTitle = ''}): _filaments = filaments,_extras = extras;
  factory _QuoteLine.fromJson(Map<String, dynamic> json) => _$QuoteLineFromJson(json);

@override final  String id;
/// Catalog product this print was taken from. Empty on older quotes and
/// on prints that were never saved as a product. Home groups by this id
/// so a renamed title still counts as the same product.
@override@JsonKey() final  String productId;
@override final  String title;
@override final  int quantity;
@override@JsonKey() final  String printerId;
@override final  int printTimeSeconds;
 final  List<FilamentUsage> _filaments;
@override List<FilamentUsage> get filaments {
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

@override final  int markupBasisPoints;
@override final  int failureBasisPoints;
@override final  int vatBasisPoints;
@override final  PriceBreakdown breakdown;
@override@JsonKey() final  String sourceUrl;
@override@JsonKey() final  String sourceModelTitle;
@override@JsonKey() final  String sourceProfileTitle;

/// Create a copy of QuoteLine
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$QuoteLineCopyWith<_QuoteLine> get copyWith => __$QuoteLineCopyWithImpl<_QuoteLine>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$QuoteLineToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _QuoteLine&&(identical(other.id, id) || other.id == id)&&(identical(other.productId, productId) || other.productId == productId)&&(identical(other.title, title) || other.title == title)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.printerId, printerId) || other.printerId == printerId)&&(identical(other.printTimeSeconds, printTimeSeconds) || other.printTimeSeconds == printTimeSeconds)&&const DeepCollectionEquality().equals(other._filaments, _filaments)&&(identical(other.prepMinutes, prepMinutes) || other.prepMinutes == prepMinutes)&&(identical(other.postMinutes, postMinutes) || other.postMinutes == postMinutes)&&const DeepCollectionEquality().equals(other._extras, _extras)&&(identical(other.markupBasisPoints, markupBasisPoints) || other.markupBasisPoints == markupBasisPoints)&&(identical(other.failureBasisPoints, failureBasisPoints) || other.failureBasisPoints == failureBasisPoints)&&(identical(other.vatBasisPoints, vatBasisPoints) || other.vatBasisPoints == vatBasisPoints)&&(identical(other.breakdown, breakdown) || other.breakdown == breakdown)&&(identical(other.sourceUrl, sourceUrl) || other.sourceUrl == sourceUrl)&&(identical(other.sourceModelTitle, sourceModelTitle) || other.sourceModelTitle == sourceModelTitle)&&(identical(other.sourceProfileTitle, sourceProfileTitle) || other.sourceProfileTitle == sourceProfileTitle));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,productId,title,quantity,printerId,printTimeSeconds,const DeepCollectionEquality().hash(_filaments),prepMinutes,postMinutes,const DeepCollectionEquality().hash(_extras),markupBasisPoints,failureBasisPoints,vatBasisPoints,breakdown,sourceUrl,sourceModelTitle,sourceProfileTitle);

@override
String toString() {
  return 'QuoteLine(id: $id, productId: $productId, title: $title, quantity: $quantity, printerId: $printerId, printTimeSeconds: $printTimeSeconds, filaments: $filaments, prepMinutes: $prepMinutes, postMinutes: $postMinutes, extras: $extras, markupBasisPoints: $markupBasisPoints, failureBasisPoints: $failureBasisPoints, vatBasisPoints: $vatBasisPoints, breakdown: $breakdown, sourceUrl: $sourceUrl, sourceModelTitle: $sourceModelTitle, sourceProfileTitle: $sourceProfileTitle)';
}


}

/// @nodoc
abstract mixin class _$QuoteLineCopyWith<$Res> implements $QuoteLineCopyWith<$Res> {
  factory _$QuoteLineCopyWith(_QuoteLine value, $Res Function(_QuoteLine) _then) = __$QuoteLineCopyWithImpl;
@override @useResult
$Res call({
 String id, String productId, String title, int quantity, String printerId, int printTimeSeconds, List<FilamentUsage> filaments, int prepMinutes, int postMinutes, List<ExtraCost> extras, int markupBasisPoints, int failureBasisPoints, int vatBasisPoints, PriceBreakdown breakdown, String sourceUrl, String sourceModelTitle, String sourceProfileTitle
});


@override $PriceBreakdownCopyWith<$Res> get breakdown;

}
/// @nodoc
class __$QuoteLineCopyWithImpl<$Res>
    implements _$QuoteLineCopyWith<$Res> {
  __$QuoteLineCopyWithImpl(this._self, this._then);

  final _QuoteLine _self;
  final $Res Function(_QuoteLine) _then;

/// Create a copy of QuoteLine
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? productId = null,Object? title = null,Object? quantity = null,Object? printerId = null,Object? printTimeSeconds = null,Object? filaments = null,Object? prepMinutes = null,Object? postMinutes = null,Object? extras = null,Object? markupBasisPoints = null,Object? failureBasisPoints = null,Object? vatBasisPoints = null,Object? breakdown = null,Object? sourceUrl = null,Object? sourceModelTitle = null,Object? sourceProfileTitle = null,}) {
  return _then(_QuoteLine(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,productId: null == productId ? _self.productId : productId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,printerId: null == printerId ? _self.printerId : printerId // ignore: cast_nullable_to_non_nullable
as String,printTimeSeconds: null == printTimeSeconds ? _self.printTimeSeconds : printTimeSeconds // ignore: cast_nullable_to_non_nullable
as int,filaments: null == filaments ? _self._filaments : filaments // ignore: cast_nullable_to_non_nullable
as List<FilamentUsage>,prepMinutes: null == prepMinutes ? _self.prepMinutes : prepMinutes // ignore: cast_nullable_to_non_nullable
as int,postMinutes: null == postMinutes ? _self.postMinutes : postMinutes // ignore: cast_nullable_to_non_nullable
as int,extras: null == extras ? _self._extras : extras // ignore: cast_nullable_to_non_nullable
as List<ExtraCost>,markupBasisPoints: null == markupBasisPoints ? _self.markupBasisPoints : markupBasisPoints // ignore: cast_nullable_to_non_nullable
as int,failureBasisPoints: null == failureBasisPoints ? _self.failureBasisPoints : failureBasisPoints // ignore: cast_nullable_to_non_nullable
as int,vatBasisPoints: null == vatBasisPoints ? _self.vatBasisPoints : vatBasisPoints // ignore: cast_nullable_to_non_nullable
as int,breakdown: null == breakdown ? _self.breakdown : breakdown // ignore: cast_nullable_to_non_nullable
as PriceBreakdown,sourceUrl: null == sourceUrl ? _self.sourceUrl : sourceUrl // ignore: cast_nullable_to_non_nullable
as String,sourceModelTitle: null == sourceModelTitle ? _self.sourceModelTitle : sourceModelTitle // ignore: cast_nullable_to_non_nullable
as String,sourceProfileTitle: null == sourceProfileTitle ? _self.sourceProfileTitle : sourceProfileTitle // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of QuoteLine
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PriceBreakdownCopyWith<$Res> get breakdown {
  
  return $PriceBreakdownCopyWith<$Res>(_self.breakdown, (value) {
    return _then(_self.copyWith(breakdown: value));
  });
}
}


/// @nodoc
mixin _$PrintOrder {

 String get id; int get quoteNumber; String get customerId; String get title;@JsonKey(fromJson: orderStatusFromJson, toJson: orderStatusToJson) OrderStatus get status; String get validUntil; int get quantity; String get printerId; int get printTimeSeconds; List<FilamentUsage> get filaments; int get prepMinutes; int get postMinutes; List<ExtraCost> get extras; int get markupBasisPoints; int get failureBasisPoints; int get vatBasisPoints;/// Missing on older orders. Those quotes stay in SEK. No conversion.
@JsonKey(readValue: readCurrencyCode) String get currencyCode;/// Customer PDF language. Empty follows the app language at preview time.
 String get quoteLanguage; PriceBreakdown get breakdown; bool get stockDeducted; Map<String, double> get deductedGrams; String get stockWarning; int get depositMinor;/// When the deposit was received, as a UTC timestamp. Empty on older
/// orders: Home then keeps the whole total in the print month.
 String get depositAt; String get revenueAt; String get sourceUrl; String get sourceModelTitle; String get sourceProfileTitle; String get note; List<QuoteLine> get lines; String get createdAt; String get updatedAt;
/// Create a copy of PrintOrder
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PrintOrderCopyWith<PrintOrder> get copyWith => _$PrintOrderCopyWithImpl<PrintOrder>(this as PrintOrder, _$identity);

  /// Serializes this PrintOrder to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PrintOrder&&(identical(other.id, id) || other.id == id)&&(identical(other.quoteNumber, quoteNumber) || other.quoteNumber == quoteNumber)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.validUntil, validUntil) || other.validUntil == validUntil)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.printerId, printerId) || other.printerId == printerId)&&(identical(other.printTimeSeconds, printTimeSeconds) || other.printTimeSeconds == printTimeSeconds)&&const DeepCollectionEquality().equals(other.filaments, filaments)&&(identical(other.prepMinutes, prepMinutes) || other.prepMinutes == prepMinutes)&&(identical(other.postMinutes, postMinutes) || other.postMinutes == postMinutes)&&const DeepCollectionEquality().equals(other.extras, extras)&&(identical(other.markupBasisPoints, markupBasisPoints) || other.markupBasisPoints == markupBasisPoints)&&(identical(other.failureBasisPoints, failureBasisPoints) || other.failureBasisPoints == failureBasisPoints)&&(identical(other.vatBasisPoints, vatBasisPoints) || other.vatBasisPoints == vatBasisPoints)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.quoteLanguage, quoteLanguage) || other.quoteLanguage == quoteLanguage)&&(identical(other.breakdown, breakdown) || other.breakdown == breakdown)&&(identical(other.stockDeducted, stockDeducted) || other.stockDeducted == stockDeducted)&&const DeepCollectionEquality().equals(other.deductedGrams, deductedGrams)&&(identical(other.stockWarning, stockWarning) || other.stockWarning == stockWarning)&&(identical(other.depositMinor, depositMinor) || other.depositMinor == depositMinor)&&(identical(other.depositAt, depositAt) || other.depositAt == depositAt)&&(identical(other.revenueAt, revenueAt) || other.revenueAt == revenueAt)&&(identical(other.sourceUrl, sourceUrl) || other.sourceUrl == sourceUrl)&&(identical(other.sourceModelTitle, sourceModelTitle) || other.sourceModelTitle == sourceModelTitle)&&(identical(other.sourceProfileTitle, sourceProfileTitle) || other.sourceProfileTitle == sourceProfileTitle)&&(identical(other.note, note) || other.note == note)&&const DeepCollectionEquality().equals(other.lines, lines)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,quoteNumber,customerId,title,status,validUntil,quantity,printerId,printTimeSeconds,const DeepCollectionEquality().hash(filaments),prepMinutes,postMinutes,const DeepCollectionEquality().hash(extras),markupBasisPoints,failureBasisPoints,vatBasisPoints,currencyCode,quoteLanguage,breakdown,stockDeducted,const DeepCollectionEquality().hash(deductedGrams),stockWarning,depositMinor,depositAt,revenueAt,sourceUrl,sourceModelTitle,sourceProfileTitle,note,const DeepCollectionEquality().hash(lines),createdAt,updatedAt]);

@override
String toString() {
  return 'PrintOrder(id: $id, quoteNumber: $quoteNumber, customerId: $customerId, title: $title, status: $status, validUntil: $validUntil, quantity: $quantity, printerId: $printerId, printTimeSeconds: $printTimeSeconds, filaments: $filaments, prepMinutes: $prepMinutes, postMinutes: $postMinutes, extras: $extras, markupBasisPoints: $markupBasisPoints, failureBasisPoints: $failureBasisPoints, vatBasisPoints: $vatBasisPoints, currencyCode: $currencyCode, quoteLanguage: $quoteLanguage, breakdown: $breakdown, stockDeducted: $stockDeducted, deductedGrams: $deductedGrams, stockWarning: $stockWarning, depositMinor: $depositMinor, depositAt: $depositAt, revenueAt: $revenueAt, sourceUrl: $sourceUrl, sourceModelTitle: $sourceModelTitle, sourceProfileTitle: $sourceProfileTitle, note: $note, lines: $lines, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $PrintOrderCopyWith<$Res>  {
  factory $PrintOrderCopyWith(PrintOrder value, $Res Function(PrintOrder) _then) = _$PrintOrderCopyWithImpl;
@useResult
$Res call({
 String id, int quoteNumber, String customerId, String title,@JsonKey(fromJson: orderStatusFromJson, toJson: orderStatusToJson) OrderStatus status, String validUntil, int quantity, String printerId, int printTimeSeconds, List<FilamentUsage> filaments, int prepMinutes, int postMinutes, List<ExtraCost> extras, int markupBasisPoints, int failureBasisPoints, int vatBasisPoints,@JsonKey(readValue: readCurrencyCode) String currencyCode, String quoteLanguage, PriceBreakdown breakdown, bool stockDeducted, Map<String, double> deductedGrams, String stockWarning, int depositMinor, String depositAt, String revenueAt, String sourceUrl, String sourceModelTitle, String sourceProfileTitle, String note, List<QuoteLine> lines, String createdAt, String updatedAt
});


$PriceBreakdownCopyWith<$Res> get breakdown;

}
/// @nodoc
class _$PrintOrderCopyWithImpl<$Res>
    implements $PrintOrderCopyWith<$Res> {
  _$PrintOrderCopyWithImpl(this._self, this._then);

  final PrintOrder _self;
  final $Res Function(PrintOrder) _then;

/// Create a copy of PrintOrder
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? quoteNumber = null,Object? customerId = null,Object? title = null,Object? status = null,Object? validUntil = null,Object? quantity = null,Object? printerId = null,Object? printTimeSeconds = null,Object? filaments = null,Object? prepMinutes = null,Object? postMinutes = null,Object? extras = null,Object? markupBasisPoints = null,Object? failureBasisPoints = null,Object? vatBasisPoints = null,Object? currencyCode = null,Object? quoteLanguage = null,Object? breakdown = null,Object? stockDeducted = null,Object? deductedGrams = null,Object? stockWarning = null,Object? depositMinor = null,Object? depositAt = null,Object? revenueAt = null,Object? sourceUrl = null,Object? sourceModelTitle = null,Object? sourceProfileTitle = null,Object? note = null,Object? lines = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,quoteNumber: null == quoteNumber ? _self.quoteNumber : quoteNumber // ignore: cast_nullable_to_non_nullable
as int,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OrderStatus,validUntil: null == validUntil ? _self.validUntil : validUntil // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,printerId: null == printerId ? _self.printerId : printerId // ignore: cast_nullable_to_non_nullable
as String,printTimeSeconds: null == printTimeSeconds ? _self.printTimeSeconds : printTimeSeconds // ignore: cast_nullable_to_non_nullable
as int,filaments: null == filaments ? _self.filaments : filaments // ignore: cast_nullable_to_non_nullable
as List<FilamentUsage>,prepMinutes: null == prepMinutes ? _self.prepMinutes : prepMinutes // ignore: cast_nullable_to_non_nullable
as int,postMinutes: null == postMinutes ? _self.postMinutes : postMinutes // ignore: cast_nullable_to_non_nullable
as int,extras: null == extras ? _self.extras : extras // ignore: cast_nullable_to_non_nullable
as List<ExtraCost>,markupBasisPoints: null == markupBasisPoints ? _self.markupBasisPoints : markupBasisPoints // ignore: cast_nullable_to_non_nullable
as int,failureBasisPoints: null == failureBasisPoints ? _self.failureBasisPoints : failureBasisPoints // ignore: cast_nullable_to_non_nullable
as int,vatBasisPoints: null == vatBasisPoints ? _self.vatBasisPoints : vatBasisPoints // ignore: cast_nullable_to_non_nullable
as int,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,quoteLanguage: null == quoteLanguage ? _self.quoteLanguage : quoteLanguage // ignore: cast_nullable_to_non_nullable
as String,breakdown: null == breakdown ? _self.breakdown : breakdown // ignore: cast_nullable_to_non_nullable
as PriceBreakdown,stockDeducted: null == stockDeducted ? _self.stockDeducted : stockDeducted // ignore: cast_nullable_to_non_nullable
as bool,deductedGrams: null == deductedGrams ? _self.deductedGrams : deductedGrams // ignore: cast_nullable_to_non_nullable
as Map<String, double>,stockWarning: null == stockWarning ? _self.stockWarning : stockWarning // ignore: cast_nullable_to_non_nullable
as String,depositMinor: null == depositMinor ? _self.depositMinor : depositMinor // ignore: cast_nullable_to_non_nullable
as int,depositAt: null == depositAt ? _self.depositAt : depositAt // ignore: cast_nullable_to_non_nullable
as String,revenueAt: null == revenueAt ? _self.revenueAt : revenueAt // ignore: cast_nullable_to_non_nullable
as String,sourceUrl: null == sourceUrl ? _self.sourceUrl : sourceUrl // ignore: cast_nullable_to_non_nullable
as String,sourceModelTitle: null == sourceModelTitle ? _self.sourceModelTitle : sourceModelTitle // ignore: cast_nullable_to_non_nullable
as String,sourceProfileTitle: null == sourceProfileTitle ? _self.sourceProfileTitle : sourceProfileTitle // ignore: cast_nullable_to_non_nullable
as String,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,lines: null == lines ? _self.lines : lines // ignore: cast_nullable_to_non_nullable
as List<QuoteLine>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of PrintOrder
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PriceBreakdownCopyWith<$Res> get breakdown {
  
  return $PriceBreakdownCopyWith<$Res>(_self.breakdown, (value) {
    return _then(_self.copyWith(breakdown: value));
  });
}
}


/// Adds pattern-matching-related methods to [PrintOrder].
extension PrintOrderPatterns on PrintOrder {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PrintOrder value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PrintOrder() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PrintOrder value)  $default,){
final _that = this;
switch (_that) {
case _PrintOrder():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PrintOrder value)?  $default,){
final _that = this;
switch (_that) {
case _PrintOrder() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  int quoteNumber,  String customerId,  String title, @JsonKey(fromJson: orderStatusFromJson, toJson: orderStatusToJson)  OrderStatus status,  String validUntil,  int quantity,  String printerId,  int printTimeSeconds,  List<FilamentUsage> filaments,  int prepMinutes,  int postMinutes,  List<ExtraCost> extras,  int markupBasisPoints,  int failureBasisPoints,  int vatBasisPoints, @JsonKey(readValue: readCurrencyCode)  String currencyCode,  String quoteLanguage,  PriceBreakdown breakdown,  bool stockDeducted,  Map<String, double> deductedGrams,  String stockWarning,  int depositMinor,  String depositAt,  String revenueAt,  String sourceUrl,  String sourceModelTitle,  String sourceProfileTitle,  String note,  List<QuoteLine> lines,  String createdAt,  String updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PrintOrder() when $default != null:
return $default(_that.id,_that.quoteNumber,_that.customerId,_that.title,_that.status,_that.validUntil,_that.quantity,_that.printerId,_that.printTimeSeconds,_that.filaments,_that.prepMinutes,_that.postMinutes,_that.extras,_that.markupBasisPoints,_that.failureBasisPoints,_that.vatBasisPoints,_that.currencyCode,_that.quoteLanguage,_that.breakdown,_that.stockDeducted,_that.deductedGrams,_that.stockWarning,_that.depositMinor,_that.depositAt,_that.revenueAt,_that.sourceUrl,_that.sourceModelTitle,_that.sourceProfileTitle,_that.note,_that.lines,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  int quoteNumber,  String customerId,  String title, @JsonKey(fromJson: orderStatusFromJson, toJson: orderStatusToJson)  OrderStatus status,  String validUntil,  int quantity,  String printerId,  int printTimeSeconds,  List<FilamentUsage> filaments,  int prepMinutes,  int postMinutes,  List<ExtraCost> extras,  int markupBasisPoints,  int failureBasisPoints,  int vatBasisPoints, @JsonKey(readValue: readCurrencyCode)  String currencyCode,  String quoteLanguage,  PriceBreakdown breakdown,  bool stockDeducted,  Map<String, double> deductedGrams,  String stockWarning,  int depositMinor,  String depositAt,  String revenueAt,  String sourceUrl,  String sourceModelTitle,  String sourceProfileTitle,  String note,  List<QuoteLine> lines,  String createdAt,  String updatedAt)  $default,) {final _that = this;
switch (_that) {
case _PrintOrder():
return $default(_that.id,_that.quoteNumber,_that.customerId,_that.title,_that.status,_that.validUntil,_that.quantity,_that.printerId,_that.printTimeSeconds,_that.filaments,_that.prepMinutes,_that.postMinutes,_that.extras,_that.markupBasisPoints,_that.failureBasisPoints,_that.vatBasisPoints,_that.currencyCode,_that.quoteLanguage,_that.breakdown,_that.stockDeducted,_that.deductedGrams,_that.stockWarning,_that.depositMinor,_that.depositAt,_that.revenueAt,_that.sourceUrl,_that.sourceModelTitle,_that.sourceProfileTitle,_that.note,_that.lines,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  int quoteNumber,  String customerId,  String title, @JsonKey(fromJson: orderStatusFromJson, toJson: orderStatusToJson)  OrderStatus status,  String validUntil,  int quantity,  String printerId,  int printTimeSeconds,  List<FilamentUsage> filaments,  int prepMinutes,  int postMinutes,  List<ExtraCost> extras,  int markupBasisPoints,  int failureBasisPoints,  int vatBasisPoints, @JsonKey(readValue: readCurrencyCode)  String currencyCode,  String quoteLanguage,  PriceBreakdown breakdown,  bool stockDeducted,  Map<String, double> deductedGrams,  String stockWarning,  int depositMinor,  String depositAt,  String revenueAt,  String sourceUrl,  String sourceModelTitle,  String sourceProfileTitle,  String note,  List<QuoteLine> lines,  String createdAt,  String updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _PrintOrder() when $default != null:
return $default(_that.id,_that.quoteNumber,_that.customerId,_that.title,_that.status,_that.validUntil,_that.quantity,_that.printerId,_that.printTimeSeconds,_that.filaments,_that.prepMinutes,_that.postMinutes,_that.extras,_that.markupBasisPoints,_that.failureBasisPoints,_that.vatBasisPoints,_that.currencyCode,_that.quoteLanguage,_that.breakdown,_that.stockDeducted,_that.deductedGrams,_that.stockWarning,_that.depositMinor,_that.depositAt,_that.revenueAt,_that.sourceUrl,_that.sourceModelTitle,_that.sourceProfileTitle,_that.note,_that.lines,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PrintOrder implements PrintOrder {
  const _PrintOrder({required this.id, required this.quoteNumber, this.customerId = '', required this.title, @JsonKey(fromJson: orderStatusFromJson, toJson: orderStatusToJson) required this.status, required this.validUntil, required this.quantity, this.printerId = '', required this.printTimeSeconds, required final  List<FilamentUsage> filaments, this.prepMinutes = 0, this.postMinutes = 0, final  List<ExtraCost> extras = const [], required this.markupBasisPoints, required this.failureBasisPoints, required this.vatBasisPoints, @JsonKey(readValue: readCurrencyCode) this.currencyCode = 'SEK', this.quoteLanguage = '', required this.breakdown, this.stockDeducted = false, final  Map<String, double> deductedGrams = const <String, double>{}, this.stockWarning = '', this.depositMinor = 0, this.depositAt = '', this.revenueAt = '', this.sourceUrl = '', this.sourceModelTitle = '', this.sourceProfileTitle = '', this.note = '', final  List<QuoteLine> lines = const [], required this.createdAt, required this.updatedAt}): _filaments = filaments,_extras = extras,_deductedGrams = deductedGrams,_lines = lines;
  factory _PrintOrder.fromJson(Map<String, dynamic> json) => _$PrintOrderFromJson(json);

@override final  String id;
@override final  int quoteNumber;
@override@JsonKey() final  String customerId;
@override final  String title;
@override@JsonKey(fromJson: orderStatusFromJson, toJson: orderStatusToJson) final  OrderStatus status;
@override final  String validUntil;
@override final  int quantity;
@override@JsonKey() final  String printerId;
@override final  int printTimeSeconds;
 final  List<FilamentUsage> _filaments;
@override List<FilamentUsage> get filaments {
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

@override final  int markupBasisPoints;
@override final  int failureBasisPoints;
@override final  int vatBasisPoints;
/// Missing on older orders. Those quotes stay in SEK. No conversion.
@override@JsonKey(readValue: readCurrencyCode) final  String currencyCode;
/// Customer PDF language. Empty follows the app language at preview time.
@override@JsonKey() final  String quoteLanguage;
@override final  PriceBreakdown breakdown;
@override@JsonKey() final  bool stockDeducted;
 final  Map<String, double> _deductedGrams;
@override@JsonKey() Map<String, double> get deductedGrams {
  if (_deductedGrams is EqualUnmodifiableMapView) return _deductedGrams;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_deductedGrams);
}

@override@JsonKey() final  String stockWarning;
@override@JsonKey() final  int depositMinor;
/// When the deposit was received, as a UTC timestamp. Empty on older
/// orders: Home then keeps the whole total in the print month.
@override@JsonKey() final  String depositAt;
@override@JsonKey() final  String revenueAt;
@override@JsonKey() final  String sourceUrl;
@override@JsonKey() final  String sourceModelTitle;
@override@JsonKey() final  String sourceProfileTitle;
@override@JsonKey() final  String note;
 final  List<QuoteLine> _lines;
@override@JsonKey() List<QuoteLine> get lines {
  if (_lines is EqualUnmodifiableListView) return _lines;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_lines);
}

@override final  String createdAt;
@override final  String updatedAt;

/// Create a copy of PrintOrder
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PrintOrderCopyWith<_PrintOrder> get copyWith => __$PrintOrderCopyWithImpl<_PrintOrder>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PrintOrderToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PrintOrder&&(identical(other.id, id) || other.id == id)&&(identical(other.quoteNumber, quoteNumber) || other.quoteNumber == quoteNumber)&&(identical(other.customerId, customerId) || other.customerId == customerId)&&(identical(other.title, title) || other.title == title)&&(identical(other.status, status) || other.status == status)&&(identical(other.validUntil, validUntil) || other.validUntil == validUntil)&&(identical(other.quantity, quantity) || other.quantity == quantity)&&(identical(other.printerId, printerId) || other.printerId == printerId)&&(identical(other.printTimeSeconds, printTimeSeconds) || other.printTimeSeconds == printTimeSeconds)&&const DeepCollectionEquality().equals(other._filaments, _filaments)&&(identical(other.prepMinutes, prepMinutes) || other.prepMinutes == prepMinutes)&&(identical(other.postMinutes, postMinutes) || other.postMinutes == postMinutes)&&const DeepCollectionEquality().equals(other._extras, _extras)&&(identical(other.markupBasisPoints, markupBasisPoints) || other.markupBasisPoints == markupBasisPoints)&&(identical(other.failureBasisPoints, failureBasisPoints) || other.failureBasisPoints == failureBasisPoints)&&(identical(other.vatBasisPoints, vatBasisPoints) || other.vatBasisPoints == vatBasisPoints)&&(identical(other.currencyCode, currencyCode) || other.currencyCode == currencyCode)&&(identical(other.quoteLanguage, quoteLanguage) || other.quoteLanguage == quoteLanguage)&&(identical(other.breakdown, breakdown) || other.breakdown == breakdown)&&(identical(other.stockDeducted, stockDeducted) || other.stockDeducted == stockDeducted)&&const DeepCollectionEquality().equals(other._deductedGrams, _deductedGrams)&&(identical(other.stockWarning, stockWarning) || other.stockWarning == stockWarning)&&(identical(other.depositMinor, depositMinor) || other.depositMinor == depositMinor)&&(identical(other.depositAt, depositAt) || other.depositAt == depositAt)&&(identical(other.revenueAt, revenueAt) || other.revenueAt == revenueAt)&&(identical(other.sourceUrl, sourceUrl) || other.sourceUrl == sourceUrl)&&(identical(other.sourceModelTitle, sourceModelTitle) || other.sourceModelTitle == sourceModelTitle)&&(identical(other.sourceProfileTitle, sourceProfileTitle) || other.sourceProfileTitle == sourceProfileTitle)&&(identical(other.note, note) || other.note == note)&&const DeepCollectionEquality().equals(other._lines, _lines)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,quoteNumber,customerId,title,status,validUntil,quantity,printerId,printTimeSeconds,const DeepCollectionEquality().hash(_filaments),prepMinutes,postMinutes,const DeepCollectionEquality().hash(_extras),markupBasisPoints,failureBasisPoints,vatBasisPoints,currencyCode,quoteLanguage,breakdown,stockDeducted,const DeepCollectionEquality().hash(_deductedGrams),stockWarning,depositMinor,depositAt,revenueAt,sourceUrl,sourceModelTitle,sourceProfileTitle,note,const DeepCollectionEquality().hash(_lines),createdAt,updatedAt]);

@override
String toString() {
  return 'PrintOrder(id: $id, quoteNumber: $quoteNumber, customerId: $customerId, title: $title, status: $status, validUntil: $validUntil, quantity: $quantity, printerId: $printerId, printTimeSeconds: $printTimeSeconds, filaments: $filaments, prepMinutes: $prepMinutes, postMinutes: $postMinutes, extras: $extras, markupBasisPoints: $markupBasisPoints, failureBasisPoints: $failureBasisPoints, vatBasisPoints: $vatBasisPoints, currencyCode: $currencyCode, quoteLanguage: $quoteLanguage, breakdown: $breakdown, stockDeducted: $stockDeducted, deductedGrams: $deductedGrams, stockWarning: $stockWarning, depositMinor: $depositMinor, depositAt: $depositAt, revenueAt: $revenueAt, sourceUrl: $sourceUrl, sourceModelTitle: $sourceModelTitle, sourceProfileTitle: $sourceProfileTitle, note: $note, lines: $lines, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$PrintOrderCopyWith<$Res> implements $PrintOrderCopyWith<$Res> {
  factory _$PrintOrderCopyWith(_PrintOrder value, $Res Function(_PrintOrder) _then) = __$PrintOrderCopyWithImpl;
@override @useResult
$Res call({
 String id, int quoteNumber, String customerId, String title,@JsonKey(fromJson: orderStatusFromJson, toJson: orderStatusToJson) OrderStatus status, String validUntil, int quantity, String printerId, int printTimeSeconds, List<FilamentUsage> filaments, int prepMinutes, int postMinutes, List<ExtraCost> extras, int markupBasisPoints, int failureBasisPoints, int vatBasisPoints,@JsonKey(readValue: readCurrencyCode) String currencyCode, String quoteLanguage, PriceBreakdown breakdown, bool stockDeducted, Map<String, double> deductedGrams, String stockWarning, int depositMinor, String depositAt, String revenueAt, String sourceUrl, String sourceModelTitle, String sourceProfileTitle, String note, List<QuoteLine> lines, String createdAt, String updatedAt
});


@override $PriceBreakdownCopyWith<$Res> get breakdown;

}
/// @nodoc
class __$PrintOrderCopyWithImpl<$Res>
    implements _$PrintOrderCopyWith<$Res> {
  __$PrintOrderCopyWithImpl(this._self, this._then);

  final _PrintOrder _self;
  final $Res Function(_PrintOrder) _then;

/// Create a copy of PrintOrder
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? quoteNumber = null,Object? customerId = null,Object? title = null,Object? status = null,Object? validUntil = null,Object? quantity = null,Object? printerId = null,Object? printTimeSeconds = null,Object? filaments = null,Object? prepMinutes = null,Object? postMinutes = null,Object? extras = null,Object? markupBasisPoints = null,Object? failureBasisPoints = null,Object? vatBasisPoints = null,Object? currencyCode = null,Object? quoteLanguage = null,Object? breakdown = null,Object? stockDeducted = null,Object? deductedGrams = null,Object? stockWarning = null,Object? depositMinor = null,Object? depositAt = null,Object? revenueAt = null,Object? sourceUrl = null,Object? sourceModelTitle = null,Object? sourceProfileTitle = null,Object? note = null,Object? lines = null,Object? createdAt = null,Object? updatedAt = null,}) {
  return _then(_PrintOrder(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,quoteNumber: null == quoteNumber ? _self.quoteNumber : quoteNumber // ignore: cast_nullable_to_non_nullable
as int,customerId: null == customerId ? _self.customerId : customerId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as OrderStatus,validUntil: null == validUntil ? _self.validUntil : validUntil // ignore: cast_nullable_to_non_nullable
as String,quantity: null == quantity ? _self.quantity : quantity // ignore: cast_nullable_to_non_nullable
as int,printerId: null == printerId ? _self.printerId : printerId // ignore: cast_nullable_to_non_nullable
as String,printTimeSeconds: null == printTimeSeconds ? _self.printTimeSeconds : printTimeSeconds // ignore: cast_nullable_to_non_nullable
as int,filaments: null == filaments ? _self._filaments : filaments // ignore: cast_nullable_to_non_nullable
as List<FilamentUsage>,prepMinutes: null == prepMinutes ? _self.prepMinutes : prepMinutes // ignore: cast_nullable_to_non_nullable
as int,postMinutes: null == postMinutes ? _self.postMinutes : postMinutes // ignore: cast_nullable_to_non_nullable
as int,extras: null == extras ? _self._extras : extras // ignore: cast_nullable_to_non_nullable
as List<ExtraCost>,markupBasisPoints: null == markupBasisPoints ? _self.markupBasisPoints : markupBasisPoints // ignore: cast_nullable_to_non_nullable
as int,failureBasisPoints: null == failureBasisPoints ? _self.failureBasisPoints : failureBasisPoints // ignore: cast_nullable_to_non_nullable
as int,vatBasisPoints: null == vatBasisPoints ? _self.vatBasisPoints : vatBasisPoints // ignore: cast_nullable_to_non_nullable
as int,currencyCode: null == currencyCode ? _self.currencyCode : currencyCode // ignore: cast_nullable_to_non_nullable
as String,quoteLanguage: null == quoteLanguage ? _self.quoteLanguage : quoteLanguage // ignore: cast_nullable_to_non_nullable
as String,breakdown: null == breakdown ? _self.breakdown : breakdown // ignore: cast_nullable_to_non_nullable
as PriceBreakdown,stockDeducted: null == stockDeducted ? _self.stockDeducted : stockDeducted // ignore: cast_nullable_to_non_nullable
as bool,deductedGrams: null == deductedGrams ? _self._deductedGrams : deductedGrams // ignore: cast_nullable_to_non_nullable
as Map<String, double>,stockWarning: null == stockWarning ? _self.stockWarning : stockWarning // ignore: cast_nullable_to_non_nullable
as String,depositMinor: null == depositMinor ? _self.depositMinor : depositMinor // ignore: cast_nullable_to_non_nullable
as int,depositAt: null == depositAt ? _self.depositAt : depositAt // ignore: cast_nullable_to_non_nullable
as String,revenueAt: null == revenueAt ? _self.revenueAt : revenueAt // ignore: cast_nullable_to_non_nullable
as String,sourceUrl: null == sourceUrl ? _self.sourceUrl : sourceUrl // ignore: cast_nullable_to_non_nullable
as String,sourceModelTitle: null == sourceModelTitle ? _self.sourceModelTitle : sourceModelTitle // ignore: cast_nullable_to_non_nullable
as String,sourceProfileTitle: null == sourceProfileTitle ? _self.sourceProfileTitle : sourceProfileTitle // ignore: cast_nullable_to_non_nullable
as String,note: null == note ? _self.note : note // ignore: cast_nullable_to_non_nullable
as String,lines: null == lines ? _self._lines : lines // ignore: cast_nullable_to_non_nullable
as List<QuoteLine>,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of PrintOrder
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PriceBreakdownCopyWith<$Res> get breakdown {
  
  return $PriceBreakdownCopyWith<$Res>(_self.breakdown, (value) {
    return _then(_self.copyWith(breakdown: value));
  });
}
}

// dart format on
