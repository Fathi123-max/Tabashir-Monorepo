// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'ai_job_apply_config_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$AiJobApplyConfigResponse {

/// List of popular job roles
 List<String> get popularRoles;/// List of popular job locations
 List<String> get popularLocations;/// List of available nationalities
 List<String> get nationalities;/// Maximum number of roles to display in UI
 int get maxRolesToShow;/// Maximum number of locations to display in UI
 int get maxLocationsToShow;/// Default AI confidence score (0-100)
 int get defaultAiConfidence;/// Configuration version for cache invalidation
 String get version;/// When this configuration expires (ISO 8601 string)
 String get expiresAt;
/// Create a copy of AiJobApplyConfigResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiJobApplyConfigResponseCopyWith<AiJobApplyConfigResponse> get copyWith => _$AiJobApplyConfigResponseCopyWithImpl<AiJobApplyConfigResponse>(this as AiJobApplyConfigResponse, _$identity);

  /// Serializes this AiJobApplyConfigResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiJobApplyConfigResponse&&const DeepCollectionEquality().equals(other.popularRoles, popularRoles)&&const DeepCollectionEquality().equals(other.popularLocations, popularLocations)&&const DeepCollectionEquality().equals(other.nationalities, nationalities)&&(identical(other.maxRolesToShow, maxRolesToShow) || other.maxRolesToShow == maxRolesToShow)&&(identical(other.maxLocationsToShow, maxLocationsToShow) || other.maxLocationsToShow == maxLocationsToShow)&&(identical(other.defaultAiConfidence, defaultAiConfidence) || other.defaultAiConfidence == defaultAiConfidence)&&(identical(other.version, version) || other.version == version)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(popularRoles),const DeepCollectionEquality().hash(popularLocations),const DeepCollectionEquality().hash(nationalities),maxRolesToShow,maxLocationsToShow,defaultAiConfidence,version,expiresAt);

@override
String toString() {
  return 'AiJobApplyConfigResponse(popularRoles: $popularRoles, popularLocations: $popularLocations, nationalities: $nationalities, maxRolesToShow: $maxRolesToShow, maxLocationsToShow: $maxLocationsToShow, defaultAiConfidence: $defaultAiConfidence, version: $version, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class $AiJobApplyConfigResponseCopyWith<$Res>  {
  factory $AiJobApplyConfigResponseCopyWith(AiJobApplyConfigResponse value, $Res Function(AiJobApplyConfigResponse) _then) = _$AiJobApplyConfigResponseCopyWithImpl;
@useResult
$Res call({
 List<String> popularRoles, List<String> popularLocations, List<String> nationalities, int maxRolesToShow, int maxLocationsToShow, int defaultAiConfidence, String version, String expiresAt
});




}
/// @nodoc
class _$AiJobApplyConfigResponseCopyWithImpl<$Res>
    implements $AiJobApplyConfigResponseCopyWith<$Res> {
  _$AiJobApplyConfigResponseCopyWithImpl(this._self, this._then);

  final AiJobApplyConfigResponse _self;
  final $Res Function(AiJobApplyConfigResponse) _then;

/// Create a copy of AiJobApplyConfigResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? popularRoles = null,Object? popularLocations = null,Object? nationalities = null,Object? maxRolesToShow = null,Object? maxLocationsToShow = null,Object? defaultAiConfidence = null,Object? version = null,Object? expiresAt = null,}) {
  return _then(_self.copyWith(
popularRoles: null == popularRoles ? _self.popularRoles : popularRoles // ignore: cast_nullable_to_non_nullable
as List<String>,popularLocations: null == popularLocations ? _self.popularLocations : popularLocations // ignore: cast_nullable_to_non_nullable
as List<String>,nationalities: null == nationalities ? _self.nationalities : nationalities // ignore: cast_nullable_to_non_nullable
as List<String>,maxRolesToShow: null == maxRolesToShow ? _self.maxRolesToShow : maxRolesToShow // ignore: cast_nullable_to_non_nullable
as int,maxLocationsToShow: null == maxLocationsToShow ? _self.maxLocationsToShow : maxLocationsToShow // ignore: cast_nullable_to_non_nullable
as int,defaultAiConfidence: null == defaultAiConfidence ? _self.defaultAiConfidence : defaultAiConfidence // ignore: cast_nullable_to_non_nullable
as int,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [AiJobApplyConfigResponse].
extension AiJobApplyConfigResponsePatterns on AiJobApplyConfigResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiJobApplyConfigResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiJobApplyConfigResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiJobApplyConfigResponse value)  $default,){
final _that = this;
switch (_that) {
case _AiJobApplyConfigResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiJobApplyConfigResponse value)?  $default,){
final _that = this;
switch (_that) {
case _AiJobApplyConfigResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<String> popularRoles,  List<String> popularLocations,  List<String> nationalities,  int maxRolesToShow,  int maxLocationsToShow,  int defaultAiConfidence,  String version,  String expiresAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiJobApplyConfigResponse() when $default != null:
return $default(_that.popularRoles,_that.popularLocations,_that.nationalities,_that.maxRolesToShow,_that.maxLocationsToShow,_that.defaultAiConfidence,_that.version,_that.expiresAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<String> popularRoles,  List<String> popularLocations,  List<String> nationalities,  int maxRolesToShow,  int maxLocationsToShow,  int defaultAiConfidence,  String version,  String expiresAt)  $default,) {final _that = this;
switch (_that) {
case _AiJobApplyConfigResponse():
return $default(_that.popularRoles,_that.popularLocations,_that.nationalities,_that.maxRolesToShow,_that.maxLocationsToShow,_that.defaultAiConfidence,_that.version,_that.expiresAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<String> popularRoles,  List<String> popularLocations,  List<String> nationalities,  int maxRolesToShow,  int maxLocationsToShow,  int defaultAiConfidence,  String version,  String expiresAt)?  $default,) {final _that = this;
switch (_that) {
case _AiJobApplyConfigResponse() when $default != null:
return $default(_that.popularRoles,_that.popularLocations,_that.nationalities,_that.maxRolesToShow,_that.maxLocationsToShow,_that.defaultAiConfidence,_that.version,_that.expiresAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiJobApplyConfigResponse implements AiJobApplyConfigResponse {
  const _AiJobApplyConfigResponse({required final  List<String> popularRoles, required final  List<String> popularLocations, required final  List<String> nationalities, required this.maxRolesToShow, required this.maxLocationsToShow, required this.defaultAiConfidence, required this.version, required this.expiresAt}): _popularRoles = popularRoles,_popularLocations = popularLocations,_nationalities = nationalities;
  factory _AiJobApplyConfigResponse.fromJson(Map<String, dynamic> json) => _$AiJobApplyConfigResponseFromJson(json);

/// List of popular job roles
 final  List<String> _popularRoles;
/// List of popular job roles
@override List<String> get popularRoles {
  if (_popularRoles is EqualUnmodifiableListView) return _popularRoles;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_popularRoles);
}

/// List of popular job locations
 final  List<String> _popularLocations;
/// List of popular job locations
@override List<String> get popularLocations {
  if (_popularLocations is EqualUnmodifiableListView) return _popularLocations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_popularLocations);
}

/// List of available nationalities
 final  List<String> _nationalities;
/// List of available nationalities
@override List<String> get nationalities {
  if (_nationalities is EqualUnmodifiableListView) return _nationalities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_nationalities);
}

/// Maximum number of roles to display in UI
@override final  int maxRolesToShow;
/// Maximum number of locations to display in UI
@override final  int maxLocationsToShow;
/// Default AI confidence score (0-100)
@override final  int defaultAiConfidence;
/// Configuration version for cache invalidation
@override final  String version;
/// When this configuration expires (ISO 8601 string)
@override final  String expiresAt;

/// Create a copy of AiJobApplyConfigResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiJobApplyConfigResponseCopyWith<_AiJobApplyConfigResponse> get copyWith => __$AiJobApplyConfigResponseCopyWithImpl<_AiJobApplyConfigResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiJobApplyConfigResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiJobApplyConfigResponse&&const DeepCollectionEquality().equals(other._popularRoles, _popularRoles)&&const DeepCollectionEquality().equals(other._popularLocations, _popularLocations)&&const DeepCollectionEquality().equals(other._nationalities, _nationalities)&&(identical(other.maxRolesToShow, maxRolesToShow) || other.maxRolesToShow == maxRolesToShow)&&(identical(other.maxLocationsToShow, maxLocationsToShow) || other.maxLocationsToShow == maxLocationsToShow)&&(identical(other.defaultAiConfidence, defaultAiConfidence) || other.defaultAiConfidence == defaultAiConfidence)&&(identical(other.version, version) || other.version == version)&&(identical(other.expiresAt, expiresAt) || other.expiresAt == expiresAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(_popularRoles),const DeepCollectionEquality().hash(_popularLocations),const DeepCollectionEquality().hash(_nationalities),maxRolesToShow,maxLocationsToShow,defaultAiConfidence,version,expiresAt);

@override
String toString() {
  return 'AiJobApplyConfigResponse(popularRoles: $popularRoles, popularLocations: $popularLocations, nationalities: $nationalities, maxRolesToShow: $maxRolesToShow, maxLocationsToShow: $maxLocationsToShow, defaultAiConfidence: $defaultAiConfidence, version: $version, expiresAt: $expiresAt)';
}


}

/// @nodoc
abstract mixin class _$AiJobApplyConfigResponseCopyWith<$Res> implements $AiJobApplyConfigResponseCopyWith<$Res> {
  factory _$AiJobApplyConfigResponseCopyWith(_AiJobApplyConfigResponse value, $Res Function(_AiJobApplyConfigResponse) _then) = __$AiJobApplyConfigResponseCopyWithImpl;
@override @useResult
$Res call({
 List<String> popularRoles, List<String> popularLocations, List<String> nationalities, int maxRolesToShow, int maxLocationsToShow, int defaultAiConfidence, String version, String expiresAt
});




}
/// @nodoc
class __$AiJobApplyConfigResponseCopyWithImpl<$Res>
    implements _$AiJobApplyConfigResponseCopyWith<$Res> {
  __$AiJobApplyConfigResponseCopyWithImpl(this._self, this._then);

  final _AiJobApplyConfigResponse _self;
  final $Res Function(_AiJobApplyConfigResponse) _then;

/// Create a copy of AiJobApplyConfigResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? popularRoles = null,Object? popularLocations = null,Object? nationalities = null,Object? maxRolesToShow = null,Object? maxLocationsToShow = null,Object? defaultAiConfidence = null,Object? version = null,Object? expiresAt = null,}) {
  return _then(_AiJobApplyConfigResponse(
popularRoles: null == popularRoles ? _self._popularRoles : popularRoles // ignore: cast_nullable_to_non_nullable
as List<String>,popularLocations: null == popularLocations ? _self._popularLocations : popularLocations // ignore: cast_nullable_to_non_nullable
as List<String>,nationalities: null == nationalities ? _self._nationalities : nationalities // ignore: cast_nullable_to_non_nullable
as List<String>,maxRolesToShow: null == maxRolesToShow ? _self.maxRolesToShow : maxRolesToShow // ignore: cast_nullable_to_non_nullable
as int,maxLocationsToShow: null == maxLocationsToShow ? _self.maxLocationsToShow : maxLocationsToShow // ignore: cast_nullable_to_non_nullable
as int,defaultAiConfidence: null == defaultAiConfidence ? _self.defaultAiConfidence : defaultAiConfidence // ignore: cast_nullable_to_non_nullable
as int,version: null == version ? _self.version : version // ignore: cast_nullable_to_non_nullable
as String,expiresAt: null == expiresAt ? _self.expiresAt : expiresAt // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
