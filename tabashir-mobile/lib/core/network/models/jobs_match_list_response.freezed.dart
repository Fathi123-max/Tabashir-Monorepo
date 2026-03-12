// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'jobs_match_list_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JobsMatchListResponse {

/// Success status
 bool get success;/// Matched jobs (note: field name from API)
@JsonKey(name: 'matched_jobs') List<JobDetailsResponse> get matchedJobs;/// Pagination info
 Map<String, dynamic> get pagination;
/// Create a copy of JobsMatchListResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobsMatchListResponseCopyWith<JobsMatchListResponse> get copyWith => _$JobsMatchListResponseCopyWithImpl<JobsMatchListResponse>(this as JobsMatchListResponse, _$identity);

  /// Serializes this JobsMatchListResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobsMatchListResponse&&(identical(other.success, success) || other.success == success)&&const DeepCollectionEquality().equals(other.matchedJobs, matchedJobs)&&const DeepCollectionEquality().equals(other.pagination, pagination));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,const DeepCollectionEquality().hash(matchedJobs),const DeepCollectionEquality().hash(pagination));

@override
String toString() {
  return 'JobsMatchListResponse(success: $success, matchedJobs: $matchedJobs, pagination: $pagination)';
}


}

/// @nodoc
abstract mixin class $JobsMatchListResponseCopyWith<$Res>  {
  factory $JobsMatchListResponseCopyWith(JobsMatchListResponse value, $Res Function(JobsMatchListResponse) _then) = _$JobsMatchListResponseCopyWithImpl;
@useResult
$Res call({
 bool success,@JsonKey(name: 'matched_jobs') List<JobDetailsResponse> matchedJobs, Map<String, dynamic> pagination
});




}
/// @nodoc
class _$JobsMatchListResponseCopyWithImpl<$Res>
    implements $JobsMatchListResponseCopyWith<$Res> {
  _$JobsMatchListResponseCopyWithImpl(this._self, this._then);

  final JobsMatchListResponse _self;
  final $Res Function(JobsMatchListResponse) _then;

/// Create a copy of JobsMatchListResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? matchedJobs = null,Object? pagination = null,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,matchedJobs: null == matchedJobs ? _self.matchedJobs : matchedJobs // ignore: cast_nullable_to_non_nullable
as List<JobDetailsResponse>,pagination: null == pagination ? _self.pagination : pagination // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}

}


/// Adds pattern-matching-related methods to [JobsMatchListResponse].
extension JobsMatchListResponsePatterns on JobsMatchListResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobsMatchListResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobsMatchListResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobsMatchListResponse value)  $default,){
final _that = this;
switch (_that) {
case _JobsMatchListResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobsMatchListResponse value)?  $default,){
final _that = this;
switch (_that) {
case _JobsMatchListResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success, @JsonKey(name: 'matched_jobs')  List<JobDetailsResponse> matchedJobs,  Map<String, dynamic> pagination)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobsMatchListResponse() when $default != null:
return $default(_that.success,_that.matchedJobs,_that.pagination);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success, @JsonKey(name: 'matched_jobs')  List<JobDetailsResponse> matchedJobs,  Map<String, dynamic> pagination)  $default,) {final _that = this;
switch (_that) {
case _JobsMatchListResponse():
return $default(_that.success,_that.matchedJobs,_that.pagination);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success, @JsonKey(name: 'matched_jobs')  List<JobDetailsResponse> matchedJobs,  Map<String, dynamic> pagination)?  $default,) {final _that = this;
switch (_that) {
case _JobsMatchListResponse() when $default != null:
return $default(_that.success,_that.matchedJobs,_that.pagination);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JobsMatchListResponse implements JobsMatchListResponse {
  const _JobsMatchListResponse({required this.success, @JsonKey(name: 'matched_jobs') required final  List<JobDetailsResponse> matchedJobs, required final  Map<String, dynamic> pagination}): _matchedJobs = matchedJobs,_pagination = pagination;
  factory _JobsMatchListResponse.fromJson(Map<String, dynamic> json) => _$JobsMatchListResponseFromJson(json);

/// Success status
@override final  bool success;
/// Matched jobs (note: field name from API)
 final  List<JobDetailsResponse> _matchedJobs;
/// Matched jobs (note: field name from API)
@override@JsonKey(name: 'matched_jobs') List<JobDetailsResponse> get matchedJobs {
  if (_matchedJobs is EqualUnmodifiableListView) return _matchedJobs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_matchedJobs);
}

/// Pagination info
 final  Map<String, dynamic> _pagination;
/// Pagination info
@override Map<String, dynamic> get pagination {
  if (_pagination is EqualUnmodifiableMapView) return _pagination;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(_pagination);
}


/// Create a copy of JobsMatchListResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobsMatchListResponseCopyWith<_JobsMatchListResponse> get copyWith => __$JobsMatchListResponseCopyWithImpl<_JobsMatchListResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JobsMatchListResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobsMatchListResponse&&(identical(other.success, success) || other.success == success)&&const DeepCollectionEquality().equals(other._matchedJobs, _matchedJobs)&&const DeepCollectionEquality().equals(other._pagination, _pagination));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,const DeepCollectionEquality().hash(_matchedJobs),const DeepCollectionEquality().hash(_pagination));

@override
String toString() {
  return 'JobsMatchListResponse(success: $success, matchedJobs: $matchedJobs, pagination: $pagination)';
}


}

/// @nodoc
abstract mixin class _$JobsMatchListResponseCopyWith<$Res> implements $JobsMatchListResponseCopyWith<$Res> {
  factory _$JobsMatchListResponseCopyWith(_JobsMatchListResponse value, $Res Function(_JobsMatchListResponse) _then) = __$JobsMatchListResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success,@JsonKey(name: 'matched_jobs') List<JobDetailsResponse> matchedJobs, Map<String, dynamic> pagination
});




}
/// @nodoc
class __$JobsMatchListResponseCopyWithImpl<$Res>
    implements _$JobsMatchListResponseCopyWith<$Res> {
  __$JobsMatchListResponseCopyWithImpl(this._self, this._then);

  final _JobsMatchListResponse _self;
  final $Res Function(_JobsMatchListResponse) _then;

/// Create a copy of JobsMatchListResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? matchedJobs = null,Object? pagination = null,}) {
  return _then(_JobsMatchListResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,matchedJobs: null == matchedJobs ? _self._matchedJobs : matchedJobs // ignore: cast_nullable_to_non_nullable
as List<JobDetailsResponse>,pagination: null == pagination ? _self._pagination : pagination // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>,
  ));
}


}

// dart format on
