// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_details_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JobDetailsResponse {

/// Job ID
@JsonKey(name: 'id', fromJson: _dynamicToString) String? get jobId;/// Job title
@JsonKey(name: 'job_title') String? get jobTitle;/// Company name
@JsonKey(name: 'entity') String? get companyName;/// Job description
@JsonKey(name: 'job_description') String? get jobDescription;/// Location (city)
@JsonKey(name: 'vacancy_city') String? get location;/// Salary
@JsonKey(name: 'salary') String? get salary;/// Job type
@JsonKey(name: 'job_type') String? get jobType;/// Application URL
@JsonKey(name: 'apply_url') String? get applyUrl;/// Academic qualifications required
@JsonKey(name: 'academic_qualification') String? get academicQualification;/// Experience level required
@JsonKey(name: 'experience') String? get experience;/// Language skills required
@JsonKey(name: 'languages') String? get languages;/// Working hours
@JsonKey(name: 'working_hours') String? get workingHours;/// Working days
@JsonKey(name: 'working_days') String? get workingDays;/// Application email
@JsonKey(name: 'application_email') String? get applicationEmail;/// Job posting date
@JsonKey(name: 'job_date') String? get jobDate;/// Contact phone
@JsonKey(name: 'phone') String? get phone;/// Job source (where it was posted)
@JsonKey(name: 'source') String? get source;/// Nationality requirement
@JsonKey(name: 'nationality') String? get nationality;/// Gender requirement
@JsonKey(name: 'gender') String? get gender;/// Is job saved
@JsonKey(name: 'is_saved') bool? get isSaved;/// Match percentage for the job
@JsonKey(name: 'match_percentage', fromJson: _dynamicToString) String? get matchPercentage;
/// Create a copy of JobDetailsResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobDetailsResponseCopyWith<JobDetailsResponse> get copyWith => _$JobDetailsResponseCopyWithImpl<JobDetailsResponse>(this as JobDetailsResponse, _$identity);

  /// Serializes this JobDetailsResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobDetailsResponse&&(identical(other.jobId, jobId) || other.jobId == jobId)&&(identical(other.jobTitle, jobTitle) || other.jobTitle == jobTitle)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.jobDescription, jobDescription) || other.jobDescription == jobDescription)&&(identical(other.location, location) || other.location == location)&&(identical(other.salary, salary) || other.salary == salary)&&(identical(other.jobType, jobType) || other.jobType == jobType)&&(identical(other.applyUrl, applyUrl) || other.applyUrl == applyUrl)&&(identical(other.academicQualification, academicQualification) || other.academicQualification == academicQualification)&&(identical(other.experience, experience) || other.experience == experience)&&(identical(other.languages, languages) || other.languages == languages)&&(identical(other.workingHours, workingHours) || other.workingHours == workingHours)&&(identical(other.workingDays, workingDays) || other.workingDays == workingDays)&&(identical(other.applicationEmail, applicationEmail) || other.applicationEmail == applicationEmail)&&(identical(other.jobDate, jobDate) || other.jobDate == jobDate)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.source, source) || other.source == source)&&(identical(other.nationality, nationality) || other.nationality == nationality)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.isSaved, isSaved) || other.isSaved == isSaved)&&(identical(other.matchPercentage, matchPercentage) || other.matchPercentage == matchPercentage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,jobId,jobTitle,companyName,jobDescription,location,salary,jobType,applyUrl,academicQualification,experience,languages,workingHours,workingDays,applicationEmail,jobDate,phone,source,nationality,gender,isSaved,matchPercentage]);

@override
String toString() {
  return 'JobDetailsResponse(jobId: $jobId, jobTitle: $jobTitle, companyName: $companyName, jobDescription: $jobDescription, location: $location, salary: $salary, jobType: $jobType, applyUrl: $applyUrl, academicQualification: $academicQualification, experience: $experience, languages: $languages, workingHours: $workingHours, workingDays: $workingDays, applicationEmail: $applicationEmail, jobDate: $jobDate, phone: $phone, source: $source, nationality: $nationality, gender: $gender, isSaved: $isSaved, matchPercentage: $matchPercentage)';
}


}

/// @nodoc
abstract mixin class $JobDetailsResponseCopyWith<$Res>  {
  factory $JobDetailsResponseCopyWith(JobDetailsResponse value, $Res Function(JobDetailsResponse) _then) = _$JobDetailsResponseCopyWithImpl;
@useResult
$Res call({
@JsonKey(name: 'id', fromJson: _dynamicToString) String? jobId,@JsonKey(name: 'job_title') String? jobTitle,@JsonKey(name: 'entity') String? companyName,@JsonKey(name: 'job_description') String? jobDescription,@JsonKey(name: 'vacancy_city') String? location,@JsonKey(name: 'salary') String? salary,@JsonKey(name: 'job_type') String? jobType,@JsonKey(name: 'apply_url') String? applyUrl,@JsonKey(name: 'academic_qualification') String? academicQualification,@JsonKey(name: 'experience') String? experience,@JsonKey(name: 'languages') String? languages,@JsonKey(name: 'working_hours') String? workingHours,@JsonKey(name: 'working_days') String? workingDays,@JsonKey(name: 'application_email') String? applicationEmail,@JsonKey(name: 'job_date') String? jobDate,@JsonKey(name: 'phone') String? phone,@JsonKey(name: 'source') String? source,@JsonKey(name: 'nationality') String? nationality,@JsonKey(name: 'gender') String? gender,@JsonKey(name: 'is_saved') bool? isSaved,@JsonKey(name: 'match_percentage', fromJson: _dynamicToString) String? matchPercentage
});




}
/// @nodoc
class _$JobDetailsResponseCopyWithImpl<$Res>
    implements $JobDetailsResponseCopyWith<$Res> {
  _$JobDetailsResponseCopyWithImpl(this._self, this._then);

  final JobDetailsResponse _self;
  final $Res Function(JobDetailsResponse) _then;

/// Create a copy of JobDetailsResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? jobId = freezed,Object? jobTitle = freezed,Object? companyName = freezed,Object? jobDescription = freezed,Object? location = freezed,Object? salary = freezed,Object? jobType = freezed,Object? applyUrl = freezed,Object? academicQualification = freezed,Object? experience = freezed,Object? languages = freezed,Object? workingHours = freezed,Object? workingDays = freezed,Object? applicationEmail = freezed,Object? jobDate = freezed,Object? phone = freezed,Object? source = freezed,Object? nationality = freezed,Object? gender = freezed,Object? isSaved = freezed,Object? matchPercentage = freezed,}) {
  return _then(_self.copyWith(
jobId: freezed == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String?,jobTitle: freezed == jobTitle ? _self.jobTitle : jobTitle // ignore: cast_nullable_to_non_nullable
as String?,companyName: freezed == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String?,jobDescription: freezed == jobDescription ? _self.jobDescription : jobDescription // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,salary: freezed == salary ? _self.salary : salary // ignore: cast_nullable_to_non_nullable
as String?,jobType: freezed == jobType ? _self.jobType : jobType // ignore: cast_nullable_to_non_nullable
as String?,applyUrl: freezed == applyUrl ? _self.applyUrl : applyUrl // ignore: cast_nullable_to_non_nullable
as String?,academicQualification: freezed == academicQualification ? _self.academicQualification : academicQualification // ignore: cast_nullable_to_non_nullable
as String?,experience: freezed == experience ? _self.experience : experience // ignore: cast_nullable_to_non_nullable
as String?,languages: freezed == languages ? _self.languages : languages // ignore: cast_nullable_to_non_nullable
as String?,workingHours: freezed == workingHours ? _self.workingHours : workingHours // ignore: cast_nullable_to_non_nullable
as String?,workingDays: freezed == workingDays ? _self.workingDays : workingDays // ignore: cast_nullable_to_non_nullable
as String?,applicationEmail: freezed == applicationEmail ? _self.applicationEmail : applicationEmail // ignore: cast_nullable_to_non_nullable
as String?,jobDate: freezed == jobDate ? _self.jobDate : jobDate // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,nationality: freezed == nationality ? _self.nationality : nationality // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,isSaved: freezed == isSaved ? _self.isSaved : isSaved // ignore: cast_nullable_to_non_nullable
as bool?,matchPercentage: freezed == matchPercentage ? _self.matchPercentage : matchPercentage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [JobDetailsResponse].
extension JobDetailsResponsePatterns on JobDetailsResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobDetailsResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobDetailsResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobDetailsResponse value)  $default,){
final _that = this;
switch (_that) {
case _JobDetailsResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobDetailsResponse value)?  $default,){
final _that = this;
switch (_that) {
case _JobDetailsResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function(@JsonKey(name: 'id', fromJson: _dynamicToString)  String? jobId, @JsonKey(name: 'job_title')  String? jobTitle, @JsonKey(name: 'entity')  String? companyName, @JsonKey(name: 'job_description')  String? jobDescription, @JsonKey(name: 'vacancy_city')  String? location, @JsonKey(name: 'salary')  String? salary, @JsonKey(name: 'job_type')  String? jobType, @JsonKey(name: 'apply_url')  String? applyUrl, @JsonKey(name: 'academic_qualification')  String? academicQualification, @JsonKey(name: 'experience')  String? experience, @JsonKey(name: 'languages')  String? languages, @JsonKey(name: 'working_hours')  String? workingHours, @JsonKey(name: 'working_days')  String? workingDays, @JsonKey(name: 'application_email')  String? applicationEmail, @JsonKey(name: 'job_date')  String? jobDate, @JsonKey(name: 'phone')  String? phone, @JsonKey(name: 'source')  String? source, @JsonKey(name: 'nationality')  String? nationality, @JsonKey(name: 'gender')  String? gender, @JsonKey(name: 'is_saved')  bool? isSaved, @JsonKey(name: 'match_percentage', fromJson: _dynamicToString)  String? matchPercentage)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobDetailsResponse() when $default != null:
return $default(_that.jobId,_that.jobTitle,_that.companyName,_that.jobDescription,_that.location,_that.salary,_that.jobType,_that.applyUrl,_that.academicQualification,_that.experience,_that.languages,_that.workingHours,_that.workingDays,_that.applicationEmail,_that.jobDate,_that.phone,_that.source,_that.nationality,_that.gender,_that.isSaved,_that.matchPercentage);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function(@JsonKey(name: 'id', fromJson: _dynamicToString)  String? jobId, @JsonKey(name: 'job_title')  String? jobTitle, @JsonKey(name: 'entity')  String? companyName, @JsonKey(name: 'job_description')  String? jobDescription, @JsonKey(name: 'vacancy_city')  String? location, @JsonKey(name: 'salary')  String? salary, @JsonKey(name: 'job_type')  String? jobType, @JsonKey(name: 'apply_url')  String? applyUrl, @JsonKey(name: 'academic_qualification')  String? academicQualification, @JsonKey(name: 'experience')  String? experience, @JsonKey(name: 'languages')  String? languages, @JsonKey(name: 'working_hours')  String? workingHours, @JsonKey(name: 'working_days')  String? workingDays, @JsonKey(name: 'application_email')  String? applicationEmail, @JsonKey(name: 'job_date')  String? jobDate, @JsonKey(name: 'phone')  String? phone, @JsonKey(name: 'source')  String? source, @JsonKey(name: 'nationality')  String? nationality, @JsonKey(name: 'gender')  String? gender, @JsonKey(name: 'is_saved')  bool? isSaved, @JsonKey(name: 'match_percentage', fromJson: _dynamicToString)  String? matchPercentage)  $default,) {final _that = this;
switch (_that) {
case _JobDetailsResponse():
return $default(_that.jobId,_that.jobTitle,_that.companyName,_that.jobDescription,_that.location,_that.salary,_that.jobType,_that.applyUrl,_that.academicQualification,_that.experience,_that.languages,_that.workingHours,_that.workingDays,_that.applicationEmail,_that.jobDate,_that.phone,_that.source,_that.nationality,_that.gender,_that.isSaved,_that.matchPercentage);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function(@JsonKey(name: 'id', fromJson: _dynamicToString)  String? jobId, @JsonKey(name: 'job_title')  String? jobTitle, @JsonKey(name: 'entity')  String? companyName, @JsonKey(name: 'job_description')  String? jobDescription, @JsonKey(name: 'vacancy_city')  String? location, @JsonKey(name: 'salary')  String? salary, @JsonKey(name: 'job_type')  String? jobType, @JsonKey(name: 'apply_url')  String? applyUrl, @JsonKey(name: 'academic_qualification')  String? academicQualification, @JsonKey(name: 'experience')  String? experience, @JsonKey(name: 'languages')  String? languages, @JsonKey(name: 'working_hours')  String? workingHours, @JsonKey(name: 'working_days')  String? workingDays, @JsonKey(name: 'application_email')  String? applicationEmail, @JsonKey(name: 'job_date')  String? jobDate, @JsonKey(name: 'phone')  String? phone, @JsonKey(name: 'source')  String? source, @JsonKey(name: 'nationality')  String? nationality, @JsonKey(name: 'gender')  String? gender, @JsonKey(name: 'is_saved')  bool? isSaved, @JsonKey(name: 'match_percentage', fromJson: _dynamicToString)  String? matchPercentage)?  $default,) {final _that = this;
switch (_that) {
case _JobDetailsResponse() when $default != null:
return $default(_that.jobId,_that.jobTitle,_that.companyName,_that.jobDescription,_that.location,_that.salary,_that.jobType,_that.applyUrl,_that.academicQualification,_that.experience,_that.languages,_that.workingHours,_that.workingDays,_that.applicationEmail,_that.jobDate,_that.phone,_that.source,_that.nationality,_that.gender,_that.isSaved,_that.matchPercentage);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JobDetailsResponse implements JobDetailsResponse {
  const _JobDetailsResponse({@JsonKey(name: 'id', fromJson: _dynamicToString) this.jobId, @JsonKey(name: 'job_title') this.jobTitle, @JsonKey(name: 'entity') this.companyName, @JsonKey(name: 'job_description') this.jobDescription, @JsonKey(name: 'vacancy_city') this.location, @JsonKey(name: 'salary') this.salary, @JsonKey(name: 'job_type') this.jobType, @JsonKey(name: 'apply_url') this.applyUrl, @JsonKey(name: 'academic_qualification') this.academicQualification, @JsonKey(name: 'experience') this.experience, @JsonKey(name: 'languages') this.languages, @JsonKey(name: 'working_hours') this.workingHours, @JsonKey(name: 'working_days') this.workingDays, @JsonKey(name: 'application_email') this.applicationEmail, @JsonKey(name: 'job_date') this.jobDate, @JsonKey(name: 'phone') this.phone, @JsonKey(name: 'source') this.source, @JsonKey(name: 'nationality') this.nationality, @JsonKey(name: 'gender') this.gender, @JsonKey(name: 'is_saved') this.isSaved, @JsonKey(name: 'match_percentage', fromJson: _dynamicToString) this.matchPercentage});
  factory _JobDetailsResponse.fromJson(Map<String, dynamic> json) => _$JobDetailsResponseFromJson(json);

/// Job ID
@override@JsonKey(name: 'id', fromJson: _dynamicToString) final  String? jobId;
/// Job title
@override@JsonKey(name: 'job_title') final  String? jobTitle;
/// Company name
@override@JsonKey(name: 'entity') final  String? companyName;
/// Job description
@override@JsonKey(name: 'job_description') final  String? jobDescription;
/// Location (city)
@override@JsonKey(name: 'vacancy_city') final  String? location;
/// Salary
@override@JsonKey(name: 'salary') final  String? salary;
/// Job type
@override@JsonKey(name: 'job_type') final  String? jobType;
/// Application URL
@override@JsonKey(name: 'apply_url') final  String? applyUrl;
/// Academic qualifications required
@override@JsonKey(name: 'academic_qualification') final  String? academicQualification;
/// Experience level required
@override@JsonKey(name: 'experience') final  String? experience;
/// Language skills required
@override@JsonKey(name: 'languages') final  String? languages;
/// Working hours
@override@JsonKey(name: 'working_hours') final  String? workingHours;
/// Working days
@override@JsonKey(name: 'working_days') final  String? workingDays;
/// Application email
@override@JsonKey(name: 'application_email') final  String? applicationEmail;
/// Job posting date
@override@JsonKey(name: 'job_date') final  String? jobDate;
/// Contact phone
@override@JsonKey(name: 'phone') final  String? phone;
/// Job source (where it was posted)
@override@JsonKey(name: 'source') final  String? source;
/// Nationality requirement
@override@JsonKey(name: 'nationality') final  String? nationality;
/// Gender requirement
@override@JsonKey(name: 'gender') final  String? gender;
/// Is job saved
@override@JsonKey(name: 'is_saved') final  bool? isSaved;
/// Match percentage for the job
@override@JsonKey(name: 'match_percentage', fromJson: _dynamicToString) final  String? matchPercentage;

/// Create a copy of JobDetailsResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobDetailsResponseCopyWith<_JobDetailsResponse> get copyWith => __$JobDetailsResponseCopyWithImpl<_JobDetailsResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JobDetailsResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobDetailsResponse&&(identical(other.jobId, jobId) || other.jobId == jobId)&&(identical(other.jobTitle, jobTitle) || other.jobTitle == jobTitle)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.jobDescription, jobDescription) || other.jobDescription == jobDescription)&&(identical(other.location, location) || other.location == location)&&(identical(other.salary, salary) || other.salary == salary)&&(identical(other.jobType, jobType) || other.jobType == jobType)&&(identical(other.applyUrl, applyUrl) || other.applyUrl == applyUrl)&&(identical(other.academicQualification, academicQualification) || other.academicQualification == academicQualification)&&(identical(other.experience, experience) || other.experience == experience)&&(identical(other.languages, languages) || other.languages == languages)&&(identical(other.workingHours, workingHours) || other.workingHours == workingHours)&&(identical(other.workingDays, workingDays) || other.workingDays == workingDays)&&(identical(other.applicationEmail, applicationEmail) || other.applicationEmail == applicationEmail)&&(identical(other.jobDate, jobDate) || other.jobDate == jobDate)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.source, source) || other.source == source)&&(identical(other.nationality, nationality) || other.nationality == nationality)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.isSaved, isSaved) || other.isSaved == isSaved)&&(identical(other.matchPercentage, matchPercentage) || other.matchPercentage == matchPercentage));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,jobId,jobTitle,companyName,jobDescription,location,salary,jobType,applyUrl,academicQualification,experience,languages,workingHours,workingDays,applicationEmail,jobDate,phone,source,nationality,gender,isSaved,matchPercentage]);

@override
String toString() {
  return 'JobDetailsResponse(jobId: $jobId, jobTitle: $jobTitle, companyName: $companyName, jobDescription: $jobDescription, location: $location, salary: $salary, jobType: $jobType, applyUrl: $applyUrl, academicQualification: $academicQualification, experience: $experience, languages: $languages, workingHours: $workingHours, workingDays: $workingDays, applicationEmail: $applicationEmail, jobDate: $jobDate, phone: $phone, source: $source, nationality: $nationality, gender: $gender, isSaved: $isSaved, matchPercentage: $matchPercentage)';
}


}

/// @nodoc
abstract mixin class _$JobDetailsResponseCopyWith<$Res> implements $JobDetailsResponseCopyWith<$Res> {
  factory _$JobDetailsResponseCopyWith(_JobDetailsResponse value, $Res Function(_JobDetailsResponse) _then) = __$JobDetailsResponseCopyWithImpl;
@override @useResult
$Res call({
@JsonKey(name: 'id', fromJson: _dynamicToString) String? jobId,@JsonKey(name: 'job_title') String? jobTitle,@JsonKey(name: 'entity') String? companyName,@JsonKey(name: 'job_description') String? jobDescription,@JsonKey(name: 'vacancy_city') String? location,@JsonKey(name: 'salary') String? salary,@JsonKey(name: 'job_type') String? jobType,@JsonKey(name: 'apply_url') String? applyUrl,@JsonKey(name: 'academic_qualification') String? academicQualification,@JsonKey(name: 'experience') String? experience,@JsonKey(name: 'languages') String? languages,@JsonKey(name: 'working_hours') String? workingHours,@JsonKey(name: 'working_days') String? workingDays,@JsonKey(name: 'application_email') String? applicationEmail,@JsonKey(name: 'job_date') String? jobDate,@JsonKey(name: 'phone') String? phone,@JsonKey(name: 'source') String? source,@JsonKey(name: 'nationality') String? nationality,@JsonKey(name: 'gender') String? gender,@JsonKey(name: 'is_saved') bool? isSaved,@JsonKey(name: 'match_percentage', fromJson: _dynamicToString) String? matchPercentage
});




}
/// @nodoc
class __$JobDetailsResponseCopyWithImpl<$Res>
    implements _$JobDetailsResponseCopyWith<$Res> {
  __$JobDetailsResponseCopyWithImpl(this._self, this._then);

  final _JobDetailsResponse _self;
  final $Res Function(_JobDetailsResponse) _then;

/// Create a copy of JobDetailsResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? jobId = freezed,Object? jobTitle = freezed,Object? companyName = freezed,Object? jobDescription = freezed,Object? location = freezed,Object? salary = freezed,Object? jobType = freezed,Object? applyUrl = freezed,Object? academicQualification = freezed,Object? experience = freezed,Object? languages = freezed,Object? workingHours = freezed,Object? workingDays = freezed,Object? applicationEmail = freezed,Object? jobDate = freezed,Object? phone = freezed,Object? source = freezed,Object? nationality = freezed,Object? gender = freezed,Object? isSaved = freezed,Object? matchPercentage = freezed,}) {
  return _then(_JobDetailsResponse(
jobId: freezed == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String?,jobTitle: freezed == jobTitle ? _self.jobTitle : jobTitle // ignore: cast_nullable_to_non_nullable
as String?,companyName: freezed == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String?,jobDescription: freezed == jobDescription ? _self.jobDescription : jobDescription // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,salary: freezed == salary ? _self.salary : salary // ignore: cast_nullable_to_non_nullable
as String?,jobType: freezed == jobType ? _self.jobType : jobType // ignore: cast_nullable_to_non_nullable
as String?,applyUrl: freezed == applyUrl ? _self.applyUrl : applyUrl // ignore: cast_nullable_to_non_nullable
as String?,academicQualification: freezed == academicQualification ? _self.academicQualification : academicQualification // ignore: cast_nullable_to_non_nullable
as String?,experience: freezed == experience ? _self.experience : experience // ignore: cast_nullable_to_non_nullable
as String?,languages: freezed == languages ? _self.languages : languages // ignore: cast_nullable_to_non_nullable
as String?,workingHours: freezed == workingHours ? _self.workingHours : workingHours // ignore: cast_nullable_to_non_nullable
as String?,workingDays: freezed == workingDays ? _self.workingDays : workingDays // ignore: cast_nullable_to_non_nullable
as String?,applicationEmail: freezed == applicationEmail ? _self.applicationEmail : applicationEmail // ignore: cast_nullable_to_non_nullable
as String?,jobDate: freezed == jobDate ? _self.jobDate : jobDate // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,nationality: freezed == nationality ? _self.nationality : nationality // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,isSaved: freezed == isSaved ? _self.isSaved : isSaved // ignore: cast_nullable_to_non_nullable
as bool?,matchPercentage: freezed == matchPercentage ? _self.matchPercentage : matchPercentage // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
