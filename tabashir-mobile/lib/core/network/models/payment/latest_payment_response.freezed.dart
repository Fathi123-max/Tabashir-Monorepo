// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'latest_payment_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LatestPaymentResponse {

 bool get success; String? get message; LatestPaymentData? get data;
/// Create a copy of LatestPaymentResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LatestPaymentResponseCopyWith<LatestPaymentResponse> get copyWith => _$LatestPaymentResponseCopyWithImpl<LatestPaymentResponse>(this as LatestPaymentResponse, _$identity);

  /// Serializes this LatestPaymentResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LatestPaymentResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,data);

@override
String toString() {
  return 'LatestPaymentResponse(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class $LatestPaymentResponseCopyWith<$Res>  {
  factory $LatestPaymentResponseCopyWith(LatestPaymentResponse value, $Res Function(LatestPaymentResponse) _then) = _$LatestPaymentResponseCopyWithImpl;
@useResult
$Res call({
 bool success, String? message, LatestPaymentData? data
});


$LatestPaymentDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$LatestPaymentResponseCopyWithImpl<$Res>
    implements $LatestPaymentResponseCopyWith<$Res> {
  _$LatestPaymentResponseCopyWithImpl(this._self, this._then);

  final LatestPaymentResponse _self;
  final $Res Function(LatestPaymentResponse) _then;

/// Create a copy of LatestPaymentResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = freezed,Object? data = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as LatestPaymentData?,
  ));
}
/// Create a copy of LatestPaymentResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LatestPaymentDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $LatestPaymentDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [LatestPaymentResponse].
extension LatestPaymentResponsePatterns on LatestPaymentResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LatestPaymentResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LatestPaymentResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LatestPaymentResponse value)  $default,){
final _that = this;
switch (_that) {
case _LatestPaymentResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LatestPaymentResponse value)?  $default,){
final _that = this;
switch (_that) {
case _LatestPaymentResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String? message,  LatestPaymentData? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LatestPaymentResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String? message,  LatestPaymentData? data)  $default,) {final _that = this;
switch (_that) {
case _LatestPaymentResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String? message,  LatestPaymentData? data)?  $default,) {final _that = this;
switch (_that) {
case _LatestPaymentResponse() when $default != null:
return $default(_that.success,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LatestPaymentResponse implements LatestPaymentResponse {
  const _LatestPaymentResponse({required this.success, this.message, this.data});
  factory _LatestPaymentResponse.fromJson(Map<String, dynamic> json) => _$LatestPaymentResponseFromJson(json);

@override final  bool success;
@override final  String? message;
@override final  LatestPaymentData? data;

/// Create a copy of LatestPaymentResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LatestPaymentResponseCopyWith<_LatestPaymentResponse> get copyWith => __$LatestPaymentResponseCopyWithImpl<_LatestPaymentResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LatestPaymentResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LatestPaymentResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,data);

@override
String toString() {
  return 'LatestPaymentResponse(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$LatestPaymentResponseCopyWith<$Res> implements $LatestPaymentResponseCopyWith<$Res> {
  factory _$LatestPaymentResponseCopyWith(_LatestPaymentResponse value, $Res Function(_LatestPaymentResponse) _then) = __$LatestPaymentResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, String? message, LatestPaymentData? data
});


@override $LatestPaymentDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$LatestPaymentResponseCopyWithImpl<$Res>
    implements _$LatestPaymentResponseCopyWith<$Res> {
  __$LatestPaymentResponseCopyWithImpl(this._self, this._then);

  final _LatestPaymentResponse _self;
  final $Res Function(_LatestPaymentResponse) _then;

/// Create a copy of LatestPaymentResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = freezed,Object? data = freezed,}) {
  return _then(_LatestPaymentResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as LatestPaymentData?,
  ));
}

/// Create a copy of LatestPaymentResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$LatestPaymentDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $LatestPaymentDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$LatestPaymentData {

 String? get id; String? get subscriptionId; double? get amount; String? get currency; String? get status; String? get paymentMethod; String? get transactionId; String? get paymentDate; String? get createdAt; String? get updatedAt;
/// Create a copy of LatestPaymentData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LatestPaymentDataCopyWith<LatestPaymentData> get copyWith => _$LatestPaymentDataCopyWithImpl<LatestPaymentData>(this as LatestPaymentData, _$identity);

  /// Serializes this LatestPaymentData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LatestPaymentData&&(identical(other.id, id) || other.id == id)&&(identical(other.subscriptionId, subscriptionId) || other.subscriptionId == subscriptionId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.status, status) || other.status == status)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.paymentDate, paymentDate) || other.paymentDate == paymentDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,subscriptionId,amount,currency,status,paymentMethod,transactionId,paymentDate,createdAt,updatedAt);

@override
String toString() {
  return 'LatestPaymentData(id: $id, subscriptionId: $subscriptionId, amount: $amount, currency: $currency, status: $status, paymentMethod: $paymentMethod, transactionId: $transactionId, paymentDate: $paymentDate, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $LatestPaymentDataCopyWith<$Res>  {
  factory $LatestPaymentDataCopyWith(LatestPaymentData value, $Res Function(LatestPaymentData) _then) = _$LatestPaymentDataCopyWithImpl;
@useResult
$Res call({
 String? id, String? subscriptionId, double? amount, String? currency, String? status, String? paymentMethod, String? transactionId, String? paymentDate, String? createdAt, String? updatedAt
});




}
/// @nodoc
class _$LatestPaymentDataCopyWithImpl<$Res>
    implements $LatestPaymentDataCopyWith<$Res> {
  _$LatestPaymentDataCopyWithImpl(this._self, this._then);

  final LatestPaymentData _self;
  final $Res Function(LatestPaymentData) _then;

/// Create a copy of LatestPaymentData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? subscriptionId = freezed,Object? amount = freezed,Object? currency = freezed,Object? status = freezed,Object? paymentMethod = freezed,Object? transactionId = freezed,Object? paymentDate = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,subscriptionId: freezed == subscriptionId ? _self.subscriptionId : subscriptionId // ignore: cast_nullable_to_non_nullable
as String?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String?,transactionId: freezed == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String?,paymentDate: freezed == paymentDate ? _self.paymentDate : paymentDate // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [LatestPaymentData].
extension LatestPaymentDataPatterns on LatestPaymentData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LatestPaymentData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LatestPaymentData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LatestPaymentData value)  $default,){
final _that = this;
switch (_that) {
case _LatestPaymentData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LatestPaymentData value)?  $default,){
final _that = this;
switch (_that) {
case _LatestPaymentData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? subscriptionId,  double? amount,  String? currency,  String? status,  String? paymentMethod,  String? transactionId,  String? paymentDate,  String? createdAt,  String? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LatestPaymentData() when $default != null:
return $default(_that.id,_that.subscriptionId,_that.amount,_that.currency,_that.status,_that.paymentMethod,_that.transactionId,_that.paymentDate,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? subscriptionId,  double? amount,  String? currency,  String? status,  String? paymentMethod,  String? transactionId,  String? paymentDate,  String? createdAt,  String? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _LatestPaymentData():
return $default(_that.id,_that.subscriptionId,_that.amount,_that.currency,_that.status,_that.paymentMethod,_that.transactionId,_that.paymentDate,_that.createdAt,_that.updatedAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? subscriptionId,  double? amount,  String? currency,  String? status,  String? paymentMethod,  String? transactionId,  String? paymentDate,  String? createdAt,  String? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _LatestPaymentData() when $default != null:
return $default(_that.id,_that.subscriptionId,_that.amount,_that.currency,_that.status,_that.paymentMethod,_that.transactionId,_that.paymentDate,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LatestPaymentData implements LatestPaymentData {
  const _LatestPaymentData({this.id, this.subscriptionId, this.amount, this.currency, this.status, this.paymentMethod, this.transactionId, this.paymentDate, this.createdAt, this.updatedAt});
  factory _LatestPaymentData.fromJson(Map<String, dynamic> json) => _$LatestPaymentDataFromJson(json);

@override final  String? id;
@override final  String? subscriptionId;
@override final  double? amount;
@override final  String? currency;
@override final  String? status;
@override final  String? paymentMethod;
@override final  String? transactionId;
@override final  String? paymentDate;
@override final  String? createdAt;
@override final  String? updatedAt;

/// Create a copy of LatestPaymentData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LatestPaymentDataCopyWith<_LatestPaymentData> get copyWith => __$LatestPaymentDataCopyWithImpl<_LatestPaymentData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LatestPaymentDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LatestPaymentData&&(identical(other.id, id) || other.id == id)&&(identical(other.subscriptionId, subscriptionId) || other.subscriptionId == subscriptionId)&&(identical(other.amount, amount) || other.amount == amount)&&(identical(other.currency, currency) || other.currency == currency)&&(identical(other.status, status) || other.status == status)&&(identical(other.paymentMethod, paymentMethod) || other.paymentMethod == paymentMethod)&&(identical(other.transactionId, transactionId) || other.transactionId == transactionId)&&(identical(other.paymentDate, paymentDate) || other.paymentDate == paymentDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,subscriptionId,amount,currency,status,paymentMethod,transactionId,paymentDate,createdAt,updatedAt);

@override
String toString() {
  return 'LatestPaymentData(id: $id, subscriptionId: $subscriptionId, amount: $amount, currency: $currency, status: $status, paymentMethod: $paymentMethod, transactionId: $transactionId, paymentDate: $paymentDate, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$LatestPaymentDataCopyWith<$Res> implements $LatestPaymentDataCopyWith<$Res> {
  factory _$LatestPaymentDataCopyWith(_LatestPaymentData value, $Res Function(_LatestPaymentData) _then) = __$LatestPaymentDataCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? subscriptionId, double? amount, String? currency, String? status, String? paymentMethod, String? transactionId, String? paymentDate, String? createdAt, String? updatedAt
});




}
/// @nodoc
class __$LatestPaymentDataCopyWithImpl<$Res>
    implements _$LatestPaymentDataCopyWith<$Res> {
  __$LatestPaymentDataCopyWithImpl(this._self, this._then);

  final _LatestPaymentData _self;
  final $Res Function(_LatestPaymentData) _then;

/// Create a copy of LatestPaymentData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? subscriptionId = freezed,Object? amount = freezed,Object? currency = freezed,Object? status = freezed,Object? paymentMethod = freezed,Object? transactionId = freezed,Object? paymentDate = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_LatestPaymentData(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,subscriptionId: freezed == subscriptionId ? _self.subscriptionId : subscriptionId // ignore: cast_nullable_to_non_nullable
as String?,amount: freezed == amount ? _self.amount : amount // ignore: cast_nullable_to_non_nullable
as double?,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,paymentMethod: freezed == paymentMethod ? _self.paymentMethod : paymentMethod // ignore: cast_nullable_to_non_nullable
as String?,transactionId: freezed == transactionId ? _self.transactionId : transactionId // ignore: cast_nullable_to_non_nullable
as String?,paymentDate: freezed == paymentDate ? _self.paymentDate : paymentDate // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
