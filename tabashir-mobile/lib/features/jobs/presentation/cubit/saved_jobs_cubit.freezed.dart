// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'saved_jobs_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$SavedJobsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavedJobsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SavedJobsState()';
}


}

/// @nodoc
class $SavedJobsStateCopyWith<$Res>  {
$SavedJobsStateCopyWith(SavedJobsState _, $Res Function(SavedJobsState) __);
}


/// Adds pattern-matching-related methods to [SavedJobsState].
extension SavedJobsStatePatterns on SavedJobsState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( SavedJobsStateInitial value)?  initial,TResult Function( SavedJobsStateLoaded value)?  loaded,TResult Function( SavedJobsStateLoading value)?  loading,TResult Function( SavedJobsStateError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case SavedJobsStateInitial() when initial != null:
return initial(_that);case SavedJobsStateLoaded() when loaded != null:
return loaded(_that);case SavedJobsStateLoading() when loading != null:
return loading(_that);case SavedJobsStateError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( SavedJobsStateInitial value)  initial,required TResult Function( SavedJobsStateLoaded value)  loaded,required TResult Function( SavedJobsStateLoading value)  loading,required TResult Function( SavedJobsStateError value)  error,}){
final _that = this;
switch (_that) {
case SavedJobsStateInitial():
return initial(_that);case SavedJobsStateLoaded():
return loaded(_that);case SavedJobsStateLoading():
return loading(_that);case SavedJobsStateError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( SavedJobsStateInitial value)?  initial,TResult? Function( SavedJobsStateLoaded value)?  loaded,TResult? Function( SavedJobsStateLoading value)?  loading,TResult? Function( SavedJobsStateError value)?  error,}){
final _that = this;
switch (_that) {
case SavedJobsStateInitial() when initial != null:
return initial(_that);case SavedJobsStateLoaded() when loaded != null:
return loaded(_that);case SavedJobsStateLoading() when loading != null:
return loading(_that);case SavedJobsStateError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function( List<Map<String, dynamic>> jobs,  Set<String> savedJobs,  String cardStyle,  bool isGridView,  String searchQuery)?  loaded,TResult Function()?  loading,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case SavedJobsStateInitial() when initial != null:
return initial();case SavedJobsStateLoaded() when loaded != null:
return loaded(_that.jobs,_that.savedJobs,_that.cardStyle,_that.isGridView,_that.searchQuery);case SavedJobsStateLoading() when loading != null:
return loading();case SavedJobsStateError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function( List<Map<String, dynamic>> jobs,  Set<String> savedJobs,  String cardStyle,  bool isGridView,  String searchQuery)  loaded,required TResult Function()  loading,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case SavedJobsStateInitial():
return initial();case SavedJobsStateLoaded():
return loaded(_that.jobs,_that.savedJobs,_that.cardStyle,_that.isGridView,_that.searchQuery);case SavedJobsStateLoading():
return loading();case SavedJobsStateError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function( List<Map<String, dynamic>> jobs,  Set<String> savedJobs,  String cardStyle,  bool isGridView,  String searchQuery)?  loaded,TResult? Function()?  loading,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case SavedJobsStateInitial() when initial != null:
return initial();case SavedJobsStateLoaded() when loaded != null:
return loaded(_that.jobs,_that.savedJobs,_that.cardStyle,_that.isGridView,_that.searchQuery);case SavedJobsStateLoading() when loading != null:
return loading();case SavedJobsStateError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class SavedJobsStateInitial implements SavedJobsState {
  const SavedJobsStateInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavedJobsStateInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SavedJobsState.initial()';
}


}




/// @nodoc


class SavedJobsStateLoaded implements SavedJobsState {
  const SavedJobsStateLoaded({required final  List<Map<String, dynamic>> jobs, required final  Set<String> savedJobs, required this.cardStyle, required this.isGridView, required this.searchQuery}): _jobs = jobs,_savedJobs = savedJobs;
  

 final  List<Map<String, dynamic>> _jobs;
 List<Map<String, dynamic>> get jobs {
  if (_jobs is EqualUnmodifiableListView) return _jobs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_jobs);
}

 final  Set<String> _savedJobs;
 Set<String> get savedJobs {
  if (_savedJobs is EqualUnmodifiableSetView) return _savedJobs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableSetView(_savedJobs);
}

 final  String cardStyle;
 final  bool isGridView;
 final  String searchQuery;

/// Create a copy of SavedJobsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavedJobsStateLoadedCopyWith<SavedJobsStateLoaded> get copyWith => _$SavedJobsStateLoadedCopyWithImpl<SavedJobsStateLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavedJobsStateLoaded&&const DeepCollectionEquality().equals(other._jobs, _jobs)&&const DeepCollectionEquality().equals(other._savedJobs, _savedJobs)&&(identical(other.cardStyle, cardStyle) || other.cardStyle == cardStyle)&&(identical(other.isGridView, isGridView) || other.isGridView == isGridView)&&(identical(other.searchQuery, searchQuery) || other.searchQuery == searchQuery));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_jobs),const DeepCollectionEquality().hash(_savedJobs),cardStyle,isGridView,searchQuery);

@override
String toString() {
  return 'SavedJobsState.loaded(jobs: $jobs, savedJobs: $savedJobs, cardStyle: $cardStyle, isGridView: $isGridView, searchQuery: $searchQuery)';
}


}

/// @nodoc
abstract mixin class $SavedJobsStateLoadedCopyWith<$Res> implements $SavedJobsStateCopyWith<$Res> {
  factory $SavedJobsStateLoadedCopyWith(SavedJobsStateLoaded value, $Res Function(SavedJobsStateLoaded) _then) = _$SavedJobsStateLoadedCopyWithImpl;
@useResult
$Res call({
 List<Map<String, dynamic>> jobs, Set<String> savedJobs, String cardStyle, bool isGridView, String searchQuery
});




}
/// @nodoc
class _$SavedJobsStateLoadedCopyWithImpl<$Res>
    implements $SavedJobsStateLoadedCopyWith<$Res> {
  _$SavedJobsStateLoadedCopyWithImpl(this._self, this._then);

  final SavedJobsStateLoaded _self;
  final $Res Function(SavedJobsStateLoaded) _then;

/// Create a copy of SavedJobsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? jobs = null,Object? savedJobs = null,Object? cardStyle = null,Object? isGridView = null,Object? searchQuery = null,}) {
  return _then(SavedJobsStateLoaded(
jobs: null == jobs ? _self._jobs : jobs // ignore: cast_nullable_to_non_nullable
as List<Map<String, dynamic>>,savedJobs: null == savedJobs ? _self._savedJobs : savedJobs // ignore: cast_nullable_to_non_nullable
as Set<String>,cardStyle: null == cardStyle ? _self.cardStyle : cardStyle // ignore: cast_nullable_to_non_nullable
as String,isGridView: null == isGridView ? _self.isGridView : isGridView // ignore: cast_nullable_to_non_nullable
as bool,searchQuery: null == searchQuery ? _self.searchQuery : searchQuery // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

/// @nodoc


class SavedJobsStateLoading implements SavedJobsState {
  const SavedJobsStateLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavedJobsStateLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'SavedJobsState.loading()';
}


}




/// @nodoc


class SavedJobsStateError implements SavedJobsState {
  const SavedJobsStateError(this.message);
  

 final  String message;

/// Create a copy of SavedJobsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SavedJobsStateErrorCopyWith<SavedJobsStateError> get copyWith => _$SavedJobsStateErrorCopyWithImpl<SavedJobsStateError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SavedJobsStateError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'SavedJobsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $SavedJobsStateErrorCopyWith<$Res> implements $SavedJobsStateCopyWith<$Res> {
  factory $SavedJobsStateErrorCopyWith(SavedJobsStateError value, $Res Function(SavedJobsStateError) _then) = _$SavedJobsStateErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$SavedJobsStateErrorCopyWithImpl<$Res>
    implements $SavedJobsStateErrorCopyWith<$Res> {
  _$SavedJobsStateErrorCopyWithImpl(this._self, this._then);

  final SavedJobsStateError _self;
  final $Res Function(SavedJobsStateError) _then;

/// Create a copy of SavedJobsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(SavedJobsStateError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
