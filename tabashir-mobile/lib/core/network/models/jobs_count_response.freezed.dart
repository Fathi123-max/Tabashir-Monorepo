// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'jobs_count_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JobsCountResponse {

/// Success status
 bool get success;/// Applicant email
 String get email;/// Count of applied jobs
@JsonKey(name: 'applied_jobs_count') int get appliedJobsCount;
/// Create a copy of JobsCountResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobsCountResponseCopyWith<JobsCountResponse> get copyWith => _$JobsCountResponseCopyWithImpl<JobsCountResponse>(this as JobsCountResponse, _$identity);

  /// Serializes this JobsCountResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobsCountResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.email, email) || other.email == email)&&(identical(other.appliedJobsCount, appliedJobsCount) || other.appliedJobsCount == appliedJobsCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,email,appliedJobsCount);

@override
String toString() {
  return 'JobsCountResponse(success: $success, email: $email, appliedJobsCount: $appliedJobsCount)';
}


}

/// @nodoc
abstract mixin class $JobsCountResponseCopyWith<$Res>  {
  factory $JobsCountResponseCopyWith(JobsCountResponse value, $Res Function(JobsCountResponse) _then) = _$JobsCountResponseCopyWithImpl;
@useResult
$Res call({
 bool success, String email,@JsonKey(name: 'applied_jobs_count') int appliedJobsCount
});




}
/// @nodoc
class _$JobsCountResponseCopyWithImpl<$Res>
    implements $JobsCountResponseCopyWith<$Res> {
  _$JobsCountResponseCopyWithImpl(this._self, this._then);

  final JobsCountResponse _self;
  final $Res Function(JobsCountResponse) _then;

/// Create a copy of JobsCountResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? email = null,Object? appliedJobsCount = null,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,appliedJobsCount: null == appliedJobsCount ? _self.appliedJobsCount : appliedJobsCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [JobsCountResponse].
extension JobsCountResponsePatterns on JobsCountResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobsCountResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobsCountResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobsCountResponse value)  $default,){
final _that = this;
switch (_that) {
case _JobsCountResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobsCountResponse value)?  $default,){
final _that = this;
switch (_that) {
case _JobsCountResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String email, @JsonKey(name: 'applied_jobs_count')  int appliedJobsCount)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobsCountResponse() when $default != null:
return $default(_that.success,_that.email,_that.appliedJobsCount);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String email, @JsonKey(name: 'applied_jobs_count')  int appliedJobsCount)  $default,) {final _that = this;
switch (_that) {
case _JobsCountResponse():
return $default(_that.success,_that.email,_that.appliedJobsCount);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String email, @JsonKey(name: 'applied_jobs_count')  int appliedJobsCount)?  $default,) {final _that = this;
switch (_that) {
case _JobsCountResponse() when $default != null:
return $default(_that.success,_that.email,_that.appliedJobsCount);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JobsCountResponse implements JobsCountResponse {
  const _JobsCountResponse({required this.success, required this.email, @JsonKey(name: 'applied_jobs_count') required this.appliedJobsCount});
  factory _JobsCountResponse.fromJson(Map<String, dynamic> json) => _$JobsCountResponseFromJson(json);

/// Success status
@override final  bool success;
/// Applicant email
@override final  String email;
/// Count of applied jobs
@override@JsonKey(name: 'applied_jobs_count') final  int appliedJobsCount;

/// Create a copy of JobsCountResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobsCountResponseCopyWith<_JobsCountResponse> get copyWith => __$JobsCountResponseCopyWithImpl<_JobsCountResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JobsCountResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobsCountResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.email, email) || other.email == email)&&(identical(other.appliedJobsCount, appliedJobsCount) || other.appliedJobsCount == appliedJobsCount));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,email,appliedJobsCount);

@override
String toString() {
  return 'JobsCountResponse(success: $success, email: $email, appliedJobsCount: $appliedJobsCount)';
}


}

/// @nodoc
abstract mixin class _$JobsCountResponseCopyWith<$Res> implements $JobsCountResponseCopyWith<$Res> {
  factory _$JobsCountResponseCopyWith(_JobsCountResponse value, $Res Function(_JobsCountResponse) _then) = __$JobsCountResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, String email,@JsonKey(name: 'applied_jobs_count') int appliedJobsCount
});




}
/// @nodoc
class __$JobsCountResponseCopyWithImpl<$Res>
    implements _$JobsCountResponseCopyWith<$Res> {
  __$JobsCountResponseCopyWithImpl(this._self, this._then);

  final _JobsCountResponse _self;
  final $Res Function(_JobsCountResponse) _then;

/// Create a copy of JobsCountResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? email = null,Object? appliedJobsCount = null,}) {
  return _then(_JobsCountResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,appliedJobsCount: null == appliedJobsCount ? _self.appliedJobsCount : appliedJobsCount // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
