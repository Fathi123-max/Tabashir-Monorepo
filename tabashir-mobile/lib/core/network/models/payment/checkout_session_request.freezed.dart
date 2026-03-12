// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checkout_session_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CheckoutSessionRequest {

 String get plan; double? get amount; String? get currency; String? get userId; String? get successUrl; String? get cancelUrl;
/// Create a copy of CheckoutSessionRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutSessionRequestCopyWith<CheckoutSessionRequest> get copyWith => _$CheckoutSessionRequestCopyWithImpl<CheckoutSessionRequest>(this as CheckoutSessionRequest, _$identity);

  /// Serializes this CheckoutSessionRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutSessionRequest&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.successUrl, successUrl) || other.successUrl == successUrl)&&(identical(other.cancelUrl, cancelUrl) || other.cancelUrl == cancelUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,plan,amount,currency,userId,successUrl,cancelUrl);

@override
String toString() {
  return 'CheckoutSessionRequest(plan: $plan, amount: $amount, currency: $currency, userId: $userId, successUrl: $successUrl, cancelUrl: $cancelUrl)';
}


}

/// @nodoc
abstract mixin class $CheckoutSessionRequestCopyWith<$Res>  {
  factory $CheckoutSessionRequestCopyWith(CheckoutSessionRequest value, $Res Function(CheckoutSessionRequest) _then) = _$CheckoutSessionRequestCopyWithImpl;
@useResult
$Res call({
 String plan, double? amount, String? currency, String? userId, String? successUrl, String? cancelUrl
});




}
/// @nodoc
class _$CheckoutSessionRequestCopyWithImpl<$Res>
    implements $CheckoutSessionRequestCopyWith<$Res> {
  _$CheckoutSessionRequestCopyWithImpl(this._self, this._then);

  final CheckoutSessionRequest _self;
  final $Res Function(CheckoutSessionRequest) _then;

/// Create a copy of CheckoutSessionRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? plan = null,Object? amount = freezed,Object? currency = freezed,Object? userId = freezed,Object? successUrl = freezed,Object? cancelUrl = freezed,}) {
  return _then(_self.copyWith(
plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as String,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,successUrl: freezed == successUrl ? _self.successUrl : successUrl // ignore: cast_nullable_to_non_nullable
as String?,cancelUrl: freezed == cancelUrl ? _self.cancelUrl : cancelUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CheckoutSessionRequest].
extension CheckoutSessionRequestPatterns on CheckoutSessionRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckoutSessionRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckoutSessionRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckoutSessionRequest value)  $default,){
final _that = this;
switch (_that) {
case _CheckoutSessionRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckoutSessionRequest value)?  $default,){
final _that = this;
switch (_that) {
case _CheckoutSessionRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String plan,  double? amount,  String? currency,  String? userId,  String? successUrl,  String? cancelUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckoutSessionRequest() when $default != null:
return $default(_that.plan,_that.amount,_that.currency,_that.userId,_that.successUrl,_that.cancelUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String plan,  double? amount,  String? currency,  String? userId,  String? successUrl,  String? cancelUrl)  $default,) {final _that = this;
switch (_that) {
case _CheckoutSessionRequest():
return $default(_that.plan,_that.amount,_that.currency,_that.userId,_that.successUrl,_that.cancelUrl);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String plan,  double? amount,  String? currency,  String? userId,  String? successUrl,  String? cancelUrl)?  $default,) {final _that = this;
switch (_that) {
case _CheckoutSessionRequest() when $default != null:
return $default(_that.plan,_that.amount,_that.currency,_that.userId,_that.successUrl,_that.cancelUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CheckoutSessionRequest implements CheckoutSessionRequest {
  const _CheckoutSessionRequest({required this.plan, this.amount, this.currency, this.userId, this.successUrl, this.cancelUrl});
  factory _CheckoutSessionRequest.fromJson(Map<String, dynamic> json) => _$CheckoutSessionRequestFromJson(json);

@override final  String plan;
@override final  double? amount;
@override final  String? currency;
@override final  String? userId;
@override final  String? successUrl;
@override final  String? cancelUrl;

/// Create a copy of CheckoutSessionRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckoutSessionRequestCopyWith<_CheckoutSessionRequest> get copyWith => __$CheckoutSessionRequestCopyWithImpl<_CheckoutSessionRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CheckoutSessionRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckoutSessionRequest&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.successUrl, successUrl) || other.successUrl == successUrl)&&(identical(other.cancelUrl, cancelUrl) || other.cancelUrl == cancelUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,plan,amount,currency,userId,successUrl,cancelUrl);

@override
String toString() {
  return 'CheckoutSessionRequest(plan: $plan, amount: $amount, currency: $currency, userId: $userId, successUrl: $successUrl, cancelUrl: $cancelUrl)';
}


}

/// @nodoc
abstract mixin class _$CheckoutSessionRequestCopyWith<$Res> implements $CheckoutSessionRequestCopyWith<$Res> {
  factory _$CheckoutSessionRequestCopyWith(_CheckoutSessionRequest value, $Res Function(_CheckoutSessionRequest) _then) = __$CheckoutSessionRequestCopyWithImpl;
@override @useResult
$Res call({
 String plan, double? amount, String? currency, String? userId, String? successUrl, String? cancelUrl
});




}
/// @nodoc
class __$CheckoutSessionRequestCopyWithImpl<$Res>
    implements _$CheckoutSessionRequestCopyWith<$Res> {
  __$CheckoutSessionRequestCopyWithImpl(this._self, this._then);

  final _CheckoutSessionRequest _self;
  final $Res Function(_CheckoutSessionRequest) _then;

/// Create a copy of CheckoutSessionRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? plan = null,Object? amount = freezed,Object? currency = freezed,Object? userId = freezed,Object? successUrl = freezed,Object? cancelUrl = freezed,}) {
  return _then(_CheckoutSessionRequest(
plan: null == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as String,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,successUrl: freezed == successUrl ? _self.successUrl : successUrl // ignore: cast_nullable_to_non_nullable
as String?,cancelUrl: freezed == cancelUrl ? _self.cancelUrl : cancelUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
