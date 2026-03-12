// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'resume_upload_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ResumeUploadResponse {

 bool get success; ResumeItem get resume; String? get message;
/// Create a copy of ResumeUploadResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResumeUploadResponseCopyWith<ResumeUploadResponse> get copyWith => _$ResumeUploadResponseCopyWithImpl<ResumeUploadResponse>(this as ResumeUploadResponse, _$identity);

  /// Serializes this ResumeUploadResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResumeUploadResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.resume, resume) || other.resume == resume)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,resume,message);

@override
String toString() {
  return 'ResumeUploadResponse(success: $success, resume: $resume, message: $message)';
}


}

/// @nodoc
abstract mixin class $ResumeUploadResponseCopyWith<$Res>  {
  factory $ResumeUploadResponseCopyWith(ResumeUploadResponse value, $Res Function(ResumeUploadResponse) _then) = _$ResumeUploadResponseCopyWithImpl;
@useResult
$Res call({
 bool success, ResumeItem resume, String? message
});


$ResumeItemCopyWith<$Res> get resume;

}
/// @nodoc
class _$ResumeUploadResponseCopyWithImpl<$Res>
    implements $ResumeUploadResponseCopyWith<$Res> {
  _$ResumeUploadResponseCopyWithImpl(this._self, this._then);

  final ResumeUploadResponse _self;
  final $Res Function(ResumeUploadResponse) _then;

/// Create a copy of ResumeUploadResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? resume = null,Object? message = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,resume: null == resume ? _self.resume : resume // ignore: cast_nullable_to_non_nullable
as ResumeItem,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ResumeUploadResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResumeItemCopyWith<$Res> get resume {
  
  return $ResumeItemCopyWith<$Res>(_self.resume, (value) {
    return _then(_self.copyWith(resume: value));
  });
}
}


/// Adds pattern-matching-related methods to [ResumeUploadResponse].
extension ResumeUploadResponsePatterns on ResumeUploadResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResumeUploadResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResumeUploadResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResumeUploadResponse value)  $default,){
final _that = this;
switch (_that) {
case _ResumeUploadResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResumeUploadResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ResumeUploadResponse() when $default != null:
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
case _ResumeUploadResponse() when $default != null:
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
case _ResumeUploadResponse():
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
case _ResumeUploadResponse() when $default != null:
return $default(_that.success,_that.resume,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ResumeUploadResponse implements ResumeUploadResponse {
  const _ResumeUploadResponse({required this.success, required this.resume, this.message});
  factory _ResumeUploadResponse.fromJson(Map<String, dynamic> json) => _$ResumeUploadResponseFromJson(json);

@override final  bool success;
@override final  ResumeItem resume;
@override final  String? message;

/// Create a copy of ResumeUploadResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResumeUploadResponseCopyWith<_ResumeUploadResponse> get copyWith => __$ResumeUploadResponseCopyWithImpl<_ResumeUploadResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ResumeUploadResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResumeUploadResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.resume, resume) || other.resume == resume)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,resume,message);

@override
String toString() {
  return 'ResumeUploadResponse(success: $success, resume: $resume, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ResumeUploadResponseCopyWith<$Res> implements $ResumeUploadResponseCopyWith<$Res> {
  factory _$ResumeUploadResponseCopyWith(_ResumeUploadResponse value, $Res Function(_ResumeUploadResponse) _then) = __$ResumeUploadResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, ResumeItem resume, String? message
});


@override $ResumeItemCopyWith<$Res> get resume;

}
/// @nodoc
class __$ResumeUploadResponseCopyWithImpl<$Res>
    implements _$ResumeUploadResponseCopyWith<$Res> {
  __$ResumeUploadResponseCopyWithImpl(this._self, this._then);

  final _ResumeUploadResponse _self;
  final $Res Function(_ResumeUploadResponse) _then;

/// Create a copy of ResumeUploadResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? resume = null,Object? message = freezed,}) {
  return _then(_ResumeUploadResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,resume: null == resume ? _self.resume : resume // ignore: cast_nullable_to_non_nullable
as ResumeItem,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ResumeUploadResponse
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
