// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_details_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$JobDetailsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobDetailsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'JobDetailsState()';
}


}

/// @nodoc
class $JobDetailsStateCopyWith<$Res>  {
$JobDetailsStateCopyWith(JobDetailsState _, $Res Function(JobDetailsState) __);
}


/// Adds pattern-matching-related methods to [JobDetailsState].
extension JobDetailsStatePatterns on JobDetailsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( JobDetailsInitial value)?  initial,TResult Function( JobDetailsLoading value)?  loading,TResult Function( JobDetailsLoaded value)?  loaded,TResult Function( JobDetailsError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case JobDetailsInitial() when initial != null:
return initial(_that);case JobDetailsLoading() when loading != null:
return loading(_that);case JobDetailsLoaded() when loaded != null:
return loaded(_that);case JobDetailsError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( JobDetailsInitial value)  initial,required TResult Function( JobDetailsLoading value)  loading,required TResult Function( JobDetailsLoaded value)  loaded,required TResult Function( JobDetailsError value)  error,}){
final _that = this;
switch (_that) {
case JobDetailsInitial():
return initial(_that);case JobDetailsLoading():
return loading(_that);case JobDetailsLoaded():
return loaded(_that);case JobDetailsError():
return error(_that);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( JobDetailsInitial value)?  initial,TResult? Function( JobDetailsLoading value)?  loading,TResult? Function( JobDetailsLoaded value)?  loaded,TResult? Function( JobDetailsError value)?  error,}){
final _that = this;
switch (_that) {
case JobDetailsInitial() when initial != null:
return initial(_that);case JobDetailsLoading() when loading != null:
return loading(_that);case JobDetailsLoaded() when loaded != null:
return loaded(_that);case JobDetailsError() when error != null:
return error(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( JobDetails jobDetails,  bool isApplied,  bool isSaved)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case JobDetailsInitial() when initial != null:
return initial();case JobDetailsLoading() when loading != null:
return loading();case JobDetailsLoaded() when loaded != null:
return loaded(_that.jobDetails,_that.isApplied,_that.isSaved);case JobDetailsError() when error != null:
return error(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( JobDetails jobDetails,  bool isApplied,  bool isSaved)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case JobDetailsInitial():
return initial();case JobDetailsLoading():
return loading();case JobDetailsLoaded():
return loaded(_that.jobDetails,_that.isApplied,_that.isSaved);case JobDetailsError():
return error(_that.message);case _:
  throw StateError('Unexpected subclass');

}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( JobDetails jobDetails,  bool isApplied,  bool isSaved)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case JobDetailsInitial() when initial != null:
return initial();case JobDetailsLoading() when loading != null:
return loading();case JobDetailsLoaded() when loaded != null:
return loaded(_that.jobDetails,_that.isApplied,_that.isSaved);case JobDetailsError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class JobDetailsInitial implements JobDetailsState {
  const JobDetailsInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobDetailsInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'JobDetailsState.initial()';
}


}




/// @nodoc


class JobDetailsLoading implements JobDetailsState {
  const JobDetailsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobDetailsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'JobDetailsState.loading()';
}


}




/// @nodoc


class JobDetailsLoaded implements JobDetailsState {
  const JobDetailsLoaded({required this.jobDetails, this.isApplied = false, this.isSaved = false});
  

 final  JobDetails jobDetails;
@JsonKey() final  bool isApplied;
@JsonKey() final  bool isSaved;

/// Create a copy of JobDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobDetailsLoadedCopyWith<JobDetailsLoaded> get copyWith => _$JobDetailsLoadedCopyWithImpl<JobDetailsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobDetailsLoaded&&(identical(other.jobDetails, jobDetails) || other.jobDetails == jobDetails)&&(identical(other.isApplied, isApplied) || other.isApplied == isApplied)&&(identical(other.isSaved, isSaved) || other.isSaved == isSaved));
}


@override
int get hashCode => Object.hash(runtimeType,jobDetails,isApplied,isSaved);

@override
String toString() {
  return 'JobDetailsState.loaded(jobDetails: $jobDetails, isApplied: $isApplied, isSaved: $isSaved)';
}


}

/// @nodoc
abstract mixin class $JobDetailsLoadedCopyWith<$Res> implements $JobDetailsStateCopyWith<$Res> {
  factory $JobDetailsLoadedCopyWith(JobDetailsLoaded value, $Res Function(JobDetailsLoaded) _then) = _$JobDetailsLoadedCopyWithImpl;
@useResult
$Res call({
 JobDetails jobDetails, bool isApplied, bool isSaved
});


$JobDetailsCopyWith<$Res> get jobDetails;

}
/// @nodoc
class _$JobDetailsLoadedCopyWithImpl<$Res>
    implements $JobDetailsLoadedCopyWith<$Res> {
  _$JobDetailsLoadedCopyWithImpl(this._self, this._then);

  final JobDetailsLoaded _self;
  final $Res Function(JobDetailsLoaded) _then;

/// Create a copy of JobDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? jobDetails = null,Object? isApplied = null,Object? isSaved = null,}) {
  return _then(JobDetailsLoaded(
jobDetails: null == jobDetails ? _self.jobDetails : jobDetails // ignore: cast_nullable_to_non_nullable
as JobDetails,isApplied: null == isApplied ? _self.isApplied : isApplied // ignore: cast_nullable_to_non_nullable
as bool,isSaved: null == isSaved ? _self.isSaved : isSaved // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of JobDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JobDetailsCopyWith<$Res> get jobDetails {
  
  return $JobDetailsCopyWith<$Res>(_self.jobDetails, (value) {
    return _then(_self.copyWith(jobDetails: value));
  });
}
}

/// @nodoc


class JobDetailsError implements JobDetailsState {
  const JobDetailsError(this.message);
  

 final  String message;

/// Create a copy of JobDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobDetailsErrorCopyWith<JobDetailsError> get copyWith => _$JobDetailsErrorCopyWithImpl<JobDetailsError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobDetailsError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'JobDetailsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $JobDetailsErrorCopyWith<$Res> implements $JobDetailsStateCopyWith<$Res> {
  factory $JobDetailsErrorCopyWith(JobDetailsError value, $Res Function(JobDetailsError) _then) = _$JobDetailsErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$JobDetailsErrorCopyWithImpl<$Res>
    implements $JobDetailsErrorCopyWith<$Res> {
  _$JobDetailsErrorCopyWithImpl(this._self, this._then);

  final JobDetailsError _self;
  final $Res Function(JobDetailsError) _then;

/// Create a copy of JobDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(JobDetailsError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
