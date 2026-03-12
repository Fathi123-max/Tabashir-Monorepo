// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'services_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ServicesState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServicesState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ServicesState()';
}


}

/// @nodoc
class $ServicesStateCopyWith<$Res>  {
$ServicesStateCopyWith(ServicesState _, $Res Function(ServicesState) __);
}


/// Adds pattern-matching-related methods to [ServicesState].
extension ServicesStatePatterns on ServicesState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( ServicesInitial value)?  initial,TResult Function( ServicesLoading value)?  loading,TResult Function( ServicesLoaded value)?  loaded,TResult Function( ServicesError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case ServicesInitial() when initial != null:
return initial(_that);case ServicesLoading() when loading != null:
return loading(_that);case ServicesLoaded() when loaded != null:
return loaded(_that);case ServicesError() when error != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( ServicesInitial value)  initial,required TResult Function( ServicesLoading value)  loading,required TResult Function( ServicesLoaded value)  loaded,required TResult Function( ServicesError value)  error,}){
final _that = this;
switch (_that) {
case ServicesInitial():
return initial(_that);case ServicesLoading():
return loading(_that);case ServicesLoaded():
return loaded(_that);case ServicesError():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( ServicesInitial value)?  initial,TResult? Function( ServicesLoading value)?  loading,TResult? Function( ServicesLoaded value)?  loaded,TResult? Function( ServicesError value)?  error,}){
final _that = this;
switch (_that) {
case ServicesInitial() when initial != null:
return initial(_that);case ServicesLoading() when loading != null:
return loading(_that);case ServicesLoaded() when loaded != null:
return loaded(_that);case ServicesError() when error != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function()?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case ServicesInitial() when initial != null:
return initial();case ServicesLoading() when loading != null:
return loading();case ServicesLoaded() when loaded != null:
return loaded();case ServicesError() when error != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function()  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case ServicesInitial():
return initial();case ServicesLoading():
return loading();case ServicesLoaded():
return loaded();case ServicesError():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function()?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case ServicesInitial() when initial != null:
return initial();case ServicesLoading() when loading != null:
return loading();case ServicesLoaded() when loaded != null:
return loaded();case ServicesError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class ServicesInitial implements ServicesState {
  const ServicesInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServicesInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ServicesState.initial()';
}


}




/// @nodoc


class ServicesLoading implements ServicesState {
  const ServicesLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServicesLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ServicesState.loading()';
}


}




/// @nodoc


class ServicesLoaded implements ServicesState {
  const ServicesLoaded();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServicesLoaded);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'ServicesState.loaded()';
}


}




/// @nodoc


class ServicesError implements ServicesState {
  const ServicesError(this.message);
  

 final  String message;

/// Create a copy of ServicesState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ServicesErrorCopyWith<ServicesError> get copyWith => _$ServicesErrorCopyWithImpl<ServicesError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ServicesError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'ServicesState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $ServicesErrorCopyWith<$Res> implements $ServicesStateCopyWith<$Res> {
  factory $ServicesErrorCopyWith(ServicesError value, $Res Function(ServicesError) _then) = _$ServicesErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$ServicesErrorCopyWithImpl<$Res>
    implements $ServicesErrorCopyWith<$Res> {
  _$ServicesErrorCopyWithImpl(this._self, this._then);

  final ServicesError _self;
  final $Res Function(ServicesError) _then;

/// Create a copy of ServicesState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(ServicesError(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
