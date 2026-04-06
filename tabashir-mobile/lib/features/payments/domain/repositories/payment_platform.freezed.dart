// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_platform.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$PaymentResult {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentResult);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentResult()';
}


}

/// @nodoc
class $PaymentResultCopyWith<$Res>  {
$PaymentResultCopyWith(PaymentResult _, $Res Function(PaymentResult) __);
}


/// Adds pattern-matching-related methods to [PaymentResult].
extension PaymentResultPatterns on PaymentResult {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( _PaymentSuccess value)?  success,TResult Function( _PaymentCancelled value)?  cancelled,TResult Function( _PaymentFailed value)?  failed,required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentSuccess() when success != null:
return success(_that);case _PaymentCancelled() when cancelled != null:
return cancelled(_that);case _PaymentFailed() when failed != null:
return failed(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( _PaymentSuccess value)  success,required TResult Function( _PaymentCancelled value)  cancelled,required TResult Function( _PaymentFailed value)  failed,}){
final _that = this;
switch (_that) {
case _PaymentSuccess():
return success(_that);case _PaymentCancelled():
return cancelled(_that);case _PaymentFailed():
return failed(_that);case _:
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( _PaymentSuccess value)?  success,TResult? Function( _PaymentCancelled value)?  cancelled,TResult? Function( _PaymentFailed value)?  failed,}){
final _that = this;
switch (_that) {
case _PaymentSuccess() when success != null:
return success(_that);case _PaymentCancelled() when cancelled != null:
return cancelled(_that);case _PaymentFailed() when failed != null:
return failed(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function( String? transactionId)?  success,TResult Function()?  cancelled,TResult Function( String message)?  failed,required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentSuccess() when success != null:
return success(_that.transactionId);case _PaymentCancelled() when cancelled != null:
return cancelled();case _PaymentFailed() when failed != null:
return failed(_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function( String? transactionId)  success,required TResult Function()  cancelled,required TResult Function( String message)  failed,}) {final _that = this;
switch (_that) {
case _PaymentSuccess():
return success(_that.transactionId);case _PaymentCancelled():
return cancelled();case _PaymentFailed():
return failed(_that.message);case _:
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function( String? transactionId)?  success,TResult? Function()?  cancelled,TResult? Function( String message)?  failed,}) {final _that = this;
switch (_that) {
case _PaymentSuccess() when success != null:
return success(_that.transactionId);case _PaymentCancelled() when cancelled != null:
return cancelled();case _PaymentFailed() when failed != null:
return failed(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class _PaymentSuccess implements PaymentResult {
  const _PaymentSuccess({this.transactionId});
  

 final  String? transactionId;

/// Create a copy of PaymentResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentSuccessCopyWith<_PaymentSuccess> get copyWith => __$PaymentSuccessCopyWithImpl<_PaymentSuccess>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentSuccess&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId));
}


@override
int get hashCode => Object.hash(runtimeType,transactionId);

@override
String toString() {
  return 'PaymentResult.success(transactionId: $transactionId)';
}


}

/// @nodoc
abstract mixin class _$PaymentSuccessCopyWith<$Res> implements $PaymentResultCopyWith<$Res> {
  factory _$PaymentSuccessCopyWith(_PaymentSuccess value, $Res Function(_PaymentSuccess) _then) = __$PaymentSuccessCopyWithImpl;
@useResult
$Res call({
 String? transactionId
});




}
/// @nodoc
class __$PaymentSuccessCopyWithImpl<$Res>
    implements _$PaymentSuccessCopyWith<$Res> {
  __$PaymentSuccessCopyWithImpl(this._self, this._then);

  final _PaymentSuccess _self;
  final $Res Function(_PaymentSuccess) _then;

/// Create a copy of PaymentResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? transactionId = freezed,}) {
  return _then(_PaymentSuccess(
transactionId: freezed == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

/// @nodoc


class _PaymentCancelled implements PaymentResult {
  const _PaymentCancelled();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentCancelled);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'PaymentResult.cancelled()';
}


}




/// @nodoc


class _PaymentFailed implements PaymentResult {
  const _PaymentFailed(this.message);
  

 final  String message;

/// Create a copy of PaymentResult
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentFailedCopyWith<_PaymentFailed> get copyWith => __$PaymentFailedCopyWithImpl<_PaymentFailed>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentFailed&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'PaymentResult.failed(message: $message)';
}


}

/// @nodoc
abstract mixin class _$PaymentFailedCopyWith<$Res> implements $PaymentResultCopyWith<$Res> {
  factory _$PaymentFailedCopyWith(_PaymentFailed value, $Res Function(_PaymentFailed) _then) = __$PaymentFailedCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class __$PaymentFailedCopyWithImpl<$Res>
    implements _$PaymentFailedCopyWith<$Res> {
  __$PaymentFailedCopyWithImpl(this._self, this._then);

  final _PaymentFailed _self;
  final $Res Function(_PaymentFailed) _then;

/// Create a copy of PaymentResult
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(_PaymentFailed(
null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
