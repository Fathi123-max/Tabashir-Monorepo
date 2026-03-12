// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'checkout_session_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CheckoutSessionResponse {

 bool get success; String? get message; CheckoutSessionData? get data;
/// Create a copy of CheckoutSessionResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutSessionResponseCopyWith<CheckoutSessionResponse> get copyWith => _$CheckoutSessionResponseCopyWithImpl<CheckoutSessionResponse>(this as CheckoutSessionResponse, _$identity);

  /// Serializes this CheckoutSessionResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutSessionResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,data);

@override
String toString() {
  return 'CheckoutSessionResponse(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class $CheckoutSessionResponseCopyWith<$Res>  {
  factory $CheckoutSessionResponseCopyWith(CheckoutSessionResponse value, $Res Function(CheckoutSessionResponse) _then) = _$CheckoutSessionResponseCopyWithImpl;
@useResult
$Res call({
 bool success, String? message, CheckoutSessionData? data
});


$CheckoutSessionDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$CheckoutSessionResponseCopyWithImpl<$Res>
    implements $CheckoutSessionResponseCopyWith<$Res> {
  _$CheckoutSessionResponseCopyWithImpl(this._self, this._then);

  final CheckoutSessionResponse _self;
  final $Res Function(CheckoutSessionResponse) _then;

/// Create a copy of CheckoutSessionResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = freezed,Object? data = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as CheckoutSessionData?,
  ));
}
/// Create a copy of CheckoutSessionResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CheckoutSessionDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $CheckoutSessionDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [CheckoutSessionResponse].
extension CheckoutSessionResponsePatterns on CheckoutSessionResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckoutSessionResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckoutSessionResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckoutSessionResponse value)  $default,){
final _that = this;
switch (_that) {
case _CheckoutSessionResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckoutSessionResponse value)?  $default,){
final _that = this;
switch (_that) {
case _CheckoutSessionResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String? message,  CheckoutSessionData? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckoutSessionResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String? message,  CheckoutSessionData? data)  $default,) {final _that = this;
switch (_that) {
case _CheckoutSessionResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String? message,  CheckoutSessionData? data)?  $default,) {final _that = this;
switch (_that) {
case _CheckoutSessionResponse() when $default != null:
return $default(_that.success,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CheckoutSessionResponse implements CheckoutSessionResponse {
  const _CheckoutSessionResponse({required this.success, this.message, this.data});
  factory _CheckoutSessionResponse.fromJson(Map<String, dynamic> json) => _$CheckoutSessionResponseFromJson(json);

@override final  bool success;
@override final  String? message;
@override final  CheckoutSessionData? data;

/// Create a copy of CheckoutSessionResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckoutSessionResponseCopyWith<_CheckoutSessionResponse> get copyWith => __$CheckoutSessionResponseCopyWithImpl<_CheckoutSessionResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CheckoutSessionResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckoutSessionResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,data);

@override
String toString() {
  return 'CheckoutSessionResponse(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$CheckoutSessionResponseCopyWith<$Res> implements $CheckoutSessionResponseCopyWith<$Res> {
  factory _$CheckoutSessionResponseCopyWith(_CheckoutSessionResponse value, $Res Function(_CheckoutSessionResponse) _then) = __$CheckoutSessionResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, String? message, CheckoutSessionData? data
});


@override $CheckoutSessionDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$CheckoutSessionResponseCopyWithImpl<$Res>
    implements _$CheckoutSessionResponseCopyWith<$Res> {
  __$CheckoutSessionResponseCopyWithImpl(this._self, this._then);

  final _CheckoutSessionResponse _self;
  final $Res Function(_CheckoutSessionResponse) _then;

/// Create a copy of CheckoutSessionResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = freezed,Object? data = freezed,}) {
  return _then(_CheckoutSessionResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as CheckoutSessionData?,
  ));
}

/// Create a copy of CheckoutSessionResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CheckoutSessionDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $CheckoutSessionDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$CheckoutSessionData {

 String? get sessionId; String? get url; String? get paymentIntentId;
/// Create a copy of CheckoutSessionData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CheckoutSessionDataCopyWith<CheckoutSessionData> get copyWith => _$CheckoutSessionDataCopyWithImpl<CheckoutSessionData>(this as CheckoutSessionData, _$identity);

  /// Serializes this CheckoutSessionData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CheckoutSessionData&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.url, url) || other.url == url)&&(identical(other.paymentIntentId, paymentIntentId) || other.paymentIntentId == paymentIntentId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionId,url,paymentIntentId);

@override
String toString() {
  return 'CheckoutSessionData(sessionId: $sessionId, url: $url, paymentIntentId: $paymentIntentId)';
}


}

/// @nodoc
abstract mixin class $CheckoutSessionDataCopyWith<$Res>  {
  factory $CheckoutSessionDataCopyWith(CheckoutSessionData value, $Res Function(CheckoutSessionData) _then) = _$CheckoutSessionDataCopyWithImpl;
@useResult
$Res call({
 String? sessionId, String? url, String? paymentIntentId
});




}
/// @nodoc
class _$CheckoutSessionDataCopyWithImpl<$Res>
    implements $CheckoutSessionDataCopyWith<$Res> {
  _$CheckoutSessionDataCopyWithImpl(this._self, this._then);

  final CheckoutSessionData _self;
  final $Res Function(CheckoutSessionData) _then;

/// Create a copy of CheckoutSessionData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? sessionId = freezed,Object? url = freezed,Object? paymentIntentId = freezed,}) {
  return _then(_self.copyWith(
sessionId: freezed == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,paymentIntentId: freezed == paymentIntentId ? _self.paymentIntentId : paymentIntentId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CheckoutSessionData].
extension CheckoutSessionDataPatterns on CheckoutSessionData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CheckoutSessionData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CheckoutSessionData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CheckoutSessionData value)  $default,){
final _that = this;
switch (_that) {
case _CheckoutSessionData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CheckoutSessionData value)?  $default,){
final _that = this;
switch (_that) {
case _CheckoutSessionData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? sessionId,  String? url,  String? paymentIntentId)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CheckoutSessionData() when $default != null:
return $default(_that.sessionId,_that.url,_that.paymentIntentId);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? sessionId,  String? url,  String? paymentIntentId)  $default,) {final _that = this;
switch (_that) {
case _CheckoutSessionData():
return $default(_that.sessionId,_that.url,_that.paymentIntentId);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? sessionId,  String? url,  String? paymentIntentId)?  $default,) {final _that = this;
switch (_that) {
case _CheckoutSessionData() when $default != null:
return $default(_that.sessionId,_that.url,_that.paymentIntentId);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CheckoutSessionData implements CheckoutSessionData {
  const _CheckoutSessionData({this.sessionId, this.url, this.paymentIntentId});
  factory _CheckoutSessionData.fromJson(Map<String, dynamic> json) => _$CheckoutSessionDataFromJson(json);

@override final  String? sessionId;
@override final  String? url;
@override final  String? paymentIntentId;

/// Create a copy of CheckoutSessionData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CheckoutSessionDataCopyWith<_CheckoutSessionData> get copyWith => __$CheckoutSessionDataCopyWithImpl<_CheckoutSessionData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CheckoutSessionDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CheckoutSessionData&&(identical(other.sessionId, sessionId) || other.sessionId == sessionId)&&(identical(other.url, url) || other.url == url)&&(identical(other.paymentIntentId, paymentIntentId) || other.paymentIntentId == paymentIntentId));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,sessionId,url,paymentIntentId);

@override
String toString() {
  return 'CheckoutSessionData(sessionId: $sessionId, url: $url, paymentIntentId: $paymentIntentId)';
}


}

/// @nodoc
abstract mixin class _$CheckoutSessionDataCopyWith<$Res> implements $CheckoutSessionDataCopyWith<$Res> {
  factory _$CheckoutSessionDataCopyWith(_CheckoutSessionData value, $Res Function(_CheckoutSessionData) _then) = __$CheckoutSessionDataCopyWithImpl;
@override @useResult
$Res call({
 String? sessionId, String? url, String? paymentIntentId
});




}
/// @nodoc
class __$CheckoutSessionDataCopyWithImpl<$Res>
    implements _$CheckoutSessionDataCopyWith<$Res> {
  __$CheckoutSessionDataCopyWithImpl(this._self, this._then);

  final _CheckoutSessionData _self;
  final $Res Function(_CheckoutSessionData) _then;

/// Create a copy of CheckoutSessionData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? sessionId = freezed,Object? url = freezed,Object? paymentIntentId = freezed,}) {
  return _then(_CheckoutSessionData(
sessionId: freezed == sessionId ? _self.sessionId : sessionId // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,paymentIntentId: freezed == paymentIntentId ? _self.paymentIntentId : paymentIntentId // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
