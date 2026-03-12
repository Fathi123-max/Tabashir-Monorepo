// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'interview_training_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$InterviewTrainingState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InterviewTrainingState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'InterviewTrainingState()';
}


}

/// @nodoc
class $InterviewTrainingStateCopyWith<$Res>  {
$InterviewTrainingStateCopyWith(InterviewTrainingState _, $Res Function(InterviewTrainingState) __);
}


/// Adds pattern-matching-related methods to [InterviewTrainingState].
extension InterviewTrainingStatePatterns on InterviewTrainingState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( InterviewTrainingInitial value)?  initial,TResult Function( InterviewTrainingLoading value)?  loading,TResult Function( InterviewTrainingWaitlistSuccess value)?  waitlistSuccess,TResult Function( InterviewTrainingError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case InterviewTrainingInitial() when initial != null:
return initial(_that);case InterviewTrainingLoading() when loading != null:
return loading(_that);case InterviewTrainingWaitlistSuccess() when waitlistSuccess != null:
return waitlistSuccess(_that);case InterviewTrainingError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( InterviewTrainingInitial value)  initial,required TResult Function( InterviewTrainingLoading value)  loading,required TResult Function( InterviewTrainingWaitlistSuccess value)  waitlistSuccess,required TResult Function( InterviewTrainingError value)  error,}){
final _that = this;
switch (_that) {
case InterviewTrainingInitial():
return initial(_that);case InterviewTrainingLoading():
return loading(_that);case InterviewTrainingWaitlistSuccess():
return waitlistSuccess(_that);case InterviewTrainingError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( InterviewTrainingInitial value)?  initial,TResult? Function( InterviewTrainingLoading value)?  loading,TResult? Function( InterviewTrainingWaitlistSuccess value)?  waitlistSuccess,TResult? Function( InterviewTrainingError value)?  error,}){
final _that = this;
switch (_that) {
case InterviewTrainingInitial() when initial != null:
return initial(_that);case InterviewTrainingLoading() when loading != null:
return loading(_that);case InterviewTrainingWaitlistSuccess() when waitlistSuccess != null:
return waitlistSuccess(_that);case InterviewTrainingError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function()?  waitlistSuccess,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case InterviewTrainingInitial() when initial != null:
return initial();case InterviewTrainingLoading() when loading != null:
return loading();case InterviewTrainingWaitlistSuccess() when waitlistSuccess != null:
return waitlistSuccess();case InterviewTrainingError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function()  waitlistSuccess,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case InterviewTrainingInitial():
return initial();case InterviewTrainingLoading():
return loading();case InterviewTrainingWaitlistSuccess():
return waitlistSuccess();case InterviewTrainingError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function()?  waitlistSuccess,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case InterviewTrainingInitial() when initial != null:
return initial();case InterviewTrainingLoading() when loading != null:
return loading();case InterviewTrainingWaitlistSuccess() when waitlistSuccess != null:
return waitlistSuccess();case InterviewTrainingError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class InterviewTrainingInitial implements InterviewTrainingState {
  const InterviewTrainingInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InterviewTrainingInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'InterviewTrainingState.initial()';
}


}




/// @nodoc


class InterviewTrainingLoading implements InterviewTrainingState {
  const InterviewTrainingLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InterviewTrainingLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'InterviewTrainingState.loading()';
}


}




/// @nodoc


class InterviewTrainingWaitlistSuccess implements InterviewTrainingState {
  const InterviewTrainingWaitlistSuccess();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InterviewTrainingWaitlistSuccess);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'InterviewTrainingState.waitlistSuccess()';
}


}




/// @nodoc


class InterviewTrainingError implements InterviewTrainingState {
  const InterviewTrainingError(this.message);
  

 final  String message;

/// Create a copy of InterviewTrainingState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$InterviewTrainingErrorCopyWith<InterviewTrainingError> get copyWith => _$InterviewTrainingErrorCopyWithImpl<InterviewTrainingError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is InterviewTrainingError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'InterviewTrainingState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $InterviewTrainingErrorCopyWith<$Res> implements $InterviewTrainingStateCopyWith<$Res> {
  factory $InterviewTrainingErrorCopyWith(InterviewTrainingError value, $Res Function(InterviewTrainingError) _then) = _$InterviewTrainingErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$InterviewTrainingErrorCopyWithImpl<$Res>
    implements $InterviewTrainingErrorCopyWith<$Res> {
  _$InterviewTrainingErrorCopyWithImpl(this._self, this._then);

  final InterviewTrainingError _self;
  final $Res Function(InterviewTrainingError) _then;

/// Create a copy of InterviewTrainingState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(InterviewTrainingError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
