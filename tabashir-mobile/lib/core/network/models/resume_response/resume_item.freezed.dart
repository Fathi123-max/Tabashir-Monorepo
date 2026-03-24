// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'resume_item.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ResumeItem {

 String get id; String get filename; String? get originalUrl; String? get formatedUrl; bool get isAiResume; DateTime get createdAt; DateTime get updatedAt; String? get formatedContent;// Added for translation
 ResumeData? get sourceData;// Added for AI Resume generation source data
// UI-specific properties
 String get name;// Display name (defaults to filename)
 String get filePath;// Local or remote file path
 String get fileType;// File extension (PDF, DOC, etc.)
 int get fileSize;// File size in bytes
 String get lastModified;// Formatted last modified date
 bool get isDefault;// Whether this is the default resume
 String get title;
/// Create a copy of ResumeItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResumeItemCopyWith<ResumeItem> get copyWith => _$ResumeItemCopyWithImpl<ResumeItem>(this as ResumeItem, _$identity);

  /// Serializes this ResumeItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResumeItem&&(identical(other.id, id) || other.id == id)&&(identical(other.filename, filename) || other.filename == filename)&&(identical(other.originalUrl, originalUrl) || other.originalUrl == originalUrl)&&(identical(other.formatedUrl, formatedUrl) || other.formatedUrl == formatedUrl)&&(identical(other.isAiResume, isAiResume) || other.isAiResume == isAiResume)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.formatedContent, formatedContent) || other.formatedContent == formatedContent)&&(identical(other.sourceData, sourceData) || other.sourceData == sourceData)&&(identical(other.name, name) || other.name == name)&&(identical(other.filePath, filePath) || other.filePath == filePath)&&(identical(other.fileType, fileType) || other.fileType == fileType)&&(identical(other.fileSize, fileSize) || other.fileSize == fileSize)&&(identical(other.lastModified, lastModified) || other.lastModified == lastModified)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,filename,originalUrl,formatedUrl,isAiResume,createdAt,updatedAt,formatedContent,sourceData,name,filePath,fileType,fileSize,lastModified,isDefault,title);

@override
String toString() {
  return 'ResumeItem(id: $id, filename: $filename, originalUrl: $originalUrl, formatedUrl: $formatedUrl, isAiResume: $isAiResume, createdAt: $createdAt, updatedAt: $updatedAt, formatedContent: $formatedContent, sourceData: $sourceData, name: $name, filePath: $filePath, fileType: $fileType, fileSize: $fileSize, lastModified: $lastModified, isDefault: $isDefault, title: $title)';
}


}

/// @nodoc
abstract mixin class $ResumeItemCopyWith<$Res>  {
  factory $ResumeItemCopyWith(ResumeItem value, $Res Function(ResumeItem) _then) = _$ResumeItemCopyWithImpl;
@useResult
$Res call({
 String id, String filename, String? originalUrl, String? formatedUrl, bool isAiResume, DateTime createdAt, DateTime updatedAt, String? formatedContent, ResumeData? sourceData, String name, String filePath, String fileType, int fileSize, String lastModified, bool isDefault, String title
});


$ResumeDataCopyWith<$Res>? get sourceData;

}
/// @nodoc
class _$ResumeItemCopyWithImpl<$Res>
    implements $ResumeItemCopyWith<$Res> {
  _$ResumeItemCopyWithImpl(this._self, this._then);

  final ResumeItem _self;
  final $Res Function(ResumeItem) _then;

/// Create a copy of ResumeItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? filename = null,Object? originalUrl = freezed,Object? formatedUrl = freezed,Object? isAiResume = null,Object? createdAt = null,Object? updatedAt = null,Object? formatedContent = freezed,Object? sourceData = freezed,Object? name = null,Object? filePath = null,Object? fileType = null,Object? fileSize = null,Object? lastModified = null,Object? isDefault = null,Object? title = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,filename: null == filename ? _self.filename : filename // ignore: cast_nullable_to_non_nullable
as String,originalUrl: freezed == originalUrl ? _self.originalUrl : originalUrl // ignore: cast_nullable_to_non_nullable
as String?,formatedUrl: freezed == formatedUrl ? _self.formatedUrl : formatedUrl // ignore: cast_nullable_to_non_nullable
as String?,isAiResume: null == isAiResume ? _self.isAiResume : isAiResume // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,formatedContent: freezed == formatedContent ? _self.formatedContent : formatedContent // ignore: cast_nullable_to_non_nullable
as String?,sourceData: freezed == sourceData ? _self.sourceData : sourceData // ignore: cast_nullable_to_non_nullable
as ResumeData?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,filePath: null == filePath ? _self.filePath : filePath // ignore: cast_nullable_to_non_nullable
as String,fileType: null == fileType ? _self.fileType : fileType // ignore: cast_nullable_to_non_nullable
as String,fileSize: null == fileSize ? _self.fileSize : fileSize // ignore: cast_nullable_to_non_nullable
as int,lastModified: null == lastModified ? _self.lastModified : lastModified // ignore: cast_nullable_to_non_nullable
as String,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}
/// Create a copy of ResumeItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResumeDataCopyWith<$Res>? get sourceData {
    if (_self.sourceData == null) {
    return null;
  }

  return $ResumeDataCopyWith<$Res>(_self.sourceData!, (value) {
    return _then(_self.copyWith(sourceData: value));
  });
}
}


/// Adds pattern-matching-related methods to [ResumeItem].
extension ResumeItemPatterns on ResumeItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResumeItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResumeItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResumeItem value)  $default,){
final _that = this;
switch (_that) {
case _ResumeItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResumeItem value)?  $default,){
final _that = this;
switch (_that) {
case _ResumeItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String filename,  String? originalUrl,  String? formatedUrl,  bool isAiResume,  DateTime createdAt,  DateTime updatedAt,  String? formatedContent,  ResumeData? sourceData,  String name,  String filePath,  String fileType,  int fileSize,  String lastModified,  bool isDefault,  String title)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResumeItem() when $default != null:
return $default(_that.id,_that.filename,_that.originalUrl,_that.formatedUrl,_that.isAiResume,_that.createdAt,_that.updatedAt,_that.formatedContent,_that.sourceData,_that.name,_that.filePath,_that.fileType,_that.fileSize,_that.lastModified,_that.isDefault,_that.title);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String filename,  String? originalUrl,  String? formatedUrl,  bool isAiResume,  DateTime createdAt,  DateTime updatedAt,  String? formatedContent,  ResumeData? sourceData,  String name,  String filePath,  String fileType,  int fileSize,  String lastModified,  bool isDefault,  String title)  $default,) {final _that = this;
switch (_that) {
case _ResumeItem():
return $default(_that.id,_that.filename,_that.originalUrl,_that.formatedUrl,_that.isAiResume,_that.createdAt,_that.updatedAt,_that.formatedContent,_that.sourceData,_that.name,_that.filePath,_that.fileType,_that.fileSize,_that.lastModified,_that.isDefault,_that.title);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String filename,  String? originalUrl,  String? formatedUrl,  bool isAiResume,  DateTime createdAt,  DateTime updatedAt,  String? formatedContent,  ResumeData? sourceData,  String name,  String filePath,  String fileType,  int fileSize,  String lastModified,  bool isDefault,  String title)?  $default,) {final _that = this;
switch (_that) {
case _ResumeItem() when $default != null:
return $default(_that.id,_that.filename,_that.originalUrl,_that.formatedUrl,_that.isAiResume,_that.createdAt,_that.updatedAt,_that.formatedContent,_that.sourceData,_that.name,_that.filePath,_that.fileType,_that.fileSize,_that.lastModified,_that.isDefault,_that.title);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ResumeItem implements ResumeItem {
  const _ResumeItem({required this.id, required this.filename, required this.originalUrl, required this.formatedUrl, required this.isAiResume, required this.createdAt, required this.updatedAt, this.formatedContent, this.sourceData, this.name = '', this.filePath = '', this.fileType = '', this.fileSize = 0, this.lastModified = '', this.isDefault = false, this.title = ''});
  factory _ResumeItem.fromJson(Map<String, dynamic> json) => _$ResumeItemFromJson(json);

@override final  String id;
@override final  String filename;
@override final  String? originalUrl;
@override final  String? formatedUrl;
@override final  bool isAiResume;
@override final  DateTime createdAt;
@override final  DateTime updatedAt;
@override final  String? formatedContent;
// Added for translation
@override final  ResumeData? sourceData;
// Added for AI Resume generation source data
// UI-specific properties
@override@JsonKey() final  String name;
// Display name (defaults to filename)
@override@JsonKey() final  String filePath;
// Local or remote file path
@override@JsonKey() final  String fileType;
// File extension (PDF, DOC, etc.)
@override@JsonKey() final  int fileSize;
// File size in bytes
@override@JsonKey() final  String lastModified;
// Formatted last modified date
@override@JsonKey() final  bool isDefault;
// Whether this is the default resume
@override@JsonKey() final  String title;

/// Create a copy of ResumeItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResumeItemCopyWith<_ResumeItem> get copyWith => __$ResumeItemCopyWithImpl<_ResumeItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ResumeItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResumeItem&&(identical(other.id, id) || other.id == id)&&(identical(other.filename, filename) || other.filename == filename)&&(identical(other.originalUrl, originalUrl) || other.originalUrl == originalUrl)&&(identical(other.formatedUrl, formatedUrl) || other.formatedUrl == formatedUrl)&&(identical(other.isAiResume, isAiResume) || other.isAiResume == isAiResume)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.formatedContent, formatedContent) || other.formatedContent == formatedContent)&&(identical(other.sourceData, sourceData) || other.sourceData == sourceData)&&(identical(other.name, name) || other.name == name)&&(identical(other.filePath, filePath) || other.filePath == filePath)&&(identical(other.fileType, fileType) || other.fileType == fileType)&&(identical(other.fileSize, fileSize) || other.fileSize == fileSize)&&(identical(other.lastModified, lastModified) || other.lastModified == lastModified)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault)&&(identical(other.title, title) || other.title == title));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,filename,originalUrl,formatedUrl,isAiResume,createdAt,updatedAt,formatedContent,sourceData,name,filePath,fileType,fileSize,lastModified,isDefault,title);

@override
String toString() {
  return 'ResumeItem(id: $id, filename: $filename, originalUrl: $originalUrl, formatedUrl: $formatedUrl, isAiResume: $isAiResume, createdAt: $createdAt, updatedAt: $updatedAt, formatedContent: $formatedContent, sourceData: $sourceData, name: $name, filePath: $filePath, fileType: $fileType, fileSize: $fileSize, lastModified: $lastModified, isDefault: $isDefault, title: $title)';
}


}

/// @nodoc
abstract mixin class _$ResumeItemCopyWith<$Res> implements $ResumeItemCopyWith<$Res> {
  factory _$ResumeItemCopyWith(_ResumeItem value, $Res Function(_ResumeItem) _then) = __$ResumeItemCopyWithImpl;
@override @useResult
$Res call({
 String id, String filename, String? originalUrl, String? formatedUrl, bool isAiResume, DateTime createdAt, DateTime updatedAt, String? formatedContent, ResumeData? sourceData, String name, String filePath, String fileType, int fileSize, String lastModified, bool isDefault, String title
});


@override $ResumeDataCopyWith<$Res>? get sourceData;

}
/// @nodoc
class __$ResumeItemCopyWithImpl<$Res>
    implements _$ResumeItemCopyWith<$Res> {
  __$ResumeItemCopyWithImpl(this._self, this._then);

  final _ResumeItem _self;
  final $Res Function(_ResumeItem) _then;

/// Create a copy of ResumeItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? filename = null,Object? originalUrl = freezed,Object? formatedUrl = freezed,Object? isAiResume = null,Object? createdAt = null,Object? updatedAt = null,Object? formatedContent = freezed,Object? sourceData = freezed,Object? name = null,Object? filePath = null,Object? fileType = null,Object? fileSize = null,Object? lastModified = null,Object? isDefault = null,Object? title = null,}) {
  return _then(_ResumeItem(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,filename: null == filename ? _self.filename : filename // ignore: cast_nullable_to_non_nullable
as String,originalUrl: freezed == originalUrl ? _self.originalUrl : originalUrl // ignore: cast_nullable_to_non_nullable
as String?,formatedUrl: freezed == formatedUrl ? _self.formatedUrl : formatedUrl // ignore: cast_nullable_to_non_nullable
as String?,isAiResume: null == isAiResume ? _self.isAiResume : isAiResume // ignore: cast_nullable_to_non_nullable
as bool,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,updatedAt: null == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime,formatedContent: freezed == formatedContent ? _self.formatedContent : formatedContent // ignore: cast_nullable_to_non_nullable
as String?,sourceData: freezed == sourceData ? _self.sourceData : sourceData // ignore: cast_nullable_to_non_nullable
as ResumeData?,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,filePath: null == filePath ? _self.filePath : filePath // ignore: cast_nullable_to_non_nullable
as String,fileType: null == fileType ? _self.fileType : fileType // ignore: cast_nullable_to_non_nullable
as String,fileSize: null == fileSize ? _self.fileSize : fileSize // ignore: cast_nullable_to_non_nullable
as int,lastModified: null == lastModified ? _self.lastModified : lastModified // ignore: cast_nullable_to_non_nullable
as String,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

/// Create a copy of ResumeItem
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResumeDataCopyWith<$Res>? get sourceData {
    if (_self.sourceData == null) {
    return null;
  }

  return $ResumeDataCopyWith<$Res>(_self.sourceData!, (value) {
    return _then(_self.copyWith(sourceData: value));
  });
}
}

// dart format on
