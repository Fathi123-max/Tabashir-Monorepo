// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_applications_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JobApplicationsState {

 JobApplicationsStatus get status; List<AppliedJob> get appliedJobs; int get totalApplications; String get errorMessage;
/// Create a copy of JobApplicationsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobApplicationsStateCopyWith<JobApplicationsState> get copyWith => _$JobApplicationsStateCopyWithImpl<JobApplicationsState>(this as JobApplicationsState, _$identity);

  /// Serializes this JobApplicationsState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobApplicationsState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other.appliedJobs, appliedJobs)&&(identical(other.totalApplications, totalApplications) || other.totalApplications == totalApplications)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(appliedJobs),totalApplications,errorMessage);

@override
String toString() {
  return 'JobApplicationsState(status: $status, appliedJobs: $appliedJobs, totalApplications: $totalApplications, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class $JobApplicationsStateCopyWith<$Res>  {
  factory $JobApplicationsStateCopyWith(JobApplicationsState value, $Res Function(JobApplicationsState) _then) = _$JobApplicationsStateCopyWithImpl;
@useResult
$Res call({
 JobApplicationsStatus status, List<AppliedJob> appliedJobs, int totalApplications, String errorMessage
});




}
/// @nodoc
class _$JobApplicationsStateCopyWithImpl<$Res>
    implements $JobApplicationsStateCopyWith<$Res> {
  _$JobApplicationsStateCopyWithImpl(this._self, this._then);

  final JobApplicationsState _self;
  final $Res Function(JobApplicationsState) _then;

/// Create a copy of JobApplicationsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? appliedJobs = null,Object? totalApplications = null,Object? errorMessage = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as JobApplicationsStatus,appliedJobs: null == appliedJobs ? _self.appliedJobs : appliedJobs // ignore: cast_nullable_to_non_nullable
as List<AppliedJob>,totalApplications: null == totalApplications ? _self.totalApplications : totalApplications // ignore: cast_nullable_to_non_nullable
as int,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [JobApplicationsState].
extension JobApplicationsStatePatterns on JobApplicationsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobApplicationsState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobApplicationsState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobApplicationsState value)  $default,){
final _that = this;
switch (_that) {
case _JobApplicationsState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobApplicationsState value)?  $default,){
final _that = this;
switch (_that) {
case _JobApplicationsState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( JobApplicationsStatus status,  List<AppliedJob> appliedJobs,  int totalApplications,  String errorMessage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobApplicationsState() when $default != null:
return $default(_that.status,_that.appliedJobs,_that.totalApplications,_that.errorMessage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( JobApplicationsStatus status,  List<AppliedJob> appliedJobs,  int totalApplications,  String errorMessage)  $default,) {final _that = this;
switch (_that) {
case _JobApplicationsState():
return $default(_that.status,_that.appliedJobs,_that.totalApplications,_that.errorMessage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( JobApplicationsStatus status,  List<AppliedJob> appliedJobs,  int totalApplications,  String errorMessage)?  $default,) {final _that = this;
switch (_that) {
case _JobApplicationsState() when $default != null:
return $default(_that.status,_that.appliedJobs,_that.totalApplications,_that.errorMessage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JobApplicationsState implements JobApplicationsState {
  const _JobApplicationsState({this.status = JobApplicationsStatus.initial, final  List<AppliedJob> appliedJobs = const [], this.totalApplications = 0, this.errorMessage = ''}): _appliedJobs = appliedJobs;
  factory _JobApplicationsState.fromJson(Map<String, dynamic> json) => _$JobApplicationsStateFromJson(json);

@override@JsonKey() final  JobApplicationsStatus status;
 final  List<AppliedJob> _appliedJobs;
@override@JsonKey() List<AppliedJob> get appliedJobs {
  if (_appliedJobs is EqualUnmodifiableListView) return _appliedJobs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_appliedJobs);
}

@override@JsonKey() final  int totalApplications;
@override@JsonKey() final  String errorMessage;

/// Create a copy of JobApplicationsState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobApplicationsStateCopyWith<_JobApplicationsState> get copyWith => __$JobApplicationsStateCopyWithImpl<_JobApplicationsState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JobApplicationsStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobApplicationsState&&(identical(other.status, status) || other.status == status)&&const DeepCollectionEquality().equals(other._appliedJobs, _appliedJobs)&&(identical(other.totalApplications, totalApplications) || other.totalApplications == totalApplications)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,const DeepCollectionEquality().hash(_appliedJobs),totalApplications,errorMessage);

@override
String toString() {
  return 'JobApplicationsState(status: $status, appliedJobs: $appliedJobs, totalApplications: $totalApplications, errorMessage: $errorMessage)';
}


}

/// @nodoc
abstract mixin class _$JobApplicationsStateCopyWith<$Res> implements $JobApplicationsStateCopyWith<$Res> {
  factory _$JobApplicationsStateCopyWith(_JobApplicationsState value, $Res Function(_JobApplicationsState) _then) = __$JobApplicationsStateCopyWithImpl;
@override @useResult
$Res call({
 JobApplicationsStatus status, List<AppliedJob> appliedJobs, int totalApplications, String errorMessage
});




}
/// @nodoc
class __$JobApplicationsStateCopyWithImpl<$Res>
    implements _$JobApplicationsStateCopyWith<$Res> {
  __$JobApplicationsStateCopyWithImpl(this._self, this._then);

  final _JobApplicationsState _self;
  final $Res Function(_JobApplicationsState) _then;

/// Create a copy of JobApplicationsState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? appliedJobs = null,Object? totalApplications = null,Object? errorMessage = null,}) {
  return _then(_JobApplicationsState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as JobApplicationsStatus,appliedJobs: null == appliedJobs ? _self._appliedJobs : appliedJobs // ignore: cast_nullable_to_non_nullable
as List<AppliedJob>,totalApplications: null == totalApplications ? _self.totalApplications : totalApplications // ignore: cast_nullable_to_non_nullable
as int,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
