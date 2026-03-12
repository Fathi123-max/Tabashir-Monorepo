// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubscriptionState {

 SubscriptionStatus get status; String get errorMessage; SubscriptionResponse? get subscription; SubscriptionDebugResponse? get debugData;
/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionStateCopyWith<SubscriptionState> get copyWith => _$SubscriptionStateCopyWithImpl<SubscriptionState>(this as SubscriptionState, _$identity);

  /// Serializes this SubscriptionState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.subscription, subscription) || other.subscription == subscription)&&(identical(other.debugData, debugData) || other.debugData == debugData));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,errorMessage,subscription,debugData);

@override
String toString() {
  return 'SubscriptionState(status: $status, errorMessage: $errorMessage, subscription: $subscription, debugData: $debugData)';
}


}

/// @nodoc
abstract mixin class $SubscriptionStateCopyWith<$Res>  {
  factory $SubscriptionStateCopyWith(SubscriptionState value, $Res Function(SubscriptionState) _then) = _$SubscriptionStateCopyWithImpl;
@useResult
$Res call({
 SubscriptionStatus status, String errorMessage, SubscriptionResponse? subscription, SubscriptionDebugResponse? debugData
});


$SubscriptionResponseCopyWith<$Res>? get subscription;$SubscriptionDebugResponseCopyWith<$Res>? get debugData;

}
/// @nodoc
class _$SubscriptionStateCopyWithImpl<$Res>
    implements $SubscriptionStateCopyWith<$Res> {
  _$SubscriptionStateCopyWithImpl(this._self, this._then);

  final SubscriptionState _self;
  final $Res Function(SubscriptionState) _then;

/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? errorMessage = null,Object? subscription = freezed,Object? debugData = freezed,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SubscriptionStatus,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,subscription: freezed == subscription ? _self.subscription : subscription // ignore: cast_nullable_to_non_nullable
as SubscriptionResponse?,debugData: freezed == debugData ? _self.debugData : debugData // ignore: cast_nullable_to_non_nullable
as SubscriptionDebugResponse?,
  ));
}
/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubscriptionResponseCopyWith<$Res>? get subscription {
    if (_self.subscription == null) {
    return null;
  }

  return $SubscriptionResponseCopyWith<$Res>(_self.subscription!, (value) {
    return _then(_self.copyWith(subscription: value));
  });
}/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubscriptionDebugResponseCopyWith<$Res>? get debugData {
    if (_self.debugData == null) {
    return null;
  }

  return $SubscriptionDebugResponseCopyWith<$Res>(_self.debugData!, (value) {
    return _then(_self.copyWith(debugData: value));
  });
}
}


/// Adds pattern-matching-related methods to [SubscriptionState].
extension SubscriptionStatePatterns on SubscriptionState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubscriptionState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubscriptionState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubscriptionState value)  $default,){
final _that = this;
switch (_that) {
case _SubscriptionState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubscriptionState value)?  $default,){
final _that = this;
switch (_that) {
case _SubscriptionState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( SubscriptionStatus status,  String errorMessage,  SubscriptionResponse? subscription,  SubscriptionDebugResponse? debugData)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscriptionState() when $default != null:
return $default(_that.status,_that.errorMessage,_that.subscription,_that.debugData);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( SubscriptionStatus status,  String errorMessage,  SubscriptionResponse? subscription,  SubscriptionDebugResponse? debugData)  $default,) {final _that = this;
switch (_that) {
case _SubscriptionState():
return $default(_that.status,_that.errorMessage,_that.subscription,_that.debugData);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( SubscriptionStatus status,  String errorMessage,  SubscriptionResponse? subscription,  SubscriptionDebugResponse? debugData)?  $default,) {final _that = this;
switch (_that) {
case _SubscriptionState() when $default != null:
return $default(_that.status,_that.errorMessage,_that.subscription,_that.debugData);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubscriptionState implements SubscriptionState {
  const _SubscriptionState({this.status = SubscriptionStatus.initial, this.errorMessage = '', this.subscription, this.debugData});
  factory _SubscriptionState.fromJson(Map<String, dynamic> json) => _$SubscriptionStateFromJson(json);

@override@JsonKey() final  SubscriptionStatus status;
@override@JsonKey() final  String errorMessage;
@override final  SubscriptionResponse? subscription;
@override final  SubscriptionDebugResponse? debugData;

/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionStateCopyWith<_SubscriptionState> get copyWith => __$SubscriptionStateCopyWithImpl<_SubscriptionState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubscriptionStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionState&&(identical(other.status, status) || other.status == status)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.subscription, subscription) || other.subscription == subscription)&&(identical(other.debugData, debugData) || other.debugData == debugData));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,errorMessage,subscription,debugData);

@override
String toString() {
  return 'SubscriptionState(status: $status, errorMessage: $errorMessage, subscription: $subscription, debugData: $debugData)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionStateCopyWith<$Res> implements $SubscriptionStateCopyWith<$Res> {
  factory _$SubscriptionStateCopyWith(_SubscriptionState value, $Res Function(_SubscriptionState) _then) = __$SubscriptionStateCopyWithImpl;
@override @useResult
$Res call({
 SubscriptionStatus status, String errorMessage, SubscriptionResponse? subscription, SubscriptionDebugResponse? debugData
});


@override $SubscriptionResponseCopyWith<$Res>? get subscription;@override $SubscriptionDebugResponseCopyWith<$Res>? get debugData;

}
/// @nodoc
class __$SubscriptionStateCopyWithImpl<$Res>
    implements _$SubscriptionStateCopyWith<$Res> {
  __$SubscriptionStateCopyWithImpl(this._self, this._then);

  final _SubscriptionState _self;
  final $Res Function(_SubscriptionState) _then;

/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? errorMessage = null,Object? subscription = freezed,Object? debugData = freezed,}) {
  return _then(_SubscriptionState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as SubscriptionStatus,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,subscription: freezed == subscription ? _self.subscription : subscription // ignore: cast_nullable_to_non_nullable
as SubscriptionResponse?,debugData: freezed == debugData ? _self.debugData : debugData // ignore: cast_nullable_to_non_nullable
as SubscriptionDebugResponse?,
  ));
}

/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubscriptionResponseCopyWith<$Res>? get subscription {
    if (_self.subscription == null) {
    return null;
  }

  return $SubscriptionResponseCopyWith<$Res>(_self.subscription!, (value) {
    return _then(_self.copyWith(subscription: value));
  });
}/// Create a copy of SubscriptionState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubscriptionDebugResponseCopyWith<$Res>? get debugData {
    if (_self.debugData == null) {
    return null;
  }

  return $SubscriptionDebugResponseCopyWith<$Res>(_self.debugData!, (value) {
    return _then(_self.copyWith(debugData: value));
  });
}
}

// dart format on
