// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'payment_intent_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PaymentIntentResponse {

 bool get success; String? get message; PaymentIntentData? get data;
/// Create a copy of PaymentIntentResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentIntentResponseCopyWith<PaymentIntentResponse> get copyWith => _$PaymentIntentResponseCopyWithImpl<PaymentIntentResponse>(this as PaymentIntentResponse, _$identity);

  /// Serializes this PaymentIntentResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentIntentResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,data);

@override
String toString() {
  return 'PaymentIntentResponse(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class $PaymentIntentResponseCopyWith<$Res>  {
  factory $PaymentIntentResponseCopyWith(PaymentIntentResponse value, $Res Function(PaymentIntentResponse) _then) = _$PaymentIntentResponseCopyWithImpl;
@useResult
$Res call({
 bool success, String? message, PaymentIntentData? data
});


$PaymentIntentDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$PaymentIntentResponseCopyWithImpl<$Res>
    implements $PaymentIntentResponseCopyWith<$Res> {
  _$PaymentIntentResponseCopyWithImpl(this._self, this._then);

  final PaymentIntentResponse _self;
  final $Res Function(PaymentIntentResponse) _then;

/// Create a copy of PaymentIntentResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = freezed,Object? data = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as PaymentIntentData?,
  ));
}
/// Create a copy of PaymentIntentResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentIntentDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $PaymentIntentDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [PaymentIntentResponse].
extension PaymentIntentResponsePatterns on PaymentIntentResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentIntentResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentIntentResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentIntentResponse value)  $default,){
final _that = this;
switch (_that) {
case _PaymentIntentResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentIntentResponse value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentIntentResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String? message,  PaymentIntentData? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentIntentResponse() when $default != null:
return $default(_that.success,_that.message,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String? message,  PaymentIntentData? data)  $default,) {final _that = this;
switch (_that) {
case _PaymentIntentResponse():
return $default(_that.success,_that.message,_that.data);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String? message,  PaymentIntentData? data)?  $default,) {final _that = this;
switch (_that) {
case _PaymentIntentResponse() when $default != null:
return $default(_that.success,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentIntentResponse implements PaymentIntentResponse {
  const _PaymentIntentResponse({required this.success, this.message, this.data});
  factory _PaymentIntentResponse.fromJson(Map<String, dynamic> json) => _$PaymentIntentResponseFromJson(json);

@override final  bool success;
@override final  String? message;
@override final  PaymentIntentData? data;

/// Create a copy of PaymentIntentResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentIntentResponseCopyWith<_PaymentIntentResponse> get copyWith => __$PaymentIntentResponseCopyWithImpl<_PaymentIntentResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentIntentResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentIntentResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,data);

@override
String toString() {
  return 'PaymentIntentResponse(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$PaymentIntentResponseCopyWith<$Res> implements $PaymentIntentResponseCopyWith<$Res> {
  factory _$PaymentIntentResponseCopyWith(_PaymentIntentResponse value, $Res Function(_PaymentIntentResponse) _then) = __$PaymentIntentResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, String? message, PaymentIntentData? data
});


@override $PaymentIntentDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$PaymentIntentResponseCopyWithImpl<$Res>
    implements _$PaymentIntentResponseCopyWith<$Res> {
  __$PaymentIntentResponseCopyWithImpl(this._self, this._then);

  final _PaymentIntentResponse _self;
  final $Res Function(_PaymentIntentResponse) _then;

/// Create a copy of PaymentIntentResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = freezed,Object? data = freezed,}) {
  return _then(_PaymentIntentResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as PaymentIntentData?,
  ));
}

/// Create a copy of PaymentIntentResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentIntentDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $PaymentIntentDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$PaymentIntentData {

 String? get clientSecret; String? get paymentIntentId; double? get amount; String? get currency; String? get status; String? get ephemeralKey; String? get customer; String? get publishableKey;
/// Create a copy of PaymentIntentData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentIntentDataCopyWith<PaymentIntentData> get copyWith => _$PaymentIntentDataCopyWithImpl<PaymentIntentData>(this as PaymentIntentData, _$identity);

  /// Serializes this PaymentIntentData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentIntentData&&(identical(other.clientSecret, clientSecret) || other.clientSecret == clientSecret)&&(identical(other.paymentIntentId, paymentIntentId) || other.paymentIntentId == paymentIntentId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.status, status) || other.status == status)&&(identical(other.ephemeralKey, ephemeralKey) || other.ephemeralKey == ephemeralKey)&&(identical(other.customer, customer) || other.customer == customer)&&(identical(other.publishableKey, publishableKey) || other.publishableKey == publishableKey));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,clientSecret,paymentIntentId,amount,currency,status,ephemeralKey,customer,publishableKey);

@override
String toString() {
  return 'PaymentIntentData(clientSecret: $clientSecret, paymentIntentId: $paymentIntentId, amount: $amount, currency: $currency, status: $status, ephemeralKey: $ephemeralKey, customer: $customer, publishableKey: $publishableKey)';
}


}

/// @nodoc
abstract mixin class $PaymentIntentDataCopyWith<$Res>  {
  factory $PaymentIntentDataCopyWith(PaymentIntentData value, $Res Function(PaymentIntentData) _then) = _$PaymentIntentDataCopyWithImpl;
@useResult
$Res call({
 String? clientSecret, String? paymentIntentId, double? amount, String? currency, String? status, String? ephemeralKey, String? customer, String? publishableKey
});




}
/// @nodoc
class _$PaymentIntentDataCopyWithImpl<$Res>
    implements $PaymentIntentDataCopyWith<$Res> {
  _$PaymentIntentDataCopyWithImpl(this._self, this._then);

  final PaymentIntentData _self;
  final $Res Function(PaymentIntentData) _then;

/// Create a copy of PaymentIntentData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? clientSecret = freezed,Object? paymentIntentId = freezed,Object? amount = freezed,Object? currency = freezed,Object? status = freezed,Object? ephemeralKey = freezed,Object? customer = freezed,Object? publishableKey = freezed,}) {
  return _then(_self.copyWith(
clientSecret: freezed == clientSecret ? _self.clientSecret : clientSecret // ignore: cast_nullable_to_non_nullable
as String?,paymentIntentId: freezed == paymentIntentId ? _self.paymentIntentId : paymentIntentId // ignore: cast_nullable_to_non_nullable
as String?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,ephemeralKey: freezed == ephemeralKey ? _self.ephemeralKey : ephemeralKey // ignore: cast_nullable_to_non_nullable
as String?,customer: freezed == customer ? _self.customer : customer // ignore: cast_nullable_to_non_nullable
as String?,publishableKey: freezed == publishableKey ? _self.publishableKey : publishableKey // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentIntentData].
extension PaymentIntentDataPatterns on PaymentIntentData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentIntentData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentIntentData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentIntentData value)  $default,){
final _that = this;
switch (_that) {
case _PaymentIntentData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentIntentData value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentIntentData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? clientSecret,  String? paymentIntentId,  double? amount,  String? currency,  String? status,  String? ephemeralKey,  String? customer,  String? publishableKey)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentIntentData() when $default != null:
return $default(_that.clientSecret,_that.paymentIntentId,_that.amount,_that.currency,_that.status,_that.ephemeralKey,_that.customer,_that.publishableKey);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? clientSecret,  String? paymentIntentId,  double? amount,  String? currency,  String? status,  String? ephemeralKey,  String? customer,  String? publishableKey)  $default,) {final _that = this;
switch (_that) {
case _PaymentIntentData():
return $default(_that.clientSecret,_that.paymentIntentId,_that.amount,_that.currency,_that.status,_that.ephemeralKey,_that.customer,_that.publishableKey);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? clientSecret,  String? paymentIntentId,  double? amount,  String? currency,  String? status,  String? ephemeralKey,  String? customer,  String? publishableKey)?  $default,) {final _that = this;
switch (_that) {
case _PaymentIntentData() when $default != null:
return $default(_that.clientSecret,_that.paymentIntentId,_that.amount,_that.currency,_that.status,_that.ephemeralKey,_that.customer,_that.publishableKey);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentIntentData implements PaymentIntentData {
  const _PaymentIntentData({this.clientSecret, this.paymentIntentId, this.amount, this.currency, this.status, this.ephemeralKey, this.customer, this.publishableKey});
  factory _PaymentIntentData.fromJson(Map<String, dynamic> json) => _$PaymentIntentDataFromJson(json);

@override final  String? clientSecret;
@override final  String? paymentIntentId;
@override final  double? amount;
@override final  String? currency;
@override final  String? status;
@override final  String? ephemeralKey;
@override final  String? customer;
@override final  String? publishableKey;

/// Create a copy of PaymentIntentData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentIntentDataCopyWith<_PaymentIntentData> get copyWith => __$PaymentIntentDataCopyWithImpl<_PaymentIntentData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentIntentDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentIntentData&&(identical(other.clientSecret, clientSecret) || other.clientSecret == clientSecret)&&(identical(other.paymentIntentId, paymentIntentId) || other.paymentIntentId == paymentIntentId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.status, status) || other.status == status)&&(identical(other.ephemeralKey, ephemeralKey) || other.ephemeralKey == ephemeralKey)&&(identical(other.customer, customer) || other.customer == customer)&&(identical(other.publishableKey, publishableKey) || other.publishableKey == publishableKey));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,clientSecret,paymentIntentId,amount,currency,status,ephemeralKey,customer,publishableKey);

@override
String toString() {
  return 'PaymentIntentData(clientSecret: $clientSecret, paymentIntentId: $paymentIntentId, amount: $amount, currency: $currency, status: $status, ephemeralKey: $ephemeralKey, customer: $customer, publishableKey: $publishableKey)';
}


}

/// @nodoc
abstract mixin class _$PaymentIntentDataCopyWith<$Res> implements $PaymentIntentDataCopyWith<$Res> {
  factory _$PaymentIntentDataCopyWith(_PaymentIntentData value, $Res Function(_PaymentIntentData) _then) = __$PaymentIntentDataCopyWithImpl;
@override @useResult
$Res call({
 String? clientSecret, String? paymentIntentId, double? amount, String? currency, String? status, String? ephemeralKey, String? customer, String? publishableKey
});




}
/// @nodoc
class __$PaymentIntentDataCopyWithImpl<$Res>
    implements _$PaymentIntentDataCopyWith<$Res> {
  __$PaymentIntentDataCopyWithImpl(this._self, this._then);

  final _PaymentIntentData _self;
  final $Res Function(_PaymentIntentData) _then;

/// Create a copy of PaymentIntentData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? clientSecret = freezed,Object? paymentIntentId = freezed,Object? amount = freezed,Object? currency = freezed,Object? status = freezed,Object? ephemeralKey = freezed,Object? customer = freezed,Object? publishableKey = freezed,}) {
  return _then(_PaymentIntentData(
clientSecret: freezed == clientSecret ? _self.clientSecret : clientSecret // ignore: cast_nullable_to_non_nullable
as String?,paymentIntentId: freezed == paymentIntentId ? _self.paymentIntentId : paymentIntentId // ignore: cast_nullable_to_non_nullable
as String?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,ephemeralKey: freezed == ephemeralKey ? _self.ephemeralKey : ephemeralKey // ignore: cast_nullable_to_non_nullable
as String?,customer: freezed == customer ? _self.customer : customer // ignore: cast_nullable_to_non_nullable
as String?,publishableKey: freezed == publishableKey ? _self.publishableKey : publishableKey // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
