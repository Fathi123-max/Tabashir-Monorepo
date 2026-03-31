// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_intent_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PaymentIntentRequest {

 double get amount; String? get currency; String? get plan; String? get userId; String? get serviceId; String? get resumeId;
/// Create a copy of PaymentIntentRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentIntentRequestCopyWith<PaymentIntentRequest> get copyWith => _$PaymentIntentRequestCopyWithImpl<PaymentIntentRequest>(this as PaymentIntentRequest, _$identity);

  /// Serializes this PaymentIntentRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentIntentRequest&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.resumeId, resumeId) || other.resumeId == resumeId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,currency,plan,userId,serviceId,resumeId);

@override
String toString() {
  return 'PaymentIntentRequest(amount: $amount, currency: $currency, plan: $plan, userId: $userId, serviceId: $serviceId, resumeId: $resumeId)';
}


}

/// @nodoc
abstract mixin class $PaymentIntentRequestCopyWith<$Res>  {
  factory $PaymentIntentRequestCopyWith(PaymentIntentRequest value, $Res Function(PaymentIntentRequest) _then) = _$PaymentIntentRequestCopyWithImpl;
@useResult
$Res call({
 double amount, String? currency, String? plan, String? userId, String? serviceId, String? resumeId
});




}
/// @nodoc
class _$PaymentIntentRequestCopyWithImpl<$Res>
    implements $PaymentIntentRequestCopyWith<$Res> {
  _$PaymentIntentRequestCopyWithImpl(this._self, this._then);

  final PaymentIntentRequest _self;
  final $Res Function(PaymentIntentRequest) _then;

/// Create a copy of PaymentIntentRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? amount = null,Object? currency = freezed,Object? plan = freezed,Object? userId = freezed,Object? serviceId = freezed,Object? resumeId = freezed,}) {
  return _then(_self.copyWith(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,serviceId: freezed == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String?,resumeId: freezed == resumeId ? _self.resumeId : resumeId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentIntentRequest].
extension PaymentIntentRequestPatterns on PaymentIntentRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentIntentRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentIntentRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentIntentRequest value)  $default,){
final _that = this;
switch (_that) {
case _PaymentIntentRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentIntentRequest value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentIntentRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( double amount,  String? currency,  String? plan,  String? userId,  String? serviceId,  String? resumeId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentIntentRequest() when $default != null:
return $default(_that.amount,_that.currency,_that.plan,_that.userId,_that.serviceId,_that.resumeId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( double amount,  String? currency,  String? plan,  String? userId,  String? serviceId,  String? resumeId)  $default,) {final _that = this;
switch (_that) {
case _PaymentIntentRequest():
return $default(_that.amount,_that.currency,_that.plan,_that.userId,_that.serviceId,_that.resumeId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( double amount,  String? currency,  String? plan,  String? userId,  String? serviceId,  String? resumeId)?  $default,) {final _that = this;
switch (_that) {
case _PaymentIntentRequest() when $default != null:
return $default(_that.amount,_that.currency,_that.plan,_that.userId,_that.serviceId,_that.resumeId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentIntentRequest implements PaymentIntentRequest {
  const _PaymentIntentRequest({required this.amount, this.currency, this.plan, this.userId, this.serviceId, this.resumeId});
  factory _PaymentIntentRequest.fromJson(Map<String, dynamic> json) => _$PaymentIntentRequestFromJson(json);

@override final  double amount;
@override final  String? currency;
@override final  String? plan;
@override final  String? userId;
@override final  String? serviceId;
@override final  String? resumeId;

/// Create a copy of PaymentIntentRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentIntentRequestCopyWith<_PaymentIntentRequest> get copyWith => __$PaymentIntentRequestCopyWithImpl<_PaymentIntentRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentIntentRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentIntentRequest&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.serviceId, serviceId) || other.serviceId == serviceId)&&(identical(other.resumeId, resumeId) || other.resumeId == resumeId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,amount,currency,plan,userId,serviceId,resumeId);

@override
String toString() {
  return 'PaymentIntentRequest(amount: $amount, currency: $currency, plan: $plan, userId: $userId, serviceId: $serviceId, resumeId: $resumeId)';
}


}

/// @nodoc
abstract mixin class _$PaymentIntentRequestCopyWith<$Res> implements $PaymentIntentRequestCopyWith<$Res> {
  factory _$PaymentIntentRequestCopyWith(_PaymentIntentRequest value, $Res Function(_PaymentIntentRequest) _then) = __$PaymentIntentRequestCopyWithImpl;
@override @useResult
$Res call({
 double amount, String? currency, String? plan, String? userId, String? serviceId, String? resumeId
});




}
/// @nodoc
class __$PaymentIntentRequestCopyWithImpl<$Res>
    implements _$PaymentIntentRequestCopyWith<$Res> {
  __$PaymentIntentRequestCopyWithImpl(this._self, this._then);

  final _PaymentIntentRequest _self;
  final $Res Function(_PaymentIntentRequest) _then;

/// Create a copy of PaymentIntentRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? amount = null,Object? currency = freezed,Object? plan = freezed,Object? userId = freezed,Object? serviceId = freezed,Object? resumeId = freezed,}) {
  return _then(_PaymentIntentRequest(
amount: null == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,serviceId: freezed == serviceId ? _self.serviceId : serviceId // ignore: cast_nullable_to_non_nullable
as String?,resumeId: freezed == resumeId ? _self.resumeId : resumeId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
