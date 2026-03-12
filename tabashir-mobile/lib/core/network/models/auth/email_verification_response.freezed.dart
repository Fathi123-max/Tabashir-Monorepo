// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'email_verification_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$EmailVerificationResponse {

 bool get success; String? get message; EmailVerificationData? get data;
/// Create a copy of EmailVerificationResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmailVerificationResponseCopyWith<EmailVerificationResponse> get copyWith => _$EmailVerificationResponseCopyWithImpl<EmailVerificationResponse>(this as EmailVerificationResponse, _$identity);

  /// Serializes this EmailVerificationResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailVerificationResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,data);

@override
String toString() {
  return 'EmailVerificationResponse(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class $EmailVerificationResponseCopyWith<$Res>  {
  factory $EmailVerificationResponseCopyWith(EmailVerificationResponse value, $Res Function(EmailVerificationResponse) _then) = _$EmailVerificationResponseCopyWithImpl;
@useResult
$Res call({
 bool success, String? message, EmailVerificationData? data
});


$EmailVerificationDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$EmailVerificationResponseCopyWithImpl<$Res>
    implements $EmailVerificationResponseCopyWith<$Res> {
  _$EmailVerificationResponseCopyWithImpl(this._self, this._then);

  final EmailVerificationResponse _self;
  final $Res Function(EmailVerificationResponse) _then;

/// Create a copy of EmailVerificationResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = freezed,Object? data = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as EmailVerificationData?,
  ));
}
/// Create a copy of EmailVerificationResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EmailVerificationDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $EmailVerificationDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [EmailVerificationResponse].
extension EmailVerificationResponsePatterns on EmailVerificationResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmailVerificationResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmailVerificationResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmailVerificationResponse value)  $default,){
final _that = this;
switch (_that) {
case _EmailVerificationResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmailVerificationResponse value)?  $default,){
final _that = this;
switch (_that) {
case _EmailVerificationResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String? message,  EmailVerificationData? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmailVerificationResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String? message,  EmailVerificationData? data)  $default,) {final _that = this;
switch (_that) {
case _EmailVerificationResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String? message,  EmailVerificationData? data)?  $default,) {final _that = this;
switch (_that) {
case _EmailVerificationResponse() when $default != null:
return $default(_that.success,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EmailVerificationResponse implements EmailVerificationResponse {
  const _EmailVerificationResponse({required this.success, this.message, this.data});
  factory _EmailVerificationResponse.fromJson(Map<String, dynamic> json) => _$EmailVerificationResponseFromJson(json);

@override final  bool success;
@override final  String? message;
@override final  EmailVerificationData? data;

/// Create a copy of EmailVerificationResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmailVerificationResponseCopyWith<_EmailVerificationResponse> get copyWith => __$EmailVerificationResponseCopyWithImpl<_EmailVerificationResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EmailVerificationResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmailVerificationResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,data);

@override
String toString() {
  return 'EmailVerificationResponse(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$EmailVerificationResponseCopyWith<$Res> implements $EmailVerificationResponseCopyWith<$Res> {
  factory _$EmailVerificationResponseCopyWith(_EmailVerificationResponse value, $Res Function(_EmailVerificationResponse) _then) = __$EmailVerificationResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, String? message, EmailVerificationData? data
});


@override $EmailVerificationDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$EmailVerificationResponseCopyWithImpl<$Res>
    implements _$EmailVerificationResponseCopyWith<$Res> {
  __$EmailVerificationResponseCopyWithImpl(this._self, this._then);

  final _EmailVerificationResponse _self;
  final $Res Function(_EmailVerificationResponse) _then;

/// Create a copy of EmailVerificationResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = freezed,Object? data = freezed,}) {
  return _then(_EmailVerificationResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as EmailVerificationData?,
  ));
}

/// Create a copy of EmailVerificationResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$EmailVerificationDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $EmailVerificationDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$EmailVerificationData {

 String? get userId; String? get email; bool? get verified; String? get createdAt;
/// Create a copy of EmailVerificationData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmailVerificationDataCopyWith<EmailVerificationData> get copyWith => _$EmailVerificationDataCopyWithImpl<EmailVerificationData>(this as EmailVerificationData, _$identity);

  /// Serializes this EmailVerificationData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmailVerificationData&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.email, email) || other.email == email)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,email,verified,createdAt);

@override
String toString() {
  return 'EmailVerificationData(userId: $userId, email: $email, verified: $verified, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $EmailVerificationDataCopyWith<$Res>  {
  factory $EmailVerificationDataCopyWith(EmailVerificationData value, $Res Function(EmailVerificationData) _then) = _$EmailVerificationDataCopyWithImpl;
@useResult
$Res call({
 String? userId, String? email, bool? verified, String? createdAt
});




}
/// @nodoc
class _$EmailVerificationDataCopyWithImpl<$Res>
    implements $EmailVerificationDataCopyWith<$Res> {
  _$EmailVerificationDataCopyWithImpl(this._self, this._then);

  final EmailVerificationData _self;
  final $Res Function(EmailVerificationData) _then;

/// Create a copy of EmailVerificationData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? userId = freezed,Object? email = freezed,Object? verified = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,verified: freezed == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [EmailVerificationData].
extension EmailVerificationDataPatterns on EmailVerificationData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmailVerificationData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmailVerificationData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmailVerificationData value)  $default,){
final _that = this;
switch (_that) {
case _EmailVerificationData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmailVerificationData value)?  $default,){
final _that = this;
switch (_that) {
case _EmailVerificationData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? userId,  String? email,  bool? verified,  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmailVerificationData() when $default != null:
return $default(_that.userId,_that.email,_that.verified,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? userId,  String? email,  bool? verified,  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _EmailVerificationData():
return $default(_that.userId,_that.email,_that.verified,_that.createdAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? userId,  String? email,  bool? verified,  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _EmailVerificationData() when $default != null:
return $default(_that.userId,_that.email,_that.verified,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EmailVerificationData implements EmailVerificationData {
  const _EmailVerificationData({this.userId, this.email, this.verified, this.createdAt});
  factory _EmailVerificationData.fromJson(Map<String, dynamic> json) => _$EmailVerificationDataFromJson(json);

@override final  String? userId;
@override final  String? email;
@override final  bool? verified;
@override final  String? createdAt;

/// Create a copy of EmailVerificationData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmailVerificationDataCopyWith<_EmailVerificationData> get copyWith => __$EmailVerificationDataCopyWithImpl<_EmailVerificationData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EmailVerificationDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmailVerificationData&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.email, email) || other.email == email)&&(identical(other.verified, verified) || other.verified == verified)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,userId,email,verified,createdAt);

@override
String toString() {
  return 'EmailVerificationData(userId: $userId, email: $email, verified: $verified, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$EmailVerificationDataCopyWith<$Res> implements $EmailVerificationDataCopyWith<$Res> {
  factory _$EmailVerificationDataCopyWith(_EmailVerificationData value, $Res Function(_EmailVerificationData) _then) = __$EmailVerificationDataCopyWithImpl;
@override @useResult
$Res call({
 String? userId, String? email, bool? verified, String? createdAt
});




}
/// @nodoc
class __$EmailVerificationDataCopyWithImpl<$Res>
    implements _$EmailVerificationDataCopyWith<$Res> {
  __$EmailVerificationDataCopyWithImpl(this._self, this._then);

  final _EmailVerificationData _self;
  final $Res Function(_EmailVerificationData) _then;

/// Create a copy of EmailVerificationData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? userId = freezed,Object? email = freezed,Object? verified = freezed,Object? createdAt = freezed,}) {
  return _then(_EmailVerificationData(
userId: freezed == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,verified: freezed == verified ? _self.verified : verified // ignore: cast_nullable_to_non_nullable
as bool?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
