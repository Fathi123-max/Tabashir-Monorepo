// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'candidate_repository.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CandidateProfile {

 String get id; String get name; String get email; String get phone; String get location; List<String> get skills; String get experienceLevel; List<String> get resumeUrls; List<String> get jobApplications; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of CandidateProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CandidateProfileCopyWith<CandidateProfile> get copyWith => _$CandidateProfileCopyWithImpl<CandidateProfile>(this as CandidateProfile, _$identity);

  /// Serializes this CandidateProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CandidateProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.location, location) || other.location == location)&&const DeepCollectionEquality().equals(other.skills, skills)&&(identical(other.experienceLevel, experienceLevel) || other.experienceLevel == experienceLevel)&&const DeepCollectionEquality().equals(other.resumeUrls, resumeUrls)&&const DeepCollectionEquality().equals(other.jobApplications, jobApplications)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,email,phone,location,const DeepCollectionEquality().hash(skills),experienceLevel,const DeepCollectionEquality().hash(resumeUrls),const DeepCollectionEquality().hash(jobApplications),createdAt,updatedAt);

@override
String toString() {
  return 'CandidateProfile(id: $id, name: $name, email: $email, phone: $phone, location: $location, skills: $skills, experienceLevel: $experienceLevel, resumeUrls: $resumeUrls, jobApplications: $jobApplications, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $CandidateProfileCopyWith<$Res>  {
  factory $CandidateProfileCopyWith(CandidateProfile value, $Res Function(CandidateProfile) _then) = _$CandidateProfileCopyWithImpl;
@useResult
$Res call({
 String id, String name, String email, String phone, String location, List<String> skills, String experienceLevel, List<String> resumeUrls, List<String> jobApplications, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$CandidateProfileCopyWithImpl<$Res>
    implements $CandidateProfileCopyWith<$Res> {
  _$CandidateProfileCopyWithImpl(this._self, this._then);

  final CandidateProfile _self;
  final $Res Function(CandidateProfile) _then;

/// Create a copy of CandidateProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? email = null,Object? phone = null,Object? location = null,Object? skills = null,Object? experienceLevel = null,Object? resumeUrls = null,Object? jobApplications = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,skills: null == skills ? _self.skills : skills // ignore: cast_nullable_to_non_nullable
as List<String>,experienceLevel: null == experienceLevel ? _self.experienceLevel : experienceLevel // ignore: cast_nullable_to_non_nullable
as String,resumeUrls: null == resumeUrls ? _self.resumeUrls : resumeUrls // ignore: cast_nullable_to_non_nullable
as List<String>,jobApplications: null == jobApplications ? _self.jobApplications : jobApplications // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [CandidateProfile].
extension CandidateProfilePatterns on CandidateProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CandidateProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CandidateProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CandidateProfile value)  $default,){
final _that = this;
switch (_that) {
case _CandidateProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CandidateProfile value)?  $default,){
final _that = this;
switch (_that) {
case _CandidateProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String email,  String phone,  String location,  List<String> skills,  String experienceLevel,  List<String> resumeUrls,  List<String> jobApplications,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CandidateProfile() when $default != null:
return $default(_that.id,_that.name,_that.email,_that.phone,_that.location,_that.skills,_that.experienceLevel,_that.resumeUrls,_that.jobApplications,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String email,  String phone,  String location,  List<String> skills,  String experienceLevel,  List<String> resumeUrls,  List<String> jobApplications,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _CandidateProfile():
return $default(_that.id,_that.name,_that.email,_that.phone,_that.location,_that.skills,_that.experienceLevel,_that.resumeUrls,_that.jobApplications,_that.createdAt,_that.updatedAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String email,  String phone,  String location,  List<String> skills,  String experienceLevel,  List<String> resumeUrls,  List<String> jobApplications,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _CandidateProfile() when $default != null:
return $default(_that.id,_that.name,_that.email,_that.phone,_that.location,_that.skills,_that.experienceLevel,_that.resumeUrls,_that.jobApplications,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CandidateProfile implements CandidateProfile {
  const _CandidateProfile({required this.id, required this.name, required this.email, required this.phone, required this.location, required final  List<String> skills, required this.experienceLevel, final  List<String> resumeUrls = const [], final  List<String> jobApplications = const [], this.createdAt, this.updatedAt}): _skills = skills,_resumeUrls = resumeUrls,_jobApplications = jobApplications;
  factory _CandidateProfile.fromJson(Map<String, dynamic> json) => _$CandidateProfileFromJson(json);

@override final  String id;
@override final  String name;
@override final  String email;
@override final  String phone;
@override final  String location;
 final  List<String> _skills;
@override List<String> get skills {
  if (_skills is EqualUnmodifiableListView) return _skills;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_skills);
}

@override final  String experienceLevel;
 final  List<String> _resumeUrls;
@override@JsonKey() List<String> get resumeUrls {
  if (_resumeUrls is EqualUnmodifiableListView) return _resumeUrls;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_resumeUrls);
}

 final  List<String> _jobApplications;
@override@JsonKey() List<String> get jobApplications {
  if (_jobApplications is EqualUnmodifiableListView) return _jobApplications;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_jobApplications);
}

@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of CandidateProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CandidateProfileCopyWith<_CandidateProfile> get copyWith => __$CandidateProfileCopyWithImpl<_CandidateProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CandidateProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CandidateProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.location, location) || other.location == location)&&const DeepCollectionEquality().equals(other._skills, _skills)&&(identical(other.experienceLevel, experienceLevel) || other.experienceLevel == experienceLevel)&&const DeepCollectionEquality().equals(other._resumeUrls, _resumeUrls)&&const DeepCollectionEquality().equals(other._jobApplications, _jobApplications)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,email,phone,location,const DeepCollectionEquality().hash(_skills),experienceLevel,const DeepCollectionEquality().hash(_resumeUrls),const DeepCollectionEquality().hash(_jobApplications),createdAt,updatedAt);

@override
String toString() {
  return 'CandidateProfile(id: $id, name: $name, email: $email, phone: $phone, location: $location, skills: $skills, experienceLevel: $experienceLevel, resumeUrls: $resumeUrls, jobApplications: $jobApplications, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$CandidateProfileCopyWith<$Res> implements $CandidateProfileCopyWith<$Res> {
  factory _$CandidateProfileCopyWith(_CandidateProfile value, $Res Function(_CandidateProfile) _then) = __$CandidateProfileCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String email, String phone, String location, List<String> skills, String experienceLevel, List<String> resumeUrls, List<String> jobApplications, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$CandidateProfileCopyWithImpl<$Res>
    implements _$CandidateProfileCopyWith<$Res> {
  __$CandidateProfileCopyWithImpl(this._self, this._then);

  final _CandidateProfile _self;
  final $Res Function(_CandidateProfile) _then;

/// Create a copy of CandidateProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? email = null,Object? phone = null,Object? location = null,Object? skills = null,Object? experienceLevel = null,Object? resumeUrls = null,Object? jobApplications = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_CandidateProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,skills: null == skills ? _self._skills : skills // ignore: cast_nullable_to_non_nullable
as List<String>,experienceLevel: null == experienceLevel ? _self.experienceLevel : experienceLevel // ignore: cast_nullable_to_non_nullable
as String,resumeUrls: null == resumeUrls ? _self._resumeUrls : resumeUrls // ignore: cast_nullable_to_non_nullable
as List<String>,jobApplications: null == jobApplications ? _self._jobApplications : jobApplications // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
