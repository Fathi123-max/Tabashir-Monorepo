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

 int get currentStep; int get resumeScore; PersonalDetails? get personalDetails; ProfessionalSummary? get professionalSummary; List<WorkExperience> get workExperience; List<Education> get education; List<Skill> get skills;
/// Create a copy of ResumeData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResumeDataCopyWith<ResumeData> get copyWith => _$ResumeDataCopyWithImpl<ResumeData>(this as ResumeData, _$identity);

  /// Serializes this ResumeData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResumeData&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep)&&(identical(other.resumeScore, resumeScore) || other.resumeScore == resumeScore)&&(identical(other.personalDetails, personalDetails) || other.personalDetails == personalDetails)&&(identical(other.professionalSummary, professionalSummary) || other.professionalSummary == professionalSummary)&&const DeepCollectionEquality().equals(other.workExperience, workExperience)&&const DeepCollectionEquality().equals(other.education, education)&&const DeepCollectionEquality().equals(other.skills, skills));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentStep,resumeScore,personalDetails,professionalSummary,const DeepCollectionEquality().hash(workExperience),const DeepCollectionEquality().hash(education),const DeepCollectionEquality().hash(skills));

@override
String toString() {
  return 'ResumeData(currentStep: $currentStep, resumeScore: $resumeScore, personalDetails: $personalDetails, professionalSummary: $professionalSummary, workExperience: $workExperience, education: $education, skills: $skills)';
}


}

/// @nodoc
abstract mixin class $ResumeDataCopyWith<$Res>  {
  factory $ResumeDataCopyWith(ResumeData value, $Res Function(ResumeData) _then) = _$ResumeDataCopyWithImpl;
@useResult
$Res call({
 int currentStep, int resumeScore, PersonalDetails? personalDetails, ProfessionalSummary? professionalSummary, List<WorkExperience> workExperience, List<Education> education, List<Skill> skills
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
@pragma('vm:prefer-inline') @override $Res call({Object? currentStep = null,Object? resumeScore = null,Object? personalDetails = freezed,Object? professionalSummary = freezed,Object? workExperience = null,Object? education = null,Object? skills = null,}) {
  return _then(_self.copyWith(
currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as int,resumeScore: null == resumeScore ? _self.resumeScore : resumeScore // ignore: cast_nullable_to_non_nullable
as int,personalDetails: freezed == personalDetails ? _self.personalDetails : personalDetails // ignore: cast_nullable_to_non_nullable
as PersonalDetails?,professionalSummary: freezed == professionalSummary ? _self.professionalSummary : professionalSummary // ignore: cast_nullable_to_non_nullable
as ProfessionalSummary?,workExperience: null == workExperience ? _self.workExperience : workExperience // ignore: cast_nullable_to_non_nullable
as List<WorkExperience>,education: null == education ? _self.education : education // ignore: cast_nullable_to_non_nullable
as List<Education>,skills: null == skills ? _self.skills : skills // ignore: cast_nullable_to_non_nullable
as List<Skill>,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int currentStep,  int resumeScore,  PersonalDetails? personalDetails,  ProfessionalSummary? professionalSummary,  List<WorkExperience> workExperience,  List<Education> education,  List<Skill> skills)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResumeData() when $default != null:
return $default(_that.currentStep,_that.resumeScore,_that.personalDetails,_that.professionalSummary,_that.workExperience,_that.education,_that.skills);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int currentStep,  int resumeScore,  PersonalDetails? personalDetails,  ProfessionalSummary? professionalSummary,  List<WorkExperience> workExperience,  List<Education> education,  List<Skill> skills)  $default,) {final _that = this;
switch (_that) {
case _ResumeData():
return $default(_that.currentStep,_that.resumeScore,_that.personalDetails,_that.professionalSummary,_that.workExperience,_that.education,_that.skills);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int currentStep,  int resumeScore,  PersonalDetails? personalDetails,  ProfessionalSummary? professionalSummary,  List<WorkExperience> workExperience,  List<Education> education,  List<Skill> skills)?  $default,) {final _that = this;
switch (_that) {
case _ResumeData() when $default != null:
return $default(_that.currentStep,_that.resumeScore,_that.personalDetails,_that.professionalSummary,_that.workExperience,_that.education,_that.skills);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ResumeData implements ResumeData {
  const _ResumeData({this.currentStep = 0, this.resumeScore = 0, this.personalDetails, this.professionalSummary, final  List<WorkExperience> workExperience = const [], final  List<Education> education = const [], final  List<Skill> skills = const []}): _workExperience = workExperience,_education = education,_skills = skills;
  factory _ResumeData.fromJson(Map<String, dynamic> json) => _$ResumeDataFromJson(json);

@override@JsonKey() final  int currentStep;
@override@JsonKey() final  int resumeScore;
@override final  PersonalDetails? personalDetails;
@override final  ProfessionalSummary? professionalSummary;
 final  List<WorkExperience> _workExperience;
@override@JsonKey() List<WorkExperience> get workExperience {
  if (_workExperience is EqualUnmodifiableListView) return _workExperience;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_workExperience);
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResumeData&&(identical(other.currentStep, currentStep) || other.currentStep == currentStep)&&(identical(other.resumeScore, resumeScore) || other.resumeScore == resumeScore)&&(identical(other.personalDetails, personalDetails) || other.personalDetails == personalDetails)&&(identical(other.professionalSummary, professionalSummary) || other.professionalSummary == professionalSummary)&&const DeepCollectionEquality().equals(other._workExperience, _workExperience)&&const DeepCollectionEquality().equals(other._education, _education)&&const DeepCollectionEquality().equals(other._skills, _skills));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,currentStep,resumeScore,personalDetails,professionalSummary,const DeepCollectionEquality().hash(_workExperience),const DeepCollectionEquality().hash(_education),const DeepCollectionEquality().hash(_skills));

@override
String toString() {
  return 'ResumeData(currentStep: $currentStep, resumeScore: $resumeScore, personalDetails: $personalDetails, professionalSummary: $professionalSummary, workExperience: $workExperience, education: $education, skills: $skills)';
}


}

/// @nodoc
abstract mixin class _$ResumeDataCopyWith<$Res> implements $ResumeDataCopyWith<$Res> {
  factory _$ResumeDataCopyWith(_ResumeData value, $Res Function(_ResumeData) _then) = __$ResumeDataCopyWithImpl;
@override @useResult
$Res call({
 int currentStep, int resumeScore, PersonalDetails? personalDetails, ProfessionalSummary? professionalSummary, List<WorkExperience> workExperience, List<Education> education, List<Skill> skills
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
@override @pragma('vm:prefer-inline') $Res call({Object? currentStep = null,Object? resumeScore = null,Object? personalDetails = freezed,Object? professionalSummary = freezed,Object? workExperience = null,Object? education = null,Object? skills = null,}) {
  return _then(_ResumeData(
currentStep: null == currentStep ? _self.currentStep : currentStep // ignore: cast_nullable_to_non_nullable
as int,resumeScore: null == resumeScore ? _self.resumeScore : resumeScore // ignore: cast_nullable_to_non_nullable
as int,personalDetails: freezed == personalDetails ? _self.personalDetails : personalDetails // ignore: cast_nullable_to_non_nullable
as PersonalDetails?,professionalSummary: freezed == professionalSummary ? _self.professionalSummary : professionalSummary // ignore: cast_nullable_to_non_nullable
as ProfessionalSummary?,workExperience: null == workExperience ? _self._workExperience : workExperience // ignore: cast_nullable_to_non_nullable
as List<WorkExperience>,education: null == education ? _self._education : education // ignore: cast_nullable_to_non_nullable
as List<Education>,skills: null == skills ? _self._skills : skills // ignore: cast_nullable_to_non_nullable
as List<Skill>,
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

 String? get fullName; String? get email; String? get phoneNumber; String? get country; String? get city; List<SocialLink> get socialLinks;
/// Create a copy of PersonalDetails
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonalDetailsCopyWith<PersonalDetails> get copyWith => _$PersonalDetailsCopyWithImpl<PersonalDetails>(this as PersonalDetails, _$identity);

  /// Serializes this PersonalDetails to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersonalDetails&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.country, country) || other.country == country)&&(identical(other.city, city) || other.city == city)&&const DeepCollectionEquality().equals(other.socialLinks, socialLinks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullName,email,phoneNumber,country,city,const DeepCollectionEquality().hash(socialLinks));

@override
String toString() {
  return 'PersonalDetails(fullName: $fullName, email: $email, phoneNumber: $phoneNumber, country: $country, city: $city, socialLinks: $socialLinks)';
}


}

/// @nodoc
abstract mixin class $PersonalDetailsCopyWith<$Res>  {
  factory $PersonalDetailsCopyWith(PersonalDetails value, $Res Function(PersonalDetails) _then) = _$PersonalDetailsCopyWithImpl;
@useResult
$Res call({
 String? fullName, String? email, String? phoneNumber, String? country, String? city, List<SocialLink> socialLinks
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
@pragma('vm:prefer-inline') @override $Res call({Object? fullName = freezed,Object? email = freezed,Object? phoneNumber = freezed,Object? country = freezed,Object? city = freezed,Object? socialLinks = null,}) {
  return _then(_self.copyWith(
fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? fullName,  String? email,  String? phoneNumber,  String? country,  String? city,  List<SocialLink> socialLinks)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PersonalDetails() when $default != null:
return $default(_that.fullName,_that.email,_that.phoneNumber,_that.country,_that.city,_that.socialLinks);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? fullName,  String? email,  String? phoneNumber,  String? country,  String? city,  List<SocialLink> socialLinks)  $default,) {final _that = this;
switch (_that) {
case _PersonalDetails():
return $default(_that.fullName,_that.email,_that.phoneNumber,_that.country,_that.city,_that.socialLinks);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? fullName,  String? email,  String? phoneNumber,  String? country,  String? city,  List<SocialLink> socialLinks)?  $default,) {final _that = this;
switch (_that) {
case _PersonalDetails() when $default != null:
return $default(_that.fullName,_that.email,_that.phoneNumber,_that.country,_that.city,_that.socialLinks);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PersonalDetails implements PersonalDetails {
  const _PersonalDetails({this.fullName, this.email, this.phoneNumber, this.country, this.city, final  List<SocialLink> socialLinks = const []}): _socialLinks = socialLinks;
  factory _PersonalDetails.fromJson(Map<String, dynamic> json) => _$PersonalDetailsFromJson(json);

@override final  String? fullName;
@override final  String? email;
@override final  String? phoneNumber;
@override final  String? country;
@override final  String? city;
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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PersonalDetails&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phoneNumber, phoneNumber) || other.phoneNumber == phoneNumber)&&(identical(other.country, country) || other.country == country)&&(identical(other.city, city) || other.city == city)&&const DeepCollectionEquality().equals(other._socialLinks, _socialLinks));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullName,email,phoneNumber,country,city,const DeepCollectionEquality().hash(_socialLinks));

@override
String toString() {
  return 'PersonalDetails(fullName: $fullName, email: $email, phoneNumber: $phoneNumber, country: $country, city: $city, socialLinks: $socialLinks)';
}


}

/// @nodoc
abstract mixin class _$PersonalDetailsCopyWith<$Res> implements $PersonalDetailsCopyWith<$Res> {
  factory _$PersonalDetailsCopyWith(_PersonalDetails value, $Res Function(_PersonalDetails) _then) = __$PersonalDetailsCopyWithImpl;
@override @useResult
$Res call({
 String? fullName, String? email, String? phoneNumber, String? country, String? city, List<SocialLink> socialLinks
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
@override @pragma('vm:prefer-inline') $Res call({Object? fullName = freezed,Object? email = freezed,Object? phoneNumber = freezed,Object? country = freezed,Object? city = freezed,Object? socialLinks = null,}) {
  return _then(_PersonalDetails(
fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phoneNumber: freezed == phoneNumber ? _self.phoneNumber : phoneNumber // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
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
@JsonSerializable()

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

 String? get summary;
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
 String? summary
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? summary)?  $default,{required TResult orElse(),}) {final _that = this;
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? summary)  $default,) {final _that = this;
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? summary)?  $default,) {final _that = this;
switch (_that) {
case _ProfessionalSummary() when $default != null:
return $default(_that.summary);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfessionalSummary implements ProfessionalSummary {
  const _ProfessionalSummary({this.summary});
  factory _ProfessionalSummary.fromJson(Map<String, dynamic> json) => _$ProfessionalSummaryFromJson(json);

@override final  String? summary;

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
 String? summary
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

 String? get position; String? get organization; String? get city; String? get keyTasks; DateTime? get startDate; DateTime? get endDate; bool get isPresent;
/// Create a copy of WorkExperience
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$WorkExperienceCopyWith<WorkExperience> get copyWith => _$WorkExperienceCopyWithImpl<WorkExperience>(this as WorkExperience, _$identity);

  /// Serializes this WorkExperience to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is WorkExperience&&(identical(other.position, position) || other.position == position)&&(identical(other.organization, organization) || other.organization == organization)&&(identical(other.city, city) || other.city == city)&&(identical(other.keyTasks, keyTasks) || other.keyTasks == keyTasks)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.isPresent, isPresent) || other.isPresent == isPresent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,position,organization,city,keyTasks,startDate,endDate,isPresent);

@override
String toString() {
  return 'WorkExperience(position: $position, organization: $organization, city: $city, keyTasks: $keyTasks, startDate: $startDate, endDate: $endDate, isPresent: $isPresent)';
}


}

/// @nodoc
abstract mixin class $WorkExperienceCopyWith<$Res>  {
  factory $WorkExperienceCopyWith(WorkExperience value, $Res Function(WorkExperience) _then) = _$WorkExperienceCopyWithImpl;
@useResult
$Res call({
 String? position, String? organization, String? city, String? keyTasks, DateTime? startDate, DateTime? endDate, bool isPresent
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
@pragma('vm:prefer-inline') @override $Res call({Object? position = freezed,Object? organization = freezed,Object? city = freezed,Object? keyTasks = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? isPresent = null,}) {
  return _then(_self.copyWith(
position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String?,organization: freezed == organization ? _self.organization : organization // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,keyTasks: freezed == keyTasks ? _self.keyTasks : keyTasks // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isPresent: null == isPresent ? _self.isPresent : isPresent // ignore: cast_nullable_to_non_nullable
as bool,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? position,  String? organization,  String? city,  String? keyTasks,  DateTime? startDate,  DateTime? endDate,  bool isPresent)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _WorkExperience() when $default != null:
return $default(_that.position,_that.organization,_that.city,_that.keyTasks,_that.startDate,_that.endDate,_that.isPresent);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? position,  String? organization,  String? city,  String? keyTasks,  DateTime? startDate,  DateTime? endDate,  bool isPresent)  $default,) {final _that = this;
switch (_that) {
case _WorkExperience():
return $default(_that.position,_that.organization,_that.city,_that.keyTasks,_that.startDate,_that.endDate,_that.isPresent);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? position,  String? organization,  String? city,  String? keyTasks,  DateTime? startDate,  DateTime? endDate,  bool isPresent)?  $default,) {final _that = this;
switch (_that) {
case _WorkExperience() when $default != null:
return $default(_that.position,_that.organization,_that.city,_that.keyTasks,_that.startDate,_that.endDate,_that.isPresent);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _WorkExperience implements WorkExperience {
  const _WorkExperience({this.position, this.organization, this.city, this.keyTasks, this.startDate, this.endDate, this.isPresent = false});
  factory _WorkExperience.fromJson(Map<String, dynamic> json) => _$WorkExperienceFromJson(json);

@override final  String? position;
@override final  String? organization;
@override final  String? city;
@override final  String? keyTasks;
@override final  DateTime? startDate;
@override final  DateTime? endDate;
@override@JsonKey() final  bool isPresent;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _WorkExperience&&(identical(other.position, position) || other.position == position)&&(identical(other.organization, organization) || other.organization == organization)&&(identical(other.city, city) || other.city == city)&&(identical(other.keyTasks, keyTasks) || other.keyTasks == keyTasks)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.isPresent, isPresent) || other.isPresent == isPresent));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,position,organization,city,keyTasks,startDate,endDate,isPresent);

@override
String toString() {
  return 'WorkExperience(position: $position, organization: $organization, city: $city, keyTasks: $keyTasks, startDate: $startDate, endDate: $endDate, isPresent: $isPresent)';
}


}

/// @nodoc
abstract mixin class _$WorkExperienceCopyWith<$Res> implements $WorkExperienceCopyWith<$Res> {
  factory _$WorkExperienceCopyWith(_WorkExperience value, $Res Function(_WorkExperience) _then) = __$WorkExperienceCopyWithImpl;
@override @useResult
$Res call({
 String? position, String? organization, String? city, String? keyTasks, DateTime? startDate, DateTime? endDate, bool isPresent
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
@override @pragma('vm:prefer-inline') $Res call({Object? position = freezed,Object? organization = freezed,Object? city = freezed,Object? keyTasks = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? isPresent = null,}) {
  return _then(_WorkExperience(
position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String?,organization: freezed == organization ? _self.organization : organization // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,keyTasks: freezed == keyTasks ? _self.keyTasks : keyTasks // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,isPresent: null == isPresent ? _self.isPresent : isPresent // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}


}


/// @nodoc
mixin _$Education {

 String? get school; String? get degree; String? get city; DateTime? get startDate; DateTime? get endDate; String? get description;
/// Create a copy of Education
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EducationCopyWith<Education> get copyWith => _$EducationCopyWithImpl<Education>(this as Education, _$identity);

  /// Serializes this Education to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Education&&(identical(other.school, school) || other.school == school)&&(identical(other.degree, degree) || other.degree == degree)&&(identical(other.city, city) || other.city == city)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,school,degree,city,startDate,endDate,description);

@override
String toString() {
  return 'Education(school: $school, degree: $degree, city: $city, startDate: $startDate, endDate: $endDate, description: $description)';
}


}

/// @nodoc
abstract mixin class $EducationCopyWith<$Res>  {
  factory $EducationCopyWith(Education value, $Res Function(Education) _then) = _$EducationCopyWithImpl;
@useResult
$Res call({
 String? school, String? degree, String? city, DateTime? startDate, DateTime? endDate, String? description
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
@pragma('vm:prefer-inline') @override $Res call({Object? school = freezed,Object? degree = freezed,Object? city = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? description = freezed,}) {
  return _then(_self.copyWith(
school: freezed == school ? _self.school : school // ignore: cast_nullable_to_non_nullable
as String?,degree: freezed == degree ? _self.degree : degree // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? school,  String? degree,  String? city,  DateTime? startDate,  DateTime? endDate,  String? description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Education() when $default != null:
return $default(_that.school,_that.degree,_that.city,_that.startDate,_that.endDate,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? school,  String? degree,  String? city,  DateTime? startDate,  DateTime? endDate,  String? description)  $default,) {final _that = this;
switch (_that) {
case _Education():
return $default(_that.school,_that.degree,_that.city,_that.startDate,_that.endDate,_that.description);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? school,  String? degree,  String? city,  DateTime? startDate,  DateTime? endDate,  String? description)?  $default,) {final _that = this;
switch (_that) {
case _Education() when $default != null:
return $default(_that.school,_that.degree,_that.city,_that.startDate,_that.endDate,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Education implements Education {
  const _Education({this.school, this.degree, this.city, this.startDate, this.endDate, this.description});
  factory _Education.fromJson(Map<String, dynamic> json) => _$EducationFromJson(json);

@override final  String? school;
@override final  String? degree;
@override final  String? city;
@override final  DateTime? startDate;
@override final  DateTime? endDate;
@override final  String? description;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Education&&(identical(other.school, school) || other.school == school)&&(identical(other.degree, degree) || other.degree == degree)&&(identical(other.city, city) || other.city == city)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,school,degree,city,startDate,endDate,description);

@override
String toString() {
  return 'Education(school: $school, degree: $degree, city: $city, startDate: $startDate, endDate: $endDate, description: $description)';
}


}

/// @nodoc
abstract mixin class _$EducationCopyWith<$Res> implements $EducationCopyWith<$Res> {
  factory _$EducationCopyWith(_Education value, $Res Function(_Education) _then) = __$EducationCopyWithImpl;
@override @useResult
$Res call({
 String? school, String? degree, String? city, DateTime? startDate, DateTime? endDate, String? description
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
@override @pragma('vm:prefer-inline') $Res call({Object? school = freezed,Object? degree = freezed,Object? city = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? description = freezed,}) {
  return _then(_Education(
school: freezed == school ? _self.school : school // ignore: cast_nullable_to_non_nullable
as String?,degree: freezed == degree ? _self.degree : degree // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
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
@JsonSerializable()

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
