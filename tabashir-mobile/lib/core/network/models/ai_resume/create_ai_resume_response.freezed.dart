// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'create_ai_resume_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CreateAiResumeResponse {

 bool get success; String? get message; CreateAiResumeData? get data;
/// Create a copy of CreateAiResumeResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateAiResumeResponseCopyWith<CreateAiResumeResponse> get copyWith => _$CreateAiResumeResponseCopyWithImpl<CreateAiResumeResponse>(this as CreateAiResumeResponse, _$identity);

  /// Serializes this CreateAiResumeResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateAiResumeResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,data);

@override
String toString() {
  return 'CreateAiResumeResponse(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class $CreateAiResumeResponseCopyWith<$Res>  {
  factory $CreateAiResumeResponseCopyWith(CreateAiResumeResponse value, $Res Function(CreateAiResumeResponse) _then) = _$CreateAiResumeResponseCopyWithImpl;
@useResult
$Res call({
 bool success, String? message, CreateAiResumeData? data
});


$CreateAiResumeDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$CreateAiResumeResponseCopyWithImpl<$Res>
    implements $CreateAiResumeResponseCopyWith<$Res> {
  _$CreateAiResumeResponseCopyWithImpl(this._self, this._then);

  final CreateAiResumeResponse _self;
  final $Res Function(CreateAiResumeResponse) _then;

/// Create a copy of CreateAiResumeResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = freezed,Object? data = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as CreateAiResumeData?,
  ));
}
/// Create a copy of CreateAiResumeResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CreateAiResumeDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $CreateAiResumeDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [CreateAiResumeResponse].
extension CreateAiResumeResponsePatterns on CreateAiResumeResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateAiResumeResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateAiResumeResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateAiResumeResponse value)  $default,){
final _that = this;
switch (_that) {
case _CreateAiResumeResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateAiResumeResponse value)?  $default,){
final _that = this;
switch (_that) {
case _CreateAiResumeResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String? message,  CreateAiResumeData? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateAiResumeResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String? message,  CreateAiResumeData? data)  $default,) {final _that = this;
switch (_that) {
case _CreateAiResumeResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String? message,  CreateAiResumeData? data)?  $default,) {final _that = this;
switch (_that) {
case _CreateAiResumeResponse() when $default != null:
return $default(_that.success,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateAiResumeResponse implements CreateAiResumeResponse {
  const _CreateAiResumeResponse({required this.success, this.message, this.data});
  factory _CreateAiResumeResponse.fromJson(Map<String, dynamic> json) => _$CreateAiResumeResponseFromJson(json);

@override final  bool success;
@override final  String? message;
@override final  CreateAiResumeData? data;

/// Create a copy of CreateAiResumeResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateAiResumeResponseCopyWith<_CreateAiResumeResponse> get copyWith => __$CreateAiResumeResponseCopyWithImpl<_CreateAiResumeResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateAiResumeResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateAiResumeResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,data);

@override
String toString() {
  return 'CreateAiResumeResponse(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$CreateAiResumeResponseCopyWith<$Res> implements $CreateAiResumeResponseCopyWith<$Res> {
  factory _$CreateAiResumeResponseCopyWith(_CreateAiResumeResponse value, $Res Function(_CreateAiResumeResponse) _then) = __$CreateAiResumeResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, String? message, CreateAiResumeData? data
});


@override $CreateAiResumeDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$CreateAiResumeResponseCopyWithImpl<$Res>
    implements _$CreateAiResumeResponseCopyWith<$Res> {
  __$CreateAiResumeResponseCopyWithImpl(this._self, this._then);

  final _CreateAiResumeResponse _self;
  final $Res Function(_CreateAiResumeResponse) _then;

/// Create a copy of CreateAiResumeResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = freezed,Object? data = freezed,}) {
  return _then(_CreateAiResumeResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as CreateAiResumeData?,
  ));
}

/// Create a copy of CreateAiResumeResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CreateAiResumeDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $CreateAiResumeDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$CreateAiResumeData {

 String? get id; String? get candidateId; String? get status; int? get progress; String? get originalUrl; String? get formatedUrl; String? get formatedContent; String? get createdAt; String? get updatedAt;
/// Create a copy of CreateAiResumeData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CreateAiResumeDataCopyWith<CreateAiResumeData> get copyWith => _$CreateAiResumeDataCopyWithImpl<CreateAiResumeData>(this as CreateAiResumeData, _$identity);

  /// Serializes this CreateAiResumeData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CreateAiResumeData&&(identical(other.id, id) || other.id == id)&&(identical(other.candidateId, candidateId) || other.candidateId == candidateId)&&(identical(other.status, status) || other.status == status)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.originalUrl, originalUrl) || other.originalUrl == originalUrl)&&(identical(other.formatedUrl, formatedUrl) || other.formatedUrl == formatedUrl)&&(identical(other.formatedContent, formatedContent) || other.formatedContent == formatedContent)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,candidateId,status,progress,originalUrl,formatedUrl,formatedContent,createdAt,updatedAt);

@override
String toString() {
  return 'CreateAiResumeData(id: $id, candidateId: $candidateId, status: $status, progress: $progress, originalUrl: $originalUrl, formatedUrl: $formatedUrl, formatedContent: $formatedContent, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $CreateAiResumeDataCopyWith<$Res>  {
  factory $CreateAiResumeDataCopyWith(CreateAiResumeData value, $Res Function(CreateAiResumeData) _then) = _$CreateAiResumeDataCopyWithImpl;
@useResult
$Res call({
 String? id, String? candidateId, String? status, int? progress, String? originalUrl, String? formatedUrl, String? formatedContent, String? createdAt, String? updatedAt
});




}
/// @nodoc
class _$CreateAiResumeDataCopyWithImpl<$Res>
    implements $CreateAiResumeDataCopyWith<$Res> {
  _$CreateAiResumeDataCopyWithImpl(this._self, this._then);

  final CreateAiResumeData _self;
  final $Res Function(CreateAiResumeData) _then;

/// Create a copy of CreateAiResumeData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? candidateId = freezed,Object? status = freezed,Object? progress = freezed,Object? originalUrl = freezed,Object? formatedUrl = freezed,Object? formatedContent = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,candidateId: freezed == candidateId ? _self.candidateId : candidateId // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,progress: freezed == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as int?,originalUrl: freezed == originalUrl ? _self.originalUrl : originalUrl // ignore: cast_nullable_to_non_nullable
as String?,formatedUrl: freezed == formatedUrl ? _self.formatedUrl : formatedUrl // ignore: cast_nullable_to_non_nullable
as String?,formatedContent: freezed == formatedContent ? _self.formatedContent : formatedContent // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [CreateAiResumeData].
extension CreateAiResumeDataPatterns on CreateAiResumeData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CreateAiResumeData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CreateAiResumeData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CreateAiResumeData value)  $default,){
final _that = this;
switch (_that) {
case _CreateAiResumeData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CreateAiResumeData value)?  $default,){
final _that = this;
switch (_that) {
case _CreateAiResumeData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? candidateId,  String? status,  int? progress,  String? originalUrl,  String? formatedUrl,  String? formatedContent,  String? createdAt,  String? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CreateAiResumeData() when $default != null:
return $default(_that.id,_that.candidateId,_that.status,_that.progress,_that.originalUrl,_that.formatedUrl,_that.formatedContent,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? candidateId,  String? status,  int? progress,  String? originalUrl,  String? formatedUrl,  String? formatedContent,  String? createdAt,  String? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _CreateAiResumeData():
return $default(_that.id,_that.candidateId,_that.status,_that.progress,_that.originalUrl,_that.formatedUrl,_that.formatedContent,_that.createdAt,_that.updatedAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? candidateId,  String? status,  int? progress,  String? originalUrl,  String? formatedUrl,  String? formatedContent,  String? createdAt,  String? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _CreateAiResumeData() when $default != null:
return $default(_that.id,_that.candidateId,_that.status,_that.progress,_that.originalUrl,_that.formatedUrl,_that.formatedContent,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CreateAiResumeData implements CreateAiResumeData {
  const _CreateAiResumeData({this.id, this.candidateId, this.status, this.progress, this.originalUrl, this.formatedUrl, this.formatedContent, this.createdAt, this.updatedAt});
  factory _CreateAiResumeData.fromJson(Map<String, dynamic> json) => _$CreateAiResumeDataFromJson(json);

@override final  String? id;
@override final  String? candidateId;
@override final  String? status;
@override final  int? progress;
@override final  String? originalUrl;
@override final  String? formatedUrl;
@override final  String? formatedContent;
@override final  String? createdAt;
@override final  String? updatedAt;

/// Create a copy of CreateAiResumeData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CreateAiResumeDataCopyWith<_CreateAiResumeData> get copyWith => __$CreateAiResumeDataCopyWithImpl<_CreateAiResumeData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CreateAiResumeDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CreateAiResumeData&&(identical(other.id, id) || other.id == id)&&(identical(other.candidateId, candidateId) || other.candidateId == candidateId)&&(identical(other.status, status) || other.status == status)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.originalUrl, originalUrl) || other.originalUrl == originalUrl)&&(identical(other.formatedUrl, formatedUrl) || other.formatedUrl == formatedUrl)&&(identical(other.formatedContent, formatedContent) || other.formatedContent == formatedContent)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,candidateId,status,progress,originalUrl,formatedUrl,formatedContent,createdAt,updatedAt);

@override
String toString() {
  return 'CreateAiResumeData(id: $id, candidateId: $candidateId, status: $status, progress: $progress, originalUrl: $originalUrl, formatedUrl: $formatedUrl, formatedContent: $formatedContent, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$CreateAiResumeDataCopyWith<$Res> implements $CreateAiResumeDataCopyWith<$Res> {
  factory _$CreateAiResumeDataCopyWith(_CreateAiResumeData value, $Res Function(_CreateAiResumeData) _then) = __$CreateAiResumeDataCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? candidateId, String? status, int? progress, String? originalUrl, String? formatedUrl, String? formatedContent, String? createdAt, String? updatedAt
});




}
/// @nodoc
class __$CreateAiResumeDataCopyWithImpl<$Res>
    implements _$CreateAiResumeDataCopyWith<$Res> {
  __$CreateAiResumeDataCopyWithImpl(this._self, this._then);

  final _CreateAiResumeData _self;
  final $Res Function(_CreateAiResumeData) _then;

/// Create a copy of CreateAiResumeData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? candidateId = freezed,Object? status = freezed,Object? progress = freezed,Object? originalUrl = freezed,Object? formatedUrl = freezed,Object? formatedContent = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_CreateAiResumeData(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,candidateId: freezed == candidateId ? _self.candidateId : candidateId // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,progress: freezed == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as int?,originalUrl: freezed == originalUrl ? _self.originalUrl : originalUrl // ignore: cast_nullable_to_non_nullable
as String?,formatedUrl: freezed == formatedUrl ? _self.formatedUrl : formatedUrl // ignore: cast_nullable_to_non_nullable
as String?,formatedContent: freezed == formatedContent ? _self.formatedContent : formatedContent // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
