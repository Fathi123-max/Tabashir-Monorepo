// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'resume_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$Resume {

 String get id; String get userId; String get title; String get fullName; String get email; String? get phone; String? get summary; List<WorkExperience> get experience; List<Education> get education; List<Skill> get skills; List<String> get certifications; List<String> get languages; String? get profileImageUrl; ResumeStatus get status; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of Resume
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResumeCopyWith<Resume> get copyWith => _$ResumeCopyWithImpl<Resume>(this as Resume, _$identity);

  /// Serializes this Resume to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Resume&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.title, title) || other.title == title)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other.experience, experience)&&const DeepCollectionEquality().equals(other.education, education)&&const DeepCollectionEquality().equals(other.skills, skills)&&const DeepCollectionEquality().equals(other.certifications, certifications)&&const DeepCollectionEquality().equals(other.languages, languages)&&(identical(other.profileImageUrl, profileImageUrl) || other.profileImageUrl == profileImageUrl)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,title,fullName,email,phone,summary,const DeepCollectionEquality().hash(experience),const DeepCollectionEquality().hash(education),const DeepCollectionEquality().hash(skills),const DeepCollectionEquality().hash(certifications),const DeepCollectionEquality().hash(languages),profileImageUrl,status,createdAt,updatedAt);

@override
String toString() {
  return 'Resume(id: $id, userId: $userId, title: $title, fullName: $fullName, email: $email, phone: $phone, summary: $summary, experience: $experience, education: $education, skills: $skills, certifications: $certifications, languages: $languages, profileImageUrl: $profileImageUrl, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $ResumeCopyWith<$Res>  {
  factory $ResumeCopyWith(Resume value, $Res Function(Resume) _then) = _$ResumeCopyWithImpl;
@useResult
$Res call({
 String id, String userId, String title, String fullName, String email, String? phone, String? summary, List<WorkExperience> experience, List<Education> education, List<Skill> skills, List<String> certifications, List<String> languages, String? profileImageUrl, ResumeStatus status, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$ResumeCopyWithImpl<$Res>
    implements $ResumeCopyWith<$Res> {
  _$ResumeCopyWithImpl(this._self, this._then);

  final Resume _self;
  final $Res Function(Resume) _then;

/// Create a copy of Resume
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? userId = null,Object? title = null,Object? fullName = null,Object? email = null,Object? phone = freezed,Object? summary = freezed,Object? experience = null,Object? education = null,Object? skills = null,Object? certifications = null,Object? languages = null,Object? profileImageUrl = freezed,Object? status = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String?,experience: null == experience ? _self.experience : experience // ignore: cast_nullable_to_non_nullable
as List<WorkExperience>,education: null == education ? _self.education : education // ignore: cast_nullable_to_non_nullable
as List<Education>,skills: null == skills ? _self.skills : skills // ignore: cast_nullable_to_non_nullable
as List<Skill>,certifications: null == certifications ? _self.certifications : certifications // ignore: cast_nullable_to_non_nullable
as List<String>,languages: null == languages ? _self.languages : languages // ignore: cast_nullable_to_non_nullable
as List<String>,profileImageUrl: freezed == profileImageUrl ? _self.profileImageUrl : profileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ResumeStatus,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [Resume].
extension ResumePatterns on Resume {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Resume value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Resume() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Resume value)  $default,){
final _that = this;
switch (_that) {
case _Resume():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Resume value)?  $default,){
final _that = this;
switch (_that) {
case _Resume() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String userId,  String title,  String fullName,  String email,  String? phone,  String? summary,  List<WorkExperience> experience,  List<Education> education,  List<Skill> skills,  List<String> certifications,  List<String> languages,  String? profileImageUrl,  ResumeStatus status,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Resume() when $default != null:
return $default(_that.id,_that.userId,_that.title,_that.fullName,_that.email,_that.phone,_that.summary,_that.experience,_that.education,_that.skills,_that.certifications,_that.languages,_that.profileImageUrl,_that.status,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String userId,  String title,  String fullName,  String email,  String? phone,  String? summary,  List<WorkExperience> experience,  List<Education> education,  List<Skill> skills,  List<String> certifications,  List<String> languages,  String? profileImageUrl,  ResumeStatus status,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _Resume():
return $default(_that.id,_that.userId,_that.title,_that.fullName,_that.email,_that.phone,_that.summary,_that.experience,_that.education,_that.skills,_that.certifications,_that.languages,_that.profileImageUrl,_that.status,_that.createdAt,_that.updatedAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String userId,  String title,  String fullName,  String email,  String? phone,  String? summary,  List<WorkExperience> experience,  List<Education> education,  List<Skill> skills,  List<String> certifications,  List<String> languages,  String? profileImageUrl,  ResumeStatus status,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _Resume() when $default != null:
return $default(_that.id,_that.userId,_that.title,_that.fullName,_that.email,_that.phone,_that.summary,_that.experience,_that.education,_that.skills,_that.certifications,_that.languages,_that.profileImageUrl,_that.status,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Resume implements Resume {
  const _Resume({required this.id, required this.userId, required this.title, required this.fullName, required this.email, this.phone, this.summary, final  List<WorkExperience> experience = const [], final  List<Education> education = const [], final  List<Skill> skills = const [], final  List<String> certifications = const [], final  List<String> languages = const [], this.profileImageUrl, this.status = ResumeStatus.draft, this.createdAt, this.updatedAt}): _experience = experience,_education = education,_skills = skills,_certifications = certifications,_languages = languages;
  factory _Resume.fromJson(Map<String, dynamic> json) => _$ResumeFromJson(json);

@override final  String id;
@override final  String userId;
@override final  String title;
@override final  String fullName;
@override final  String email;
@override final  String? phone;
@override final  String? summary;
 final  List<WorkExperience> _experience;
@override@JsonKey() List<WorkExperience> get experience {
  if (_experience is EqualUnmodifiableListView) return _experience;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_experience);
}

 final  List<Education> _education;
@override@JsonKey() List<Education> get education {
  if (_education is EqualUnmodifiableListView) return _education;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_education);
}

 final  List<Skill> _skills;
@override@JsonKey() List<Skill> get skills {
  if (_skills is EqualUnmodifiableListView) return _skills;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_skills);
}

 final  List<String> _certifications;
@override@JsonKey() List<String> get certifications {
  if (_certifications is EqualUnmodifiableListView) return _certifications;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_certifications);
}

 final  List<String> _languages;
@override@JsonKey() List<String> get languages {
  if (_languages is EqualUnmodifiableListView) return _languages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_languages);
}

@override final  String? profileImageUrl;
@override@JsonKey() final  ResumeStatus status;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of Resume
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResumeCopyWith<_Resume> get copyWith => __$ResumeCopyWithImpl<_Resume>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ResumeToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Resume&&(identical(other.id, id) || other.id == id)&&(identical(other.userId, userId) || other.userId == userId)&&(identical(other.title, title) || other.title == title)&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.summary, summary) || other.summary == summary)&&const DeepCollectionEquality().equals(other._experience, _experience)&&const DeepCollectionEquality().equals(other._education, _education)&&const DeepCollectionEquality().equals(other._skills, _skills)&&const DeepCollectionEquality().equals(other._certifications, _certifications)&&const DeepCollectionEquality().equals(other._languages, _languages)&&(identical(other.profileImageUrl, profileImageUrl) || other.profileImageUrl == profileImageUrl)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,userId,title,fullName,email,phone,summary,const DeepCollectionEquality().hash(_experience),const DeepCollectionEquality().hash(_education),const DeepCollectionEquality().hash(_skills),const DeepCollectionEquality().hash(_certifications),const DeepCollectionEquality().hash(_languages),profileImageUrl,status,createdAt,updatedAt);

@override
String toString() {
  return 'Resume(id: $id, userId: $userId, title: $title, fullName: $fullName, email: $email, phone: $phone, summary: $summary, experience: $experience, education: $education, skills: $skills, certifications: $certifications, languages: $languages, profileImageUrl: $profileImageUrl, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$ResumeCopyWith<$Res> implements $ResumeCopyWith<$Res> {
  factory _$ResumeCopyWith(_Resume value, $Res Function(_Resume) _then) = __$ResumeCopyWithImpl;
@override @useResult
$Res call({
 String id, String userId, String title, String fullName, String email, String? phone, String? summary, List<WorkExperience> experience, List<Education> education, List<Skill> skills, List<String> certifications, List<String> languages, String? profileImageUrl, ResumeStatus status, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$ResumeCopyWithImpl<$Res>
    implements _$ResumeCopyWith<$Res> {
  __$ResumeCopyWithImpl(this._self, this._then);

  final _Resume _self;
  final $Res Function(_Resume) _then;

/// Create a copy of Resume
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? userId = null,Object? title = null,Object? fullName = null,Object? email = null,Object? phone = freezed,Object? summary = freezed,Object? experience = null,Object? education = null,Object? skills = null,Object? certifications = null,Object? languages = null,Object? profileImageUrl = freezed,Object? status = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_Resume(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,userId: null == userId ? _self.userId : userId // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String?,experience: null == experience ? _self._experience : experience // ignore: cast_nullable_to_non_nullable
as List<WorkExperience>,education: null == education ? _self._education : education // ignore: cast_nullable_to_non_nullable
as List<Education>,skills: null == skills ? _self._skills : skills // ignore: cast_nullable_to_non_nullable
as List<Skill>,certifications: null == certifications ? _self._certifications : certifications // ignore: cast_nullable_to_non_nullable
as List<String>,languages: null == languages ? _self._languages : languages // ignore: cast_nullable_to_non_nullable
as List<String>,profileImageUrl: freezed == profileImageUrl ? _self.profileImageUrl : profileImageUrl // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ResumeStatus,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$WorkExperience {

 String get company; String get position; DateTime get startDate; DateTime? get endDate; bool get isCurrent; String? get description; String? get location;
/// Create a copy of WorkExperience
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkExperienceCopyWith<WorkExperience> get copyWith => _$WorkExperienceCopyWithImpl<WorkExperience>(this as WorkExperience, _$identity);

  /// Serializes this WorkExperience to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkExperience&&(identical(other.company, company) || other.company == company)&&(identical(other.position, position) || other.position == position)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.isCurrent, isCurrent) || other.isCurrent == isCurrent)&&(identical(other.description, description) || other.description == description)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,company,position,startDate,endDate,isCurrent,description,location);

@override
String toString() {
  return 'WorkExperience(company: $company, position: $position, startDate: $startDate, endDate: $endDate, isCurrent: $isCurrent, description: $description, location: $location)';
}


}

/// @nodoc
abstract mixin class $WorkExperienceCopyWith<$Res>  {
  factory $WorkExperienceCopyWith(WorkExperience value, $Res Function(WorkExperience) _then) = _$WorkExperienceCopyWithImpl;
@useResult
$Res call({
 String company, String position, DateTime startDate, DateTime? endDate, bool isCurrent, String? description, String? location
});




}
/// @nodoc
class _$WorkExperienceCopyWithImpl<$Res>
    implements $WorkExperienceCopyWith<$Res> {
  _$WorkExperienceCopyWithImpl(this._self, this._then);

  final WorkExperience _self;
  final $Res Function(WorkExperience) _then;

/// Create a copy of WorkExperience
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? company = null,Object? position = null,Object? startDate = null,Object? endDate = freezed,Object? isCurrent = null,Object? description = freezed,Object? location = freezed,}) {
  return _then(_self.copyWith(
company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isCurrent: null == isCurrent ? _self.isCurrent : isCurrent // ignore: cast_nullable_to_non_nullable
as bool,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [WorkExperience].
extension WorkExperiencePatterns on WorkExperience {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _WorkExperience value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _WorkExperience() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _WorkExperience value)  $default,){
final _that = this;
switch (_that) {
case _WorkExperience():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _WorkExperience value)?  $default,){
final _that = this;
switch (_that) {
case _WorkExperience() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String company,  String position,  DateTime startDate,  DateTime? endDate,  bool isCurrent,  String? description,  String? location)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkExperience() when $default != null:
return $default(_that.company,_that.position,_that.startDate,_that.endDate,_that.isCurrent,_that.description,_that.location);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String company,  String position,  DateTime startDate,  DateTime? endDate,  bool isCurrent,  String? description,  String? location)  $default,) {final _that = this;
switch (_that) {
case _WorkExperience():
return $default(_that.company,_that.position,_that.startDate,_that.endDate,_that.isCurrent,_that.description,_that.location);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String company,  String position,  DateTime startDate,  DateTime? endDate,  bool isCurrent,  String? description,  String? location)?  $default,) {final _that = this;
switch (_that) {
case _WorkExperience() when $default != null:
return $default(_that.company,_that.position,_that.startDate,_that.endDate,_that.isCurrent,_that.description,_that.location);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WorkExperience implements WorkExperience {
  const _WorkExperience({required this.company, required this.position, required this.startDate, this.endDate, this.isCurrent = false, this.description, this.location});
  factory _WorkExperience.fromJson(Map<String, dynamic> json) => _$WorkExperienceFromJson(json);

@override final  String company;
@override final  String position;
@override final  DateTime startDate;
@override final  DateTime? endDate;
@override@JsonKey() final  bool isCurrent;
@override final  String? description;
@override final  String? location;

/// Create a copy of WorkExperience
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$WorkExperienceCopyWith<_WorkExperience> get copyWith => __$WorkExperienceCopyWithImpl<_WorkExperience>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$WorkExperienceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkExperience&&(identical(other.company, company) || other.company == company)&&(identical(other.position, position) || other.position == position)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.isCurrent, isCurrent) || other.isCurrent == isCurrent)&&(identical(other.description, description) || other.description == description)&&(identical(other.location, location) || other.location == location));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,company,position,startDate,endDate,isCurrent,description,location);

@override
String toString() {
  return 'WorkExperience(company: $company, position: $position, startDate: $startDate, endDate: $endDate, isCurrent: $isCurrent, description: $description, location: $location)';
}


}

/// @nodoc
abstract mixin class _$WorkExperienceCopyWith<$Res> implements $WorkExperienceCopyWith<$Res> {
  factory _$WorkExperienceCopyWith(_WorkExperience value, $Res Function(_WorkExperience) _then) = __$WorkExperienceCopyWithImpl;
@override @useResult
$Res call({
 String company, String position, DateTime startDate, DateTime? endDate, bool isCurrent, String? description, String? location
});




}
/// @nodoc
class __$WorkExperienceCopyWithImpl<$Res>
    implements _$WorkExperienceCopyWith<$Res> {
  __$WorkExperienceCopyWithImpl(this._self, this._then);

  final _WorkExperience _self;
  final $Res Function(_WorkExperience) _then;

/// Create a copy of WorkExperience
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? company = null,Object? position = null,Object? startDate = null,Object? endDate = freezed,Object? isCurrent = null,Object? description = freezed,Object? location = freezed,}) {
  return _then(_WorkExperience(
company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isCurrent: null == isCurrent ? _self.isCurrent : isCurrent // ignore: cast_nullable_to_non_nullable
as bool,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$Education {

 String get institution; String get degree; DateTime get startDate; DateTime? get endDate; String? get fieldOfStudy; String? get gpa;
/// Create a copy of Education
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EducationCopyWith<Education> get copyWith => _$EducationCopyWithImpl<Education>(this as Education, _$identity);

  /// Serializes this Education to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Education&&(identical(other.institution, institution) || other.institution == institution)&&(identical(other.degree, degree) || other.degree == degree)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.fieldOfStudy, fieldOfStudy) || other.fieldOfStudy == fieldOfStudy)&&(identical(other.gpa, gpa) || other.gpa == gpa));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,institution,degree,startDate,endDate,fieldOfStudy,gpa);

@override
String toString() {
  return 'Education(institution: $institution, degree: $degree, startDate: $startDate, endDate: $endDate, fieldOfStudy: $fieldOfStudy, gpa: $gpa)';
}


}

/// @nodoc
abstract mixin class $EducationCopyWith<$Res>  {
  factory $EducationCopyWith(Education value, $Res Function(Education) _then) = _$EducationCopyWithImpl;
@useResult
$Res call({
 String institution, String degree, DateTime startDate, DateTime? endDate, String? fieldOfStudy, String? gpa
});




}
/// @nodoc
class _$EducationCopyWithImpl<$Res>
    implements $EducationCopyWith<$Res> {
  _$EducationCopyWithImpl(this._self, this._then);

  final Education _self;
  final $Res Function(Education) _then;

/// Create a copy of Education
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? institution = null,Object? degree = null,Object? startDate = null,Object? endDate = freezed,Object? fieldOfStudy = freezed,Object? gpa = freezed,}) {
  return _then(_self.copyWith(
institution: null == institution ? _self.institution : institution // ignore: cast_nullable_to_non_nullable
as String,degree: null == degree ? _self.degree : degree // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,fieldOfStudy: freezed == fieldOfStudy ? _self.fieldOfStudy : fieldOfStudy // ignore: cast_nullable_to_non_nullable
as String?,gpa: freezed == gpa ? _self.gpa : gpa // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Education].
extension EducationPatterns on Education {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Education value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Education() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Education value)  $default,){
final _that = this;
switch (_that) {
case _Education():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Education value)?  $default,){
final _that = this;
switch (_that) {
case _Education() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String institution,  String degree,  DateTime startDate,  DateTime? endDate,  String? fieldOfStudy,  String? gpa)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Education() when $default != null:
return $default(_that.institution,_that.degree,_that.startDate,_that.endDate,_that.fieldOfStudy,_that.gpa);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String institution,  String degree,  DateTime startDate,  DateTime? endDate,  String? fieldOfStudy,  String? gpa)  $default,) {final _that = this;
switch (_that) {
case _Education():
return $default(_that.institution,_that.degree,_that.startDate,_that.endDate,_that.fieldOfStudy,_that.gpa);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String institution,  String degree,  DateTime startDate,  DateTime? endDate,  String? fieldOfStudy,  String? gpa)?  $default,) {final _that = this;
switch (_that) {
case _Education() when $default != null:
return $default(_that.institution,_that.degree,_that.startDate,_that.endDate,_that.fieldOfStudy,_that.gpa);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Education implements Education {
  const _Education({required this.institution, required this.degree, required this.startDate, this.endDate, this.fieldOfStudy, this.gpa});
  factory _Education.fromJson(Map<String, dynamic> json) => _$EducationFromJson(json);

@override final  String institution;
@override final  String degree;
@override final  DateTime startDate;
@override final  DateTime? endDate;
@override final  String? fieldOfStudy;
@override final  String? gpa;

/// Create a copy of Education
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EducationCopyWith<_Education> get copyWith => __$EducationCopyWithImpl<_Education>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EducationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Education&&(identical(other.institution, institution) || other.institution == institution)&&(identical(other.degree, degree) || other.degree == degree)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.fieldOfStudy, fieldOfStudy) || other.fieldOfStudy == fieldOfStudy)&&(identical(other.gpa, gpa) || other.gpa == gpa));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,institution,degree,startDate,endDate,fieldOfStudy,gpa);

@override
String toString() {
  return 'Education(institution: $institution, degree: $degree, startDate: $startDate, endDate: $endDate, fieldOfStudy: $fieldOfStudy, gpa: $gpa)';
}


}

/// @nodoc
abstract mixin class _$EducationCopyWith<$Res> implements $EducationCopyWith<$Res> {
  factory _$EducationCopyWith(_Education value, $Res Function(_Education) _then) = __$EducationCopyWithImpl;
@override @useResult
$Res call({
 String institution, String degree, DateTime startDate, DateTime? endDate, String? fieldOfStudy, String? gpa
});




}
/// @nodoc
class __$EducationCopyWithImpl<$Res>
    implements _$EducationCopyWith<$Res> {
  __$EducationCopyWithImpl(this._self, this._then);

  final _Education _self;
  final $Res Function(_Education) _then;

/// Create a copy of Education
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? institution = null,Object? degree = null,Object? startDate = null,Object? endDate = freezed,Object? fieldOfStudy = freezed,Object? gpa = freezed,}) {
  return _then(_Education(
institution: null == institution ? _self.institution : institution // ignore: cast_nullable_to_non_nullable
as String,degree: null == degree ? _self.degree : degree // ignore: cast_nullable_to_non_nullable
as String,startDate: null == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,fieldOfStudy: freezed == fieldOfStudy ? _self.fieldOfStudy : fieldOfStudy // ignore: cast_nullable_to_non_nullable
as String?,gpa: freezed == gpa ? _self.gpa : gpa // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$Skill {

 String get name; SkillLevel get level; String get category;
/// Create a copy of Skill
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SkillCopyWith<Skill> get copyWith => _$SkillCopyWithImpl<Skill>(this as Skill, _$identity);

  /// Serializes this Skill to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Skill&&(identical(other.name, name) || other.name == name)&&(identical(other.level, level) || other.level == level)&&(identical(other.category, category) || other.category == category));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,level,category);

@override
String toString() {
  return 'Skill(name: $name, level: $level, category: $category)';
}


}

/// @nodoc
abstract mixin class $SkillCopyWith<$Res>  {
  factory $SkillCopyWith(Skill value, $Res Function(Skill) _then) = _$SkillCopyWithImpl;
@useResult
$Res call({
 String name, SkillLevel level, String category
});




}
/// @nodoc
class _$SkillCopyWithImpl<$Res>
    implements $SkillCopyWith<$Res> {
  _$SkillCopyWithImpl(this._self, this._then);

  final Skill _self;
  final $Res Function(Skill) _then;

/// Create a copy of Skill
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? level = null,Object? category = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as SkillLevel,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [Skill].
extension SkillPatterns on Skill {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Skill value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Skill() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Skill value)  $default,){
final _that = this;
switch (_that) {
case _Skill():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Skill value)?  $default,){
final _that = this;
switch (_that) {
case _Skill() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  SkillLevel level,  String category)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Skill() when $default != null:
return $default(_that.name,_that.level,_that.category);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  SkillLevel level,  String category)  $default,) {final _that = this;
switch (_that) {
case _Skill():
return $default(_that.name,_that.level,_that.category);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  SkillLevel level,  String category)?  $default,) {final _that = this;
switch (_that) {
case _Skill() when $default != null:
return $default(_that.name,_that.level,_that.category);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Skill implements Skill {
  const _Skill({required this.name, required this.level, required this.category});
  factory _Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);

@override final  String name;
@override final  SkillLevel level;
@override final  String category;

/// Create a copy of Skill
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SkillCopyWith<_Skill> get copyWith => __$SkillCopyWithImpl<_Skill>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SkillToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Skill&&(identical(other.name, name) || other.name == name)&&(identical(other.level, level) || other.level == level)&&(identical(other.category, category) || other.category == category));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,level,category);

@override
String toString() {
  return 'Skill(name: $name, level: $level, category: $category)';
}


}

/// @nodoc
abstract mixin class _$SkillCopyWith<$Res> implements $SkillCopyWith<$Res> {
  factory _$SkillCopyWith(_Skill value, $Res Function(_Skill) _then) = __$SkillCopyWithImpl;
@override @useResult
$Res call({
 String name, SkillLevel level, String category
});




}
/// @nodoc
class __$SkillCopyWithImpl<$Res>
    implements _$SkillCopyWith<$Res> {
  __$SkillCopyWithImpl(this._self, this._then);

  final _Skill _self;
  final $Res Function(_Skill) _then;

/// Create a copy of Skill
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? level = null,Object? category = null,}) {
  return _then(_Skill(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,level: null == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as SkillLevel,category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
