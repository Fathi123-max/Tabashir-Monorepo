// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'raw_cv_input.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RawCVInput {

/// User ID for the request
@JsonKey(name: 'user_id') String get userId;/// Raw text extracted from CV
@JsonKey(name: 'raw_data') String get rawData;/// Output language: 'regular' or 'arabic'
 String? get outputLanguage;
/// Create a copy of RawCVInput
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RawCVInputCopyWith<RawCVInput> get copyWith => _$RawCVInputCopyWithImpl<RawCVInput>(this as RawCVInput, _$identity);

  /// Serializes this RawCVInput to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RawCVInput&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.rawData, rawData) || other.rawData == rawData)&&(identical(other.outputLanguage, outputLanguage) || other.outputLanguage == outputLanguage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,rawData,outputLanguage);

@override
String toString() {
  return 'RawCVInput(userId: $userId, rawData: $rawData, outputLanguage: $outputLanguage)';
}


}

/// @nodoc
abstract mixin class $RawCVInputCopyWith<$Res>  {
  factory $RawCVInputCopyWith(RawCVInput value, $Res Function(RawCVInput) _then) = _$RawCVInputCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'raw_data') String rawData, String? outputLanguage
});




}
/// @nodoc
class _$RawCVInputCopyWithImpl<$Res>
    implements $RawCVInputCopyWith<$Res> {
  _$RawCVInputCopyWithImpl(this._self, this._then);

  final RawCVInput _self;
  final $Res Function(RawCVInput) _then;

/// Create a copy of RawCVInput
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = null,Object? rawData = null,Object? outputLanguage = freezed,}) {
  return _then(_self.copyWith(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,rawData: null == rawData ? _self.rawData : rawData // ignore: cast_nullable_to_non_nullable
as String,outputLanguage: freezed == outputLanguage ? _self.outputLanguage : outputLanguage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RawCVInput].
extension RawCVInputPatterns on RawCVInput {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RawCVInput value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RawCVInput() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RawCVInput value)  $default,){
final _that = this;
switch (_that) {
case _RawCVInput():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RawCVInput value)?  $default,){
final _that = this;
switch (_that) {
case _RawCVInput() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'raw_data')  String rawData,  String? outputLanguage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RawCVInput() when $default != null:
return $default(_that.userId,_that.rawData,_that.outputLanguage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'raw_data')  String rawData,  String? outputLanguage)  $default,) {final _that = this;
switch (_that) {
case _RawCVInput():
return $default(_that.userId,_that.rawData,_that.outputLanguage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'user_id')  String userId, @JsonKey(name: 'raw_data')  String rawData,  String? outputLanguage)?  $default,) {final _that = this;
switch (_that) {
case _RawCVInput() when $default != null:
return $default(_that.userId,_that.rawData,_that.outputLanguage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RawCVInput implements RawCVInput {
  const _RawCVInput({@JsonKey(name: 'user_id') required this.userId, @JsonKey(name: 'raw_data') required this.rawData, this.outputLanguage = 'regular'});
  factory _RawCVInput.fromJson(Map<String, dynamic> json) => _$RawCVInputFromJson(json);

/// User ID for the request
@override@JsonKey(name: 'user_id') final  String userId;
/// Raw text extracted from CV
@override@JsonKey(name: 'raw_data') final  String rawData;
/// Output language: 'regular' or 'arabic'
@override@JsonKey() final  String? outputLanguage;

/// Create a copy of RawCVInput
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RawCVInputCopyWith<_RawCVInput> get copyWith => __$RawCVInputCopyWithImpl<_RawCVInput>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RawCVInputToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RawCVInput&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.rawData, rawData) || other.rawData == rawData)&&(identical(other.outputLanguage, outputLanguage) || other.outputLanguage == outputLanguage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,rawData,outputLanguage);

@override
String toString() {
  return 'RawCVInput(userId: $userId, rawData: $rawData, outputLanguage: $outputLanguage)';
}


}

/// @nodoc
abstract mixin class _$RawCVInputCopyWith<$Res> implements $RawCVInputCopyWith<$Res> {
  factory _$RawCVInputCopyWith(_RawCVInput value, $Res Function(_RawCVInput) _then) = __$RawCVInputCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'user_id') String userId,@JsonKey(name: 'raw_data') String rawData, String? outputLanguage
});




}
/// @nodoc
class __$RawCVInputCopyWithImpl<$Res>
    implements _$RawCVInputCopyWith<$Res> {
  __$RawCVInputCopyWithImpl(this._self, this._then);

  final _RawCVInput _self;
  final $Res Function(_RawCVInput) _then;

/// Create a copy of RawCVInput
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = null,Object? rawData = null,Object? outputLanguage = freezed,}) {
  return _then(_RawCVInput(
userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,rawData: null == rawData ? _self.rawData : rawData // ignore: cast_nullable_to_non_nullable
as String,outputLanguage: freezed == outputLanguage ? _self.outputLanguage : outputLanguage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
