// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_api_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JobApiResponse {

/// Whether the API request was successful
 bool get success;/// The job data (only present when success is true)
 JobDetailsResponse? get job;/// Error message (only present when success is false)
 String? get message;/// Language of the job data
 String? get language;
/// Create a copy of JobApiResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobApiResponseCopyWith<JobApiResponse> get copyWith => _$JobApiResponseCopyWithImpl<JobApiResponse>(this as JobApiResponse, _$identity);

  /// Serializes this JobApiResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobApiResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.job, job) || other.job == job)&&(identical(other.message, message) || other.message == message)&&(identical(other.language, language) || other.language == language));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,job,message,language);

@override
String toString() {
  return 'JobApiResponse(success: $success, job: $job, message: $message, language: $language)';
}


}

/// @nodoc
abstract mixin class $JobApiResponseCopyWith<$Res>  {
  factory $JobApiResponseCopyWith(JobApiResponse value, $Res Function(JobApiResponse) _then) = _$JobApiResponseCopyWithImpl;
@useResult
$Res call({
 bool success, JobDetailsResponse? job, String? message, String? language
});


$JobDetailsResponseCopyWith<$Res>? get job;

}
/// @nodoc
class _$JobApiResponseCopyWithImpl<$Res>
    implements $JobApiResponseCopyWith<$Res> {
  _$JobApiResponseCopyWithImpl(this._self, this._then);

  final JobApiResponse _self;
  final $Res Function(JobApiResponse) _then;

/// Create a copy of JobApiResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? job = freezed,Object? message = freezed,Object? language = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,job: freezed == job ? _self.job : job // ignore: cast_nullable_to_non_nullable
as JobDetailsResponse?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of JobApiResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JobDetailsResponseCopyWith<$Res>? get job {
    if (_self.job == null) {
    return null;
  }

  return $JobDetailsResponseCopyWith<$Res>(_self.job!, (value) {
    return _then(_self.copyWith(job: value));
  });
}
}


/// Adds pattern-matching-related methods to [JobApiResponse].
extension JobApiResponsePatterns on JobApiResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobApiResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobApiResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobApiResponse value)  $default,){
final _that = this;
switch (_that) {
case _JobApiResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobApiResponse value)?  $default,){
final _that = this;
switch (_that) {
case _JobApiResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  JobDetailsResponse? job,  String? message,  String? language)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobApiResponse() when $default != null:
return $default(_that.success,_that.job,_that.message,_that.language);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  JobDetailsResponse? job,  String? message,  String? language)  $default,) {final _that = this;
switch (_that) {
case _JobApiResponse():
return $default(_that.success,_that.job,_that.message,_that.language);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  JobDetailsResponse? job,  String? message,  String? language)?  $default,) {final _that = this;
switch (_that) {
case _JobApiResponse() when $default != null:
return $default(_that.success,_that.job,_that.message,_that.language);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JobApiResponse implements JobApiResponse {
  const _JobApiResponse({required this.success, this.job, this.message, this.language});
  factory _JobApiResponse.fromJson(Map<String, dynamic> json) => _$JobApiResponseFromJson(json);

/// Whether the API request was successful
@override final  bool success;
/// The job data (only present when success is true)
@override final  JobDetailsResponse? job;
/// Error message (only present when success is false)
@override final  String? message;
/// Language of the job data
@override final  String? language;

/// Create a copy of JobApiResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobApiResponseCopyWith<_JobApiResponse> get copyWith => __$JobApiResponseCopyWithImpl<_JobApiResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JobApiResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobApiResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.job, job) || other.job == job)&&(identical(other.message, message) || other.message == message)&&(identical(other.language, language) || other.language == language));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,job,message,language);

@override
String toString() {
  return 'JobApiResponse(success: $success, job: $job, message: $message, language: $language)';
}


}

/// @nodoc
abstract mixin class _$JobApiResponseCopyWith<$Res> implements $JobApiResponseCopyWith<$Res> {
  factory _$JobApiResponseCopyWith(_JobApiResponse value, $Res Function(_JobApiResponse) _then) = __$JobApiResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, JobDetailsResponse? job, String? message, String? language
});


@override $JobDetailsResponseCopyWith<$Res>? get job;

}
/// @nodoc
class __$JobApiResponseCopyWithImpl<$Res>
    implements _$JobApiResponseCopyWith<$Res> {
  __$JobApiResponseCopyWithImpl(this._self, this._then);

  final _JobApiResponse _self;
  final $Res Function(_JobApiResponse) _then;

/// Create a copy of JobApiResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? job = freezed,Object? message = freezed,Object? language = freezed,}) {
  return _then(_JobApiResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,job: freezed == job ? _self.job : job // ignore: cast_nullable_to_non_nullable
as JobDetailsResponse?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,language: freezed == language ? _self.language : language // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of JobApiResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JobDetailsResponseCopyWith<$Res>? get job {
    if (_self.job == null) {
    return null;
  }

  return $JobDetailsResponseCopyWith<$Res>(_self.job!, (value) {
    return _then(_self.copyWith(job: value));
  });
}
}

// dart format on
