// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_jobs_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SavedJobsResponse {

/// Success status
 bool get success;/// List of saved job IDs (for GET operations)
 List<String> get savedJobs;/// Count of saved jobs
 int? get count;/// Success message
 String? get message;/// Error message
 String? get error;
/// Create a copy of SavedJobsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavedJobsResponseCopyWith<SavedJobsResponse> get copyWith => _$SavedJobsResponseCopyWithImpl<SavedJobsResponse>(this as SavedJobsResponse, _$identity);

  /// Serializes this SavedJobsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavedJobsResponse&&(identical(other.success, success) || other.success == success)&&const DeepCollectionEquality().equals(other.savedJobs, savedJobs)&&(identical(other.count, count) || other.count == count)&&(identical(other.message, message) || other.message == message)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,const DeepCollectionEquality().hash(savedJobs),count,message,error);

@override
String toString() {
  return 'SavedJobsResponse(success: $success, savedJobs: $savedJobs, count: $count, message: $message, error: $error)';
}


}

/// @nodoc
abstract mixin class $SavedJobsResponseCopyWith<$Res>  {
  factory $SavedJobsResponseCopyWith(SavedJobsResponse value, $Res Function(SavedJobsResponse) _then) = _$SavedJobsResponseCopyWithImpl;
@useResult
$Res call({
 bool success, List<String> savedJobs, int? count, String? message, String? error
});




}
/// @nodoc
class _$SavedJobsResponseCopyWithImpl<$Res>
    implements $SavedJobsResponseCopyWith<$Res> {
  _$SavedJobsResponseCopyWithImpl(this._self, this._then);

  final SavedJobsResponse _self;
  final $Res Function(SavedJobsResponse) _then;

/// Create a copy of SavedJobsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? savedJobs = null,Object? count = freezed,Object? message = freezed,Object? error = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,savedJobs: null == savedJobs ? _self.savedJobs : savedJobs // ignore: cast_nullable_to_non_nullable
as List<String>,count: freezed == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SavedJobsResponse].
extension SavedJobsResponsePatterns on SavedJobsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SavedJobsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SavedJobsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SavedJobsResponse value)  $default,){
final _that = this;
switch (_that) {
case _SavedJobsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SavedJobsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _SavedJobsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  List<String> savedJobs,  int? count,  String? message,  String? error)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SavedJobsResponse() when $default != null:
return $default(_that.success,_that.savedJobs,_that.count,_that.message,_that.error);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  List<String> savedJobs,  int? count,  String? message,  String? error)  $default,) {final _that = this;
switch (_that) {
case _SavedJobsResponse():
return $default(_that.success,_that.savedJobs,_that.count,_that.message,_that.error);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  List<String> savedJobs,  int? count,  String? message,  String? error)?  $default,) {final _that = this;
switch (_that) {
case _SavedJobsResponse() when $default != null:
return $default(_that.success,_that.savedJobs,_that.count,_that.message,_that.error);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SavedJobsResponse implements SavedJobsResponse {
  const _SavedJobsResponse({required this.success, final  List<String> savedJobs = const [], this.count, this.message, this.error}): _savedJobs = savedJobs;
  factory _SavedJobsResponse.fromJson(Map<String, dynamic> json) => _$SavedJobsResponseFromJson(json);

/// Success status
@override final  bool success;
/// List of saved job IDs (for GET operations)
 final  List<String> _savedJobs;
/// List of saved job IDs (for GET operations)
@override@JsonKey() List<String> get savedJobs {
  if (_savedJobs is EqualUnmodifiableListView) return _savedJobs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_savedJobs);
}

/// Count of saved jobs
@override final  int? count;
/// Success message
@override final  String? message;
/// Error message
@override final  String? error;

/// Create a copy of SavedJobsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SavedJobsResponseCopyWith<_SavedJobsResponse> get copyWith => __$SavedJobsResponseCopyWithImpl<_SavedJobsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SavedJobsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SavedJobsResponse&&(identical(other.success, success) || other.success == success)&&const DeepCollectionEquality().equals(other._savedJobs, _savedJobs)&&(identical(other.count, count) || other.count == count)&&(identical(other.message, message) || other.message == message)&&(identical(other.error, error) || other.error == error));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,const DeepCollectionEquality().hash(_savedJobs),count,message,error);

@override
String toString() {
  return 'SavedJobsResponse(success: $success, savedJobs: $savedJobs, count: $count, message: $message, error: $error)';
}


}

/// @nodoc
abstract mixin class _$SavedJobsResponseCopyWith<$Res> implements $SavedJobsResponseCopyWith<$Res> {
  factory _$SavedJobsResponseCopyWith(_SavedJobsResponse value, $Res Function(_SavedJobsResponse) _then) = __$SavedJobsResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, List<String> savedJobs, int? count, String? message, String? error
});




}
/// @nodoc
class __$SavedJobsResponseCopyWithImpl<$Res>
    implements _$SavedJobsResponseCopyWith<$Res> {
  __$SavedJobsResponseCopyWithImpl(this._self, this._then);

  final _SavedJobsResponse _self;
  final $Res Function(_SavedJobsResponse) _then;

/// Create a copy of SavedJobsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? savedJobs = null,Object? count = freezed,Object? message = freezed,Object? error = freezed,}) {
  return _then(_SavedJobsResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,savedJobs: null == savedJobs ? _self._savedJobs : savedJobs // ignore: cast_nullable_to_non_nullable
as List<String>,count: freezed == count ? _self.count : count // ignore: cast_nullable_to_non_nullable
as int?,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,error: freezed == error ? _self.error : error // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
