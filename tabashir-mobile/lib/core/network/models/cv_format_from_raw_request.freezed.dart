// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cv_format_from_raw_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CVFormatFromRawRequest {

/// Raw CV text data
@JsonKey(name: 'raw_data') String get rawData;/// Output language: 'regular' or 'arabic'
 String? get outputLanguage;
/// Create a copy of CVFormatFromRawRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CVFormatFromRawRequestCopyWith<CVFormatFromRawRequest> get copyWith => _$CVFormatFromRawRequestCopyWithImpl<CVFormatFromRawRequest>(this as CVFormatFromRawRequest, _$identity);

  /// Serializes this CVFormatFromRawRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CVFormatFromRawRequest&&(identical(other.rawData, rawData) || other.rawData == rawData)&&(identical(other.outputLanguage, outputLanguage) || other.outputLanguage == outputLanguage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rawData,outputLanguage);

@override
String toString() {
  return 'CVFormatFromRawRequest(rawData: $rawData, outputLanguage: $outputLanguage)';
}


}

/// @nodoc
abstract mixin class $CVFormatFromRawRequestCopyWith<$Res>  {
  factory $CVFormatFromRawRequestCopyWith(CVFormatFromRawRequest value, $Res Function(CVFormatFromRawRequest) _then) = _$CVFormatFromRawRequestCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'raw_data') String rawData, String? outputLanguage
});




}
/// @nodoc
class _$CVFormatFromRawRequestCopyWithImpl<$Res>
    implements $CVFormatFromRawRequestCopyWith<$Res> {
  _$CVFormatFromRawRequestCopyWithImpl(this._self, this._then);

  final CVFormatFromRawRequest _self;
  final $Res Function(CVFormatFromRawRequest) _then;

/// Create a copy of CVFormatFromRawRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? rawData = null,Object? outputLanguage = freezed,}) {
  return _then(_self.copyWith(
rawData: null == rawData ? _self.rawData : rawData // ignore: cast_nullable_to_non_nullable
as String,outputLanguage: freezed == outputLanguage ? _self.outputLanguage : outputLanguage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CVFormatFromRawRequest].
extension CVFormatFromRawRequestPatterns on CVFormatFromRawRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CVFormatFromRawRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CVFormatFromRawRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CVFormatFromRawRequest value)  $default,){
final _that = this;
switch (_that) {
case _CVFormatFromRawRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CVFormatFromRawRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CVFormatFromRawRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'raw_data')  String rawData,  String? outputLanguage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CVFormatFromRawRequest() when $default != null:
return $default(_that.rawData,_that.outputLanguage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'raw_data')  String rawData,  String? outputLanguage)  $default,) {final _that = this;
switch (_that) {
case _CVFormatFromRawRequest():
return $default(_that.rawData,_that.outputLanguage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'raw_data')  String rawData,  String? outputLanguage)?  $default,) {final _that = this;
switch (_that) {
case _CVFormatFromRawRequest() when $default != null:
return $default(_that.rawData,_that.outputLanguage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CVFormatFromRawRequest implements CVFormatFromRawRequest {
  const _CVFormatFromRawRequest({@JsonKey(name: 'raw_data') required this.rawData, this.outputLanguage = 'regular'});
  factory _CVFormatFromRawRequest.fromJson(Map<String, dynamic> json) => _$CVFormatFromRawRequestFromJson(json);

/// Raw CV text data
@override@JsonKey(name: 'raw_data') final  String rawData;
/// Output language: 'regular' or 'arabic'
@override@JsonKey() final  String? outputLanguage;

/// Create a copy of CVFormatFromRawRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CVFormatFromRawRequestCopyWith<_CVFormatFromRawRequest> get copyWith => __$CVFormatFromRawRequestCopyWithImpl<_CVFormatFromRawRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CVFormatFromRawRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CVFormatFromRawRequest&&(identical(other.rawData, rawData) || other.rawData == rawData)&&(identical(other.outputLanguage, outputLanguage) || other.outputLanguage == outputLanguage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,rawData,outputLanguage);

@override
String toString() {
  return 'CVFormatFromRawRequest(rawData: $rawData, outputLanguage: $outputLanguage)';
}


}

/// @nodoc
abstract mixin class _$CVFormatFromRawRequestCopyWith<$Res> implements $CVFormatFromRawRequestCopyWith<$Res> {
  factory _$CVFormatFromRawRequestCopyWith(_CVFormatFromRawRequest value, $Res Function(_CVFormatFromRawRequest) _then) = __$CVFormatFromRawRequestCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'raw_data') String rawData, String? outputLanguage
});




}
/// @nodoc
class __$CVFormatFromRawRequestCopyWithImpl<$Res>
    implements _$CVFormatFromRawRequestCopyWith<$Res> {
  __$CVFormatFromRawRequestCopyWithImpl(this._self, this._then);

  final _CVFormatFromRawRequest _self;
  final $Res Function(_CVFormatFromRawRequest) _then;

/// Create a copy of CVFormatFromRawRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? rawData = null,Object? outputLanguage = freezed,}) {
  return _then(_CVFormatFromRawRequest(
rawData: null == rawData ? _self.rawData : rawData // ignore: cast_nullable_to_non_nullable
as String,outputLanguage: freezed == outputLanguage ? _self.outputLanguage : outputLanguage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
