// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'upload_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UploadState {

 UploadStatus get status; int get progress; String get errorMessage; UploadResponse? get uploadResponse; List<UploadResponse> get uploadedFiles;
/// Create a copy of UploadState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UploadStateCopyWith<UploadState> get copyWith => _$UploadStateCopyWithImpl<UploadState>(this as UploadState, _$identity);

  /// Serializes this UploadState to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UploadState&&(identical(other.status, status) || other.status == status)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.uploadResponse, uploadResponse) || other.uploadResponse == uploadResponse)&&const DeepCollectionEquality().equals(other.uploadedFiles, uploadedFiles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,progress,errorMessage,uploadResponse,const DeepCollectionEquality().hash(uploadedFiles));

@override
String toString() {
  return 'UploadState(status: $status, progress: $progress, errorMessage: $errorMessage, uploadResponse: $uploadResponse, uploadedFiles: $uploadedFiles)';
}


}

/// @nodoc
abstract mixin class $UploadStateCopyWith<$Res>  {
  factory $UploadStateCopyWith(UploadState value, $Res Function(UploadState) _then) = _$UploadStateCopyWithImpl;
@useResult
$Res call({
 UploadStatus status, int progress, String errorMessage, UploadResponse? uploadResponse, List<UploadResponse> uploadedFiles
});


$UploadResponseCopyWith<$Res>? get uploadResponse;

}
/// @nodoc
class _$UploadStateCopyWithImpl<$Res>
    implements $UploadStateCopyWith<$Res> {
  _$UploadStateCopyWithImpl(this._self, this._then);

  final UploadState _self;
  final $Res Function(UploadState) _then;

/// Create a copy of UploadState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? progress = null,Object? errorMessage = null,Object? uploadResponse = freezed,Object? uploadedFiles = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UploadStatus,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as int,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,uploadResponse: freezed == uploadResponse ? _self.uploadResponse : uploadResponse // ignore: cast_nullable_to_non_nullable
as UploadResponse?,uploadedFiles: null == uploadedFiles ? _self.uploadedFiles : uploadedFiles // ignore: cast_nullable_to_non_nullable
as List<UploadResponse>,
  ));
}
/// Create a copy of UploadState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UploadResponseCopyWith<$Res>? get uploadResponse {
    if (_self.uploadResponse == null) {
    return null;
  }

  return $UploadResponseCopyWith<$Res>(_self.uploadResponse!, (value) {
    return _then(_self.copyWith(uploadResponse: value));
  });
}
}


/// Adds pattern-matching-related methods to [UploadState].
extension UploadStatePatterns on UploadState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UploadState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UploadState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UploadState value)  $default,){
final _that = this;
switch (_that) {
case _UploadState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UploadState value)?  $default,){
final _that = this;
switch (_that) {
case _UploadState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UploadStatus status,  int progress,  String errorMessage,  UploadResponse? uploadResponse,  List<UploadResponse> uploadedFiles)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UploadState() when $default != null:
return $default(_that.status,_that.progress,_that.errorMessage,_that.uploadResponse,_that.uploadedFiles);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UploadStatus status,  int progress,  String errorMessage,  UploadResponse? uploadResponse,  List<UploadResponse> uploadedFiles)  $default,) {final _that = this;
switch (_that) {
case _UploadState():
return $default(_that.status,_that.progress,_that.errorMessage,_that.uploadResponse,_that.uploadedFiles);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UploadStatus status,  int progress,  String errorMessage,  UploadResponse? uploadResponse,  List<UploadResponse> uploadedFiles)?  $default,) {final _that = this;
switch (_that) {
case _UploadState() when $default != null:
return $default(_that.status,_that.progress,_that.errorMessage,_that.uploadResponse,_that.uploadedFiles);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UploadState implements UploadState {
  const _UploadState({this.status = UploadStatus.initial, this.progress = 0, this.errorMessage = '', this.uploadResponse, final  List<UploadResponse> uploadedFiles = const []}): _uploadedFiles = uploadedFiles;
  factory _UploadState.fromJson(Map<String, dynamic> json) => _$UploadStateFromJson(json);

@override@JsonKey() final  UploadStatus status;
@override@JsonKey() final  int progress;
@override@JsonKey() final  String errorMessage;
@override final  UploadResponse? uploadResponse;
 final  List<UploadResponse> _uploadedFiles;
@override@JsonKey() List<UploadResponse> get uploadedFiles {
  if (_uploadedFiles is EqualUnmodifiableListView) return _uploadedFiles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_uploadedFiles);
}


/// Create a copy of UploadState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UploadStateCopyWith<_UploadState> get copyWith => __$UploadStateCopyWithImpl<_UploadState>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UploadStateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UploadState&&(identical(other.status, status) || other.status == status)&&(identical(other.progress, progress) || other.progress == progress)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.uploadResponse, uploadResponse) || other.uploadResponse == uploadResponse)&&const DeepCollectionEquality().equals(other._uploadedFiles, _uploadedFiles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,status,progress,errorMessage,uploadResponse,const DeepCollectionEquality().hash(_uploadedFiles));

@override
String toString() {
  return 'UploadState(status: $status, progress: $progress, errorMessage: $errorMessage, uploadResponse: $uploadResponse, uploadedFiles: $uploadedFiles)';
}


}

/// @nodoc
abstract mixin class _$UploadStateCopyWith<$Res> implements $UploadStateCopyWith<$Res> {
  factory _$UploadStateCopyWith(_UploadState value, $Res Function(_UploadState) _then) = __$UploadStateCopyWithImpl;
@override @useResult
$Res call({
 UploadStatus status, int progress, String errorMessage, UploadResponse? uploadResponse, List<UploadResponse> uploadedFiles
});


@override $UploadResponseCopyWith<$Res>? get uploadResponse;

}
/// @nodoc
class __$UploadStateCopyWithImpl<$Res>
    implements _$UploadStateCopyWith<$Res> {
  __$UploadStateCopyWithImpl(this._self, this._then);

  final _UploadState _self;
  final $Res Function(_UploadState) _then;

/// Create a copy of UploadState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? progress = null,Object? errorMessage = null,Object? uploadResponse = freezed,Object? uploadedFiles = null,}) {
  return _then(_UploadState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as UploadStatus,progress: null == progress ? _self.progress : progress // ignore: cast_nullable_to_non_nullable
as int,errorMessage: null == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String,uploadResponse: freezed == uploadResponse ? _self.uploadResponse : uploadResponse // ignore: cast_nullable_to_non_nullable
as UploadResponse?,uploadedFiles: null == uploadedFiles ? _self._uploadedFiles : uploadedFiles // ignore: cast_nullable_to_non_nullable
as List<UploadResponse>,
  ));
}

/// Create a copy of UploadState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UploadResponseCopyWith<$Res>? get uploadResponse {
    if (_self.uploadResponse == null) {
    return null;
  }

  return $UploadResponseCopyWith<$Res>(_self.uploadResponse!, (value) {
    return _then(_self.copyWith(uploadResponse: value));
  });
}
}

// dart format on
