// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'resume_duplicate_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ResumeDuplicateResponse {

 bool get success; ResumeItem get resume; String? get message;
/// Create a copy of ResumeDuplicateResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResumeDuplicateResponseCopyWith<ResumeDuplicateResponse> get copyWith => _$ResumeDuplicateResponseCopyWithImpl<ResumeDuplicateResponse>(this as ResumeDuplicateResponse, _$identity);

  /// Serializes this ResumeDuplicateResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResumeDuplicateResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.resume, resume) || other.resume == resume)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,resume,message);

@override
String toString() {
  return 'ResumeDuplicateResponse(success: $success, resume: $resume, message: $message)';
}


}

/// @nodoc
abstract mixin class $ResumeDuplicateResponseCopyWith<$Res>  {
  factory $ResumeDuplicateResponseCopyWith(ResumeDuplicateResponse value, $Res Function(ResumeDuplicateResponse) _then) = _$ResumeDuplicateResponseCopyWithImpl;
@useResult
$Res call({
 bool success, ResumeItem resume, String? message
});


$ResumeItemCopyWith<$Res> get resume;

}
/// @nodoc
class _$ResumeDuplicateResponseCopyWithImpl<$Res>
    implements $ResumeDuplicateResponseCopyWith<$Res> {
  _$ResumeDuplicateResponseCopyWithImpl(this._self, this._then);

  final ResumeDuplicateResponse _self;
  final $Res Function(ResumeDuplicateResponse) _then;

/// Create a copy of ResumeDuplicateResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? resume = null,Object? message = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,resume: null == resume ? _self.resume : resume // ignore: cast_nullable_to_non_nullable
as ResumeItem,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ResumeDuplicateResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResumeItemCopyWith<$Res> get resume {
  
  return $ResumeItemCopyWith<$Res>(_self.resume, (value) {
    return _then(_self.copyWith(resume: value));
  });
}
}


/// Adds pattern-matching-related methods to [ResumeDuplicateResponse].
extension ResumeDuplicateResponsePatterns on ResumeDuplicateResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResumeDuplicateResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResumeDuplicateResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResumeDuplicateResponse value)  $default,){
final _that = this;
switch (_that) {
case _ResumeDuplicateResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResumeDuplicateResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ResumeDuplicateResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  ResumeItem resume,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResumeDuplicateResponse() when $default != null:
return $default(_that.success,_that.resume,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  ResumeItem resume,  String? message)  $default,) {final _that = this;
switch (_that) {
case _ResumeDuplicateResponse():
return $default(_that.success,_that.resume,_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  ResumeItem resume,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _ResumeDuplicateResponse() when $default != null:
return $default(_that.success,_that.resume,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ResumeDuplicateResponse implements ResumeDuplicateResponse {
  const _ResumeDuplicateResponse({required this.success, required this.resume, this.message});
  factory _ResumeDuplicateResponse.fromJson(Map<String, dynamic> json) => _$ResumeDuplicateResponseFromJson(json);

@override final  bool success;
@override final  ResumeItem resume;
@override final  String? message;

/// Create a copy of ResumeDuplicateResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResumeDuplicateResponseCopyWith<_ResumeDuplicateResponse> get copyWith => __$ResumeDuplicateResponseCopyWithImpl<_ResumeDuplicateResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ResumeDuplicateResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResumeDuplicateResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.resume, resume) || other.resume == resume)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,resume,message);

@override
String toString() {
  return 'ResumeDuplicateResponse(success: $success, resume: $resume, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ResumeDuplicateResponseCopyWith<$Res> implements $ResumeDuplicateResponseCopyWith<$Res> {
  factory _$ResumeDuplicateResponseCopyWith(_ResumeDuplicateResponse value, $Res Function(_ResumeDuplicateResponse) _then) = __$ResumeDuplicateResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, ResumeItem resume, String? message
});


@override $ResumeItemCopyWith<$Res> get resume;

}
/// @nodoc
class __$ResumeDuplicateResponseCopyWithImpl<$Res>
    implements _$ResumeDuplicateResponseCopyWith<$Res> {
  __$ResumeDuplicateResponseCopyWithImpl(this._self, this._then);

  final _ResumeDuplicateResponse _self;
  final $Res Function(_ResumeDuplicateResponse) _then;

/// Create a copy of ResumeDuplicateResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? resume = null,Object? message = freezed,}) {
  return _then(_ResumeDuplicateResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,resume: null == resume ? _self.resume : resume // ignore: cast_nullable_to_non_nullable
as ResumeItem,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ResumeDuplicateResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResumeItemCopyWith<$Res> get resume {
  
  return $ResumeItemCopyWith<$Res>(_self.resume, (value) {
    return _then(_self.copyWith(resume: value));
  });
}
}

// dart format on
