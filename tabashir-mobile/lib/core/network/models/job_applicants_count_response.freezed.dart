// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_applicants_count_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JobApplicantsCountResponse {

/// Success status
 bool get success;/// Job ID
 int get jobId;/// Job title
 String get jobTitle;/// Total number of applicants
@JsonKey(name: 'total_applicants') int get totalApplicants;/// Status filter applied
@JsonKey(name: 'status_filter') String get statusFilter;
/// Create a copy of JobApplicantsCountResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobApplicantsCountResponseCopyWith<JobApplicantsCountResponse> get copyWith => _$JobApplicantsCountResponseCopyWithImpl<JobApplicantsCountResponse>(this as JobApplicantsCountResponse, _$identity);

  /// Serializes this JobApplicantsCountResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobApplicantsCountResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.jobId, jobId) || other.jobId == jobId)&&(identical(other.jobTitle, jobTitle) || other.jobTitle == jobTitle)&&(identical(other.totalApplicants, totalApplicants) || other.totalApplicants == totalApplicants)&&(identical(other.statusFilter, statusFilter) || other.statusFilter == statusFilter));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,jobId,jobTitle,totalApplicants,statusFilter);

@override
String toString() {
  return 'JobApplicantsCountResponse(success: $success, jobId: $jobId, jobTitle: $jobTitle, totalApplicants: $totalApplicants, statusFilter: $statusFilter)';
}


}

/// @nodoc
abstract mixin class $JobApplicantsCountResponseCopyWith<$Res>  {
  factory $JobApplicantsCountResponseCopyWith(JobApplicantsCountResponse value, $Res Function(JobApplicantsCountResponse) _then) = _$JobApplicantsCountResponseCopyWithImpl;
@useResult
$Res call({
 bool success, int jobId, String jobTitle,@JsonKey(name: 'total_applicants') int totalApplicants,@JsonKey(name: 'status_filter') String statusFilter
});




}
/// @nodoc
class _$JobApplicantsCountResponseCopyWithImpl<$Res>
    implements $JobApplicantsCountResponseCopyWith<$Res> {
  _$JobApplicantsCountResponseCopyWithImpl(this._self, this._then);

  final JobApplicantsCountResponse _self;
  final $Res Function(JobApplicantsCountResponse) _then;

/// Create a copy of JobApplicantsCountResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? jobId = null,Object? jobTitle = null,Object? totalApplicants = null,Object? statusFilter = null,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,jobId: null == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as int,jobTitle: null == jobTitle ? _self.jobTitle : jobTitle // ignore: cast_nullable_to_non_nullable
as String,totalApplicants: null == totalApplicants ? _self.totalApplicants : totalApplicants // ignore: cast_nullable_to_non_nullable
as int,statusFilter: null == statusFilter ? _self.statusFilter : statusFilter // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [JobApplicantsCountResponse].
extension JobApplicantsCountResponsePatterns on JobApplicantsCountResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobApplicantsCountResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobApplicantsCountResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobApplicantsCountResponse value)  $default,){
final _that = this;
switch (_that) {
case _JobApplicantsCountResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobApplicantsCountResponse value)?  $default,){
final _that = this;
switch (_that) {
case _JobApplicantsCountResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  int jobId,  String jobTitle, @JsonKey(name: 'total_applicants')  int totalApplicants, @JsonKey(name: 'status_filter')  String statusFilter)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobApplicantsCountResponse() when $default != null:
return $default(_that.success,_that.jobId,_that.jobTitle,_that.totalApplicants,_that.statusFilter);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  int jobId,  String jobTitle, @JsonKey(name: 'total_applicants')  int totalApplicants, @JsonKey(name: 'status_filter')  String statusFilter)  $default,) {final _that = this;
switch (_that) {
case _JobApplicantsCountResponse():
return $default(_that.success,_that.jobId,_that.jobTitle,_that.totalApplicants,_that.statusFilter);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  int jobId,  String jobTitle, @JsonKey(name: 'total_applicants')  int totalApplicants, @JsonKey(name: 'status_filter')  String statusFilter)?  $default,) {final _that = this;
switch (_that) {
case _JobApplicantsCountResponse() when $default != null:
return $default(_that.success,_that.jobId,_that.jobTitle,_that.totalApplicants,_that.statusFilter);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JobApplicantsCountResponse implements JobApplicantsCountResponse {
  const _JobApplicantsCountResponse({required this.success, required this.jobId, required this.jobTitle, @JsonKey(name: 'total_applicants') required this.totalApplicants, @JsonKey(name: 'status_filter') required this.statusFilter});
  factory _JobApplicantsCountResponse.fromJson(Map<String, dynamic> json) => _$JobApplicantsCountResponseFromJson(json);

/// Success status
@override final  bool success;
/// Job ID
@override final  int jobId;
/// Job title
@override final  String jobTitle;
/// Total number of applicants
@override@JsonKey(name: 'total_applicants') final  int totalApplicants;
/// Status filter applied
@override@JsonKey(name: 'status_filter') final  String statusFilter;

/// Create a copy of JobApplicantsCountResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobApplicantsCountResponseCopyWith<_JobApplicantsCountResponse> get copyWith => __$JobApplicantsCountResponseCopyWithImpl<_JobApplicantsCountResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JobApplicantsCountResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobApplicantsCountResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.jobId, jobId) || other.jobId == jobId)&&(identical(other.jobTitle, jobTitle) || other.jobTitle == jobTitle)&&(identical(other.totalApplicants, totalApplicants) || other.totalApplicants == totalApplicants)&&(identical(other.statusFilter, statusFilter) || other.statusFilter == statusFilter));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,jobId,jobTitle,totalApplicants,statusFilter);

@override
String toString() {
  return 'JobApplicantsCountResponse(success: $success, jobId: $jobId, jobTitle: $jobTitle, totalApplicants: $totalApplicants, statusFilter: $statusFilter)';
}


}

/// @nodoc
abstract mixin class _$JobApplicantsCountResponseCopyWith<$Res> implements $JobApplicantsCountResponseCopyWith<$Res> {
  factory _$JobApplicantsCountResponseCopyWith(_JobApplicantsCountResponse value, $Res Function(_JobApplicantsCountResponse) _then) = __$JobApplicantsCountResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, int jobId, String jobTitle,@JsonKey(name: 'total_applicants') int totalApplicants,@JsonKey(name: 'status_filter') String statusFilter
});




}
/// @nodoc
class __$JobApplicantsCountResponseCopyWithImpl<$Res>
    implements _$JobApplicantsCountResponseCopyWith<$Res> {
  __$JobApplicantsCountResponseCopyWithImpl(this._self, this._then);

  final _JobApplicantsCountResponse _self;
  final $Res Function(_JobApplicantsCountResponse) _then;

/// Create a copy of JobApplicantsCountResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? jobId = null,Object? jobTitle = null,Object? totalApplicants = null,Object? statusFilter = null,}) {
  return _then(_JobApplicantsCountResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,jobId: null == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as int,jobTitle: null == jobTitle ? _self.jobTitle : jobTitle // ignore: cast_nullable_to_non_nullable
as String,totalApplicants: null == totalApplicants ? _self.totalApplicants : totalApplicants // ignore: cast_nullable_to_non_nullable
as int,statusFilter: null == statusFilter ? _self.statusFilter : statusFilter // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
