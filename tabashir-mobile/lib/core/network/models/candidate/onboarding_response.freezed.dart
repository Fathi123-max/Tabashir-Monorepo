// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'onboarding_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$OnboardingResponse {

 bool get success; String? get message; OnboardingData? get data;
/// Create a copy of OnboardingResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingResponseCopyWith<OnboardingResponse> get copyWith => _$OnboardingResponseCopyWithImpl<OnboardingResponse>(this as OnboardingResponse, _$identity);

  /// Serializes this OnboardingResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,data);

@override
String toString() {
  return 'OnboardingResponse(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class $OnboardingResponseCopyWith<$Res>  {
  factory $OnboardingResponseCopyWith(OnboardingResponse value, $Res Function(OnboardingResponse) _then) = _$OnboardingResponseCopyWithImpl;
@useResult
$Res call({
 bool success, String? message, OnboardingData? data
});


$OnboardingDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$OnboardingResponseCopyWithImpl<$Res>
    implements $OnboardingResponseCopyWith<$Res> {
  _$OnboardingResponseCopyWithImpl(this._self, this._then);

  final OnboardingResponse _self;
  final $Res Function(OnboardingResponse) _then;

/// Create a copy of OnboardingResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = freezed,Object? data = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as OnboardingData?,
  ));
}
/// Create a copy of OnboardingResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OnboardingDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $OnboardingDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [OnboardingResponse].
extension OnboardingResponsePatterns on OnboardingResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OnboardingResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnboardingResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OnboardingResponse value)  $default,){
final _that = this;
switch (_that) {
case _OnboardingResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OnboardingResponse value)?  $default,){
final _that = this;
switch (_that) {
case _OnboardingResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String? message,  OnboardingData? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnboardingResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String? message,  OnboardingData? data)  $default,) {final _that = this;
switch (_that) {
case _OnboardingResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String? message,  OnboardingData? data)?  $default,) {final _that = this;
switch (_that) {
case _OnboardingResponse() when $default != null:
return $default(_that.success,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OnboardingResponse implements OnboardingResponse {
  const _OnboardingResponse({required this.success, this.message, this.data});
  factory _OnboardingResponse.fromJson(Map<String, dynamic> json) => _$OnboardingResponseFromJson(json);

@override final  bool success;
@override final  String? message;
@override final  OnboardingData? data;

/// Create a copy of OnboardingResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnboardingResponseCopyWith<_OnboardingResponse> get copyWith => __$OnboardingResponseCopyWithImpl<_OnboardingResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OnboardingResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,data);

@override
String toString() {
  return 'OnboardingResponse(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$OnboardingResponseCopyWith<$Res> implements $OnboardingResponseCopyWith<$Res> {
  factory _$OnboardingResponseCopyWith(_OnboardingResponse value, $Res Function(_OnboardingResponse) _then) = __$OnboardingResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, String? message, OnboardingData? data
});


@override $OnboardingDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$OnboardingResponseCopyWithImpl<$Res>
    implements _$OnboardingResponseCopyWith<$Res> {
  __$OnboardingResponseCopyWithImpl(this._self, this._then);

  final _OnboardingResponse _self;
  final $Res Function(_OnboardingResponse) _then;

/// Create a copy of OnboardingResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = freezed,Object? data = freezed,}) {
  return _then(_OnboardingResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as OnboardingData?,
  ));
}

/// Create a copy of OnboardingResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OnboardingDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $OnboardingDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$OnboardingData {

 String? get id; String? get candidateId; String? get fullName; String? get email; String? get phone; String? get country; String? get city; bool? get onboardingCompleted; String? get createdAt; String? get updatedAt;
/// Create a copy of OnboardingData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OnboardingDataCopyWith<OnboardingData> get copyWith => _$OnboardingDataCopyWithImpl<OnboardingData>(this as OnboardingData, _$identity);

  /// Serializes this OnboardingData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OnboardingData&&(identical(other.id, id) || other.id == id)&&(identical(other.candidateId, candidateId) || other.candidateId == candidateId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.country, country) || other.country == country)&&(identical(other.city, city) || other.city == city)&&(identical(other.onboardingCompleted, onboardingCompleted) || other.onboardingCompleted == onboardingCompleted)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,candidateId,fullName,email,phone,country,city,onboardingCompleted,createdAt,updatedAt);

@override
String toString() {
  return 'OnboardingData(id: $id, candidateId: $candidateId, fullName: $fullName, email: $email, phone: $phone, country: $country, city: $city, onboardingCompleted: $onboardingCompleted, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $OnboardingDataCopyWith<$Res>  {
  factory $OnboardingDataCopyWith(OnboardingData value, $Res Function(OnboardingData) _then) = _$OnboardingDataCopyWithImpl;
@useResult
$Res call({
 String? id, String? candidateId, String? fullName, String? email, String? phone, String? country, String? city, bool? onboardingCompleted, String? createdAt, String? updatedAt
});




}
/// @nodoc
class _$OnboardingDataCopyWithImpl<$Res>
    implements $OnboardingDataCopyWith<$Res> {
  _$OnboardingDataCopyWithImpl(this._self, this._then);

  final OnboardingData _self;
  final $Res Function(OnboardingData) _then;

/// Create a copy of OnboardingData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? candidateId = freezed,Object? fullName = freezed,Object? email = freezed,Object? phone = freezed,Object? country = freezed,Object? city = freezed,Object? onboardingCompleted = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,candidateId: freezed == candidateId ? _self.candidateId : candidateId // ignore: cast_nullable_to_non_nullable
as String?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,onboardingCompleted: freezed == onboardingCompleted ? _self.onboardingCompleted : onboardingCompleted // ignore: cast_nullable_to_non_nullable
as bool?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OnboardingData].
extension OnboardingDataPatterns on OnboardingData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OnboardingData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OnboardingData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OnboardingData value)  $default,){
final _that = this;
switch (_that) {
case _OnboardingData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OnboardingData value)?  $default,){
final _that = this;
switch (_that) {
case _OnboardingData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? candidateId,  String? fullName,  String? email,  String? phone,  String? country,  String? city,  bool? onboardingCompleted,  String? createdAt,  String? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OnboardingData() when $default != null:
return $default(_that.id,_that.candidateId,_that.fullName,_that.email,_that.phone,_that.country,_that.city,_that.onboardingCompleted,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? candidateId,  String? fullName,  String? email,  String? phone,  String? country,  String? city,  bool? onboardingCompleted,  String? createdAt,  String? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _OnboardingData():
return $default(_that.id,_that.candidateId,_that.fullName,_that.email,_that.phone,_that.country,_that.city,_that.onboardingCompleted,_that.createdAt,_that.updatedAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? candidateId,  String? fullName,  String? email,  String? phone,  String? country,  String? city,  bool? onboardingCompleted,  String? createdAt,  String? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _OnboardingData() when $default != null:
return $default(_that.id,_that.candidateId,_that.fullName,_that.email,_that.phone,_that.country,_that.city,_that.onboardingCompleted,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OnboardingData implements OnboardingData {
  const _OnboardingData({this.id, this.candidateId, this.fullName, this.email, this.phone, this.country, this.city, this.onboardingCompleted, this.createdAt, this.updatedAt});
  factory _OnboardingData.fromJson(Map<String, dynamic> json) => _$OnboardingDataFromJson(json);

@override final  String? id;
@override final  String? candidateId;
@override final  String? fullName;
@override final  String? email;
@override final  String? phone;
@override final  String? country;
@override final  String? city;
@override final  bool? onboardingCompleted;
@override final  String? createdAt;
@override final  String? updatedAt;

/// Create a copy of OnboardingData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OnboardingDataCopyWith<_OnboardingData> get copyWith => __$OnboardingDataCopyWithImpl<_OnboardingData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OnboardingDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OnboardingData&&(identical(other.id, id) || other.id == id)&&(identical(other.candidateId, candidateId) || other.candidateId == candidateId)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.country, country) || other.country == country)&&(identical(other.city, city) || other.city == city)&&(identical(other.onboardingCompleted, onboardingCompleted) || other.onboardingCompleted == onboardingCompleted)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,candidateId,fullName,email,phone,country,city,onboardingCompleted,createdAt,updatedAt);

@override
String toString() {
  return 'OnboardingData(id: $id, candidateId: $candidateId, fullName: $fullName, email: $email, phone: $phone, country: $country, city: $city, onboardingCompleted: $onboardingCompleted, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$OnboardingDataCopyWith<$Res> implements $OnboardingDataCopyWith<$Res> {
  factory _$OnboardingDataCopyWith(_OnboardingData value, $Res Function(_OnboardingData) _then) = __$OnboardingDataCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? candidateId, String? fullName, String? email, String? phone, String? country, String? city, bool? onboardingCompleted, String? createdAt, String? updatedAt
});




}
/// @nodoc
class __$OnboardingDataCopyWithImpl<$Res>
    implements _$OnboardingDataCopyWith<$Res> {
  __$OnboardingDataCopyWithImpl(this._self, this._then);

  final _OnboardingData _self;
  final $Res Function(_OnboardingData) _then;

/// Create a copy of OnboardingData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? candidateId = freezed,Object? fullName = freezed,Object? email = freezed,Object? phone = freezed,Object? country = freezed,Object? city = freezed,Object? onboardingCompleted = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_OnboardingData(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,candidateId: freezed == candidateId ? _self.candidateId : candidateId // ignore: cast_nullable_to_non_nullable
as String?,fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,onboardingCompleted: freezed == onboardingCompleted ? _self.onboardingCompleted : onboardingCompleted // ignore: cast_nullable_to_non_nullable
as bool?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
