// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'location_preference_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$LocationPreferenceModel {

/// Unique identifier for the location
 String get id;/// Location name/title
 String get name;/// Whether this is a custom location added by user
 bool get isCustom;/// Location type (e.g., city, remote, country)
/// Empty string means type not specified
 String get type;/// Match score or relevance (0-100)
/// -1 indicates score not calculated yet
 int get matchScore;/// Growth percentage for this location
/// 0 means no data available
 int get growthPercentage;/// Additional metadata
/// Empty string means no description provided
 String get description;
/// Create a copy of LocationPreferenceModel
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LocationPreferenceModelCopyWith<LocationPreferenceModel> get copyWith => _$LocationPreferenceModelCopyWithImpl<LocationPreferenceModel>(this as LocationPreferenceModel, _$identity);

  /// Serializes this LocationPreferenceModel to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LocationPreferenceModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.isCustom, isCustom) || other.isCustom == isCustom)&&(identical(other.type, type) || other.type == type)&&(identical(other.matchScore, matchScore) || other.matchScore == matchScore)&&(identical(other.growthPercentage, growthPercentage) || other.growthPercentage == growthPercentage)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,isCustom,type,matchScore,growthPercentage,description);

@override
String toString() {
  return 'LocationPreferenceModel(id: $id, name: $name, isCustom: $isCustom, type: $type, matchScore: $matchScore, growthPercentage: $growthPercentage, description: $description)';
}


}

/// @nodoc
abstract mixin class $LocationPreferenceModelCopyWith<$Res>  {
  factory $LocationPreferenceModelCopyWith(LocationPreferenceModel value, $Res Function(LocationPreferenceModel) _then) = _$LocationPreferenceModelCopyWithImpl;
@useResult
$Res call({
 String id, String name, bool isCustom, String type, int matchScore, int growthPercentage, String description
});




}
/// @nodoc
class _$LocationPreferenceModelCopyWithImpl<$Res>
    implements $LocationPreferenceModelCopyWith<$Res> {
  _$LocationPreferenceModelCopyWithImpl(this._self, this._then);

  final LocationPreferenceModel _self;
  final $Res Function(LocationPreferenceModel) _then;

/// Create a copy of LocationPreferenceModel
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? isCustom = null,Object? type = null,Object? matchScore = null,Object? growthPercentage = null,Object? description = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isCustom: null == isCustom ? _self.isCustom : isCustom // ignore: cast_nullable_to_non_nullable
as bool,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,matchScore: null == matchScore ? _self.matchScore : matchScore // ignore: cast_nullable_to_non_nullable
as int,growthPercentage: null == growthPercentage ? _self.growthPercentage : growthPercentage // ignore: cast_nullable_to_non_nullable
as int,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LocationPreferenceModel].
extension LocationPreferenceModelPatterns on LocationPreferenceModel {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LocationPreferenceModel value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LocationPreferenceModel() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LocationPreferenceModel value)  $default,){
final _that = this;
switch (_that) {
case _LocationPreferenceModel():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LocationPreferenceModel value)?  $default,){
final _that = this;
switch (_that) {
case _LocationPreferenceModel() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  bool isCustom,  String type,  int matchScore,  int growthPercentage,  String description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LocationPreferenceModel() when $default != null:
return $default(_that.id,_that.name,_that.isCustom,_that.type,_that.matchScore,_that.growthPercentage,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  bool isCustom,  String type,  int matchScore,  int growthPercentage,  String description)  $default,) {final _that = this;
switch (_that) {
case _LocationPreferenceModel():
return $default(_that.id,_that.name,_that.isCustom,_that.type,_that.matchScore,_that.growthPercentage,_that.description);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  bool isCustom,  String type,  int matchScore,  int growthPercentage,  String description)?  $default,) {final _that = this;
switch (_that) {
case _LocationPreferenceModel() when $default != null:
return $default(_that.id,_that.name,_that.isCustom,_that.type,_that.matchScore,_that.growthPercentage,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LocationPreferenceModel implements LocationPreferenceModel {
  const _LocationPreferenceModel({required this.id, required this.name, this.isCustom = false, this.type = 'unspecified', this.matchScore = -1, this.growthPercentage = 0, this.description = 'No description available'});
  factory _LocationPreferenceModel.fromJson(Map<String, dynamic> json) => _$LocationPreferenceModelFromJson(json);

/// Unique identifier for the location
@override final  String id;
/// Location name/title
@override final  String name;
/// Whether this is a custom location added by user
@override@JsonKey() final  bool isCustom;
/// Location type (e.g., city, remote, country)
/// Empty string means type not specified
@override@JsonKey() final  String type;
/// Match score or relevance (0-100)
/// -1 indicates score not calculated yet
@override@JsonKey() final  int matchScore;
/// Growth percentage for this location
/// 0 means no data available
@override@JsonKey() final  int growthPercentage;
/// Additional metadata
/// Empty string means no description provided
@override@JsonKey() final  String description;

/// Create a copy of LocationPreferenceModel
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LocationPreferenceModelCopyWith<_LocationPreferenceModel> get copyWith => __$LocationPreferenceModelCopyWithImpl<_LocationPreferenceModel>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LocationPreferenceModelToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LocationPreferenceModel&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.isCustom, isCustom) || other.isCustom == isCustom)&&(identical(other.type, type) || other.type == type)&&(identical(other.matchScore, matchScore) || other.matchScore == matchScore)&&(identical(other.growthPercentage, growthPercentage) || other.growthPercentage == growthPercentage)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,isCustom,type,matchScore,growthPercentage,description);

@override
String toString() {
  return 'LocationPreferenceModel(id: $id, name: $name, isCustom: $isCustom, type: $type, matchScore: $matchScore, growthPercentage: $growthPercentage, description: $description)';
}


}

/// @nodoc
abstract mixin class _$LocationPreferenceModelCopyWith<$Res> implements $LocationPreferenceModelCopyWith<$Res> {
  factory _$LocationPreferenceModelCopyWith(_LocationPreferenceModel value, $Res Function(_LocationPreferenceModel) _then) = __$LocationPreferenceModelCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, bool isCustom, String type, int matchScore, int growthPercentage, String description
});




}
/// @nodoc
class __$LocationPreferenceModelCopyWithImpl<$Res>
    implements _$LocationPreferenceModelCopyWith<$Res> {
  __$LocationPreferenceModelCopyWithImpl(this._self, this._then);

  final _LocationPreferenceModel _self;
  final $Res Function(_LocationPreferenceModel) _then;

/// Create a copy of LocationPreferenceModel
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? isCustom = null,Object? type = null,Object? matchScore = null,Object? growthPercentage = null,Object? description = null,}) {
  return _then(_LocationPreferenceModel(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,isCustom: null == isCustom ? _self.isCustom : isCustom // ignore: cast_nullable_to_non_nullable
as bool,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as String,matchScore: null == matchScore ? _self.matchScore : matchScore // ignore: cast_nullable_to_non_nullable
as int,growthPercentage: null == growthPercentage ? _self.growthPercentage : growthPercentage // ignore: cast_nullable_to_non_nullable
as int,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
