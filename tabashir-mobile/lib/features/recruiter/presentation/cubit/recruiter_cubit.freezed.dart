// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recruiter_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RecruiterState {

 RecruiterStatus get status; String get errorMessage; RecruiterProfile? get profile; List<JobPosting> get jobPostings; List<JobApplication> get applications; JobPosting? get currentJobPosting; List<JobApplication> get jobApplications;
/// Create a copy of RecruiterState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecruiterStateCopyWith<RecruiterState> get copyWith => _$RecruiterStateCopyWithImpl<RecruiterState>(this as RecruiterState, _$identity);

  /// Serializes this RecruiterState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecruiterState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.profile, profile) || other.profile == profile)&&const DeepCollectionEquality().equals(other.jobPostings, jobPostings)&&const DeepCollectionEquality().equals(other.applications, applications)&&(identical(other.currentJobPosting, currentJobPosting) || other.currentJobPosting == currentJobPosting)&&const DeepCollectionEquality().equals(other.jobApplications, jobApplications));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,errorMessage,profile,const DeepCollectionEquality().hash(jobPostings),const DeepCollectionEquality().hash(applications),currentJobPosting,const DeepCollectionEquality().hash(jobApplications));

@override
String toString() {
  return 'RecruiterState(status: $status, errorMessage: $errorMessage, profile: $profile, jobPostings: $jobPostings, applications: $applications, currentJobPosting: $currentJobPosting, jobApplications: $jobApplications)';
}


}

/// @nodoc
abstract mixin class $RecruiterStateCopyWith<$Res>  {
  factory $RecruiterStateCopyWith(RecruiterState value, $Res Function(RecruiterState) _then) = _$RecruiterStateCopyWithImpl;
@useResult
$Res call({
 RecruiterStatus status, String errorMessage, RecruiterProfile? profile, List<JobPosting> jobPostings, List<JobApplication> applications, JobPosting? currentJobPosting, List<JobApplication> jobApplications
});


$RecruiterProfileCopyWith<$Res>? get profile;$JobPostingCopyWith<$Res>? get currentJobPosting;

}
/// @nodoc
class _$RecruiterStateCopyWithImpl<$Res>
    implements $RecruiterStateCopyWith<$Res> {
  _$RecruiterStateCopyWithImpl(this._self, this._then);

  final RecruiterState _self;
  final $Res Function(RecruiterState) _then;

/// Create a copy of RecruiterState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? errorMessage = null,Object? profile = freezed,Object? jobPostings = null,Object? applications = null,Object? currentJobPosting = freezed,Object? jobApplications = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RecruiterStatus,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as RecruiterProfile?,jobPostings: null == jobPostings ? _self.jobPostings : jobPostings // ignore: cast_nullable_to_non_nullable
as List<JobPosting>,applications: null == applications ? _self.applications : applications // ignore: cast_nullable_to_non_nullable
as List<JobApplication>,currentJobPosting: freezed == currentJobPosting ? _self.currentJobPosting : currentJobPosting // ignore: cast_nullable_to_non_nullable
as JobPosting?,jobApplications: null == jobApplications ? _self.jobApplications : jobApplications // ignore: cast_nullable_to_non_nullable
as List<JobApplication>,
  ));
}
/// Create a copy of RecruiterState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecruiterProfileCopyWith<$Res>? get profile {
    if (_self.profile == null) {
    return null;
  }

  return $RecruiterProfileCopyWith<$Res>(_self.profile!, (value) {
    return _then(_self.copyWith(profile: value));
  });
}/// Create a copy of RecruiterState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JobPostingCopyWith<$Res>? get currentJobPosting {
    if (_self.currentJobPosting == null) {
    return null;
  }

  return $JobPostingCopyWith<$Res>(_self.currentJobPosting!, (value) {
    return _then(_self.copyWith(currentJobPosting: value));
  });
}
}


/// Adds pattern-matching-related methods to [RecruiterState].
extension RecruiterStatePatterns on RecruiterState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecruiterState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecruiterState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecruiterState value)  $default,){
final _that = this;
switch (_that) {
case _RecruiterState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecruiterState value)?  $default,){
final _that = this;
switch (_that) {
case _RecruiterState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RecruiterStatus status,  String errorMessage,  RecruiterProfile? profile,  List<JobPosting> jobPostings,  List<JobApplication> applications,  JobPosting? currentJobPosting,  List<JobApplication> jobApplications)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecruiterState() when $default != null:
return $default(_that.status,_that.errorMessage,_that.profile,_that.jobPostings,_that.applications,_that.currentJobPosting,_that.jobApplications);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RecruiterStatus status,  String errorMessage,  RecruiterProfile? profile,  List<JobPosting> jobPostings,  List<JobApplication> applications,  JobPosting? currentJobPosting,  List<JobApplication> jobApplications)  $default,) {final _that = this;
switch (_that) {
case _RecruiterState():
return $default(_that.status,_that.errorMessage,_that.profile,_that.jobPostings,_that.applications,_that.currentJobPosting,_that.jobApplications);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RecruiterStatus status,  String errorMessage,  RecruiterProfile? profile,  List<JobPosting> jobPostings,  List<JobApplication> applications,  JobPosting? currentJobPosting,  List<JobApplication> jobApplications)?  $default,) {final _that = this;
switch (_that) {
case _RecruiterState() when $default != null:
return $default(_that.status,_that.errorMessage,_that.profile,_that.jobPostings,_that.applications,_that.currentJobPosting,_that.jobApplications);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RecruiterState implements RecruiterState {
  const _RecruiterState({this.status = RecruiterStatus.initial, this.errorMessage = '', this.profile, final  List<JobPosting> jobPostings = const [], final  List<JobApplication> applications = const [], this.currentJobPosting, final  List<JobApplication> jobApplications = const []}): _jobPostings = jobPostings,_applications = applications,_jobApplications = jobApplications;
  factory _RecruiterState.fromJson(Map<String, dynamic> json) => _$RecruiterStateFromJson(json);

@override@JsonKey() final  RecruiterStatus status;
@override@JsonKey() final  String errorMessage;
@override final  RecruiterProfile? profile;
 final  List<JobPosting> _jobPostings;
@override@JsonKey() List<JobPosting> get jobPostings {
  if (_jobPostings is EqualUnmodifiableListView) return _jobPostings;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_jobPostings);
}

 final  List<JobApplication> _applications;
@override@JsonKey() List<JobApplication> get applications {
  if (_applications is EqualUnmodifiableListView) return _applications;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_applications);
}

@override final  JobPosting? currentJobPosting;
 final  List<JobApplication> _jobApplications;
@override@JsonKey() List<JobApplication> get jobApplications {
  if (_jobApplications is EqualUnmodifiableListView) return _jobApplications;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_jobApplications);
}


/// Create a copy of RecruiterState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecruiterStateCopyWith<_RecruiterState> get copyWith => __$RecruiterStateCopyWithImpl<_RecruiterState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecruiterStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecruiterState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.profile, profile) || other.profile == profile)&&const DeepCollectionEquality().equals(other._jobPostings, _jobPostings)&&const DeepCollectionEquality().equals(other._applications, _applications)&&(identical(other.currentJobPosting, currentJobPosting) || other.currentJobPosting == currentJobPosting)&&const DeepCollectionEquality().equals(other._jobApplications, _jobApplications));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,errorMessage,profile,const DeepCollectionEquality().hash(_jobPostings),const DeepCollectionEquality().hash(_applications),currentJobPosting,const DeepCollectionEquality().hash(_jobApplications));

@override
String toString() {
  return 'RecruiterState(status: $status, errorMessage: $errorMessage, profile: $profile, jobPostings: $jobPostings, applications: $applications, currentJobPosting: $currentJobPosting, jobApplications: $jobApplications)';
}


}

/// @nodoc
abstract mixin class _$RecruiterStateCopyWith<$Res> implements $RecruiterStateCopyWith<$Res> {
  factory _$RecruiterStateCopyWith(_RecruiterState value, $Res Function(_RecruiterState) _then) = __$RecruiterStateCopyWithImpl;
@override @useResult
$Res call({
 RecruiterStatus status, String errorMessage, RecruiterProfile? profile, List<JobPosting> jobPostings, List<JobApplication> applications, JobPosting? currentJobPosting, List<JobApplication> jobApplications
});


@override $RecruiterProfileCopyWith<$Res>? get profile;@override $JobPostingCopyWith<$Res>? get currentJobPosting;

}
/// @nodoc
class __$RecruiterStateCopyWithImpl<$Res>
    implements _$RecruiterStateCopyWith<$Res> {
  __$RecruiterStateCopyWithImpl(this._self, this._then);

  final _RecruiterState _self;
  final $Res Function(_RecruiterState) _then;

/// Create a copy of RecruiterState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? errorMessage = null,Object? profile = freezed,Object? jobPostings = null,Object? applications = null,Object? currentJobPosting = freezed,Object? jobApplications = null,}) {
  return _then(_RecruiterState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as RecruiterStatus,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as RecruiterProfile?,jobPostings: null == jobPostings ? _self._jobPostings : jobPostings // ignore: cast_nullable_to_non_nullable
as List<JobPosting>,applications: null == applications ? _self._applications : applications // ignore: cast_nullable_to_non_nullable
as List<JobApplication>,currentJobPosting: freezed == currentJobPosting ? _self.currentJobPosting : currentJobPosting // ignore: cast_nullable_to_non_nullable
as JobPosting?,jobApplications: null == jobApplications ? _self._jobApplications : jobApplications // ignore: cast_nullable_to_non_nullable
as List<JobApplication>,
  ));
}

/// Create a copy of RecruiterState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecruiterProfileCopyWith<$Res>? get profile {
    if (_self.profile == null) {
    return null;
  }

  return $RecruiterProfileCopyWith<$Res>(_self.profile!, (value) {
    return _then(_self.copyWith(profile: value));
  });
}/// Create a copy of RecruiterState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JobPostingCopyWith<$Res>? get currentJobPosting {
    if (_self.currentJobPosting == null) {
    return null;
  }

  return $JobPostingCopyWith<$Res>(_self.currentJobPosting!, (value) {
    return _then(_self.copyWith(currentJobPosting: value));
  });
}
}

// dart format on
