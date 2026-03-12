// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_create_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JobCreate {

/// Job title
 String get jobTitle;/// Job posting date YYYY-MM-DD
 String get jobDate;/// Entity
 String? get entity;/// Nationality
 String? get nationality;/// Gender
 String? get gender;/// Academic qualification
 String? get academicQualification;/// Experience
 String? get experience;/// Languages
 String? get languages;/// Salary
 String? get salary;/// Vacancy city
 String? get vacancyCity;/// Working hours
 String? get workingHours;/// Working days
 String? get workingDays;/// Application email
 String? get applicationEmail;/// Job description
 String? get jobDescription;/// Phone
 String? get phone;/// Apply URL
 String? get applyUrl;/// Company Name
 String? get companyName;/// Website URL
 String? get websiteUrl;/// Job Type
 String? get jobType;
/// Create a copy of JobCreate
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobCreateCopyWith<JobCreate> get copyWith => _$JobCreateCopyWithImpl<JobCreate>(this as JobCreate, _$identity);

  /// Serializes this JobCreate to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobCreate&&(identical(other.jobTitle, jobTitle) || other.jobTitle == jobTitle)&&(identical(other.jobDate, jobDate) || other.jobDate == jobDate)&&(identical(other.entity, entity) || other.entity == entity)&&(identical(other.nationality, nationality) || other.nationality == nationality)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.academicQualification, academicQualification) || other.academicQualification == academicQualification)&&(identical(other.experience, experience) || other.experience == experience)&&(identical(other.languages, languages) || other.languages == languages)&&(identical(other.salary, salary) || other.salary == salary)&&(identical(other.vacancyCity, vacancyCity) || other.vacancyCity == vacancyCity)&&(identical(other.workingHours, workingHours) || other.workingHours == workingHours)&&(identical(other.workingDays, workingDays) || other.workingDays == workingDays)&&(identical(other.applicationEmail, applicationEmail) || other.applicationEmail == applicationEmail)&&(identical(other.jobDescription, jobDescription) || other.jobDescription == jobDescription)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.applyUrl, applyUrl) || other.applyUrl == applyUrl)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.websiteUrl, websiteUrl) || other.websiteUrl == websiteUrl)&&(identical(other.jobType, jobType) || other.jobType == jobType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,jobTitle,jobDate,entity,nationality,gender,academicQualification,experience,languages,salary,vacancyCity,workingHours,workingDays,applicationEmail,jobDescription,phone,applyUrl,companyName,websiteUrl,jobType]);

@override
String toString() {
  return 'JobCreate(jobTitle: $jobTitle, jobDate: $jobDate, entity: $entity, nationality: $nationality, gender: $gender, academicQualification: $academicQualification, experience: $experience, languages: $languages, salary: $salary, vacancyCity: $vacancyCity, workingHours: $workingHours, workingDays: $workingDays, applicationEmail: $applicationEmail, jobDescription: $jobDescription, phone: $phone, applyUrl: $applyUrl, companyName: $companyName, websiteUrl: $websiteUrl, jobType: $jobType)';
}


}

/// @nodoc
abstract mixin class $JobCreateCopyWith<$Res>  {
  factory $JobCreateCopyWith(JobCreate value, $Res Function(JobCreate) _then) = _$JobCreateCopyWithImpl;
@useResult
$Res call({
 String jobTitle, String jobDate, String? entity, String? nationality, String? gender, String? academicQualification, String? experience, String? languages, String? salary, String? vacancyCity, String? workingHours, String? workingDays, String? applicationEmail, String? jobDescription, String? phone, String? applyUrl, String? companyName, String? websiteUrl, String? jobType
});




}
/// @nodoc
class _$JobCreateCopyWithImpl<$Res>
    implements $JobCreateCopyWith<$Res> {
  _$JobCreateCopyWithImpl(this._self, this._then);

  final JobCreate _self;
  final $Res Function(JobCreate) _then;

/// Create a copy of JobCreate
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? jobTitle = null,Object? jobDate = null,Object? entity = freezed,Object? nationality = freezed,Object? gender = freezed,Object? academicQualification = freezed,Object? experience = freezed,Object? languages = freezed,Object? salary = freezed,Object? vacancyCity = freezed,Object? workingHours = freezed,Object? workingDays = freezed,Object? applicationEmail = freezed,Object? jobDescription = freezed,Object? phone = freezed,Object? applyUrl = freezed,Object? companyName = freezed,Object? websiteUrl = freezed,Object? jobType = freezed,}) {
  return _then(_self.copyWith(
jobTitle: null == jobTitle ? _self.jobTitle : jobTitle // ignore: cast_nullable_to_non_nullable
as String,jobDate: null == jobDate ? _self.jobDate : jobDate // ignore: cast_nullable_to_non_nullable
as String,entity: freezed == entity ? _self.entity : entity // ignore: cast_nullable_to_non_nullable
as String?,nationality: freezed == nationality ? _self.nationality : nationality // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,academicQualification: freezed == academicQualification ? _self.academicQualification : academicQualification // ignore: cast_nullable_to_non_nullable
as String?,experience: freezed == experience ? _self.experience : experience // ignore: cast_nullable_to_non_nullable
as String?,languages: freezed == languages ? _self.languages : languages // ignore: cast_nullable_to_non_nullable
as String?,salary: freezed == salary ? _self.salary : salary // ignore: cast_nullable_to_non_nullable
as String?,vacancyCity: freezed == vacancyCity ? _self.vacancyCity : vacancyCity // ignore: cast_nullable_to_non_nullable
as String?,workingHours: freezed == workingHours ? _self.workingHours : workingHours // ignore: cast_nullable_to_non_nullable
as String?,workingDays: freezed == workingDays ? _self.workingDays : workingDays // ignore: cast_nullable_to_non_nullable
as String?,applicationEmail: freezed == applicationEmail ? _self.applicationEmail : applicationEmail // ignore: cast_nullable_to_non_nullable
as String?,jobDescription: freezed == jobDescription ? _self.jobDescription : jobDescription // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,applyUrl: freezed == applyUrl ? _self.applyUrl : applyUrl // ignore: cast_nullable_to_non_nullable
as String?,companyName: freezed == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String?,websiteUrl: freezed == websiteUrl ? _self.websiteUrl : websiteUrl // ignore: cast_nullable_to_non_nullable
as String?,jobType: freezed == jobType ? _self.jobType : jobType // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [JobCreate].
extension JobCreatePatterns on JobCreate {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobCreate value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobCreate() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobCreate value)  $default,){
final _that = this;
switch (_that) {
case _JobCreate():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobCreate value)?  $default,){
final _that = this;
switch (_that) {
case _JobCreate() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String jobTitle,  String jobDate,  String? entity,  String? nationality,  String? gender,  String? academicQualification,  String? experience,  String? languages,  String? salary,  String? vacancyCity,  String? workingHours,  String? workingDays,  String? applicationEmail,  String? jobDescription,  String? phone,  String? applyUrl,  String? companyName,  String? websiteUrl,  String? jobType)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobCreate() when $default != null:
return $default(_that.jobTitle,_that.jobDate,_that.entity,_that.nationality,_that.gender,_that.academicQualification,_that.experience,_that.languages,_that.salary,_that.vacancyCity,_that.workingHours,_that.workingDays,_that.applicationEmail,_that.jobDescription,_that.phone,_that.applyUrl,_that.companyName,_that.websiteUrl,_that.jobType);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String jobTitle,  String jobDate,  String? entity,  String? nationality,  String? gender,  String? academicQualification,  String? experience,  String? languages,  String? salary,  String? vacancyCity,  String? workingHours,  String? workingDays,  String? applicationEmail,  String? jobDescription,  String? phone,  String? applyUrl,  String? companyName,  String? websiteUrl,  String? jobType)  $default,) {final _that = this;
switch (_that) {
case _JobCreate():
return $default(_that.jobTitle,_that.jobDate,_that.entity,_that.nationality,_that.gender,_that.academicQualification,_that.experience,_that.languages,_that.salary,_that.vacancyCity,_that.workingHours,_that.workingDays,_that.applicationEmail,_that.jobDescription,_that.phone,_that.applyUrl,_that.companyName,_that.websiteUrl,_that.jobType);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String jobTitle,  String jobDate,  String? entity,  String? nationality,  String? gender,  String? academicQualification,  String? experience,  String? languages,  String? salary,  String? vacancyCity,  String? workingHours,  String? workingDays,  String? applicationEmail,  String? jobDescription,  String? phone,  String? applyUrl,  String? companyName,  String? websiteUrl,  String? jobType)?  $default,) {final _that = this;
switch (_that) {
case _JobCreate() when $default != null:
return $default(_that.jobTitle,_that.jobDate,_that.entity,_that.nationality,_that.gender,_that.academicQualification,_that.experience,_that.languages,_that.salary,_that.vacancyCity,_that.workingHours,_that.workingDays,_that.applicationEmail,_that.jobDescription,_that.phone,_that.applyUrl,_that.companyName,_that.websiteUrl,_that.jobType);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JobCreate implements JobCreate {
  const _JobCreate({required this.jobTitle, required this.jobDate, this.entity, this.nationality, this.gender, this.academicQualification, this.experience, this.languages, this.salary, this.vacancyCity, this.workingHours, this.workingDays, this.applicationEmail, this.jobDescription, this.phone, this.applyUrl, this.companyName, this.websiteUrl, this.jobType});
  factory _JobCreate.fromJson(Map<String, dynamic> json) => _$JobCreateFromJson(json);

/// Job title
@override final  String jobTitle;
/// Job posting date YYYY-MM-DD
@override final  String jobDate;
/// Entity
@override final  String? entity;
/// Nationality
@override final  String? nationality;
/// Gender
@override final  String? gender;
/// Academic qualification
@override final  String? academicQualification;
/// Experience
@override final  String? experience;
/// Languages
@override final  String? languages;
/// Salary
@override final  String? salary;
/// Vacancy city
@override final  String? vacancyCity;
/// Working hours
@override final  String? workingHours;
/// Working days
@override final  String? workingDays;
/// Application email
@override final  String? applicationEmail;
/// Job description
@override final  String? jobDescription;
/// Phone
@override final  String? phone;
/// Apply URL
@override final  String? applyUrl;
/// Company Name
@override final  String? companyName;
/// Website URL
@override final  String? websiteUrl;
/// Job Type
@override final  String? jobType;

/// Create a copy of JobCreate
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobCreateCopyWith<_JobCreate> get copyWith => __$JobCreateCopyWithImpl<_JobCreate>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JobCreateToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobCreate&&(identical(other.jobTitle, jobTitle) || other.jobTitle == jobTitle)&&(identical(other.jobDate, jobDate) || other.jobDate == jobDate)&&(identical(other.entity, entity) || other.entity == entity)&&(identical(other.nationality, nationality) || other.nationality == nationality)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.academicQualification, academicQualification) || other.academicQualification == academicQualification)&&(identical(other.experience, experience) || other.experience == experience)&&(identical(other.languages, languages) || other.languages == languages)&&(identical(other.salary, salary) || other.salary == salary)&&(identical(other.vacancyCity, vacancyCity) || other.vacancyCity == vacancyCity)&&(identical(other.workingHours, workingHours) || other.workingHours == workingHours)&&(identical(other.workingDays, workingDays) || other.workingDays == workingDays)&&(identical(other.applicationEmail, applicationEmail) || other.applicationEmail == applicationEmail)&&(identical(other.jobDescription, jobDescription) || other.jobDescription == jobDescription)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.applyUrl, applyUrl) || other.applyUrl == applyUrl)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.websiteUrl, websiteUrl) || other.websiteUrl == websiteUrl)&&(identical(other.jobType, jobType) || other.jobType == jobType));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,jobTitle,jobDate,entity,nationality,gender,academicQualification,experience,languages,salary,vacancyCity,workingHours,workingDays,applicationEmail,jobDescription,phone,applyUrl,companyName,websiteUrl,jobType]);

@override
String toString() {
  return 'JobCreate(jobTitle: $jobTitle, jobDate: $jobDate, entity: $entity, nationality: $nationality, gender: $gender, academicQualification: $academicQualification, experience: $experience, languages: $languages, salary: $salary, vacancyCity: $vacancyCity, workingHours: $workingHours, workingDays: $workingDays, applicationEmail: $applicationEmail, jobDescription: $jobDescription, phone: $phone, applyUrl: $applyUrl, companyName: $companyName, websiteUrl: $websiteUrl, jobType: $jobType)';
}


}

/// @nodoc
abstract mixin class _$JobCreateCopyWith<$Res> implements $JobCreateCopyWith<$Res> {
  factory _$JobCreateCopyWith(_JobCreate value, $Res Function(_JobCreate) _then) = __$JobCreateCopyWithImpl;
@override @useResult
$Res call({
 String jobTitle, String jobDate, String? entity, String? nationality, String? gender, String? academicQualification, String? experience, String? languages, String? salary, String? vacancyCity, String? workingHours, String? workingDays, String? applicationEmail, String? jobDescription, String? phone, String? applyUrl, String? companyName, String? websiteUrl, String? jobType
});




}
/// @nodoc
class __$JobCreateCopyWithImpl<$Res>
    implements _$JobCreateCopyWith<$Res> {
  __$JobCreateCopyWithImpl(this._self, this._then);

  final _JobCreate _self;
  final $Res Function(_JobCreate) _then;

/// Create a copy of JobCreate
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? jobTitle = null,Object? jobDate = null,Object? entity = freezed,Object? nationality = freezed,Object? gender = freezed,Object? academicQualification = freezed,Object? experience = freezed,Object? languages = freezed,Object? salary = freezed,Object? vacancyCity = freezed,Object? workingHours = freezed,Object? workingDays = freezed,Object? applicationEmail = freezed,Object? jobDescription = freezed,Object? phone = freezed,Object? applyUrl = freezed,Object? companyName = freezed,Object? websiteUrl = freezed,Object? jobType = freezed,}) {
  return _then(_JobCreate(
jobTitle: null == jobTitle ? _self.jobTitle : jobTitle // ignore: cast_nullable_to_non_nullable
as String,jobDate: null == jobDate ? _self.jobDate : jobDate // ignore: cast_nullable_to_non_nullable
as String,entity: freezed == entity ? _self.entity : entity // ignore: cast_nullable_to_non_nullable
as String?,nationality: freezed == nationality ? _self.nationality : nationality // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,academicQualification: freezed == academicQualification ? _self.academicQualification : academicQualification // ignore: cast_nullable_to_non_nullable
as String?,experience: freezed == experience ? _self.experience : experience // ignore: cast_nullable_to_non_nullable
as String?,languages: freezed == languages ? _self.languages : languages // ignore: cast_nullable_to_non_nullable
as String?,salary: freezed == salary ? _self.salary : salary // ignore: cast_nullable_to_non_nullable
as String?,vacancyCity: freezed == vacancyCity ? _self.vacancyCity : vacancyCity // ignore: cast_nullable_to_non_nullable
as String?,workingHours: freezed == workingHours ? _self.workingHours : workingHours // ignore: cast_nullable_to_non_nullable
as String?,workingDays: freezed == workingDays ? _self.workingDays : workingDays // ignore: cast_nullable_to_non_nullable
as String?,applicationEmail: freezed == applicationEmail ? _self.applicationEmail : applicationEmail // ignore: cast_nullable_to_non_nullable
as String?,jobDescription: freezed == jobDescription ? _self.jobDescription : jobDescription // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,applyUrl: freezed == applyUrl ? _self.applyUrl : applyUrl // ignore: cast_nullable_to_non_nullable
as String?,companyName: freezed == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String?,websiteUrl: freezed == websiteUrl ? _self.websiteUrl : websiteUrl // ignore: cast_nullable_to_non_nullable
as String?,jobType: freezed == jobType ? _self.jobType : jobType // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
