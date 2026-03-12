// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'resume_selection_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ResumeSelectionModel {

/// Unique identifier for the resume
 String get id;/// Resume title/name
 String get title;/// Last updated timestamp
 DateTime get lastUpdated;/// Match percentage for AI recommendation (0-100)
/// -1 indicates score not calculated yet
 int get matchPercentage;/// Whether this resume is recommended by AI
 bool get isRecommended;/// Additional metadata
/// Empty string means no description provided
 String get description;
/// Create a copy of ResumeSelectionModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResumeSelectionModelCopyWith<ResumeSelectionModel> get copyWith => _$ResumeSelectionModelCopyWithImpl<ResumeSelectionModel>(this as ResumeSelectionModel, _$identity);

  /// Serializes this ResumeSelectionModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResumeSelectionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.matchPercentage, matchPercentage) || other.matchPercentage == matchPercentage)&&(identical(other.isRecommended, isRecommended) || other.isRecommended == isRecommended)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,lastUpdated,matchPercentage,isRecommended,description);

@override
String toString() {
  return 'ResumeSelectionModel(id: $id, title: $title, lastUpdated: $lastUpdated, matchPercentage: $matchPercentage, isRecommended: $isRecommended, description: $description)';
}


}

/// @nodoc
abstract mixin class $ResumeSelectionModelCopyWith<$Res>  {
  factory $ResumeSelectionModelCopyWith(ResumeSelectionModel value, $Res Function(ResumeSelectionModel) _then) = _$ResumeSelectionModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, DateTime lastUpdated, int matchPercentage, bool isRecommended, String description
});




}
/// @nodoc
class _$ResumeSelectionModelCopyWithImpl<$Res>
    implements $ResumeSelectionModelCopyWith<$Res> {
  _$ResumeSelectionModelCopyWithImpl(this._self, this._then);

  final ResumeSelectionModel _self;
  final $Res Function(ResumeSelectionModel) _then;

/// Create a copy of ResumeSelectionModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? lastUpdated = null,Object? matchPercentage = null,Object? isRecommended = null,Object? description = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,matchPercentage: null == matchPercentage ? _self.matchPercentage : matchPercentage // ignore: cast_nullable_to_non_nullable
as int,isRecommended: null == isRecommended ? _self.isRecommended : isRecommended // ignore: cast_nullable_to_non_nullable
as bool,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [ResumeSelectionModel].
extension ResumeSelectionModelPatterns on ResumeSelectionModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResumeSelectionModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResumeSelectionModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResumeSelectionModel value)  $default,){
final _that = this;
switch (_that) {
case _ResumeSelectionModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResumeSelectionModel value)?  $default,){
final _that = this;
switch (_that) {
case _ResumeSelectionModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  DateTime lastUpdated,  int matchPercentage,  bool isRecommended,  String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResumeSelectionModel() when $default != null:
return $default(_that.id,_that.title,_that.lastUpdated,_that.matchPercentage,_that.isRecommended,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  DateTime lastUpdated,  int matchPercentage,  bool isRecommended,  String description)  $default,) {final _that = this;
switch (_that) {
case _ResumeSelectionModel():
return $default(_that.id,_that.title,_that.lastUpdated,_that.matchPercentage,_that.isRecommended,_that.description);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  DateTime lastUpdated,  int matchPercentage,  bool isRecommended,  String description)?  $default,) {final _that = this;
switch (_that) {
case _ResumeSelectionModel() when $default != null:
return $default(_that.id,_that.title,_that.lastUpdated,_that.matchPercentage,_that.isRecommended,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ResumeSelectionModel implements ResumeSelectionModel {
  const _ResumeSelectionModel({required this.id, required this.title, required this.lastUpdated, this.matchPercentage = -1, this.isRecommended = false, this.description = 'No description available'});
  factory _ResumeSelectionModel.fromJson(Map<String, dynamic> json) => _$ResumeSelectionModelFromJson(json);

/// Unique identifier for the resume
@override final  String id;
/// Resume title/name
@override final  String title;
/// Last updated timestamp
@override final  DateTime lastUpdated;
/// Match percentage for AI recommendation (0-100)
/// -1 indicates score not calculated yet
@override@JsonKey() final  int matchPercentage;
/// Whether this resume is recommended by AI
@override@JsonKey() final  bool isRecommended;
/// Additional metadata
/// Empty string means no description provided
@override@JsonKey() final  String description;

/// Create a copy of ResumeSelectionModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResumeSelectionModelCopyWith<_ResumeSelectionModel> get copyWith => __$ResumeSelectionModelCopyWithImpl<_ResumeSelectionModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ResumeSelectionModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResumeSelectionModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.lastUpdated, lastUpdated) || other.lastUpdated == lastUpdated)&&(identical(other.matchPercentage, matchPercentage) || other.matchPercentage == matchPercentage)&&(identical(other.isRecommended, isRecommended) || other.isRecommended == isRecommended)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,lastUpdated,matchPercentage,isRecommended,description);

@override
String toString() {
  return 'ResumeSelectionModel(id: $id, title: $title, lastUpdated: $lastUpdated, matchPercentage: $matchPercentage, isRecommended: $isRecommended, description: $description)';
}


}

/// @nodoc
abstract mixin class _$ResumeSelectionModelCopyWith<$Res> implements $ResumeSelectionModelCopyWith<$Res> {
  factory _$ResumeSelectionModelCopyWith(_ResumeSelectionModel value, $Res Function(_ResumeSelectionModel) _then) = __$ResumeSelectionModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, DateTime lastUpdated, int matchPercentage, bool isRecommended, String description
});




}
/// @nodoc
class __$ResumeSelectionModelCopyWithImpl<$Res>
    implements _$ResumeSelectionModelCopyWith<$Res> {
  __$ResumeSelectionModelCopyWithImpl(this._self, this._then);

  final _ResumeSelectionModel _self;
  final $Res Function(_ResumeSelectionModel) _then;

/// Create a copy of ResumeSelectionModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? lastUpdated = null,Object? matchPercentage = null,Object? isRecommended = null,Object? description = null,}) {
  return _then(_ResumeSelectionModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,lastUpdated: null == lastUpdated ? _self.lastUpdated : lastUpdated // ignore: cast_nullable_to_non_nullable
as DateTime,matchPercentage: null == matchPercentage ? _self.matchPercentage : matchPercentage // ignore: cast_nullable_to_non_nullable
as int,isRecommended: null == isRecommended ? _self.isRecommended : isRecommended // ignore: cast_nullable_to_non_nullable
as bool,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
