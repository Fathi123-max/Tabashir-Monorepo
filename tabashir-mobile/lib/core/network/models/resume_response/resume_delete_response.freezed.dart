// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'resume_delete_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ResumeDeleteResponse {

 bool get success; String? get message;
/// Create a copy of ResumeDeleteResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResumeDeleteResponseCopyWith<ResumeDeleteResponse> get copyWith => _$ResumeDeleteResponseCopyWithImpl<ResumeDeleteResponse>(this as ResumeDeleteResponse, _$identity);

  /// Serializes this ResumeDeleteResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResumeDeleteResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message);

@override
String toString() {
  return 'ResumeDeleteResponse(success: $success, message: $message)';
}


}

/// @nodoc
abstract mixin class $ResumeDeleteResponseCopyWith<$Res>  {
  factory $ResumeDeleteResponseCopyWith(ResumeDeleteResponse value, $Res Function(ResumeDeleteResponse) _then) = _$ResumeDeleteResponseCopyWithImpl;
@useResult
$Res call({
 bool success, String? message
});




}
/// @nodoc
class _$ResumeDeleteResponseCopyWithImpl<$Res>
    implements $ResumeDeleteResponseCopyWith<$Res> {
  _$ResumeDeleteResponseCopyWithImpl(this._self, this._then);

  final ResumeDeleteResponse _self;
  final $Res Function(ResumeDeleteResponse) _then;

/// Create a copy of ResumeDeleteResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ResumeDeleteResponse].
extension ResumeDeleteResponsePatterns on ResumeDeleteResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResumeDeleteResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResumeDeleteResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResumeDeleteResponse value)  $default,){
final _that = this;
switch (_that) {
case _ResumeDeleteResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResumeDeleteResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ResumeDeleteResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResumeDeleteResponse() when $default != null:
return $default(_that.success,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String? message)  $default,) {final _that = this;
switch (_that) {
case _ResumeDeleteResponse():
return $default(_that.success,_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _ResumeDeleteResponse() when $default != null:
return $default(_that.success,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ResumeDeleteResponse implements ResumeDeleteResponse {
  const _ResumeDeleteResponse({required this.success, this.message});
  factory _ResumeDeleteResponse.fromJson(Map<String, dynamic> json) => _$ResumeDeleteResponseFromJson(json);

@override final  bool success;
@override final  String? message;

/// Create a copy of ResumeDeleteResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResumeDeleteResponseCopyWith<_ResumeDeleteResponse> get copyWith => __$ResumeDeleteResponseCopyWithImpl<_ResumeDeleteResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ResumeDeleteResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResumeDeleteResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message);

@override
String toString() {
  return 'ResumeDeleteResponse(success: $success, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ResumeDeleteResponseCopyWith<$Res> implements $ResumeDeleteResponseCopyWith<$Res> {
  factory _$ResumeDeleteResponseCopyWith(_ResumeDeleteResponse value, $Res Function(_ResumeDeleteResponse) _then) = __$ResumeDeleteResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, String? message
});




}
/// @nodoc
class __$ResumeDeleteResponseCopyWithImpl<$Res>
    implements _$ResumeDeleteResponseCopyWith<$Res> {
  __$ResumeDeleteResponseCopyWithImpl(this._self, this._then);

  final _ResumeDeleteResponse _self;
  final $Res Function(_ResumeDeleteResponse) _then;

/// Create a copy of ResumeDeleteResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = freezed,}) {
  return _then(_ResumeDeleteResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
