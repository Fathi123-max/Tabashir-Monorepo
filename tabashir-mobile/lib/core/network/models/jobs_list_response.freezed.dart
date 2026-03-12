// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'jobs_list_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JobsListResponse {

/// Success status
 bool? get success;/// List of jobs
 List<JobDetailsResponse>? get jobs;/// Pagination info
 Map<String, dynamic>? get pagination;
/// Create a copy of JobsListResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobsListResponseCopyWith<JobsListResponse> get copyWith => _$JobsListResponseCopyWithImpl<JobsListResponse>(this as JobsListResponse, _$identity);

  /// Serializes this JobsListResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobsListResponse&&(identical(other.success, success) || other.success == success)&&const DeepCollectionEquality().equals(other.jobs, jobs)&&const DeepCollectionEquality().equals(other.pagination, pagination));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,const DeepCollectionEquality().hash(jobs),const DeepCollectionEquality().hash(pagination));

@override
String toString() {
  return 'JobsListResponse(success: $success, jobs: $jobs, pagination: $pagination)';
}


}

/// @nodoc
abstract mixin class $JobsListResponseCopyWith<$Res>  {
  factory $JobsListResponseCopyWith(JobsListResponse value, $Res Function(JobsListResponse) _then) = _$JobsListResponseCopyWithImpl;
@useResult
$Res call({
 bool? success, List<JobDetailsResponse>? jobs, Map<String, dynamic>? pagination
});




}
/// @nodoc
class _$JobsListResponseCopyWithImpl<$Res>
    implements $JobsListResponseCopyWith<$Res> {
  _$JobsListResponseCopyWithImpl(this._self, this._then);

  final JobsListResponse _self;
  final $Res Function(JobsListResponse) _then;

/// Create a copy of JobsListResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = freezed,Object? jobs = freezed,Object? pagination = freezed,}) {
  return _then(_self.copyWith(
success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool?,jobs: freezed == jobs ? _self.jobs : jobs // ignore: cast_nullable_to_non_nullable
as List<JobDetailsResponse>?,pagination: freezed == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}

}


/// Adds pattern-matching-related methods to [JobsListResponse].
extension JobsListResponsePatterns on JobsListResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobsListResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobsListResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobsListResponse value)  $default,){
final _that = this;
switch (_that) {
case _JobsListResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobsListResponse value)?  $default,){
final _that = this;
switch (_that) {
case _JobsListResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool? success,  List<JobDetailsResponse>? jobs,  Map<String, dynamic>? pagination)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobsListResponse() when $default != null:
return $default(_that.success,_that.jobs,_that.pagination);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool? success,  List<JobDetailsResponse>? jobs,  Map<String, dynamic>? pagination)  $default,) {final _that = this;
switch (_that) {
case _JobsListResponse():
return $default(_that.success,_that.jobs,_that.pagination);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool? success,  List<JobDetailsResponse>? jobs,  Map<String, dynamic>? pagination)?  $default,) {final _that = this;
switch (_that) {
case _JobsListResponse() when $default != null:
return $default(_that.success,_that.jobs,_that.pagination);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JobsListResponse implements JobsListResponse {
  const _JobsListResponse({this.success, final  List<JobDetailsResponse>? jobs, final  Map<String, dynamic>? pagination}): _jobs = jobs,_pagination = pagination;
  factory _JobsListResponse.fromJson(Map<String, dynamic> json) => _$JobsListResponseFromJson(json);

/// Success status
@override final  bool? success;
/// List of jobs
 final  List<JobDetailsResponse>? _jobs;
/// List of jobs
@override List<JobDetailsResponse>? get jobs {
  final value = _jobs;
  if (value == null) return null;
  if (_jobs is EqualUnmodifiableListView) return _jobs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Pagination info
 final  Map<String, dynamic>? _pagination;
/// Pagination info
@override Map<String, dynamic>? get pagination {
  final value = _pagination;
  if (value == null) return null;
  if (_pagination is EqualUnmodifiableMapView) return _pagination;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}


/// Create a copy of JobsListResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobsListResponseCopyWith<_JobsListResponse> get copyWith => __$JobsListResponseCopyWithImpl<_JobsListResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JobsListResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobsListResponse&&(identical(other.success, success) || other.success == success)&&const DeepCollectionEquality().equals(other._jobs, _jobs)&&const DeepCollectionEquality().equals(other._pagination, _pagination));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,const DeepCollectionEquality().hash(_jobs),const DeepCollectionEquality().hash(_pagination));

@override
String toString() {
  return 'JobsListResponse(success: $success, jobs: $jobs, pagination: $pagination)';
}


}

/// @nodoc
abstract mixin class _$JobsListResponseCopyWith<$Res> implements $JobsListResponseCopyWith<$Res> {
  factory _$JobsListResponseCopyWith(_JobsListResponse value, $Res Function(_JobsListResponse) _then) = __$JobsListResponseCopyWithImpl;
@override @useResult
$Res call({
 bool? success, List<JobDetailsResponse>? jobs, Map<String, dynamic>? pagination
});




}
/// @nodoc
class __$JobsListResponseCopyWithImpl<$Res>
    implements _$JobsListResponseCopyWith<$Res> {
  __$JobsListResponseCopyWithImpl(this._self, this._then);

  final _JobsListResponse _self;
  final $Res Function(_JobsListResponse) _then;

/// Create a copy of JobsListResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = freezed,Object? jobs = freezed,Object? pagination = freezed,}) {
  return _then(_JobsListResponse(
success: freezed == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool?,jobs: freezed == jobs ? _self._jobs : jobs // ignore: cast_nullable_to_non_nullable
as List<JobDetailsResponse>?,pagination: freezed == pagination ? _self._pagination : pagination // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,
  ));
}


}

// dart format on
