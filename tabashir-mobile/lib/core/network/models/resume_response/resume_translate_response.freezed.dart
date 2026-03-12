// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'resume_translate_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ResumeTranslateResponse {

 bool get success; ResumeItem get resume; String get targetLanguage; String? get message;
/// Create a copy of ResumeTranslateResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResumeTranslateResponseCopyWith<ResumeTranslateResponse> get copyWith => _$ResumeTranslateResponseCopyWithImpl<ResumeTranslateResponse>(this as ResumeTranslateResponse, _$identity);

  /// Serializes this ResumeTranslateResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResumeTranslateResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.resume, resume) || other.resume == resume)&&(identical(other.targetLanguage, targetLanguage) || other.targetLanguage == targetLanguage)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,resume,targetLanguage,message);

@override
String toString() {
  return 'ResumeTranslateResponse(success: $success, resume: $resume, targetLanguage: $targetLanguage, message: $message)';
}


}

/// @nodoc
abstract mixin class $ResumeTranslateResponseCopyWith<$Res>  {
  factory $ResumeTranslateResponseCopyWith(ResumeTranslateResponse value, $Res Function(ResumeTranslateResponse) _then) = _$ResumeTranslateResponseCopyWithImpl;
@useResult
$Res call({
 bool success, ResumeItem resume, String targetLanguage, String? message
});


$ResumeItemCopyWith<$Res> get resume;

}
/// @nodoc
class _$ResumeTranslateResponseCopyWithImpl<$Res>
    implements $ResumeTranslateResponseCopyWith<$Res> {
  _$ResumeTranslateResponseCopyWithImpl(this._self, this._then);

  final ResumeTranslateResponse _self;
  final $Res Function(ResumeTranslateResponse) _then;

/// Create a copy of ResumeTranslateResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? resume = null,Object? targetLanguage = null,Object? message = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,resume: null == resume ? _self.resume : resume // ignore: cast_nullable_to_non_nullable
as ResumeItem,targetLanguage: null == targetLanguage ? _self.targetLanguage : targetLanguage // ignore: cast_nullable_to_non_nullable
as String,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of ResumeTranslateResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResumeItemCopyWith<$Res> get resume {
  
  return $ResumeItemCopyWith<$Res>(_self.resume, (value) {
    return _then(_self.copyWith(resume: value));
  });
}
}


/// Adds pattern-matching-related methods to [ResumeTranslateResponse].
extension ResumeTranslateResponsePatterns on ResumeTranslateResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResumeTranslateResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResumeTranslateResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResumeTranslateResponse value)  $default,){
final _that = this;
switch (_that) {
case _ResumeTranslateResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResumeTranslateResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ResumeTranslateResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  ResumeItem resume,  String targetLanguage,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResumeTranslateResponse() when $default != null:
return $default(_that.success,_that.resume,_that.targetLanguage,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  ResumeItem resume,  String targetLanguage,  String? message)  $default,) {final _that = this;
switch (_that) {
case _ResumeTranslateResponse():
return $default(_that.success,_that.resume,_that.targetLanguage,_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  ResumeItem resume,  String targetLanguage,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _ResumeTranslateResponse() when $default != null:
return $default(_that.success,_that.resume,_that.targetLanguage,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ResumeTranslateResponse implements ResumeTranslateResponse {
  const _ResumeTranslateResponse({required this.success, required this.resume, required this.targetLanguage, this.message});
  factory _ResumeTranslateResponse.fromJson(Map<String, dynamic> json) => _$ResumeTranslateResponseFromJson(json);

@override final  bool success;
@override final  ResumeItem resume;
@override final  String targetLanguage;
@override final  String? message;

/// Create a copy of ResumeTranslateResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResumeTranslateResponseCopyWith<_ResumeTranslateResponse> get copyWith => __$ResumeTranslateResponseCopyWithImpl<_ResumeTranslateResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ResumeTranslateResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResumeTranslateResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.resume, resume) || other.resume == resume)&&(identical(other.targetLanguage, targetLanguage) || other.targetLanguage == targetLanguage)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,resume,targetLanguage,message);

@override
String toString() {
  return 'ResumeTranslateResponse(success: $success, resume: $resume, targetLanguage: $targetLanguage, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ResumeTranslateResponseCopyWith<$Res> implements $ResumeTranslateResponseCopyWith<$Res> {
  factory _$ResumeTranslateResponseCopyWith(_ResumeTranslateResponse value, $Res Function(_ResumeTranslateResponse) _then) = __$ResumeTranslateResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, ResumeItem resume, String targetLanguage, String? message
});


@override $ResumeItemCopyWith<$Res> get resume;

}
/// @nodoc
class __$ResumeTranslateResponseCopyWithImpl<$Res>
    implements _$ResumeTranslateResponseCopyWith<$Res> {
  __$ResumeTranslateResponseCopyWithImpl(this._self, this._then);

  final _ResumeTranslateResponse _self;
  final $Res Function(_ResumeTranslateResponse) _then;

/// Create a copy of ResumeTranslateResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? resume = null,Object? targetLanguage = null,Object? message = freezed,}) {
  return _then(_ResumeTranslateResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,resume: null == resume ? _self.resume : resume // ignore: cast_nullable_to_non_nullable
as ResumeItem,targetLanguage: null == targetLanguage ? _self.targetLanguage : targetLanguage // ignore: cast_nullable_to_non_nullable
as String,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of ResumeTranslateResponse
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
