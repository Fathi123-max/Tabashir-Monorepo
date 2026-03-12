// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'upload_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UploadResponse {

 bool get success; String? get message; UploadData? get data;
/// Create a copy of UploadResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UploadResponseCopyWith<UploadResponse> get copyWith => _$UploadResponseCopyWithImpl<UploadResponse>(this as UploadResponse, _$identity);

  /// Serializes this UploadResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UploadResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,data);

@override
String toString() {
  return 'UploadResponse(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class $UploadResponseCopyWith<$Res>  {
  factory $UploadResponseCopyWith(UploadResponse value, $Res Function(UploadResponse) _then) = _$UploadResponseCopyWithImpl;
@useResult
$Res call({
 bool success, String? message, UploadData? data
});


$UploadDataCopyWith<$Res>? get data;

}
/// @nodoc
class _$UploadResponseCopyWithImpl<$Res>
    implements $UploadResponseCopyWith<$Res> {
  _$UploadResponseCopyWithImpl(this._self, this._then);

  final UploadResponse _self;
  final $Res Function(UploadResponse) _then;

/// Create a copy of UploadResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? message = freezed,Object? data = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as UploadData?,
  ));
}
/// Create a copy of UploadResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UploadDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $UploadDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// Adds pattern-matching-related methods to [UploadResponse].
extension UploadResponsePatterns on UploadResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UploadResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UploadResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UploadResponse value)  $default,){
final _that = this;
switch (_that) {
case _UploadResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UploadResponse value)?  $default,){
final _that = this;
switch (_that) {
case _UploadResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String? message,  UploadData? data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UploadResponse() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String? message,  UploadData? data)  $default,) {final _that = this;
switch (_that) {
case _UploadResponse():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String? message,  UploadData? data)?  $default,) {final _that = this;
switch (_that) {
case _UploadResponse() when $default != null:
return $default(_that.success,_that.message,_that.data);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UploadResponse implements UploadResponse {
  const _UploadResponse({required this.success, this.message, this.data});
  factory _UploadResponse.fromJson(Map<String, dynamic> json) => _$UploadResponseFromJson(json);

@override final  bool success;
@override final  String? message;
@override final  UploadData? data;

/// Create a copy of UploadResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UploadResponseCopyWith<_UploadResponse> get copyWith => __$UploadResponseCopyWithImpl<_UploadResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UploadResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UploadResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.message, message) || other.message == message)&&(identical(other.data, data) || other.data == data));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,message,data);

@override
String toString() {
  return 'UploadResponse(success: $success, message: $message, data: $data)';
}


}

/// @nodoc
abstract mixin class _$UploadResponseCopyWith<$Res> implements $UploadResponseCopyWith<$Res> {
  factory _$UploadResponseCopyWith(_UploadResponse value, $Res Function(_UploadResponse) _then) = __$UploadResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, String? message, UploadData? data
});


@override $UploadDataCopyWith<$Res>? get data;

}
/// @nodoc
class __$UploadResponseCopyWithImpl<$Res>
    implements _$UploadResponseCopyWith<$Res> {
  __$UploadResponseCopyWithImpl(this._self, this._then);

  final _UploadResponse _self;
  final $Res Function(_UploadResponse) _then;

/// Create a copy of UploadResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? message = freezed,Object? data = freezed,}) {
  return _then(_UploadResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,data: freezed == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as UploadData?,
  ));
}

/// Create a copy of UploadResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UploadDataCopyWith<$Res>? get data {
    if (_self.data == null) {
    return null;
  }

  return $UploadDataCopyWith<$Res>(_self.data!, (value) {
    return _then(_self.copyWith(data: value));
  });
}
}


/// @nodoc
mixin _$UploadData {

 String? get fileUrl; String? get fileId; String? get fileName; String? get fileType; int? get fileSize; String? get createdAt;
/// Create a copy of UploadData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UploadDataCopyWith<UploadData> get copyWith => _$UploadDataCopyWithImpl<UploadData>(this as UploadData, _$identity);

  /// Serializes this UploadData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UploadData&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl)&&(identical(other.fileId, fileId) || other.fileId == fileId)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.fileType, fileType) || other.fileType == fileType)&&(identical(other.fileSize, fileSize) || other.fileSize == fileSize)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fileUrl,fileId,fileName,fileType,fileSize,createdAt);

@override
String toString() {
  return 'UploadData(fileUrl: $fileUrl, fileId: $fileId, fileName: $fileName, fileType: $fileType, fileSize: $fileSize, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $UploadDataCopyWith<$Res>  {
  factory $UploadDataCopyWith(UploadData value, $Res Function(UploadData) _then) = _$UploadDataCopyWithImpl;
@useResult
$Res call({
 String? fileUrl, String? fileId, String? fileName, String? fileType, int? fileSize, String? createdAt
});




}
/// @nodoc
class _$UploadDataCopyWithImpl<$Res>
    implements $UploadDataCopyWith<$Res> {
  _$UploadDataCopyWithImpl(this._self, this._then);

  final UploadData _self;
  final $Res Function(UploadData) _then;

/// Create a copy of UploadData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fileUrl = freezed,Object? fileId = freezed,Object? fileName = freezed,Object? fileType = freezed,Object? fileSize = freezed,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
fileUrl: freezed == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String?,fileId: freezed == fileId ? _self.fileId : fileId // ignore: cast_nullable_to_non_nullable
as String?,fileName: freezed == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String?,fileType: freezed == fileType ? _self.fileType : fileType // ignore: cast_nullable_to_non_nullable
as String?,fileSize: freezed == fileSize ? _self.fileSize : fileSize // ignore: cast_nullable_to_non_nullable
as int?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UploadData].
extension UploadDataPatterns on UploadData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UploadData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UploadData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UploadData value)  $default,){
final _that = this;
switch (_that) {
case _UploadData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UploadData value)?  $default,){
final _that = this;
switch (_that) {
case _UploadData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? fileUrl,  String? fileId,  String? fileName,  String? fileType,  int? fileSize,  String? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UploadData() when $default != null:
return $default(_that.fileUrl,_that.fileId,_that.fileName,_that.fileType,_that.fileSize,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? fileUrl,  String? fileId,  String? fileName,  String? fileType,  int? fileSize,  String? createdAt)  $default,) {final _that = this;
switch (_that) {
case _UploadData():
return $default(_that.fileUrl,_that.fileId,_that.fileName,_that.fileType,_that.fileSize,_that.createdAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? fileUrl,  String? fileId,  String? fileName,  String? fileType,  int? fileSize,  String? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _UploadData() when $default != null:
return $default(_that.fileUrl,_that.fileId,_that.fileName,_that.fileType,_that.fileSize,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UploadData implements UploadData {
  const _UploadData({this.fileUrl, this.fileId, this.fileName, this.fileType, this.fileSize, this.createdAt});
  factory _UploadData.fromJson(Map<String, dynamic> json) => _$UploadDataFromJson(json);

@override final  String? fileUrl;
@override final  String? fileId;
@override final  String? fileName;
@override final  String? fileType;
@override final  int? fileSize;
@override final  String? createdAt;

/// Create a copy of UploadData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UploadDataCopyWith<_UploadData> get copyWith => __$UploadDataCopyWithImpl<_UploadData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UploadDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UploadData&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl)&&(identical(other.fileId, fileId) || other.fileId == fileId)&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.fileType, fileType) || other.fileType == fileType)&&(identical(other.fileSize, fileSize) || other.fileSize == fileSize)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fileUrl,fileId,fileName,fileType,fileSize,createdAt);

@override
String toString() {
  return 'UploadData(fileUrl: $fileUrl, fileId: $fileId, fileName: $fileName, fileType: $fileType, fileSize: $fileSize, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$UploadDataCopyWith<$Res> implements $UploadDataCopyWith<$Res> {
  factory _$UploadDataCopyWith(_UploadData value, $Res Function(_UploadData) _then) = __$UploadDataCopyWithImpl;
@override @useResult
$Res call({
 String? fileUrl, String? fileId, String? fileName, String? fileType, int? fileSize, String? createdAt
});




}
/// @nodoc
class __$UploadDataCopyWithImpl<$Res>
    implements _$UploadDataCopyWith<$Res> {
  __$UploadDataCopyWithImpl(this._self, this._then);

  final _UploadData _self;
  final $Res Function(_UploadData) _then;

/// Create a copy of UploadData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fileUrl = freezed,Object? fileId = freezed,Object? fileName = freezed,Object? fileType = freezed,Object? fileSize = freezed,Object? createdAt = freezed,}) {
  return _then(_UploadData(
fileUrl: freezed == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String?,fileId: freezed == fileId ? _self.fileId : fileId // ignore: cast_nullable_to_non_nullable
as String?,fileName: freezed == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String?,fileType: freezed == fileType ? _self.fileType : fileType // ignore: cast_nullable_to_non_nullable
as String?,fileSize: freezed == fileSize ? _self.fileSize : fileSize // ignore: cast_nullable_to_non_nullable
as int?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
