// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cv_format_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CVFormatResponse {

/// Success status
 bool get success;/// Formatted CV URL or data
 String? get formattedCv;/// Message
 String? get message;
/// Create a copy of CVFormatResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CVFormatResponseCopyWith<CVFormatResponse> get copyWith => _$CVFormatResponseCopyWithImpl<CVFormatResponse>(this as CVFormatResponse, _$identity);

  /// Serializes this CVFormatResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CVFormatResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.formattedCv, formattedCv) || other.formattedCv == formattedCv)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,formattedCv,message);

@override
String toString() {
  return 'CVFormatResponse(success: $success, formattedCv: $formattedCv, message: $message)';
}


}

/// @nodoc
abstract mixin class $CVFormatResponseCopyWith<$Res>  {
  factory $CVFormatResponseCopyWith(CVFormatResponse value, $Res Function(CVFormatResponse) _then) = _$CVFormatResponseCopyWithImpl;
@useResult
$Res call({
 bool success, String? formattedCv, String? message
});




}
/// @nodoc
class _$CVFormatResponseCopyWithImpl<$Res>
    implements $CVFormatResponseCopyWith<$Res> {
  _$CVFormatResponseCopyWithImpl(this._self, this._then);

  final CVFormatResponse _self;
  final $Res Function(CVFormatResponse) _then;

/// Create a copy of CVFormatResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? formattedCv = freezed,Object? message = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,formattedCv: freezed == formattedCv ? _self.formattedCv : formattedCv // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CVFormatResponse].
extension CVFormatResponsePatterns on CVFormatResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CVFormatResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CVFormatResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CVFormatResponse value)  $default,){
final _that = this;
switch (_that) {
case _CVFormatResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CVFormatResponse value)?  $default,){
final _that = this;
switch (_that) {
case _CVFormatResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String? formattedCv,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CVFormatResponse() when $default != null:
return $default(_that.success,_that.formattedCv,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String? formattedCv,  String? message)  $default,) {final _that = this;
switch (_that) {
case _CVFormatResponse():
return $default(_that.success,_that.formattedCv,_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String? formattedCv,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _CVFormatResponse() when $default != null:
return $default(_that.success,_that.formattedCv,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CVFormatResponse implements CVFormatResponse {
  const _CVFormatResponse({required this.success, this.formattedCv, this.message});
  factory _CVFormatResponse.fromJson(Map<String, dynamic> json) => _$CVFormatResponseFromJson(json);

/// Success status
@override final  bool success;
/// Formatted CV URL or data
@override final  String? formattedCv;
/// Message
@override final  String? message;

/// Create a copy of CVFormatResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CVFormatResponseCopyWith<_CVFormatResponse> get copyWith => __$CVFormatResponseCopyWithImpl<_CVFormatResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CVFormatResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CVFormatResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.formattedCv, formattedCv) || other.formattedCv == formattedCv)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,formattedCv,message);

@override
String toString() {
  return 'CVFormatResponse(success: $success, formattedCv: $formattedCv, message: $message)';
}


}

/// @nodoc
abstract mixin class _$CVFormatResponseCopyWith<$Res> implements $CVFormatResponseCopyWith<$Res> {
  factory _$CVFormatResponseCopyWith(_CVFormatResponse value, $Res Function(_CVFormatResponse) _then) = __$CVFormatResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, String? formattedCv, String? message
});




}
/// @nodoc
class __$CVFormatResponseCopyWithImpl<$Res>
    implements _$CVFormatResponseCopyWith<$Res> {
  __$CVFormatResponseCopyWithImpl(this._self, this._then);

  final _CVFormatResponse _self;
  final $Res Function(_CVFormatResponse) _then;

/// Create a copy of CVFormatResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? formattedCv = freezed,Object? message = freezed,}) {
  return _then(_CVFormatResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,formattedCv: freezed == formattedCv ? _self.formattedCv : formattedCv // ignore: cast_nullable_to_non_nullable
as String?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
