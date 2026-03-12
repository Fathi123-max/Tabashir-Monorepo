// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'upload_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UploadRequest {

 String get fileName; String get fileType;
/// Create a copy of UploadRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UploadRequestCopyWith<UploadRequest> get copyWith => _$UploadRequestCopyWithImpl<UploadRequest>(this as UploadRequest, _$identity);

  /// Serializes this UploadRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UploadRequest&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.fileType, fileType) || other.fileType == fileType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fileName,fileType);

@override
String toString() {
  return 'UploadRequest(fileName: $fileName, fileType: $fileType)';
}


}

/// @nodoc
abstract mixin class $UploadRequestCopyWith<$Res>  {
  factory $UploadRequestCopyWith(UploadRequest value, $Res Function(UploadRequest) _then) = _$UploadRequestCopyWithImpl;
@useResult
$Res call({
 String fileName, String fileType
});




}
/// @nodoc
class _$UploadRequestCopyWithImpl<$Res>
    implements $UploadRequestCopyWith<$Res> {
  _$UploadRequestCopyWithImpl(this._self, this._then);

  final UploadRequest _self;
  final $Res Function(UploadRequest) _then;

/// Create a copy of UploadRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fileName = null,Object? fileType = null,}) {
  return _then(_self.copyWith(
fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,fileType: null == fileType ? _self.fileType : fileType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [UploadRequest].
extension UploadRequestPatterns on UploadRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UploadRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UploadRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UploadRequest value)  $default,){
final _that = this;
switch (_that) {
case _UploadRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UploadRequest value)?  $default,){
final _that = this;
switch (_that) {
case _UploadRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String fileName,  String fileType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UploadRequest() when $default != null:
return $default(_that.fileName,_that.fileType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String fileName,  String fileType)  $default,) {final _that = this;
switch (_that) {
case _UploadRequest():
return $default(_that.fileName,_that.fileType);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String fileName,  String fileType)?  $default,) {final _that = this;
switch (_that) {
case _UploadRequest() when $default != null:
return $default(_that.fileName,_that.fileType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UploadRequest implements UploadRequest {
  const _UploadRequest({required this.fileName, required this.fileType});
  factory _UploadRequest.fromJson(Map<String, dynamic> json) => _$UploadRequestFromJson(json);

@override final  String fileName;
@override final  String fileType;

/// Create a copy of UploadRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UploadRequestCopyWith<_UploadRequest> get copyWith => __$UploadRequestCopyWithImpl<_UploadRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UploadRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UploadRequest&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.fileType, fileType) || other.fileType == fileType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fileName,fileType);

@override
String toString() {
  return 'UploadRequest(fileName: $fileName, fileType: $fileType)';
}


}

/// @nodoc
abstract mixin class _$UploadRequestCopyWith<$Res> implements $UploadRequestCopyWith<$Res> {
  factory _$UploadRequestCopyWith(_UploadRequest value, $Res Function(_UploadRequest) _then) = __$UploadRequestCopyWithImpl;
@override @useResult
$Res call({
 String fileName, String fileType
});




}
/// @nodoc
class __$UploadRequestCopyWithImpl<$Res>
    implements _$UploadRequestCopyWith<$Res> {
  __$UploadRequestCopyWithImpl(this._self, this._then);

  final _UploadRequest _self;
  final $Res Function(_UploadRequest) _then;

/// Create a copy of UploadRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fileName = null,Object? fileType = null,}) {
  return _then(_UploadRequest(
fileName: null == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String,fileType: null == fileType ? _self.fileType : fileType // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
