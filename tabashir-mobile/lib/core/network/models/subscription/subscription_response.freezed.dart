// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubscriptionResponse {

 bool get success; String? get message; SubscriptionData? get data;
/// Create a copy of SubscriptionResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionResponseCopyWith<SubscriptionResponse> get copyWith => _$SubscriptionResponseCopyWithImpl<SubscriptionResponse>(this as SubscriptionResponse, _$identity);

  /// Serializes this SubscriptionResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,data);

@override
String toString() {
  return 'SubscriptionResponse(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class $SubscriptionResponseCopyWith<$Res>  {
  factory $SubscriptionResponseCopyWith(SubscriptionResponse value, $Res Function(SubscriptionResponse) _then) = _$SubscriptionResponseCopyWithImpl;
@useResult
$Res call({
 bool success, String? message, SubscriptionData? data
});


$SubscriptionDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$SubscriptionResponseCopyWithImpl<$Res>
    implements $SubscriptionResponseCopyWith<$Res> {
  _$SubscriptionResponseCopyWithImpl(this._self, this._then);

  final SubscriptionResponse _self;
  final $Res Function(SubscriptionResponse) _then;

/// Create a copy of SubscriptionResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = freezed,Object? data = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as SubscriptionData?,
  ));
}
/// Create a copy of SubscriptionResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubscriptionDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $SubscriptionDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [SubscriptionResponse].
extension SubscriptionResponsePatterns on SubscriptionResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubscriptionResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubscriptionResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubscriptionResponse value)  $default,){
final _that = this;
switch (_that) {
case _SubscriptionResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubscriptionResponse value)?  $default,){
final _that = this;
switch (_that) {
case _SubscriptionResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String? message,  SubscriptionData? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscriptionResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String? message,  SubscriptionData? data)  $default,) {final _that = this;
switch (_that) {
case _SubscriptionResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String? message,  SubscriptionData? data)?  $default,) {final _that = this;
switch (_that) {
case _SubscriptionResponse() when $default != null:
return $default(_that.success,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubscriptionResponse implements SubscriptionResponse {
  const _SubscriptionResponse({required this.success, this.message, this.data});
  factory _SubscriptionResponse.fromJson(Map<String, dynamic> json) => _$SubscriptionResponseFromJson(json);

@override final  bool success;
@override final  String? message;
@override final  SubscriptionData? data;

/// Create a copy of SubscriptionResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionResponseCopyWith<_SubscriptionResponse> get copyWith => __$SubscriptionResponseCopyWithImpl<_SubscriptionResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubscriptionResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,data);

@override
String toString() {
  return 'SubscriptionResponse(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionResponseCopyWith<$Res> implements $SubscriptionResponseCopyWith<$Res> {
  factory _$SubscriptionResponseCopyWith(_SubscriptionResponse value, $Res Function(_SubscriptionResponse) _then) = __$SubscriptionResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, String? message, SubscriptionData? data
});


@override $SubscriptionDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$SubscriptionResponseCopyWithImpl<$Res>
    implements _$SubscriptionResponseCopyWith<$Res> {
  __$SubscriptionResponseCopyWithImpl(this._self, this._then);

  final _SubscriptionResponse _self;
  final $Res Function(_SubscriptionResponse) _then;

/// Create a copy of SubscriptionResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = freezed,Object? data = freezed,}) {
  return _then(_SubscriptionResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as SubscriptionData?,
  ));
}

/// Create a copy of SubscriptionResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubscriptionDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $SubscriptionDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$SubscriptionData {

 String get id; String? get userId; String? get plan; String? get status; String? get startDate; String? get endDate; bool? get autoRenew; double? get paymentAmount; String? get paymentDate; String? get createdAt; String? get updatedAt;
/// Create a copy of SubscriptionData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionDataCopyWith<SubscriptionData> get copyWith => _$SubscriptionDataCopyWithImpl<SubscriptionData>(this as SubscriptionData, _$identity);

  /// Serializes this SubscriptionData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionData&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.status, status) || other.status == status)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.autoRenew, autoRenew) || other.autoRenew == autoRenew)&&(identical(other.paymentAmount, paymentAmount) || other.paymentAmount == paymentAmount)&&(identical(other.paymentDate, paymentDate) || other.paymentDate == paymentDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,plan,status,startDate,endDate,autoRenew,paymentAmount,paymentDate,createdAt,updatedAt);

@override
String toString() {
  return 'SubscriptionData(id: $id, userId: $userId, plan: $plan, status: $status, startDate: $startDate, endDate: $endDate, autoRenew: $autoRenew, paymentAmount: $paymentAmount, paymentDate: $paymentDate, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $SubscriptionDataCopyWith<$Res>  {
  factory $SubscriptionDataCopyWith(SubscriptionData value, $Res Function(SubscriptionData) _then) = _$SubscriptionDataCopyWithImpl;
@useResult
$Res call({
 String id, String? userId, String? plan, String? status, String? startDate, String? endDate, bool? autoRenew, double? paymentAmount, String? paymentDate, String? createdAt, String? updatedAt
});




}
/// @nodoc
class _$SubscriptionDataCopyWithImpl<$Res>
    implements $SubscriptionDataCopyWith<$Res> {
  _$SubscriptionDataCopyWithImpl(this._self, this._then);

  final SubscriptionData _self;
  final $Res Function(SubscriptionData) _then;

/// Create a copy of SubscriptionData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = freezed,Object? plan = freezed,Object? status = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? autoRenew = freezed,Object? paymentAmount = freezed,Object? paymentDate = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,autoRenew: freezed == autoRenew ? _self.autoRenew : autoRenew // ignore: cast_nullable_to_non_nullable
as bool?,paymentAmount: freezed == paymentAmount ? _self.paymentAmount : paymentAmount // ignore: cast_nullable_to_non_nullable
as double?,paymentDate: freezed == paymentDate ? _self.paymentDate : paymentDate // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SubscriptionData].
extension SubscriptionDataPatterns on SubscriptionData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubscriptionData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubscriptionData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubscriptionData value)  $default,){
final _that = this;
switch (_that) {
case _SubscriptionData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubscriptionData value)?  $default,){
final _that = this;
switch (_that) {
case _SubscriptionData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? userId,  String? plan,  String? status,  String? startDate,  String? endDate,  bool? autoRenew,  double? paymentAmount,  String? paymentDate,  String? createdAt,  String? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscriptionData() when $default != null:
return $default(_that.id,_that.userId,_that.plan,_that.status,_that.startDate,_that.endDate,_that.autoRenew,_that.paymentAmount,_that.paymentDate,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? userId,  String? plan,  String? status,  String? startDate,  String? endDate,  bool? autoRenew,  double? paymentAmount,  String? paymentDate,  String? createdAt,  String? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _SubscriptionData():
return $default(_that.id,_that.userId,_that.plan,_that.status,_that.startDate,_that.endDate,_that.autoRenew,_that.paymentAmount,_that.paymentDate,_that.createdAt,_that.updatedAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? userId,  String? plan,  String? status,  String? startDate,  String? endDate,  bool? autoRenew,  double? paymentAmount,  String? paymentDate,  String? createdAt,  String? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _SubscriptionData() when $default != null:
return $default(_that.id,_that.userId,_that.plan,_that.status,_that.startDate,_that.endDate,_that.autoRenew,_that.paymentAmount,_that.paymentDate,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubscriptionData implements SubscriptionData {
  const _SubscriptionData({required this.id, this.userId, this.plan, this.status, this.startDate, this.endDate, this.autoRenew, this.paymentAmount, this.paymentDate, this.createdAt, this.updatedAt});
  factory _SubscriptionData.fromJson(Map<String, dynamic> json) => _$SubscriptionDataFromJson(json);

@override final  String id;
@override final  String? userId;
@override final  String? plan;
@override final  String? status;
@override final  String? startDate;
@override final  String? endDate;
@override final  bool? autoRenew;
@override final  double? paymentAmount;
@override final  String? paymentDate;
@override final  String? createdAt;
@override final  String? updatedAt;

/// Create a copy of SubscriptionData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionDataCopyWith<_SubscriptionData> get copyWith => __$SubscriptionDataCopyWithImpl<_SubscriptionData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubscriptionDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionData&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.status, status) || other.status == status)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.autoRenew, autoRenew) || other.autoRenew == autoRenew)&&(identical(other.paymentAmount, paymentAmount) || other.paymentAmount == paymentAmount)&&(identical(other.paymentDate, paymentDate) || other.paymentDate == paymentDate)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,plan,status,startDate,endDate,autoRenew,paymentAmount,paymentDate,createdAt,updatedAt);

@override
String toString() {
  return 'SubscriptionData(id: $id, userId: $userId, plan: $plan, status: $status, startDate: $startDate, endDate: $endDate, autoRenew: $autoRenew, paymentAmount: $paymentAmount, paymentDate: $paymentDate, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionDataCopyWith<$Res> implements $SubscriptionDataCopyWith<$Res> {
  factory _$SubscriptionDataCopyWith(_SubscriptionData value, $Res Function(_SubscriptionData) _then) = __$SubscriptionDataCopyWithImpl;
@override @useResult
$Res call({
 String id, String? userId, String? plan, String? status, String? startDate, String? endDate, bool? autoRenew, double? paymentAmount, String? paymentDate, String? createdAt, String? updatedAt
});




}
/// @nodoc
class __$SubscriptionDataCopyWithImpl<$Res>
    implements _$SubscriptionDataCopyWith<$Res> {
  __$SubscriptionDataCopyWithImpl(this._self, this._then);

  final _SubscriptionData _self;
  final $Res Function(_SubscriptionData) _then;

/// Create a copy of SubscriptionData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = freezed,Object? plan = freezed,Object? status = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? autoRenew = freezed,Object? paymentAmount = freezed,Object? paymentDate = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_SubscriptionData(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,autoRenew: freezed == autoRenew ? _self.autoRenew : autoRenew // ignore: cast_nullable_to_non_nullable
as bool?,paymentAmount: freezed == paymentAmount ? _self.paymentAmount : paymentAmount // ignore: cast_nullable_to_non_nullable
as double?,paymentDate: freezed == paymentDate ? _self.paymentDate : paymentDate // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
