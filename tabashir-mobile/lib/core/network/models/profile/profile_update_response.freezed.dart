// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_update_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProfileUpdateResponse {

 bool get success; String get message;
/// Create a copy of ProfileUpdateResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileUpdateResponseCopyWith<ProfileUpdateResponse> get copyWith => _$ProfileUpdateResponseCopyWithImpl<ProfileUpdateResponse>(this as ProfileUpdateResponse, _$identity);

  /// Serializes this ProfileUpdateResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileUpdateResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message);

@override
String toString() {
  return 'ProfileUpdateResponse(success: $success, message: $message)';
}


}

/// @nodoc
abstract mixin class $ProfileUpdateResponseCopyWith<$Res>  {
  factory $ProfileUpdateResponseCopyWith(ProfileUpdateResponse value, $Res Function(ProfileUpdateResponse) _then) = _$ProfileUpdateResponseCopyWithImpl;
@useResult
$Res call({
 bool success, String message
});




}
/// @nodoc
class _$ProfileUpdateResponseCopyWithImpl<$Res>
    implements $ProfileUpdateResponseCopyWith<$Res> {
  _$ProfileUpdateResponseCopyWithImpl(this._self, this._then);

  final ProfileUpdateResponse _self;
  final $Res Function(ProfileUpdateResponse) _then;

/// Create a copy of ProfileUpdateResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = null,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileUpdateResponse].
extension ProfileUpdateResponsePatterns on ProfileUpdateResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileUpdateResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileUpdateResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileUpdateResponse value)  $default,){
final _that = this;
switch (_that) {
case _ProfileUpdateResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileUpdateResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileUpdateResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileUpdateResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String message)  $default,) {final _that = this;
switch (_that) {
case _ProfileUpdateResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String message)?  $default,) {final _that = this;
switch (_that) {
case _ProfileUpdateResponse() when $default != null:
return $default(_that.success,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileUpdateResponse implements ProfileUpdateResponse {
  const _ProfileUpdateResponse({required this.success, required this.message});
  factory _ProfileUpdateResponse.fromJson(Map<String, dynamic> json) => _$ProfileUpdateResponseFromJson(json);

@override final  bool success;
@override final  String message;

/// Create a copy of ProfileUpdateResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileUpdateResponseCopyWith<_ProfileUpdateResponse> get copyWith => __$ProfileUpdateResponseCopyWithImpl<_ProfileUpdateResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileUpdateResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileUpdateResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message);

@override
String toString() {
  return 'ProfileUpdateResponse(success: $success, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ProfileUpdateResponseCopyWith<$Res> implements $ProfileUpdateResponseCopyWith<$Res> {
  factory _$ProfileUpdateResponseCopyWith(_ProfileUpdateResponse value, $Res Function(_ProfileUpdateResponse) _then) = __$ProfileUpdateResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, String message
});




}
/// @nodoc
class __$ProfileUpdateResponseCopyWithImpl<$Res>
    implements _$ProfileUpdateResponseCopyWith<$Res> {
  __$ProfileUpdateResponseCopyWithImpl(this._self, this._then);

  final _ProfileUpdateResponse _self;
  final $Res Function(_ProfileUpdateResponse) _then;

/// Create a copy of ProfileUpdateResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = null,}) {
  return _then(_ProfileUpdateResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
