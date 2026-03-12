// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'local_resume.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LocalResume {

 String get id; String get name; String get title; String get filePath; String get fileType; int get fileSize; DateTime get createdAt; bool get isDefault;
/// Create a copy of LocalResume
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocalResumeCopyWith<LocalResume> get copyWith => _$LocalResumeCopyWithImpl<LocalResume>(this as LocalResume, _$identity);

  /// Serializes this LocalResume to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocalResume&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.title, title) || other.title == title)&&(identical(other.filePath, filePath) || other.filePath == filePath)&&(identical(other.fileType, fileType) || other.fileType == fileType)&&(identical(other.fileSize, fileSize) || other.fileSize == fileSize)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,title,filePath,fileType,fileSize,createdAt,isDefault);

@override
String toString() {
  return 'LocalResume(id: $id, name: $name, title: $title, filePath: $filePath, fileType: $fileType, fileSize: $fileSize, createdAt: $createdAt, isDefault: $isDefault)';
}


}

/// @nodoc
abstract mixin class $LocalResumeCopyWith<$Res>  {
  factory $LocalResumeCopyWith(LocalResume value, $Res Function(LocalResume) _then) = _$LocalResumeCopyWithImpl;
@useResult
$Res call({
 String id, String name, String title, String filePath, String fileType, int fileSize, DateTime createdAt, bool isDefault
});




}
/// @nodoc
class _$LocalResumeCopyWithImpl<$Res>
    implements $LocalResumeCopyWith<$Res> {
  _$LocalResumeCopyWithImpl(this._self, this._then);

  final LocalResume _self;
  final $Res Function(LocalResume) _then;

/// Create a copy of LocalResume
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? title = null,Object? filePath = null,Object? fileType = null,Object? fileSize = null,Object? createdAt = null,Object? isDefault = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,filePath: null == filePath ? _self.filePath : filePath // ignore: cast_nullable_to_non_nullable
as String,fileType: null == fileType ? _self.fileType : fileType // ignore: cast_nullable_to_non_nullable
as String,fileSize: null == fileSize ? _self.fileSize : fileSize // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

}


/// Adds pattern-matching-related methods to [LocalResume].
extension LocalResumePatterns on LocalResume {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocalResume value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocalResume() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocalResume value)  $default,){
final _that = this;
switch (_that) {
case _LocalResume():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocalResume value)?  $default,){
final _that = this;
switch (_that) {
case _LocalResume() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String title,  String filePath,  String fileType,  int fileSize,  DateTime createdAt,  bool isDefault)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocalResume() when $default != null:
return $default(_that.id,_that.name,_that.title,_that.filePath,_that.fileType,_that.fileSize,_that.createdAt,_that.isDefault);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String title,  String filePath,  String fileType,  int fileSize,  DateTime createdAt,  bool isDefault)  $default,) {final _that = this;
switch (_that) {
case _LocalResume():
return $default(_that.id,_that.name,_that.title,_that.filePath,_that.fileType,_that.fileSize,_that.createdAt,_that.isDefault);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String title,  String filePath,  String fileType,  int fileSize,  DateTime createdAt,  bool isDefault)?  $default,) {final _that = this;
switch (_that) {
case _LocalResume() when $default != null:
return $default(_that.id,_that.name,_that.title,_that.filePath,_that.fileType,_that.fileSize,_that.createdAt,_that.isDefault);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LocalResume implements LocalResume {
  const _LocalResume({required this.id, required this.name, required this.title, required this.filePath, required this.fileType, required this.fileSize, required this.createdAt, this.isDefault = false});
  factory _LocalResume.fromJson(Map<String, dynamic> json) => _$LocalResumeFromJson(json);

@override final  String id;
@override final  String name;
@override final  String title;
@override final  String filePath;
@override final  String fileType;
@override final  int fileSize;
@override final  DateTime createdAt;
@override@JsonKey() final  bool isDefault;

/// Create a copy of LocalResume
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocalResumeCopyWith<_LocalResume> get copyWith => __$LocalResumeCopyWithImpl<_LocalResume>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LocalResumeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocalResume&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.title, title) || other.title == title)&&(identical(other.filePath, filePath) || other.filePath == filePath)&&(identical(other.fileType, fileType) || other.fileType == fileType)&&(identical(other.fileSize, fileSize) || other.fileSize == fileSize)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.isDefault, isDefault) || other.isDefault == isDefault));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,title,filePath,fileType,fileSize,createdAt,isDefault);

@override
String toString() {
  return 'LocalResume(id: $id, name: $name, title: $title, filePath: $filePath, fileType: $fileType, fileSize: $fileSize, createdAt: $createdAt, isDefault: $isDefault)';
}


}

/// @nodoc
abstract mixin class _$LocalResumeCopyWith<$Res> implements $LocalResumeCopyWith<$Res> {
  factory _$LocalResumeCopyWith(_LocalResume value, $Res Function(_LocalResume) _then) = __$LocalResumeCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String title, String filePath, String fileType, int fileSize, DateTime createdAt, bool isDefault
});




}
/// @nodoc
class __$LocalResumeCopyWithImpl<$Res>
    implements _$LocalResumeCopyWith<$Res> {
  __$LocalResumeCopyWithImpl(this._self, this._then);

  final _LocalResume _self;
  final $Res Function(_LocalResume) _then;

/// Create a copy of LocalResume
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? title = null,Object? filePath = null,Object? fileType = null,Object? fileSize = null,Object? createdAt = null,Object? isDefault = null,}) {
  return _then(_LocalResume(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,filePath: null == filePath ? _self.filePath : filePath // ignore: cast_nullable_to_non_nullable
as String,fileType: null == fileType ? _self.fileType : fileType // ignore: cast_nullable_to_non_nullable
as String,fileSize: null == fileSize ? _self.fileSize : fileSize // ignore: cast_nullable_to_non_nullable
as int,createdAt: null == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime,isDefault: null == isDefault ? _self.isDefault : isDefault // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}

// dart format on
