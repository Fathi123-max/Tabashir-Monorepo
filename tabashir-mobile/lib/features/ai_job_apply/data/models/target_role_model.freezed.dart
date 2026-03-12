// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'target_role_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$TargetRoleModel {

/// Unique identifier for the role
 String get id;/// Role title/name
 String get title;/// Whether this is a custom role added by user
 bool get isCustom;/// Additional metadata
/// Empty string means no description provided
 String get description;/// Match score or relevance (0-100)
/// -1 indicates score not calculated yet
 int get matchScore;/// Potential opportunities unlock by adding this role
/// 0 means no data available
 int get potentialRoles;
/// Create a copy of TargetRoleModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$TargetRoleModelCopyWith<TargetRoleModel> get copyWith => _$TargetRoleModelCopyWithImpl<TargetRoleModel>(this as TargetRoleModel, _$identity);

  /// Serializes this TargetRoleModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is TargetRoleModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.isCustom, isCustom) || other.isCustom == isCustom)&&(identical(other.description, description) || other.description == description)&&(identical(other.matchScore, matchScore) || other.matchScore == matchScore)&&(identical(other.potentialRoles, potentialRoles) || other.potentialRoles == potentialRoles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,isCustom,description,matchScore,potentialRoles);

@override
String toString() {
  return 'TargetRoleModel(id: $id, title: $title, isCustom: $isCustom, description: $description, matchScore: $matchScore, potentialRoles: $potentialRoles)';
}


}

/// @nodoc
abstract mixin class $TargetRoleModelCopyWith<$Res>  {
  factory $TargetRoleModelCopyWith(TargetRoleModel value, $Res Function(TargetRoleModel) _then) = _$TargetRoleModelCopyWithImpl;
@useResult
$Res call({
 String id, String title, bool isCustom, String description, int matchScore, int potentialRoles
});




}
/// @nodoc
class _$TargetRoleModelCopyWithImpl<$Res>
    implements $TargetRoleModelCopyWith<$Res> {
  _$TargetRoleModelCopyWithImpl(this._self, this._then);

  final TargetRoleModel _self;
  final $Res Function(TargetRoleModel) _then;

/// Create a copy of TargetRoleModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? isCustom = null,Object? description = null,Object? matchScore = null,Object? potentialRoles = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,isCustom: null == isCustom ? _self.isCustom : isCustom // ignore: cast_nullable_to_non_nullable
as bool,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,matchScore: null == matchScore ? _self.matchScore : matchScore // ignore: cast_nullable_to_non_nullable
as int,potentialRoles: null == potentialRoles ? _self.potentialRoles : potentialRoles // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [TargetRoleModel].
extension TargetRoleModelPatterns on TargetRoleModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _TargetRoleModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _TargetRoleModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _TargetRoleModel value)  $default,){
final _that = this;
switch (_that) {
case _TargetRoleModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _TargetRoleModel value)?  $default,){
final _that = this;
switch (_that) {
case _TargetRoleModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  bool isCustom,  String description,  int matchScore,  int potentialRoles)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _TargetRoleModel() when $default != null:
return $default(_that.id,_that.title,_that.isCustom,_that.description,_that.matchScore,_that.potentialRoles);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  bool isCustom,  String description,  int matchScore,  int potentialRoles)  $default,) {final _that = this;
switch (_that) {
case _TargetRoleModel():
return $default(_that.id,_that.title,_that.isCustom,_that.description,_that.matchScore,_that.potentialRoles);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  bool isCustom,  String description,  int matchScore,  int potentialRoles)?  $default,) {final _that = this;
switch (_that) {
case _TargetRoleModel() when $default != null:
return $default(_that.id,_that.title,_that.isCustom,_that.description,_that.matchScore,_that.potentialRoles);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _TargetRoleModel implements TargetRoleModel {
  const _TargetRoleModel({required this.id, required this.title, this.isCustom = false, this.description = 'No description available', this.matchScore = -1, this.potentialRoles = 0});
  factory _TargetRoleModel.fromJson(Map<String, dynamic> json) => _$TargetRoleModelFromJson(json);

/// Unique identifier for the role
@override final  String id;
/// Role title/name
@override final  String title;
/// Whether this is a custom role added by user
@override@JsonKey() final  bool isCustom;
/// Additional metadata
/// Empty string means no description provided
@override@JsonKey() final  String description;
/// Match score or relevance (0-100)
/// -1 indicates score not calculated yet
@override@JsonKey() final  int matchScore;
/// Potential opportunities unlock by adding this role
/// 0 means no data available
@override@JsonKey() final  int potentialRoles;

/// Create a copy of TargetRoleModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$TargetRoleModelCopyWith<_TargetRoleModel> get copyWith => __$TargetRoleModelCopyWithImpl<_TargetRoleModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$TargetRoleModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _TargetRoleModel&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.isCustom, isCustom) || other.isCustom == isCustom)&&(identical(other.description, description) || other.description == description)&&(identical(other.matchScore, matchScore) || other.matchScore == matchScore)&&(identical(other.potentialRoles, potentialRoles) || other.potentialRoles == potentialRoles));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,isCustom,description,matchScore,potentialRoles);

@override
String toString() {
  return 'TargetRoleModel(id: $id, title: $title, isCustom: $isCustom, description: $description, matchScore: $matchScore, potentialRoles: $potentialRoles)';
}


}

/// @nodoc
abstract mixin class _$TargetRoleModelCopyWith<$Res> implements $TargetRoleModelCopyWith<$Res> {
  factory _$TargetRoleModelCopyWith(_TargetRoleModel value, $Res Function(_TargetRoleModel) _then) = __$TargetRoleModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, bool isCustom, String description, int matchScore, int potentialRoles
});




}
/// @nodoc
class __$TargetRoleModelCopyWithImpl<$Res>
    implements _$TargetRoleModelCopyWith<$Res> {
  __$TargetRoleModelCopyWithImpl(this._self, this._then);

  final _TargetRoleModel _self;
  final $Res Function(_TargetRoleModel) _then;

/// Create a copy of TargetRoleModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? isCustom = null,Object? description = null,Object? matchScore = null,Object? potentialRoles = null,}) {
  return _then(_TargetRoleModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,isCustom: null == isCustom ? _self.isCustom : isCustom // ignore: cast_nullable_to_non_nullable
as bool,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,matchScore: null == matchScore ? _self.matchScore : matchScore // ignore: cast_nullable_to_non_nullable
as int,potentialRoles: null == potentialRoles ? _self.potentialRoles : potentialRoles // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}

// dart format on
