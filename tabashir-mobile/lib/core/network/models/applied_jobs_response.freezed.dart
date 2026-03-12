// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'applied_jobs_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AppliedJobsResponse {

/// Success status
 bool get success;/// Applicant email
 String get email;/// List of applied jobs
 List<AppliedJob> get jobs;
/// Create a copy of AppliedJobsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppliedJobsResponseCopyWith<AppliedJobsResponse> get copyWith => _$AppliedJobsResponseCopyWithImpl<AppliedJobsResponse>(this as AppliedJobsResponse, _$identity);

  /// Serializes this AppliedJobsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppliedJobsResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.email, email) || other.email == email)&&const DeepCollectionEquality().equals(other.jobs, jobs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,email,const DeepCollectionEquality().hash(jobs));

@override
String toString() {
  return 'AppliedJobsResponse(success: $success, email: $email, jobs: $jobs)';
}


}

/// @nodoc
abstract mixin class $AppliedJobsResponseCopyWith<$Res>  {
  factory $AppliedJobsResponseCopyWith(AppliedJobsResponse value, $Res Function(AppliedJobsResponse) _then) = _$AppliedJobsResponseCopyWithImpl;
@useResult
$Res call({
 bool success, String email, List<AppliedJob> jobs
});




}
/// @nodoc
class _$AppliedJobsResponseCopyWithImpl<$Res>
    implements $AppliedJobsResponseCopyWith<$Res> {
  _$AppliedJobsResponseCopyWithImpl(this._self, this._then);

  final AppliedJobsResponse _self;
  final $Res Function(AppliedJobsResponse) _then;

/// Create a copy of AppliedJobsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? email = null,Object? jobs = null,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,jobs: null == jobs ? _self.jobs : jobs // ignore: cast_nullable_to_non_nullable
as List<AppliedJob>,
  ));
}

}


/// Adds pattern-matching-related methods to [AppliedJobsResponse].
extension AppliedJobsResponsePatterns on AppliedJobsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppliedJobsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppliedJobsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppliedJobsResponse value)  $default,){
final _that = this;
switch (_that) {
case _AppliedJobsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppliedJobsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AppliedJobsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String email,  List<AppliedJob> jobs)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppliedJobsResponse() when $default != null:
return $default(_that.success,_that.email,_that.jobs);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String email,  List<AppliedJob> jobs)  $default,) {final _that = this;
switch (_that) {
case _AppliedJobsResponse():
return $default(_that.success,_that.email,_that.jobs);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String email,  List<AppliedJob> jobs)?  $default,) {final _that = this;
switch (_that) {
case _AppliedJobsResponse() when $default != null:
return $default(_that.success,_that.email,_that.jobs);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppliedJobsResponse implements AppliedJobsResponse {
  const _AppliedJobsResponse({required this.success, required this.email, required final  List<AppliedJob> jobs}): _jobs = jobs;
  factory _AppliedJobsResponse.fromJson(Map<String, dynamic> json) => _$AppliedJobsResponseFromJson(json);

/// Success status
@override final  bool success;
/// Applicant email
@override final  String email;
/// List of applied jobs
 final  List<AppliedJob> _jobs;
/// List of applied jobs
@override List<AppliedJob> get jobs {
  if (_jobs is EqualUnmodifiableListView) return _jobs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_jobs);
}


/// Create a copy of AppliedJobsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppliedJobsResponseCopyWith<_AppliedJobsResponse> get copyWith => __$AppliedJobsResponseCopyWithImpl<_AppliedJobsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppliedJobsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppliedJobsResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.email, email) || other.email == email)&&const DeepCollectionEquality().equals(other._jobs, _jobs));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,email,const DeepCollectionEquality().hash(_jobs));

@override
String toString() {
  return 'AppliedJobsResponse(success: $success, email: $email, jobs: $jobs)';
}


}

/// @nodoc
abstract mixin class _$AppliedJobsResponseCopyWith<$Res> implements $AppliedJobsResponseCopyWith<$Res> {
  factory _$AppliedJobsResponseCopyWith(_AppliedJobsResponse value, $Res Function(_AppliedJobsResponse) _then) = __$AppliedJobsResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, String email, List<AppliedJob> jobs
});




}
/// @nodoc
class __$AppliedJobsResponseCopyWithImpl<$Res>
    implements _$AppliedJobsResponseCopyWith<$Res> {
  __$AppliedJobsResponseCopyWithImpl(this._self, this._then);

  final _AppliedJobsResponse _self;
  final $Res Function(_AppliedJobsResponse) _then;

/// Create a copy of AppliedJobsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? email = null,Object? jobs = null,}) {
  return _then(_AppliedJobsResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,jobs: null == jobs ? _self._jobs : jobs // ignore: cast_nullable_to_non_nullable
as List<AppliedJob>,
  ));
}


}


/// @nodoc
mixin _$AppliedJob {

/// Job title
@JsonKey(name: 'job_title') String get jobTitle;/// Job ID
@JsonKey(name: 'job_id') String get jobId;/// Application status
 String get status;/// Job location
 String get location;/// Application date
@JsonKey(name: 'applied') String get applied;/// Experience level
 String get experience;/// Company name
 String get company;
/// Create a copy of AppliedJob
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AppliedJobCopyWith<AppliedJob> get copyWith => _$AppliedJobCopyWithImpl<AppliedJob>(this as AppliedJob, _$identity);

  /// Serializes this AppliedJob to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AppliedJob&&(identical(other.jobTitle, jobTitle) || other.jobTitle == jobTitle)&&(identical(other.jobId, jobId) || other.jobId == jobId)&&(identical(other.status, status) || other.status == status)&&(identical(other.location, location) || other.location == location)&&(identical(other.applied, applied) || other.applied == applied)&&(identical(other.experience, experience) || other.experience == experience)&&(identical(other.company, company) || other.company == company));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,jobTitle,jobId,status,location,applied,experience,company);

@override
String toString() {
  return 'AppliedJob(jobTitle: $jobTitle, jobId: $jobId, status: $status, location: $location, applied: $applied, experience: $experience, company: $company)';
}


}

/// @nodoc
abstract mixin class $AppliedJobCopyWith<$Res>  {
  factory $AppliedJobCopyWith(AppliedJob value, $Res Function(AppliedJob) _then) = _$AppliedJobCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'job_title') String jobTitle,@JsonKey(name: 'job_id') String jobId, String status, String location,@JsonKey(name: 'applied') String applied, String experience, String company
});




}
/// @nodoc
class _$AppliedJobCopyWithImpl<$Res>
    implements $AppliedJobCopyWith<$Res> {
  _$AppliedJobCopyWithImpl(this._self, this._then);

  final AppliedJob _self;
  final $Res Function(AppliedJob) _then;

/// Create a copy of AppliedJob
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? jobTitle = null,Object? jobId = null,Object? status = null,Object? location = null,Object? applied = null,Object? experience = null,Object? company = null,}) {
  return _then(_self.copyWith(
jobTitle: null == jobTitle ? _self.jobTitle : jobTitle // ignore: cast_nullable_to_non_nullable
as String,jobId: null == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,applied: null == applied ? _self.applied : applied // ignore: cast_nullable_to_non_nullable
as String,experience: null == experience ? _self.experience : experience // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AppliedJob].
extension AppliedJobPatterns on AppliedJob {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AppliedJob value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AppliedJob() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AppliedJob value)  $default,){
final _that = this;
switch (_that) {
case _AppliedJob():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AppliedJob value)?  $default,){
final _that = this;
switch (_that) {
case _AppliedJob() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'job_title')  String jobTitle, @JsonKey(name: 'job_id')  String jobId,  String status,  String location, @JsonKey(name: 'applied')  String applied,  String experience,  String company)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AppliedJob() when $default != null:
return $default(_that.jobTitle,_that.jobId,_that.status,_that.location,_that.applied,_that.experience,_that.company);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'job_title')  String jobTitle, @JsonKey(name: 'job_id')  String jobId,  String status,  String location, @JsonKey(name: 'applied')  String applied,  String experience,  String company)  $default,) {final _that = this;
switch (_that) {
case _AppliedJob():
return $default(_that.jobTitle,_that.jobId,_that.status,_that.location,_that.applied,_that.experience,_that.company);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'job_title')  String jobTitle, @JsonKey(name: 'job_id')  String jobId,  String status,  String location, @JsonKey(name: 'applied')  String applied,  String experience,  String company)?  $default,) {final _that = this;
switch (_that) {
case _AppliedJob() when $default != null:
return $default(_that.jobTitle,_that.jobId,_that.status,_that.location,_that.applied,_that.experience,_that.company);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AppliedJob implements AppliedJob {
  const _AppliedJob({@JsonKey(name: 'job_title') required this.jobTitle, @JsonKey(name: 'job_id') required this.jobId, required this.status, required this.location, @JsonKey(name: 'applied') required this.applied, required this.experience, required this.company});
  factory _AppliedJob.fromJson(Map<String, dynamic> json) => _$AppliedJobFromJson(json);

/// Job title
@override@JsonKey(name: 'job_title') final  String jobTitle;
/// Job ID
@override@JsonKey(name: 'job_id') final  String jobId;
/// Application status
@override final  String status;
/// Job location
@override final  String location;
/// Application date
@override@JsonKey(name: 'applied') final  String applied;
/// Experience level
@override final  String experience;
/// Company name
@override final  String company;

/// Create a copy of AppliedJob
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AppliedJobCopyWith<_AppliedJob> get copyWith => __$AppliedJobCopyWithImpl<_AppliedJob>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AppliedJobToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AppliedJob&&(identical(other.jobTitle, jobTitle) || other.jobTitle == jobTitle)&&(identical(other.jobId, jobId) || other.jobId == jobId)&&(identical(other.status, status) || other.status == status)&&(identical(other.location, location) || other.location == location)&&(identical(other.applied, applied) || other.applied == applied)&&(identical(other.experience, experience) || other.experience == experience)&&(identical(other.company, company) || other.company == company));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,jobTitle,jobId,status,location,applied,experience,company);

@override
String toString() {
  return 'AppliedJob(jobTitle: $jobTitle, jobId: $jobId, status: $status, location: $location, applied: $applied, experience: $experience, company: $company)';
}


}

/// @nodoc
abstract mixin class _$AppliedJobCopyWith<$Res> implements $AppliedJobCopyWith<$Res> {
  factory _$AppliedJobCopyWith(_AppliedJob value, $Res Function(_AppliedJob) _then) = __$AppliedJobCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'job_title') String jobTitle,@JsonKey(name: 'job_id') String jobId, String status, String location,@JsonKey(name: 'applied') String applied, String experience, String company
});




}
/// @nodoc
class __$AppliedJobCopyWithImpl<$Res>
    implements _$AppliedJobCopyWith<$Res> {
  __$AppliedJobCopyWithImpl(this._self, this._then);

  final _AppliedJob _self;
  final $Res Function(_AppliedJob) _then;

/// Create a copy of AppliedJob
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? jobTitle = null,Object? jobId = null,Object? status = null,Object? location = null,Object? applied = null,Object? experience = null,Object? company = null,}) {
  return _then(_AppliedJob(
jobTitle: null == jobTitle ? _self.jobTitle : jobTitle // ignore: cast_nullable_to_non_nullable
as String,jobId: null == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,applied: null == applied ? _self.applied : applied // ignore: cast_nullable_to_non_nullable
as String,experience: null == experience ? _self.experience : experience // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
