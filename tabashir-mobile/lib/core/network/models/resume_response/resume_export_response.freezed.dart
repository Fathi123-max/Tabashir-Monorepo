// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'resume_export_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ResumeExportResponse {

 bool get success; String get exportUrl; String get filename; bool get isFormatted; String? get message;
/// Create a copy of ResumeExportResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResumeExportResponseCopyWith<ResumeExportResponse> get copyWith => _$ResumeExportResponseCopyWithImpl<ResumeExportResponse>(this as ResumeExportResponse, _$identity);

  /// Serializes this ResumeExportResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResumeExportResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.exportUrl, exportUrl) || other.exportUrl == exportUrl)&&(identical(other.filename, filename) || other.filename == filename)&&(identical(other.isFormatted, isFormatted) || other.isFormatted == isFormatted)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,exportUrl,filename,isFormatted,message);

@override
String toString() {
  return 'ResumeExportResponse(success: $success, exportUrl: $exportUrl, filename: $filename, isFormatted: $isFormatted, message: $message)';
}


}

/// @nodoc
abstract mixin class $ResumeExportResponseCopyWith<$Res>  {
  factory $ResumeExportResponseCopyWith(ResumeExportResponse value, $Res Function(ResumeExportResponse) _then) = _$ResumeExportResponseCopyWithImpl;
@useResult
$Res call({
 bool success, String exportUrl, String filename, bool isFormatted, String? message
});




}
/// @nodoc
class _$ResumeExportResponseCopyWithImpl<$Res>
    implements $ResumeExportResponseCopyWith<$Res> {
  _$ResumeExportResponseCopyWithImpl(this._self, this._then);

  final ResumeExportResponse _self;
  final $Res Function(ResumeExportResponse) _then;

/// Create a copy of ResumeExportResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? success = null,Object? exportUrl = null,Object? filename = null,Object? isFormatted = null,Object? message = freezed,}) {
  return _then(_self.copyWith(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,exportUrl: null == exportUrl ? _self.exportUrl : exportUrl // ignore: cast_nullable_to_non_nullable
as String,filename: null == filename ? _self.filename : filename // ignore: cast_nullable_to_non_nullable
as String,isFormatted: null == isFormatted ? _self.isFormatted : isFormatted // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ResumeExportResponse].
extension ResumeExportResponsePatterns on ResumeExportResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResumeExportResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResumeExportResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResumeExportResponse value)  $default,){
final _that = this;
switch (_that) {
case _ResumeExportResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResumeExportResponse value)?  $default,){
final _that = this;
switch (_that) {
case _ResumeExportResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( bool success,  String exportUrl,  String filename,  bool isFormatted,  String? message)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResumeExportResponse() when $default != null:
return $default(_that.success,_that.exportUrl,_that.filename,_that.isFormatted,_that.message);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( bool success,  String exportUrl,  String filename,  bool isFormatted,  String? message)  $default,) {final _that = this;
switch (_that) {
case _ResumeExportResponse():
return $default(_that.success,_that.exportUrl,_that.filename,_that.isFormatted,_that.message);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( bool success,  String exportUrl,  String filename,  bool isFormatted,  String? message)?  $default,) {final _that = this;
switch (_that) {
case _ResumeExportResponse() when $default != null:
return $default(_that.success,_that.exportUrl,_that.filename,_that.isFormatted,_that.message);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ResumeExportResponse implements ResumeExportResponse {
  const _ResumeExportResponse({required this.success, required this.exportUrl, required this.filename, required this.isFormatted, this.message});
  factory _ResumeExportResponse.fromJson(Map<String, dynamic> json) => _$ResumeExportResponseFromJson(json);

@override final  bool success;
@override final  String exportUrl;
@override final  String filename;
@override final  bool isFormatted;
@override final  String? message;

/// Create a copy of ResumeExportResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResumeExportResponseCopyWith<_ResumeExportResponse> get copyWith => __$ResumeExportResponseCopyWithImpl<_ResumeExportResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ResumeExportResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResumeExportResponse&&(identical(other.success, success) || other.success == success)&&(identical(other.exportUrl, exportUrl) || other.exportUrl == exportUrl)&&(identical(other.filename, filename) || other.filename == filename)&&(identical(other.isFormatted, isFormatted) || other.isFormatted == isFormatted)&&(identical(other.message, message) || other.message == message));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,success,exportUrl,filename,isFormatted,message);

@override
String toString() {
  return 'ResumeExportResponse(success: $success, exportUrl: $exportUrl, filename: $filename, isFormatted: $isFormatted, message: $message)';
}


}

/// @nodoc
abstract mixin class _$ResumeExportResponseCopyWith<$Res> implements $ResumeExportResponseCopyWith<$Res> {
  factory _$ResumeExportResponseCopyWith(_ResumeExportResponse value, $Res Function(_ResumeExportResponse) _then) = __$ResumeExportResponseCopyWithImpl;
@override @useResult
$Res call({
 bool success, String exportUrl, String filename, bool isFormatted, String? message
});




}
/// @nodoc
class __$ResumeExportResponseCopyWithImpl<$Res>
    implements _$ResumeExportResponseCopyWith<$Res> {
  __$ResumeExportResponseCopyWithImpl(this._self, this._then);

  final _ResumeExportResponse _self;
  final $Res Function(_ResumeExportResponse) _then;

/// Create a copy of ResumeExportResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? success = null,Object? exportUrl = null,Object? filename = null,Object? isFormatted = null,Object? message = freezed,}) {
  return _then(_ResumeExportResponse(
success: null == success ? _self.success : success // ignore: cast_nullable_to_non_nullable
as bool,exportUrl: null == exportUrl ? _self.exportUrl : exportUrl // ignore: cast_nullable_to_non_nullable
as String,filename: null == filename ? _self.filename : filename // ignore: cast_nullable_to_non_nullable
as String,isFormatted: null == isFormatted ? _self.isFormatted : isFormatted // ignore: cast_nullable_to_non_nullable
as bool,message: freezed == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
