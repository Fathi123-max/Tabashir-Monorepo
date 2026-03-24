// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'resume_models.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ResumeData {

 int get currentStep; int get resumeScore;@JsonKey(name: 'header') PersonalDetails? get personalDetails;@JsonKey(name: 'objective') ProfessionalSummary? get professionalSummary;@JsonKey(name: 'work') List<WorkExperience> get workExperience; List<WorkExperience> get leadership; List<Education> get education; List<Skill> get skills; List<Project> get projects; List<Language> get languages;
/// Create a copy of ResumeData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResumeDataCopyWith<ResumeData> get copyWith => _$ResumeDataCopyWithImpl<ResumeData>(this as ResumeData, _$identity);

  /// Serializes this ResumeData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResumeData&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep)&&(identical(other.resumeScore, resumeScore) || other.resumeScore == resumeScore)&&(identical(other.personalDetails, personalDetails) || other.personalDetails == personalDetails)&&(identical(other.professionalSummary, professionalSummary) || other.professionalSummary == professionalSummary)&&const DeepCollectionEquality().equals(other.workExperience, workExperience)&&const DeepCollectionEquality().equals(other.leadership, leadership)&&const DeepCollectionEquality().equals(other.education, education)&&const DeepCollectionEquality().equals(other.skills, skills)&&const DeepCollectionEquality().equals(other.projects, projects)&&const DeepCollectionEquality().equals(other.languages, languages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentStep,resumeScore,personalDetails,professionalSummary,const DeepCollectionEquality().hash(workExperience),const DeepCollectionEquality().hash(leadership),const DeepCollectionEquality().hash(education),const DeepCollectionEquality().hash(skills),const DeepCollectionEquality().hash(projects),const DeepCollectionEquality().hash(languages));

@override
String toString() {
  return 'ResumeData(currentStep: $currentStep, resumeScore: $resumeScore, personalDetails: $personalDetails, professionalSummary: $professionalSummary, workExperience: $workExperience, leadership: $leadership, education: $education, skills: $skills, projects: $projects, languages: $languages)';
}


}

/// @nodoc
abstract mixin class $ResumeDataCopyWith<$Res>  {
  factory $ResumeDataCopyWith(ResumeData value, $Res Function(ResumeData) _then) = _$ResumeDataCopyWithImpl;
@useResult
$Res call({
 int currentStep, int resumeScore,@JsonKey(name: 'header') PersonalDetails? personalDetails,@JsonKey(name: 'objective') ProfessionalSummary? professionalSummary,@JsonKey(name: 'work') List<WorkExperience> workExperience, List<WorkExperience> leadership, List<Education> education, List<Skill> skills, List<Project> projects, List<Language> languages
});


$PersonalDetailsCopyWith<$Res>? get personalDetails;$ProfessionalSummaryCopyWith<$Res>? get professionalSummary;

}
/// @nodoc
class _$ResumeDataCopyWithImpl<$Res>
    implements $ResumeDataCopyWith<$Res> {
  _$ResumeDataCopyWithImpl(this._self, this._then);

  final ResumeData _self;
  final $Res Function(ResumeData) _then;

/// Create a copy of ResumeData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? currentStep = null,Object? resumeScore = null,Object? personalDetails = freezed,Object? professionalSummary = freezed,Object? workExperience = null,Object? leadership = null,Object? education = null,Object? skills = null,Object? projects = null,Object? languages = null,}) {
  return _then(_self.copyWith(
currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as int,resumeScore: null == resumeScore ? _self.resumeScore : resumeScore // ignore: cast_nullable_to_non_nullable
as int,personalDetails: freezed == personalDetails ? _self.personalDetails : personalDetails // ignore: cast_nullable_to_non_nullable
as PersonalDetails?,professionalSummary: freezed == professionalSummary ? _self.professionalSummary : professionalSummary // ignore: cast_nullable_to_non_nullable
as ProfessionalSummary?,workExperience: null == workExperience ? _self.workExperience : workExperience // ignore: cast_nullable_to_non_nullable
as List<WorkExperience>,leadership: null == leadership ? _self.leadership : leadership // ignore: cast_nullable_to_non_nullable
as List<WorkExperience>,education: null == education ? _self.education : education // ignore: cast_nullable_to_non_nullable
as List<Education>,skills: null == skills ? _self.skills : skills // ignore: cast_nullable_to_non_nullable
as List<Skill>,projects: null == projects ? _self.projects : projects // ignore: cast_nullable_to_non_nullable
as List<Project>,languages: null == languages ? _self.languages : languages // ignore: cast_nullable_to_non_nullable
as List<Language>,
  ));
}
/// Create a copy of ResumeData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonalDetailsCopyWith<$Res>? get personalDetails {
    if (_self.personalDetails == null) {
    return null;
  }

  return $PersonalDetailsCopyWith<$Res>(_self.personalDetails!, (value) {
    return _then(_self.copyWith(personalDetails: value));
  });
}/// Create a copy of ResumeData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfessionalSummaryCopyWith<$Res>? get professionalSummary {
    if (_self.professionalSummary == null) {
    return null;
  }

  return $ProfessionalSummaryCopyWith<$Res>(_self.professionalSummary!, (value) {
    return _then(_self.copyWith(professionalSummary: value));
  });
}
}


/// Adds pattern-matching-related methods to [ResumeData].
extension ResumeDataPatterns on ResumeData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResumeData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResumeData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResumeData value)  $default,){
final _that = this;
switch (_that) {
case _ResumeData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResumeData value)?  $default,){
final _that = this;
switch (_that) {
case _ResumeData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int currentStep,  int resumeScore, @JsonKey(name: 'header')  PersonalDetails? personalDetails, @JsonKey(name: 'objective')  ProfessionalSummary? professionalSummary, @JsonKey(name: 'work')  List<WorkExperience> workExperience,  List<WorkExperience> leadership,  List<Education> education,  List<Skill> skills,  List<Project> projects,  List<Language> languages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResumeData() when $default != null:
return $default(_that.currentStep,_that.resumeScore,_that.personalDetails,_that.professionalSummary,_that.workExperience,_that.leadership,_that.education,_that.skills,_that.projects,_that.languages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int currentStep,  int resumeScore, @JsonKey(name: 'header')  PersonalDetails? personalDetails, @JsonKey(name: 'objective')  ProfessionalSummary? professionalSummary, @JsonKey(name: 'work')  List<WorkExperience> workExperience,  List<WorkExperience> leadership,  List<Education> education,  List<Skill> skills,  List<Project> projects,  List<Language> languages)  $default,) {final _that = this;
switch (_that) {
case _ResumeData():
return $default(_that.currentStep,_that.resumeScore,_that.personalDetails,_that.professionalSummary,_that.workExperience,_that.leadership,_that.education,_that.skills,_that.projects,_that.languages);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int currentStep,  int resumeScore, @JsonKey(name: 'header')  PersonalDetails? personalDetails, @JsonKey(name: 'objective')  ProfessionalSummary? professionalSummary, @JsonKey(name: 'work')  List<WorkExperience> workExperience,  List<WorkExperience> leadership,  List<Education> education,  List<Skill> skills,  List<Project> projects,  List<Language> languages)?  $default,) {final _that = this;
switch (_that) {
case _ResumeData() when $default != null:
return $default(_that.currentStep,_that.resumeScore,_that.personalDetails,_that.professionalSummary,_that.workExperience,_that.leadership,_that.education,_that.skills,_that.projects,_that.languages);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _ResumeData implements ResumeData {
  const _ResumeData({this.currentStep = 0, this.resumeScore = 0, @JsonKey(name: 'header') this.personalDetails, @JsonKey(name: 'objective') this.professionalSummary, @JsonKey(name: 'work') final  List<WorkExperience> workExperience = const [], final  List<WorkExperience> leadership = const [], final  List<Education> education = const [], final  List<Skill> skills = const [], final  List<Project> projects = const [], final  List<Language> languages = const []}): _workExperience = workExperience,_leadership = leadership,_education = education,_skills = skills,_projects = projects,_languages = languages;
  factory _ResumeData.fromJson(Map<String, dynamic> json) => _$ResumeDataFromJson(json);

@override@JsonKey() final  int currentStep;
@override@JsonKey() final  int resumeScore;
@override@JsonKey(name: 'header') final  PersonalDetails? personalDetails;
@override@JsonKey(name: 'objective') final  ProfessionalSummary? professionalSummary;
 final  List<WorkExperience> _workExperience;
@override@JsonKey(name: 'work') List<WorkExperience> get workExperience {
  if (_workExperience is EqualUnmodifiableListView) return _workExperience;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_workExperience);
}

 final  List<WorkExperience> _leadership;
@override@JsonKey() List<WorkExperience> get leadership {
  if (_leadership is EqualUnmodifiableListView) return _leadership;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_leadership);
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

 final  List<Project> _projects;
@override@JsonKey() List<Project> get projects {
  if (_projects is EqualUnmodifiableListView) return _projects;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_projects);
}

 final  List<Language> _languages;
@override@JsonKey() List<Language> get languages {
  if (_languages is EqualUnmodifiableListView) return _languages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_languages);
}


/// Create a copy of ResumeData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResumeDataCopyWith<_ResumeData> get copyWith => __$ResumeDataCopyWithImpl<_ResumeData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ResumeDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResumeData&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep)&&(identical(other.resumeScore, resumeScore) || other.resumeScore == resumeScore)&&(identical(other.personalDetails, personalDetails) || other.personalDetails == personalDetails)&&(identical(other.professionalSummary, professionalSummary) || other.professionalSummary == professionalSummary)&&const DeepCollectionEquality().equals(other._workExperience, _workExperience)&&const DeepCollectionEquality().equals(other._leadership, _leadership)&&const DeepCollectionEquality().equals(other._education, _education)&&const DeepCollectionEquality().equals(other._skills, _skills)&&const DeepCollectionEquality().equals(other._projects, _projects)&&const DeepCollectionEquality().equals(other._languages, _languages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentStep,resumeScore,personalDetails,professionalSummary,const DeepCollectionEquality().hash(_workExperience),const DeepCollectionEquality().hash(_leadership),const DeepCollectionEquality().hash(_education),const DeepCollectionEquality().hash(_skills),const DeepCollectionEquality().hash(_projects),const DeepCollectionEquality().hash(_languages));

@override
String toString() {
  return 'ResumeData(currentStep: $currentStep, resumeScore: $resumeScore, personalDetails: $personalDetails, professionalSummary: $professionalSummary, workExperience: $workExperience, leadership: $leadership, education: $education, skills: $skills, projects: $projects, languages: $languages)';
}


}

/// @nodoc
abstract mixin class _$ResumeDataCopyWith<$Res> implements $ResumeDataCopyWith<$Res> {
  factory _$ResumeDataCopyWith(_ResumeData value, $Res Function(_ResumeData) _then) = __$ResumeDataCopyWithImpl;
@override @useResult
$Res call({
 int currentStep, int resumeScore,@JsonKey(name: 'header') PersonalDetails? personalDetails,@JsonKey(name: 'objective') ProfessionalSummary? professionalSummary,@JsonKey(name: 'work') List<WorkExperience> workExperience, List<WorkExperience> leadership, List<Education> education, List<Skill> skills, List<Project> projects, List<Language> languages
});


@override $PersonalDetailsCopyWith<$Res>? get personalDetails;@override $ProfessionalSummaryCopyWith<$Res>? get professionalSummary;

}
/// @nodoc
class __$ResumeDataCopyWithImpl<$Res>
    implements _$ResumeDataCopyWith<$Res> {
  __$ResumeDataCopyWithImpl(this._self, this._then);

  final _ResumeData _self;
  final $Res Function(_ResumeData) _then;

/// Create a copy of ResumeData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? currentStep = null,Object? resumeScore = null,Object? personalDetails = freezed,Object? professionalSummary = freezed,Object? workExperience = null,Object? leadership = null,Object? education = null,Object? skills = null,Object? projects = null,Object? languages = null,}) {
  return _then(_ResumeData(
currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as int,resumeScore: null == resumeScore ? _self.resumeScore : resumeScore // ignore: cast_nullable_to_non_nullable
as int,personalDetails: freezed == personalDetails ? _self.personalDetails : personalDetails // ignore: cast_nullable_to_non_nullable
as PersonalDetails?,professionalSummary: freezed == professionalSummary ? _self.professionalSummary : professionalSummary // ignore: cast_nullable_to_non_nullable
as ProfessionalSummary?,workExperience: null == workExperience ? _self._workExperience : workExperience // ignore: cast_nullable_to_non_nullable
as List<WorkExperience>,leadership: null == leadership ? _self._leadership : leadership // ignore: cast_nullable_to_non_nullable
as List<WorkExperience>,education: null == education ? _self._education : education // ignore: cast_nullable_to_non_nullable
as List<Education>,skills: null == skills ? _self._skills : skills // ignore: cast_nullable_to_non_nullable
as List<Skill>,projects: null == projects ? _self._projects : projects // ignore: cast_nullable_to_non_nullable
as List<Project>,languages: null == languages ? _self._languages : languages // ignore: cast_nullable_to_non_nullable
as List<Language>,
  ));
}

/// Create a copy of ResumeData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonalDetailsCopyWith<$Res>? get personalDetails {
    if (_self.personalDetails == null) {
    return null;
  }

  return $PersonalDetailsCopyWith<$Res>(_self.personalDetails!, (value) {
    return _then(_self.copyWith(personalDetails: value));
  });
}/// Create a copy of ResumeData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfessionalSummaryCopyWith<$Res>? get professionalSummary {
    if (_self.professionalSummary == null) {
    return null;
  }

  return $ProfessionalSummaryCopyWith<$Res>(_self.professionalSummary!, (value) {
    return _then(_self.copyWith(professionalSummary: value));
  });
}
}


/// @nodoc
mixin _$PersonalDetails {

@JsonKey(name: 'name') String? get fullName; String? get email;@JsonKey(name: 'phone') String? get phoneNumber;@JsonKey(name: 'location') String? get country; String? get city; String? get linkedin; String? get github; String? get nationality; List<SocialLink> get socialLinks;
/// Create a copy of PersonalDetails
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonalDetailsCopyWith<PersonalDetails> get copyWith => _$PersonalDetailsCopyWithImpl<PersonalDetails>(this as PersonalDetails, _$identity);

  /// Serializes this PersonalDetails to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersonalDetails&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.country, country) || other.country == country)&&(identical(other.city, city) || other.city == city)&&(identical(other.linkedin, linkedin) || other.linkedin == linkedin)&&(identical(other.github, github) || other.github == github)&&(identical(other.nationality, nationality) || other.nationality == nationality)&&const DeepCollectionEquality().equals(other.socialLinks, socialLinks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullName,email,phoneNumber,country,city,linkedin,github,nationality,const DeepCollectionEquality().hash(socialLinks));

@override
String toString() {
  return 'PersonalDetails(fullName: $fullName, email: $email, phoneNumber: $phoneNumber, country: $country, city: $city, linkedin: $linkedin, github: $github, nationality: $nationality, socialLinks: $socialLinks)';
}


}

/// @nodoc
abstract mixin class $PersonalDetailsCopyWith<$Res>  {
  factory $PersonalDetailsCopyWith(PersonalDetails value, $Res Function(PersonalDetails) _then) = _$PersonalDetailsCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'name') String? fullName, String? email,@JsonKey(name: 'phone') String? phoneNumber,@JsonKey(name: 'location') String? country, String? city, String? linkedin, String? github, String? nationality, List<SocialLink> socialLinks
});




}
/// @nodoc
class _$PersonalDetailsCopyWithImpl<$Res>
    implements $PersonalDetailsCopyWith<$Res> {
  _$PersonalDetailsCopyWithImpl(this._self, this._then);

  final PersonalDetails _self;
  final $Res Function(PersonalDetails) _then;

/// Create a copy of PersonalDetails
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fullName = freezed,Object? email = freezed,Object? phoneNumber = freezed,Object? country = freezed,Object? city = freezed,Object? linkedin = freezed,Object? github = freezed,Object? nationality = freezed,Object? socialLinks = null,}) {
  return _then(_self.copyWith(
fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,linkedin: freezed == linkedin ? _self.linkedin : linkedin // ignore: cast_nullable_to_non_nullable
as String?,github: freezed == github ? _self.github : github // ignore: cast_nullable_to_non_nullable
as String?,nationality: freezed == nationality ? _self.nationality : nationality // ignore: cast_nullable_to_non_nullable
as String?,socialLinks: null == socialLinks ? _self.socialLinks : socialLinks // ignore: cast_nullable_to_non_nullable
as List<SocialLink>,
  ));
}

}


/// Adds pattern-matching-related methods to [PersonalDetails].
extension PersonalDetailsPatterns on PersonalDetails {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PersonalDetails value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PersonalDetails() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PersonalDetails value)  $default,){
final _that = this;
switch (_that) {
case _PersonalDetails():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PersonalDetails value)?  $default,){
final _that = this;
switch (_that) {
case _PersonalDetails() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'name')  String? fullName,  String? email, @JsonKey(name: 'phone')  String? phoneNumber, @JsonKey(name: 'location')  String? country,  String? city,  String? linkedin,  String? github,  String? nationality,  List<SocialLink> socialLinks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PersonalDetails() when $default != null:
return $default(_that.fullName,_that.email,_that.phoneNumber,_that.country,_that.city,_that.linkedin,_that.github,_that.nationality,_that.socialLinks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'name')  String? fullName,  String? email, @JsonKey(name: 'phone')  String? phoneNumber, @JsonKey(name: 'location')  String? country,  String? city,  String? linkedin,  String? github,  String? nationality,  List<SocialLink> socialLinks)  $default,) {final _that = this;
switch (_that) {
case _PersonalDetails():
return $default(_that.fullName,_that.email,_that.phoneNumber,_that.country,_that.city,_that.linkedin,_that.github,_that.nationality,_that.socialLinks);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'name')  String? fullName,  String? email, @JsonKey(name: 'phone')  String? phoneNumber, @JsonKey(name: 'location')  String? country,  String? city,  String? linkedin,  String? github,  String? nationality,  List<SocialLink> socialLinks)?  $default,) {final _that = this;
switch (_that) {
case _PersonalDetails() when $default != null:
return $default(_that.fullName,_that.email,_that.phoneNumber,_that.country,_that.city,_that.linkedin,_that.github,_that.nationality,_that.socialLinks);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _PersonalDetails implements PersonalDetails {
  const _PersonalDetails({@JsonKey(name: 'name') this.fullName, this.email, @JsonKey(name: 'phone') this.phoneNumber, @JsonKey(name: 'location') this.country, this.city, this.linkedin, this.github, this.nationality, final  List<SocialLink> socialLinks = const []}): _socialLinks = socialLinks;
  factory _PersonalDetails.fromJson(Map<String, dynamic> json) => _$PersonalDetailsFromJson(json);

@override@JsonKey(name: 'name') final  String? fullName;
@override final  String? email;
@override@JsonKey(name: 'phone') final  String? phoneNumber;
@override@JsonKey(name: 'location') final  String? country;
@override final  String? city;
@override final  String? linkedin;
@override final  String? github;
@override final  String? nationality;
 final  List<SocialLink> _socialLinks;
@override@JsonKey() List<SocialLink> get socialLinks {
  if (_socialLinks is EqualUnmodifiableListView) return _socialLinks;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_socialLinks);
}


/// Create a copy of PersonalDetails
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersonalDetailsCopyWith<_PersonalDetails> get copyWith => __$PersonalDetailsCopyWithImpl<_PersonalDetails>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PersonalDetailsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PersonalDetails&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.country, country) || other.country == country)&&(identical(other.city, city) || other.city == city)&&(identical(other.linkedin, linkedin) || other.linkedin == linkedin)&&(identical(other.github, github) || other.github == github)&&(identical(other.nationality, nationality) || other.nationality == nationality)&&const DeepCollectionEquality().equals(other._socialLinks, _socialLinks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullName,email,phoneNumber,country,city,linkedin,github,nationality,const DeepCollectionEquality().hash(_socialLinks));

@override
String toString() {
  return 'PersonalDetails(fullName: $fullName, email: $email, phoneNumber: $phoneNumber, country: $country, city: $city, linkedin: $linkedin, github: $github, nationality: $nationality, socialLinks: $socialLinks)';
}


}

/// @nodoc
abstract mixin class _$PersonalDetailsCopyWith<$Res> implements $PersonalDetailsCopyWith<$Res> {
  factory _$PersonalDetailsCopyWith(_PersonalDetails value, $Res Function(_PersonalDetails) _then) = __$PersonalDetailsCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'name') String? fullName, String? email,@JsonKey(name: 'phone') String? phoneNumber,@JsonKey(name: 'location') String? country, String? city, String? linkedin, String? github, String? nationality, List<SocialLink> socialLinks
});




}
/// @nodoc
class __$PersonalDetailsCopyWithImpl<$Res>
    implements _$PersonalDetailsCopyWith<$Res> {
  __$PersonalDetailsCopyWithImpl(this._self, this._then);

  final _PersonalDetails _self;
  final $Res Function(_PersonalDetails) _then;

/// Create a copy of PersonalDetails
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fullName = freezed,Object? email = freezed,Object? phoneNumber = freezed,Object? country = freezed,Object? city = freezed,Object? linkedin = freezed,Object? github = freezed,Object? nationality = freezed,Object? socialLinks = null,}) {
  return _then(_PersonalDetails(
fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,linkedin: freezed == linkedin ? _self.linkedin : linkedin // ignore: cast_nullable_to_non_nullable
as String?,github: freezed == github ? _self.github : github // ignore: cast_nullable_to_non_nullable
as String?,nationality: freezed == nationality ? _self.nationality : nationality // ignore: cast_nullable_to_non_nullable
as String?,socialLinks: null == socialLinks ? _self._socialLinks : socialLinks // ignore: cast_nullable_to_non_nullable
as List<SocialLink>,
  ));
}


}


/// @nodoc
mixin _$SocialLink {

 String? get platform; String? get url;
/// Create a copy of SocialLink
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SocialLinkCopyWith<SocialLink> get copyWith => _$SocialLinkCopyWithImpl<SocialLink>(this as SocialLink, _$identity);

  /// Serializes this SocialLink to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SocialLink&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,platform,url);

@override
String toString() {
  return 'SocialLink(platform: $platform, url: $url)';
}


}

/// @nodoc
abstract mixin class $SocialLinkCopyWith<$Res>  {
  factory $SocialLinkCopyWith(SocialLink value, $Res Function(SocialLink) _then) = _$SocialLinkCopyWithImpl;
@useResult
$Res call({
 String? platform, String? url
});




}
/// @nodoc
class _$SocialLinkCopyWithImpl<$Res>
    implements $SocialLinkCopyWith<$Res> {
  _$SocialLinkCopyWithImpl(this._self, this._then);

  final SocialLink _self;
  final $Res Function(SocialLink) _then;

/// Create a copy of SocialLink
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? platform = freezed,Object? url = freezed,}) {
  return _then(_self.copyWith(
platform: freezed == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SocialLink].
extension SocialLinkPatterns on SocialLink {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SocialLink value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SocialLink() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SocialLink value)  $default,){
final _that = this;
switch (_that) {
case _SocialLink():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SocialLink value)?  $default,){
final _that = this;
switch (_that) {
case _SocialLink() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? platform,  String? url)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SocialLink() when $default != null:
return $default(_that.platform,_that.url);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? platform,  String? url)  $default,) {final _that = this;
switch (_that) {
case _SocialLink():
return $default(_that.platform,_that.url);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? platform,  String? url)?  $default,) {final _that = this;
switch (_that) {
case _SocialLink() when $default != null:
return $default(_that.platform,_that.url);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _SocialLink implements SocialLink {
  const _SocialLink({this.platform, this.url});
  factory _SocialLink.fromJson(Map<String, dynamic> json) => _$SocialLinkFromJson(json);

@override final  String? platform;
@override final  String? url;

/// Create a copy of SocialLink
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SocialLinkCopyWith<_SocialLink> get copyWith => __$SocialLinkCopyWithImpl<_SocialLink>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SocialLinkToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SocialLink&&(identical(other.platform, platform) || other.platform == platform)&&(identical(other.url, url) || other.url == url));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,platform,url);

@override
String toString() {
  return 'SocialLink(platform: $platform, url: $url)';
}


}

/// @nodoc
abstract mixin class _$SocialLinkCopyWith<$Res> implements $SocialLinkCopyWith<$Res> {
  factory _$SocialLinkCopyWith(_SocialLink value, $Res Function(_SocialLink) _then) = __$SocialLinkCopyWithImpl;
@override @useResult
$Res call({
 String? platform, String? url
});




}
/// @nodoc
class __$SocialLinkCopyWithImpl<$Res>
    implements _$SocialLinkCopyWith<$Res> {
  __$SocialLinkCopyWithImpl(this._self, this._then);

  final _SocialLink _self;
  final $Res Function(_SocialLink) _then;

/// Create a copy of SocialLink
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? platform = freezed,Object? url = freezed,}) {
  return _then(_SocialLink(
platform: freezed == platform ? _self.platform : platform // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ProfessionalSummary {

@JsonKey(name: 'objective') String? get summary;
/// Create a copy of ProfessionalSummary
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfessionalSummaryCopyWith<ProfessionalSummary> get copyWith => _$ProfessionalSummaryCopyWithImpl<ProfessionalSummary>(this as ProfessionalSummary, _$identity);

  /// Serializes this ProfessionalSummary to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfessionalSummary&&(identical(other.summary, summary) || other.summary == summary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,summary);

@override
String toString() {
  return 'ProfessionalSummary(summary: $summary)';
}


}

/// @nodoc
abstract mixin class $ProfessionalSummaryCopyWith<$Res>  {
  factory $ProfessionalSummaryCopyWith(ProfessionalSummary value, $Res Function(ProfessionalSummary) _then) = _$ProfessionalSummaryCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'objective') String? summary
});




}
/// @nodoc
class _$ProfessionalSummaryCopyWithImpl<$Res>
    implements $ProfessionalSummaryCopyWith<$Res> {
  _$ProfessionalSummaryCopyWithImpl(this._self, this._then);

  final ProfessionalSummary _self;
  final $Res Function(ProfessionalSummary) _then;

/// Create a copy of ProfessionalSummary
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? summary = freezed,}) {
  return _then(_self.copyWith(
summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfessionalSummary].
extension ProfessionalSummaryPatterns on ProfessionalSummary {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfessionalSummary value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfessionalSummary() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfessionalSummary value)  $default,){
final _that = this;
switch (_that) {
case _ProfessionalSummary():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfessionalSummary value)?  $default,){
final _that = this;
switch (_that) {
case _ProfessionalSummary() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'objective')  String? summary)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfessionalSummary() when $default != null:
return $default(_that.summary);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'objective')  String? summary)  $default,) {final _that = this;
switch (_that) {
case _ProfessionalSummary():
return $default(_that.summary);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'objective')  String? summary)?  $default,) {final _that = this;
switch (_that) {
case _ProfessionalSummary() when $default != null:
return $default(_that.summary);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _ProfessionalSummary implements ProfessionalSummary {
  const _ProfessionalSummary({@JsonKey(name: 'objective') this.summary});
  factory _ProfessionalSummary.fromJson(Map<String, dynamic> json) => _$ProfessionalSummaryFromJson(json);

@override@JsonKey(name: 'objective') final  String? summary;

/// Create a copy of ProfessionalSummary
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfessionalSummaryCopyWith<_ProfessionalSummary> get copyWith => __$ProfessionalSummaryCopyWithImpl<_ProfessionalSummary>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfessionalSummaryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfessionalSummary&&(identical(other.summary, summary) || other.summary == summary));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,summary);

@override
String toString() {
  return 'ProfessionalSummary(summary: $summary)';
}


}

/// @nodoc
abstract mixin class _$ProfessionalSummaryCopyWith<$Res> implements $ProfessionalSummaryCopyWith<$Res> {
  factory _$ProfessionalSummaryCopyWith(_ProfessionalSummary value, $Res Function(_ProfessionalSummary) _then) = __$ProfessionalSummaryCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'objective') String? summary
});




}
/// @nodoc
class __$ProfessionalSummaryCopyWithImpl<$Res>
    implements _$ProfessionalSummaryCopyWith<$Res> {
  __$ProfessionalSummaryCopyWithImpl(this._self, this._then);

  final _ProfessionalSummary _self;
  final $Res Function(_ProfessionalSummary) _then;

/// Create a copy of ProfessionalSummary
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? summary = freezed,}) {
  return _then(_ProfessionalSummary(
summary: freezed == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$WorkExperience {

 String? get position;@JsonKey(name: 'company') String? get organization;@JsonKey(name: 'location') String? get city;@JsonKey(name: 'details') String? get keyTasks; DateTime? get startDate; DateTime? get endDate; bool get isPresent;@JsonKey(name: 'date') String? get dateString;
/// Create a copy of WorkExperience
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkExperienceCopyWith<WorkExperience> get copyWith => _$WorkExperienceCopyWithImpl<WorkExperience>(this as WorkExperience, _$identity);

  /// Serializes this WorkExperience to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkExperience&&(identical(other.position, position) || other.position == position)&&(identical(other.organization, organization) || other.organization == organization)&&(identical(other.city, city) || other.city == city)&&(identical(other.keyTasks, keyTasks) || other.keyTasks == keyTasks)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.isPresent, isPresent) || other.isPresent == isPresent)&&(identical(other.dateString, dateString) || other.dateString == dateString));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,position,organization,city,keyTasks,startDate,endDate,isPresent,dateString);

@override
String toString() {
  return 'WorkExperience(position: $position, organization: $organization, city: $city, keyTasks: $keyTasks, startDate: $startDate, endDate: $endDate, isPresent: $isPresent, dateString: $dateString)';
}


}

/// @nodoc
abstract mixin class $WorkExperienceCopyWith<$Res>  {
  factory $WorkExperienceCopyWith(WorkExperience value, $Res Function(WorkExperience) _then) = _$WorkExperienceCopyWithImpl;
@useResult
$Res call({
 String? position,@JsonKey(name: 'company') String? organization,@JsonKey(name: 'location') String? city,@JsonKey(name: 'details') String? keyTasks, DateTime? startDate, DateTime? endDate, bool isPresent,@JsonKey(name: 'date') String? dateString
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
@pragma('vm:prefer-inline') @override $Res call({Object? position = freezed,Object? organization = freezed,Object? city = freezed,Object? keyTasks = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? isPresent = null,Object? dateString = freezed,}) {
  return _then(_self.copyWith(
position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String?,organization: freezed == organization ? _self.organization : organization // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,keyTasks: freezed == keyTasks ? _self.keyTasks : keyTasks // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isPresent: null == isPresent ? _self.isPresent : isPresent // ignore: cast_nullable_to_non_nullable
as bool,dateString: freezed == dateString ? _self.dateString : dateString // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? position, @JsonKey(name: 'company')  String? organization, @JsonKey(name: 'location')  String? city, @JsonKey(name: 'details')  String? keyTasks,  DateTime? startDate,  DateTime? endDate,  bool isPresent, @JsonKey(name: 'date')  String? dateString)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkExperience() when $default != null:
return $default(_that.position,_that.organization,_that.city,_that.keyTasks,_that.startDate,_that.endDate,_that.isPresent,_that.dateString);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? position, @JsonKey(name: 'company')  String? organization, @JsonKey(name: 'location')  String? city, @JsonKey(name: 'details')  String? keyTasks,  DateTime? startDate,  DateTime? endDate,  bool isPresent, @JsonKey(name: 'date')  String? dateString)  $default,) {final _that = this;
switch (_that) {
case _WorkExperience():
return $default(_that.position,_that.organization,_that.city,_that.keyTasks,_that.startDate,_that.endDate,_that.isPresent,_that.dateString);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? position, @JsonKey(name: 'company')  String? organization, @JsonKey(name: 'location')  String? city, @JsonKey(name: 'details')  String? keyTasks,  DateTime? startDate,  DateTime? endDate,  bool isPresent, @JsonKey(name: 'date')  String? dateString)?  $default,) {final _that = this;
switch (_that) {
case _WorkExperience() when $default != null:
return $default(_that.position,_that.organization,_that.city,_that.keyTasks,_that.startDate,_that.endDate,_that.isPresent,_that.dateString);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _WorkExperience implements WorkExperience {
  const _WorkExperience({this.position, @JsonKey(name: 'company') this.organization, @JsonKey(name: 'location') this.city, @JsonKey(name: 'details') this.keyTasks, this.startDate, this.endDate, this.isPresent = false, @JsonKey(name: 'date') this.dateString});
  factory _WorkExperience.fromJson(Map<String, dynamic> json) => _$WorkExperienceFromJson(json);

@override final  String? position;
@override@JsonKey(name: 'company') final  String? organization;
@override@JsonKey(name: 'location') final  String? city;
@override@JsonKey(name: 'details') final  String? keyTasks;
@override final  DateTime? startDate;
@override final  DateTime? endDate;
@override@JsonKey() final  bool isPresent;
@override@JsonKey(name: 'date') final  String? dateString;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkExperience&&(identical(other.position, position) || other.position == position)&&(identical(other.organization, organization) || other.organization == organization)&&(identical(other.city, city) || other.city == city)&&(identical(other.keyTasks, keyTasks) || other.keyTasks == keyTasks)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.isPresent, isPresent) || other.isPresent == isPresent)&&(identical(other.dateString, dateString) || other.dateString == dateString));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,position,organization,city,keyTasks,startDate,endDate,isPresent,dateString);

@override
String toString() {
  return 'WorkExperience(position: $position, organization: $organization, city: $city, keyTasks: $keyTasks, startDate: $startDate, endDate: $endDate, isPresent: $isPresent, dateString: $dateString)';
}


}

/// @nodoc
abstract mixin class _$WorkExperienceCopyWith<$Res> implements $WorkExperienceCopyWith<$Res> {
  factory _$WorkExperienceCopyWith(_WorkExperience value, $Res Function(_WorkExperience) _then) = __$WorkExperienceCopyWithImpl;
@override @useResult
$Res call({
 String? position,@JsonKey(name: 'company') String? organization,@JsonKey(name: 'location') String? city,@JsonKey(name: 'details') String? keyTasks, DateTime? startDate, DateTime? endDate, bool isPresent,@JsonKey(name: 'date') String? dateString
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
@override @pragma('vm:prefer-inline') $Res call({Object? position = freezed,Object? organization = freezed,Object? city = freezed,Object? keyTasks = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? isPresent = null,Object? dateString = freezed,}) {
  return _then(_WorkExperience(
position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String?,organization: freezed == organization ? _self.organization : organization // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,keyTasks: freezed == keyTasks ? _self.keyTasks : keyTasks // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isPresent: null == isPresent ? _self.isPresent : isPresent // ignore: cast_nullable_to_non_nullable
as bool,dateString: freezed == dateString ? _self.dateString : dateString // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$Education {

 String? get school; String? get degree;@JsonKey(name: 'location') String? get city; DateTime? get startDate; DateTime? get endDate; String? get description; String? get university; String? get major;@JsonKey(name: 'GPA') String? get gpa;
/// Create a copy of Education
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EducationCopyWith<Education> get copyWith => _$EducationCopyWithImpl<Education>(this as Education, _$identity);

  /// Serializes this Education to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Education&&(identical(other.school, school) || other.school == school)&&(identical(other.degree, degree) || other.degree == degree)&&(identical(other.city, city) || other.city == city)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.description, description) || other.description == description)&&(identical(other.university, university) || other.university == university)&&(identical(other.major, major) || other.major == major)&&(identical(other.gpa, gpa) || other.gpa == gpa));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,school,degree,city,startDate,endDate,description,university,major,gpa);

@override
String toString() {
  return 'Education(school: $school, degree: $degree, city: $city, startDate: $startDate, endDate: $endDate, description: $description, university: $university, major: $major, gpa: $gpa)';
}


}

/// @nodoc
abstract mixin class $EducationCopyWith<$Res>  {
  factory $EducationCopyWith(Education value, $Res Function(Education) _then) = _$EducationCopyWithImpl;
@useResult
$Res call({
 String? school, String? degree,@JsonKey(name: 'location') String? city, DateTime? startDate, DateTime? endDate, String? description, String? university, String? major,@JsonKey(name: 'GPA') String? gpa
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
@pragma('vm:prefer-inline') @override $Res call({Object? school = freezed,Object? degree = freezed,Object? city = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? description = freezed,Object? university = freezed,Object? major = freezed,Object? gpa = freezed,}) {
  return _then(_self.copyWith(
school: freezed == school ? _self.school : school // ignore: cast_nullable_to_non_nullable
as String?,degree: freezed == degree ? _self.degree : degree // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,university: freezed == university ? _self.university : university // ignore: cast_nullable_to_non_nullable
as String?,major: freezed == major ? _self.major : major // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? school,  String? degree, @JsonKey(name: 'location')  String? city,  DateTime? startDate,  DateTime? endDate,  String? description,  String? university,  String? major, @JsonKey(name: 'GPA')  String? gpa)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Education() when $default != null:
return $default(_that.school,_that.degree,_that.city,_that.startDate,_that.endDate,_that.description,_that.university,_that.major,_that.gpa);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? school,  String? degree, @JsonKey(name: 'location')  String? city,  DateTime? startDate,  DateTime? endDate,  String? description,  String? university,  String? major, @JsonKey(name: 'GPA')  String? gpa)  $default,) {final _that = this;
switch (_that) {
case _Education():
return $default(_that.school,_that.degree,_that.city,_that.startDate,_that.endDate,_that.description,_that.university,_that.major,_that.gpa);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? school,  String? degree, @JsonKey(name: 'location')  String? city,  DateTime? startDate,  DateTime? endDate,  String? description,  String? university,  String? major, @JsonKey(name: 'GPA')  String? gpa)?  $default,) {final _that = this;
switch (_that) {
case _Education() when $default != null:
return $default(_that.school,_that.degree,_that.city,_that.startDate,_that.endDate,_that.description,_that.university,_that.major,_that.gpa);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _Education implements Education {
  const _Education({this.school, this.degree, @JsonKey(name: 'location') this.city, this.startDate, this.endDate, this.description, this.university, this.major, @JsonKey(name: 'GPA') this.gpa});
  factory _Education.fromJson(Map<String, dynamic> json) => _$EducationFromJson(json);

@override final  String? school;
@override final  String? degree;
@override@JsonKey(name: 'location') final  String? city;
@override final  DateTime? startDate;
@override final  DateTime? endDate;
@override final  String? description;
@override final  String? university;
@override final  String? major;
@override@JsonKey(name: 'GPA') final  String? gpa;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Education&&(identical(other.school, school) || other.school == school)&&(identical(other.degree, degree) || other.degree == degree)&&(identical(other.city, city) || other.city == city)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.description, description) || other.description == description)&&(identical(other.university, university) || other.university == university)&&(identical(other.major, major) || other.major == major)&&(identical(other.gpa, gpa) || other.gpa == gpa));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,school,degree,city,startDate,endDate,description,university,major,gpa);

@override
String toString() {
  return 'Education(school: $school, degree: $degree, city: $city, startDate: $startDate, endDate: $endDate, description: $description, university: $university, major: $major, gpa: $gpa)';
}


}

/// @nodoc
abstract mixin class _$EducationCopyWith<$Res> implements $EducationCopyWith<$Res> {
  factory _$EducationCopyWith(_Education value, $Res Function(_Education) _then) = __$EducationCopyWithImpl;
@override @useResult
$Res call({
 String? school, String? degree,@JsonKey(name: 'location') String? city, DateTime? startDate, DateTime? endDate, String? description, String? university, String? major,@JsonKey(name: 'GPA') String? gpa
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
@override @pragma('vm:prefer-inline') $Res call({Object? school = freezed,Object? degree = freezed,Object? city = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? description = freezed,Object? university = freezed,Object? major = freezed,Object? gpa = freezed,}) {
  return _then(_Education(
school: freezed == school ? _self.school : school // ignore: cast_nullable_to_non_nullable
as String?,degree: freezed == degree ? _self.degree : degree // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,university: freezed == university ? _self.university : university // ignore: cast_nullable_to_non_nullable
as String?,major: freezed == major ? _self.major : major // ignore: cast_nullable_to_non_nullable
as String?,gpa: freezed == gpa ? _self.gpa : gpa // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$Project {

 String? get name; String? get description; String? get url; List<String>? get highlights;
/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProjectCopyWith<Project> get copyWith => _$ProjectCopyWithImpl<Project>(this as Project, _$identity);

  /// Serializes this Project to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Project&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other.highlights, highlights));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,description,url,const DeepCollectionEquality().hash(highlights));

@override
String toString() {
  return 'Project(name: $name, description: $description, url: $url, highlights: $highlights)';
}


}

/// @nodoc
abstract mixin class $ProjectCopyWith<$Res>  {
  factory $ProjectCopyWith(Project value, $Res Function(Project) _then) = _$ProjectCopyWithImpl;
@useResult
$Res call({
 String? name, String? description, String? url, List<String>? highlights
});




}
/// @nodoc
class _$ProjectCopyWithImpl<$Res>
    implements $ProjectCopyWith<$Res> {
  _$ProjectCopyWithImpl(this._self, this._then);

  final Project _self;
  final $Res Function(Project) _then;

/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? description = freezed,Object? url = freezed,Object? highlights = freezed,}) {
  return _then(_self.copyWith(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,highlights: freezed == highlights ? _self.highlights : highlights // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [Project].
extension ProjectPatterns on Project {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Project value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Project() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Project value)  $default,){
final _that = this;
switch (_that) {
case _Project():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Project value)?  $default,){
final _that = this;
switch (_that) {
case _Project() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? name,  String? description,  String? url,  List<String>? highlights)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Project() when $default != null:
return $default(_that.name,_that.description,_that.url,_that.highlights);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? name,  String? description,  String? url,  List<String>? highlights)  $default,) {final _that = this;
switch (_that) {
case _Project():
return $default(_that.name,_that.description,_that.url,_that.highlights);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? name,  String? description,  String? url,  List<String>? highlights)?  $default,) {final _that = this;
switch (_that) {
case _Project() when $default != null:
return $default(_that.name,_that.description,_that.url,_that.highlights);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _Project implements Project {
  const _Project({this.name, this.description, this.url, final  List<String>? highlights}): _highlights = highlights;
  factory _Project.fromJson(Map<String, dynamic> json) => _$ProjectFromJson(json);

@override final  String? name;
@override final  String? description;
@override final  String? url;
 final  List<String>? _highlights;
@override List<String>? get highlights {
  final value = _highlights;
  if (value == null) return null;
  if (_highlights is EqualUnmodifiableListView) return _highlights;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProjectCopyWith<_Project> get copyWith => __$ProjectCopyWithImpl<_Project>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProjectToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Project&&(identical(other.name, name) || other.name == name)&&(identical(other.description, description) || other.description == description)&&(identical(other.url, url) || other.url == url)&&const DeepCollectionEquality().equals(other._highlights, _highlights));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,description,url,const DeepCollectionEquality().hash(_highlights));

@override
String toString() {
  return 'Project(name: $name, description: $description, url: $url, highlights: $highlights)';
}


}

/// @nodoc
abstract mixin class _$ProjectCopyWith<$Res> implements $ProjectCopyWith<$Res> {
  factory _$ProjectCopyWith(_Project value, $Res Function(_Project) _then) = __$ProjectCopyWithImpl;
@override @useResult
$Res call({
 String? name, String? description, String? url, List<String>? highlights
});




}
/// @nodoc
class __$ProjectCopyWithImpl<$Res>
    implements _$ProjectCopyWith<$Res> {
  __$ProjectCopyWithImpl(this._self, this._then);

  final _Project _self;
  final $Res Function(_Project) _then;

/// Create a copy of Project
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? description = freezed,Object? url = freezed,Object? highlights = freezed,}) {
  return _then(_Project(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,url: freezed == url ? _self.url : url // ignore: cast_nullable_to_non_nullable
as String?,highlights: freezed == highlights ? _self._highlights : highlights // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}


/// @nodoc
mixin _$Language {

 String? get name; String? get proficiency;
/// Create a copy of Language
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LanguageCopyWith<Language> get copyWith => _$LanguageCopyWithImpl<Language>(this as Language, _$identity);

  /// Serializes this Language to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Language&&(identical(other.name, name) || other.name == name)&&(identical(other.proficiency, proficiency) || other.proficiency == proficiency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,proficiency);

@override
String toString() {
  return 'Language(name: $name, proficiency: $proficiency)';
}


}

/// @nodoc
abstract mixin class $LanguageCopyWith<$Res>  {
  factory $LanguageCopyWith(Language value, $Res Function(Language) _then) = _$LanguageCopyWithImpl;
@useResult
$Res call({
 String? name, String? proficiency
});




}
/// @nodoc
class _$LanguageCopyWithImpl<$Res>
    implements $LanguageCopyWith<$Res> {
  _$LanguageCopyWithImpl(this._self, this._then);

  final Language _self;
  final $Res Function(Language) _then;

/// Create a copy of Language
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? proficiency = freezed,}) {
  return _then(_self.copyWith(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,proficiency: freezed == proficiency ? _self.proficiency : proficiency // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Language].
extension LanguagePatterns on Language {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Language value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Language() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Language value)  $default,){
final _that = this;
switch (_that) {
case _Language():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Language value)?  $default,){
final _that = this;
switch (_that) {
case _Language() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? name,  String? proficiency)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Language() when $default != null:
return $default(_that.name,_that.proficiency);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? name,  String? proficiency)  $default,) {final _that = this;
switch (_that) {
case _Language():
return $default(_that.name,_that.proficiency);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? name,  String? proficiency)?  $default,) {final _that = this;
switch (_that) {
case _Language() when $default != null:
return $default(_that.name,_that.proficiency);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _Language implements Language {
  const _Language({this.name, this.proficiency});
  factory _Language.fromJson(Map<String, dynamic> json) => _$LanguageFromJson(json);

@override final  String? name;
@override final  String? proficiency;

/// Create a copy of Language
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LanguageCopyWith<_Language> get copyWith => __$LanguageCopyWithImpl<_Language>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LanguageToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Language&&(identical(other.name, name) || other.name == name)&&(identical(other.proficiency, proficiency) || other.proficiency == proficiency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,proficiency);

@override
String toString() {
  return 'Language(name: $name, proficiency: $proficiency)';
}


}

/// @nodoc
abstract mixin class _$LanguageCopyWith<$Res> implements $LanguageCopyWith<$Res> {
  factory _$LanguageCopyWith(_Language value, $Res Function(_Language) _then) = __$LanguageCopyWithImpl;
@override @useResult
$Res call({
 String? name, String? proficiency
});




}
/// @nodoc
class __$LanguageCopyWithImpl<$Res>
    implements _$LanguageCopyWith<$Res> {
  __$LanguageCopyWithImpl(this._self, this._then);

  final _Language _self;
  final $Res Function(_Language) _then;

/// Create a copy of Language
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? proficiency = freezed,}) {
  return _then(_Language(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,proficiency: freezed == proficiency ? _self.proficiency : proficiency // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$Skill {

 String? get name; SkillCategory? get category; ProficiencyLevel? get proficiency;
/// Create a copy of Skill
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SkillCopyWith<Skill> get copyWith => _$SkillCopyWithImpl<Skill>(this as Skill, _$identity);

  /// Serializes this Skill to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Skill&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.proficiency, proficiency) || other.proficiency == proficiency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,category,proficiency);

@override
String toString() {
  return 'Skill(name: $name, category: $category, proficiency: $proficiency)';
}


}

/// @nodoc
abstract mixin class $SkillCopyWith<$Res>  {
  factory $SkillCopyWith(Skill value, $Res Function(Skill) _then) = _$SkillCopyWithImpl;
@useResult
$Res call({
 String? name, SkillCategory? category, ProficiencyLevel? proficiency
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
@pragma('vm:prefer-inline') @override $Res call({Object? name = freezed,Object? category = freezed,Object? proficiency = freezed,}) {
  return _then(_self.copyWith(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as SkillCategory?,proficiency: freezed == proficiency ? _self.proficiency : proficiency // ignore: cast_nullable_to_non_nullable
as ProficiencyLevel?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? name,  SkillCategory? category,  ProficiencyLevel? proficiency)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Skill() when $default != null:
return $default(_that.name,_that.category,_that.proficiency);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? name,  SkillCategory? category,  ProficiencyLevel? proficiency)  $default,) {final _that = this;
switch (_that) {
case _Skill():
return $default(_that.name,_that.category,_that.proficiency);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? name,  SkillCategory? category,  ProficiencyLevel? proficiency)?  $default,) {final _that = this;
switch (_that) {
case _Skill() when $default != null:
return $default(_that.name,_that.category,_that.proficiency);case _:
  return null;

}
}

}

/// @nodoc

@JsonSerializable(fieldRename: FieldRename.snake)
class _Skill implements Skill {
  const _Skill({this.name, this.category, this.proficiency});
  factory _Skill.fromJson(Map<String, dynamic> json) => _$SkillFromJson(json);

@override final  String? name;
@override final  SkillCategory? category;
@override final  ProficiencyLevel? proficiency;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Skill&&(identical(other.name, name) || other.name == name)&&(identical(other.category, category) || other.category == category)&&(identical(other.proficiency, proficiency) || other.proficiency == proficiency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,category,proficiency);

@override
String toString() {
  return 'Skill(name: $name, category: $category, proficiency: $proficiency)';
}


}

/// @nodoc
abstract mixin class _$SkillCopyWith<$Res> implements $SkillCopyWith<$Res> {
  factory _$SkillCopyWith(_Skill value, $Res Function(_Skill) _then) = __$SkillCopyWithImpl;
@override @useResult
$Res call({
 String? name, SkillCategory? category, ProficiencyLevel? proficiency
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
@override @pragma('vm:prefer-inline') $Res call({Object? name = freezed,Object? category = freezed,Object? proficiency = freezed,}) {
  return _then(_Skill(
name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,category: freezed == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as SkillCategory?,proficiency: freezed == proficiency ? _self.proficiency : proficiency // ignore: cast_nullable_to_non_nullable
as ProficiencyLevel?,
  ));
}


}

// dart format on
