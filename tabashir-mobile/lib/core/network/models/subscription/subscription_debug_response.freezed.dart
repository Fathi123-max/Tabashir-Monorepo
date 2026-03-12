// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'subscription_debug_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$SubscriptionDebugResponse {

 bool get success; String? get message; SubscriptionDebugData? get data;
/// Create a copy of SubscriptionDebugResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionDebugResponseCopyWith<SubscriptionDebugResponse> get copyWith => _$SubscriptionDebugResponseCopyWithImpl<SubscriptionDebugResponse>(this as SubscriptionDebugResponse, _$identity);

  /// Serializes this SubscriptionDebugResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionDebugResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,data);

@override
String toString() {
  return 'SubscriptionDebugResponse(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class $SubscriptionDebugResponseCopyWith<$Res>  {
  factory $SubscriptionDebugResponseCopyWith(SubscriptionDebugResponse value, $Res Function(SubscriptionDebugResponse) _then) = _$SubscriptionDebugResponseCopyWithImpl;
@useResult
$Res call({
 bool success, String? message, SubscriptionDebugData? data
});


$SubscriptionDebugDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$SubscriptionDebugResponseCopyWithImpl<$Res>
    implements $SubscriptionDebugResponseCopyWith<$Res> {
  _$SubscriptionDebugResponseCopyWithImpl(this._self, this._then);

  final SubscriptionDebugResponse _self;
  final $Res Function(SubscriptionDebugResponse) _then;

/// Create a copy of SubscriptionDebugResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = freezed,Object? data = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as SubscriptionDebugData?,
  ));
}
/// Create a copy of SubscriptionDebugResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubscriptionDebugDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $SubscriptionDebugDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [SubscriptionDebugResponse].
extension SubscriptionDebugResponsePatterns on SubscriptionDebugResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubscriptionDebugResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubscriptionDebugResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubscriptionDebugResponse value)  $default,){
final _that = this;
switch (_that) {
case _SubscriptionDebugResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubscriptionDebugResponse value)?  $default,){
final _that = this;
switch (_that) {
case _SubscriptionDebugResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String? message,  SubscriptionDebugData? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscriptionDebugResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String? message,  SubscriptionDebugData? data)  $default,) {final _that = this;
switch (_that) {
case _SubscriptionDebugResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String? message,  SubscriptionDebugData? data)?  $default,) {final _that = this;
switch (_that) {
case _SubscriptionDebugResponse() when $default != null:
return $default(_that.success,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubscriptionDebugResponse implements SubscriptionDebugResponse {
  const _SubscriptionDebugResponse({required this.success, this.message, this.data});
  factory _SubscriptionDebugResponse.fromJson(Map<String, dynamic> json) => _$SubscriptionDebugResponseFromJson(json);

@override final  bool success;
@override final  String? message;
@override final  SubscriptionDebugData? data;

/// Create a copy of SubscriptionDebugResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionDebugResponseCopyWith<_SubscriptionDebugResponse> get copyWith => __$SubscriptionDebugResponseCopyWithImpl<_SubscriptionDebugResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubscriptionDebugResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionDebugResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,data);

@override
String toString() {
  return 'SubscriptionDebugResponse(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionDebugResponseCopyWith<$Res> implements $SubscriptionDebugResponseCopyWith<$Res> {
  factory _$SubscriptionDebugResponseCopyWith(_SubscriptionDebugResponse value, $Res Function(_SubscriptionDebugResponse) _then) = __$SubscriptionDebugResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, String? message, SubscriptionDebugData? data
});


@override $SubscriptionDebugDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$SubscriptionDebugResponseCopyWithImpl<$Res>
    implements _$SubscriptionDebugResponseCopyWith<$Res> {
  __$SubscriptionDebugResponseCopyWithImpl(this._self, this._then);

  final _SubscriptionDebugResponse _self;
  final $Res Function(_SubscriptionDebugResponse) _then;

/// Create a copy of SubscriptionDebugResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = freezed,Object? data = freezed,}) {
  return _then(_SubscriptionDebugResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as SubscriptionDebugData?,
  ));
}

/// Create a copy of SubscriptionDebugResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubscriptionDebugDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $SubscriptionDebugDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$SubscriptionDebugData {

 String? get subscriptionId; String? get plan; String? get status; String? get startDate; String? get endDate; String? get autoRenew; Map<String, dynamic>? get metadata; String? get createdAt; String? get updatedAt;
/// Create a copy of SubscriptionDebugData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionDebugDataCopyWith<SubscriptionDebugData> get copyWith => _$SubscriptionDebugDataCopyWithImpl<SubscriptionDebugData>(this as SubscriptionDebugData, _$identity);

  /// Serializes this SubscriptionDebugData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionDebugData&&(identical(other.subscriptionId, subscriptionId) || other.subscriptionId == subscriptionId)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.status, status) || other.status == status)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.autoRenew, autoRenew) || other.autoRenew == autoRenew)&&const DeepCollectionEquality().equals(other.metadata, metadata)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,subscriptionId,plan,status,startDate,endDate,autoRenew,const DeepCollectionEquality().hash(metadata),createdAt,updatedAt);

@override
String toString() {
  return 'SubscriptionDebugData(subscriptionId: $subscriptionId, plan: $plan, status: $status, startDate: $startDate, endDate: $endDate, autoRenew: $autoRenew, metadata: $metadata, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $SubscriptionDebugDataCopyWith<$Res>  {
  factory $SubscriptionDebugDataCopyWith(SubscriptionDebugData value, $Res Function(SubscriptionDebugData) _then) = _$SubscriptionDebugDataCopyWithImpl;
@useResult
$Res call({
 String? subscriptionId, String? plan, String? status, String? startDate, String? endDate, String? autoRenew, Map<String, dynamic>? metadata, String? createdAt, String? updatedAt
});




}
/// @nodoc
class _$SubscriptionDebugDataCopyWithImpl<$Res>
    implements $SubscriptionDebugDataCopyWith<$Res> {
  _$SubscriptionDebugDataCopyWithImpl(this._self, this._then);

  final SubscriptionDebugData _self;
  final $Res Function(SubscriptionDebugData) _then;

/// Create a copy of SubscriptionDebugData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? subscriptionId = freezed,Object? plan = freezed,Object? status = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? autoRenew = freezed,Object? metadata = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
subscriptionId: freezed == subscriptionId ? _self.subscriptionId : subscriptionId // ignore: cast_nullable_to_non_nullable
as String?,plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,autoRenew: freezed == autoRenew ? _self.autoRenew : autoRenew // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self.metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SubscriptionDebugData].
extension SubscriptionDebugDataPatterns on SubscriptionDebugData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubscriptionDebugData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubscriptionDebugData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubscriptionDebugData value)  $default,){
final _that = this;
switch (_that) {
case _SubscriptionDebugData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubscriptionDebugData value)?  $default,){
final _that = this;
switch (_that) {
case _SubscriptionDebugData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? subscriptionId,  String? plan,  String? status,  String? startDate,  String? endDate,  String? autoRenew,  Map<String, dynamic>? metadata,  String? createdAt,  String? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscriptionDebugData() when $default != null:
return $default(_that.subscriptionId,_that.plan,_that.status,_that.startDate,_that.endDate,_that.autoRenew,_that.metadata,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? subscriptionId,  String? plan,  String? status,  String? startDate,  String? endDate,  String? autoRenew,  Map<String, dynamic>? metadata,  String? createdAt,  String? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _SubscriptionDebugData():
return $default(_that.subscriptionId,_that.plan,_that.status,_that.startDate,_that.endDate,_that.autoRenew,_that.metadata,_that.createdAt,_that.updatedAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? subscriptionId,  String? plan,  String? status,  String? startDate,  String? endDate,  String? autoRenew,  Map<String, dynamic>? metadata,  String? createdAt,  String? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _SubscriptionDebugData() when $default != null:
return $default(_that.subscriptionId,_that.plan,_that.status,_that.startDate,_that.endDate,_that.autoRenew,_that.metadata,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubscriptionDebugData implements SubscriptionDebugData {
  const _SubscriptionDebugData({this.subscriptionId, this.plan, this.status, this.startDate, this.endDate, this.autoRenew, final  Map<String, dynamic>? metadata, this.createdAt, this.updatedAt}): _metadata = metadata;
  factory _SubscriptionDebugData.fromJson(Map<String, dynamic> json) => _$SubscriptionDebugDataFromJson(json);

@override final  String? subscriptionId;
@override final  String? plan;
@override final  String? status;
@override final  String? startDate;
@override final  String? endDate;
@override final  String? autoRenew;
 final  Map<String, dynamic>? _metadata;
@override Map<String, dynamic>? get metadata {
  final value = _metadata;
  if (value == null) return null;
  if (_metadata is EqualUnmodifiableMapView) return _metadata;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableMapView(value);
}

@override final  String? createdAt;
@override final  String? updatedAt;

/// Create a copy of SubscriptionDebugData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionDebugDataCopyWith<_SubscriptionDebugData> get copyWith => __$SubscriptionDebugDataCopyWithImpl<_SubscriptionDebugData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubscriptionDebugDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionDebugData&&(identical(other.subscriptionId, subscriptionId) || other.subscriptionId == subscriptionId)&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.status, status) || other.status == status)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.autoRenew, autoRenew) || other.autoRenew == autoRenew)&&const DeepCollectionEquality().equals(other._metadata, _metadata)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,subscriptionId,plan,status,startDate,endDate,autoRenew,const DeepCollectionEquality().hash(_metadata),createdAt,updatedAt);

@override
String toString() {
  return 'SubscriptionDebugData(subscriptionId: $subscriptionId, plan: $plan, status: $status, startDate: $startDate, endDate: $endDate, autoRenew: $autoRenew, metadata: $metadata, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionDebugDataCopyWith<$Res> implements $SubscriptionDebugDataCopyWith<$Res> {
  factory _$SubscriptionDebugDataCopyWith(_SubscriptionDebugData value, $Res Function(_SubscriptionDebugData) _then) = __$SubscriptionDebugDataCopyWithImpl;
@override @useResult
$Res call({
 String? subscriptionId, String? plan, String? status, String? startDate, String? endDate, String? autoRenew, Map<String, dynamic>? metadata, String? createdAt, String? updatedAt
});




}
/// @nodoc
class __$SubscriptionDebugDataCopyWithImpl<$Res>
    implements _$SubscriptionDebugDataCopyWith<$Res> {
  __$SubscriptionDebugDataCopyWithImpl(this._self, this._then);

  final _SubscriptionDebugData _self;
  final $Res Function(_SubscriptionDebugData) _then;

/// Create a copy of SubscriptionDebugData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? subscriptionId = freezed,Object? plan = freezed,Object? status = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? autoRenew = freezed,Object? metadata = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_SubscriptionDebugData(
subscriptionId: freezed == subscriptionId ? _self.subscriptionId : subscriptionId // ignore: cast_nullable_to_non_nullable
as String?,plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,autoRenew: freezed == autoRenew ? _self.autoRenew : autoRenew // ignore: cast_nullable_to_non_nullable
as String?,metadata: freezed == metadata ? _self._metadata : metadata // ignore: cast_nullable_to_non_nullable
as Map<String, dynamic>?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
