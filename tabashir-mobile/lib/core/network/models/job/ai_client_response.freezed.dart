// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_client_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AiClientResponse {

 bool get success; String? get message; AiClientData? get data;
/// Create a copy of AiClientResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiClientResponseCopyWith<AiClientResponse> get copyWith => _$AiClientResponseCopyWithImpl<AiClientResponse>(this as AiClientResponse, _$identity);

  /// Serializes this AiClientResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiClientResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,data);

@override
String toString() {
  return 'AiClientResponse(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class $AiClientResponseCopyWith<$Res>  {
  factory $AiClientResponseCopyWith(AiClientResponse value, $Res Function(AiClientResponse) _then) = _$AiClientResponseCopyWithImpl;
@useResult
$Res call({
 bool success, String? message, AiClientData? data
});


$AiClientDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$AiClientResponseCopyWithImpl<$Res>
    implements $AiClientResponseCopyWith<$Res> {
  _$AiClientResponseCopyWithImpl(this._self, this._then);

  final AiClientResponse _self;
  final $Res Function(AiClientResponse) _then;

/// Create a copy of AiClientResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = freezed,Object? data = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as AiClientData?,
  ));
}
/// Create a copy of AiClientResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AiClientDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $AiClientDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [AiClientResponse].
extension AiClientResponsePatterns on AiClientResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiClientResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiClientResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiClientResponse value)  $default,){
final _that = this;
switch (_that) {
case _AiClientResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiClientResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AiClientResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String? message,  AiClientData? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiClientResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String? message,  AiClientData? data)  $default,) {final _that = this;
switch (_that) {
case _AiClientResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String? message,  AiClientData? data)?  $default,) {final _that = this;
switch (_that) {
case _AiClientResponse() when $default != null:
return $default(_that.success,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiClientResponse implements AiClientResponse {
  const _AiClientResponse({this.success = false, this.message, this.data});
  factory _AiClientResponse.fromJson(Map<String, dynamic> json) => _$AiClientResponseFromJson(json);

@override@JsonKey() final  bool success;
@override final  String? message;
@override final  AiClientData? data;

/// Create a copy of AiClientResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiClientResponseCopyWith<_AiClientResponse> get copyWith => __$AiClientResponseCopyWithImpl<_AiClientResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiClientResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiClientResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,data);

@override
String toString() {
  return 'AiClientResponse(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$AiClientResponseCopyWith<$Res> implements $AiClientResponseCopyWith<$Res> {
  factory _$AiClientResponseCopyWith(_AiClientResponse value, $Res Function(_AiClientResponse) _then) = __$AiClientResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, String? message, AiClientData? data
});


@override $AiClientDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$AiClientResponseCopyWithImpl<$Res>
    implements _$AiClientResponseCopyWith<$Res> {
  __$AiClientResponseCopyWithImpl(this._self, this._then);

  final _AiClientResponse _self;
  final $Res Function(_AiClientResponse) _then;

/// Create a copy of AiClientResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = freezed,Object? data = freezed,}) {
  return _then(_AiClientResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as AiClientData?,
  ));
}

/// Create a copy of AiClientResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AiClientDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $AiClientDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$AiClientData {

 String? get nationality; String? get gender; String? get location; String? get positions; String? get filename;@JsonKey(name: 'jobs_to_apply_number') int? get jobsToApplyNumber;@JsonKey(name: 'job_matching') int? get jobMatching;
/// Create a copy of AiClientData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiClientDataCopyWith<AiClientData> get copyWith => _$AiClientDataCopyWithImpl<AiClientData>(this as AiClientData, _$identity);

  /// Serializes this AiClientData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiClientData&&(identical(other.nationality, nationality) || other.nationality == nationality)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.location, location) || other.location == location)&&(identical(other.positions, positions) || other.positions == positions)&&(identical(other.filename, filename) || other.filename == filename)&&(identical(other.jobsToApplyNumber, jobsToApplyNumber) || other.jobsToApplyNumber == jobsToApplyNumber)&&(identical(other.jobMatching, jobMatching) || other.jobMatching == jobMatching));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,nationality,gender,location,positions,filename,jobsToApplyNumber,jobMatching);

@override
String toString() {
  return 'AiClientData(nationality: $nationality, gender: $gender, location: $location, positions: $positions, filename: $filename, jobsToApplyNumber: $jobsToApplyNumber, jobMatching: $jobMatching)';
}


}

/// @nodoc
abstract mixin class $AiClientDataCopyWith<$Res>  {
  factory $AiClientDataCopyWith(AiClientData value, $Res Function(AiClientData) _then) = _$AiClientDataCopyWithImpl;
@useResult
$Res call({
 String? nationality, String? gender, String? location, String? positions, String? filename,@JsonKey(name: 'jobs_to_apply_number') int? jobsToApplyNumber,@JsonKey(name: 'job_matching') int? jobMatching
});




}
/// @nodoc
class _$AiClientDataCopyWithImpl<$Res>
    implements $AiClientDataCopyWith<$Res> {
  _$AiClientDataCopyWithImpl(this._self, this._then);

  final AiClientData _self;
  final $Res Function(AiClientData) _then;

/// Create a copy of AiClientData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? nationality = freezed,Object? gender = freezed,Object? location = freezed,Object? positions = freezed,Object? filename = freezed,Object? jobsToApplyNumber = freezed,Object? jobMatching = freezed,}) {
  return _then(_self.copyWith(
nationality: freezed == nationality ? _self.nationality : nationality // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,positions: freezed == positions ? _self.positions : positions // ignore: cast_nullable_to_non_nullable
as String?,filename: freezed == filename ? _self.filename : filename // ignore: cast_nullable_to_non_nullable
as String?,jobsToApplyNumber: freezed == jobsToApplyNumber ? _self.jobsToApplyNumber : jobsToApplyNumber // ignore: cast_nullable_to_non_nullable
as int?,jobMatching: freezed == jobMatching ? _self.jobMatching : jobMatching // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}

}


/// Adds pattern-matching-related methods to [AiClientData].
extension AiClientDataPatterns on AiClientData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiClientData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiClientData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiClientData value)  $default,){
final _that = this;
switch (_that) {
case _AiClientData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiClientData value)?  $default,){
final _that = this;
switch (_that) {
case _AiClientData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? nationality,  String? gender,  String? location,  String? positions,  String? filename, @JsonKey(name: 'jobs_to_apply_number')  int? jobsToApplyNumber, @JsonKey(name: 'job_matching')  int? jobMatching)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiClientData() when $default != null:
return $default(_that.nationality,_that.gender,_that.location,_that.positions,_that.filename,_that.jobsToApplyNumber,_that.jobMatching);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? nationality,  String? gender,  String? location,  String? positions,  String? filename, @JsonKey(name: 'jobs_to_apply_number')  int? jobsToApplyNumber, @JsonKey(name: 'job_matching')  int? jobMatching)  $default,) {final _that = this;
switch (_that) {
case _AiClientData():
return $default(_that.nationality,_that.gender,_that.location,_that.positions,_that.filename,_that.jobsToApplyNumber,_that.jobMatching);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? nationality,  String? gender,  String? location,  String? positions,  String? filename, @JsonKey(name: 'jobs_to_apply_number')  int? jobsToApplyNumber, @JsonKey(name: 'job_matching')  int? jobMatching)?  $default,) {final _that = this;
switch (_that) {
case _AiClientData() when $default != null:
return $default(_that.nationality,_that.gender,_that.location,_that.positions,_that.filename,_that.jobsToApplyNumber,_that.jobMatching);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiClientData implements AiClientData {
  const _AiClientData({this.nationality, this.gender, this.location, this.positions, this.filename, @JsonKey(name: 'jobs_to_apply_number') this.jobsToApplyNumber, @JsonKey(name: 'job_matching') this.jobMatching});
  factory _AiClientData.fromJson(Map<String, dynamic> json) => _$AiClientDataFromJson(json);

@override final  String? nationality;
@override final  String? gender;
@override final  String? location;
@override final  String? positions;
@override final  String? filename;
@override@JsonKey(name: 'jobs_to_apply_number') final  int? jobsToApplyNumber;
@override@JsonKey(name: 'job_matching') final  int? jobMatching;

/// Create a copy of AiClientData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiClientDataCopyWith<_AiClientData> get copyWith => __$AiClientDataCopyWithImpl<_AiClientData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiClientDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiClientData&&(identical(other.nationality, nationality) || other.nationality == nationality)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.location, location) || other.location == location)&&(identical(other.positions, positions) || other.positions == positions)&&(identical(other.filename, filename) || other.filename == filename)&&(identical(other.jobsToApplyNumber, jobsToApplyNumber) || other.jobsToApplyNumber == jobsToApplyNumber)&&(identical(other.jobMatching, jobMatching) || other.jobMatching == jobMatching));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,nationality,gender,location,positions,filename,jobsToApplyNumber,jobMatching);

@override
String toString() {
  return 'AiClientData(nationality: $nationality, gender: $gender, location: $location, positions: $positions, filename: $filename, jobsToApplyNumber: $jobsToApplyNumber, jobMatching: $jobMatching)';
}


}

/// @nodoc
abstract mixin class _$AiClientDataCopyWith<$Res> implements $AiClientDataCopyWith<$Res> {
  factory _$AiClientDataCopyWith(_AiClientData value, $Res Function(_AiClientData) _then) = __$AiClientDataCopyWithImpl;
@override @useResult
$Res call({
 String? nationality, String? gender, String? location, String? positions, String? filename,@JsonKey(name: 'jobs_to_apply_number') int? jobsToApplyNumber,@JsonKey(name: 'job_matching') int? jobMatching
});




}
/// @nodoc
class __$AiClientDataCopyWithImpl<$Res>
    implements _$AiClientDataCopyWith<$Res> {
  __$AiClientDataCopyWithImpl(this._self, this._then);

  final _AiClientData _self;
  final $Res Function(_AiClientData) _then;

/// Create a copy of AiClientData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? nationality = freezed,Object? gender = freezed,Object? location = freezed,Object? positions = freezed,Object? filename = freezed,Object? jobsToApplyNumber = freezed,Object? jobMatching = freezed,}) {
  return _then(_AiClientData(
nationality: freezed == nationality ? _self.nationality : nationality // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,positions: freezed == positions ? _self.positions : positions // ignore: cast_nullable_to_non_nullable
as String?,filename: freezed == filename ? _self.filename : filename // ignore: cast_nullable_to_non_nullable
as String?,jobsToApplyNumber: freezed == jobsToApplyNumber ? _self.jobsToApplyNumber : jobsToApplyNumber // ignore: cast_nullable_to_non_nullable
as int?,jobMatching: freezed == jobMatching ? _self.jobMatching : jobMatching // ignore: cast_nullable_to_non_nullable
as int?,
  ));
}


}

// dart format on
