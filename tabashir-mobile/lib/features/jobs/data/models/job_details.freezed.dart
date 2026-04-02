// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_details.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JobDetails {

/// Unique identifier for the job
 String get id;/// Title of the job position
 String get title;/// Description of the job role and responsibilities
 String get description;/// Name of the company offering the position
 String get company;/// Location of the job
 String get location;/// Salary range for the position
 String get salary;/// Match percentage based on user profile
 String get matchPercentage;/// Tags associated with the job (job_type, working_hours, etc.)
 List<String> get tags;/// List of requirements for the position
 List<String> get requirements;/// Skills required for the position (from languages field)
 List<String> get skills;/// Type of employment (full-time, part-time, etc.)
 String? get employmentType;/// Required experience level
 String? get experienceLevel;/// Working hours
 String? get workingHours;/// Working days
 String? get workingDays;/// Contact phone number
 String? get phone;/// Application URL
 String? get applyUrl;/// Application email
 String? get applicationEmail;/// Job source (where it was posted)
 String? get source;/// Nationality requirement
 String? get nationality;/// Gender requirement
 String? get gender;/// Academic qualifications required
 String? get academicQualification;/// Date when the job was posted
 String? get postedDate;/// Is job saved by user
 bool? get isSaved;
/// Create a copy of JobDetails
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobDetailsCopyWith<JobDetails> get copyWith => _$JobDetailsCopyWithImpl<JobDetails>(this as JobDetails, _$identity);

  /// Serializes this JobDetails to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobDetails&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.company, company) || other.company == company)&&(identical(other.location, location) || other.location == location)&&(identical(other.salary, salary) || other.salary == salary)&&(identical(other.matchPercentage, matchPercentage) || other.matchPercentage == matchPercentage)&&const DeepCollectionEquality().equals(other.tags, tags)&&const DeepCollectionEquality().equals(other.requirements, requirements)&&const DeepCollectionEquality().equals(other.skills, skills)&&(identical(other.employmentType, employmentType) || other.employmentType == employmentType)&&(identical(other.experienceLevel, experienceLevel) || other.experienceLevel == experienceLevel)&&(identical(other.workingHours, workingHours) || other.workingHours == workingHours)&&(identical(other.workingDays, workingDays) || other.workingDays == workingDays)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.applyUrl, applyUrl) || other.applyUrl == applyUrl)&&(identical(other.applicationEmail, applicationEmail) || other.applicationEmail == applicationEmail)&&(identical(other.source, source) || other.source == source)&&(identical(other.nationality, nationality) || other.nationality == nationality)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.academicQualification, academicQualification) || other.academicQualification == academicQualification)&&(identical(other.postedDate, postedDate) || other.postedDate == postedDate)&&(identical(other.isSaved, isSaved) || other.isSaved == isSaved));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,description,company,location,salary,matchPercentage,const DeepCollectionEquality().hash(tags),const DeepCollectionEquality().hash(requirements),const DeepCollectionEquality().hash(skills),employmentType,experienceLevel,workingHours,workingDays,phone,applyUrl,applicationEmail,source,nationality,gender,academicQualification,postedDate,isSaved]);

@override
String toString() {
  return 'JobDetails(id: $id, title: $title, description: $description, company: $company, location: $location, salary: $salary, matchPercentage: $matchPercentage, tags: $tags, requirements: $requirements, skills: $skills, employmentType: $employmentType, experienceLevel: $experienceLevel, workingHours: $workingHours, workingDays: $workingDays, phone: $phone, applyUrl: $applyUrl, applicationEmail: $applicationEmail, source: $source, nationality: $nationality, gender: $gender, academicQualification: $academicQualification, postedDate: $postedDate, isSaved: $isSaved)';
}


}

/// @nodoc
abstract mixin class $JobDetailsCopyWith<$Res>  {
  factory $JobDetailsCopyWith(JobDetails value, $Res Function(JobDetails) _then) = _$JobDetailsCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, String company, String location, String salary, String matchPercentage, List<String> tags, List<String> requirements, List<String> skills, String? employmentType, String? experienceLevel, String? workingHours, String? workingDays, String? phone, String? applyUrl, String? applicationEmail, String? source, String? nationality, String? gender, String? academicQualification, String? postedDate, bool? isSaved
});




}
/// @nodoc
class _$JobDetailsCopyWithImpl<$Res>
    implements $JobDetailsCopyWith<$Res> {
  _$JobDetailsCopyWithImpl(this._self, this._then);

  final JobDetails _self;
  final $Res Function(JobDetails) _then;

/// Create a copy of JobDetails
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? company = null,Object? location = null,Object? salary = null,Object? matchPercentage = null,Object? tags = null,Object? requirements = null,Object? skills = null,Object? employmentType = freezed,Object? experienceLevel = freezed,Object? workingHours = freezed,Object? workingDays = freezed,Object? phone = freezed,Object? applyUrl = freezed,Object? applicationEmail = freezed,Object? source = freezed,Object? nationality = freezed,Object? gender = freezed,Object? academicQualification = freezed,Object? postedDate = freezed,Object? isSaved = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,salary: null == salary ? _self.salary : salary // ignore: cast_nullable_to_non_nullable
as String,matchPercentage: null == matchPercentage ? _self.matchPercentage : matchPercentage // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,requirements: null == requirements ? _self.requirements : requirements // ignore: cast_nullable_to_non_nullable
as List<String>,skills: null == skills ? _self.skills : skills // ignore: cast_nullable_to_non_nullable
as List<String>,employmentType: freezed == employmentType ? _self.employmentType : employmentType // ignore: cast_nullable_to_non_nullable
as String?,experienceLevel: freezed == experienceLevel ? _self.experienceLevel : experienceLevel // ignore: cast_nullable_to_non_nullable
as String?,workingHours: freezed == workingHours ? _self.workingHours : workingHours // ignore: cast_nullable_to_non_nullable
as String?,workingDays: freezed == workingDays ? _self.workingDays : workingDays // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,applyUrl: freezed == applyUrl ? _self.applyUrl : applyUrl // ignore: cast_nullable_to_non_nullable
as String?,applicationEmail: freezed == applicationEmail ? _self.applicationEmail : applicationEmail // ignore: cast_nullable_to_non_nullable
as String?,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,nationality: freezed == nationality ? _self.nationality : nationality // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,academicQualification: freezed == academicQualification ? _self.academicQualification : academicQualification // ignore: cast_nullable_to_non_nullable
as String?,postedDate: freezed == postedDate ? _self.postedDate : postedDate // ignore: cast_nullable_to_non_nullable
as String?,isSaved: freezed == isSaved ? _self.isSaved : isSaved // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [JobDetails].
extension JobDetailsPatterns on JobDetails {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobDetails value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobDetails() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobDetails value)  $default,){
final _that = this;
switch (_that) {
case _JobDetails():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobDetails value)?  $default,){
final _that = this;
switch (_that) {
case _JobDetails() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description,  String company,  String location,  String salary,  String matchPercentage,  List<String> tags,  List<String> requirements,  List<String> skills,  String? employmentType,  String? experienceLevel,  String? workingHours,  String? workingDays,  String? phone,  String? applyUrl,  String? applicationEmail,  String? source,  String? nationality,  String? gender,  String? academicQualification,  String? postedDate,  bool? isSaved)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobDetails() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.company,_that.location,_that.salary,_that.matchPercentage,_that.tags,_that.requirements,_that.skills,_that.employmentType,_that.experienceLevel,_that.workingHours,_that.workingDays,_that.phone,_that.applyUrl,_that.applicationEmail,_that.source,_that.nationality,_that.gender,_that.academicQualification,_that.postedDate,_that.isSaved);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description,  String company,  String location,  String salary,  String matchPercentage,  List<String> tags,  List<String> requirements,  List<String> skills,  String? employmentType,  String? experienceLevel,  String? workingHours,  String? workingDays,  String? phone,  String? applyUrl,  String? applicationEmail,  String? source,  String? nationality,  String? gender,  String? academicQualification,  String? postedDate,  bool? isSaved)  $default,) {final _that = this;
switch (_that) {
case _JobDetails():
return $default(_that.id,_that.title,_that.description,_that.company,_that.location,_that.salary,_that.matchPercentage,_that.tags,_that.requirements,_that.skills,_that.employmentType,_that.experienceLevel,_that.workingHours,_that.workingDays,_that.phone,_that.applyUrl,_that.applicationEmail,_that.source,_that.nationality,_that.gender,_that.academicQualification,_that.postedDate,_that.isSaved);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description,  String company,  String location,  String salary,  String matchPercentage,  List<String> tags,  List<String> requirements,  List<String> skills,  String? employmentType,  String? experienceLevel,  String? workingHours,  String? workingDays,  String? phone,  String? applyUrl,  String? applicationEmail,  String? source,  String? nationality,  String? gender,  String? academicQualification,  String? postedDate,  bool? isSaved)?  $default,) {final _that = this;
switch (_that) {
case _JobDetails() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.company,_that.location,_that.salary,_that.matchPercentage,_that.tags,_that.requirements,_that.skills,_that.employmentType,_that.experienceLevel,_that.workingHours,_that.workingDays,_that.phone,_that.applyUrl,_that.applicationEmail,_that.source,_that.nationality,_that.gender,_that.academicQualification,_that.postedDate,_that.isSaved);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JobDetails implements JobDetails {
  const _JobDetails({required this.id, required this.title, required this.description, required this.company, required this.location, required this.salary, required this.matchPercentage, required final  List<String> tags, required final  List<String> requirements, required final  List<String> skills, this.employmentType, this.experienceLevel, this.workingHours, this.workingDays, this.phone, this.applyUrl, this.applicationEmail, this.source, this.nationality, this.gender, this.academicQualification, this.postedDate, this.isSaved}): _tags = tags,_requirements = requirements,_skills = skills;
  factory _JobDetails.fromJson(Map<String, dynamic> json) => _$JobDetailsFromJson(json);

/// Unique identifier for the job
@override final  String id;
/// Title of the job position
@override final  String title;
/// Description of the job role and responsibilities
@override final  String description;
/// Name of the company offering the position
@override final  String company;
/// Location of the job
@override final  String location;
/// Salary range for the position
@override final  String salary;
/// Match percentage based on user profile
@override final  String matchPercentage;
/// Tags associated with the job (job_type, working_hours, etc.)
 final  List<String> _tags;
/// Tags associated with the job (job_type, working_hours, etc.)
@override List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

/// List of requirements for the position
 final  List<String> _requirements;
/// List of requirements for the position
@override List<String> get requirements {
  if (_requirements is EqualUnmodifiableListView) return _requirements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_requirements);
}

/// Skills required for the position (from languages field)
 final  List<String> _skills;
/// Skills required for the position (from languages field)
@override List<String> get skills {
  if (_skills is EqualUnmodifiableListView) return _skills;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_skills);
}

/// Type of employment (full-time, part-time, etc.)
@override final  String? employmentType;
/// Required experience level
@override final  String? experienceLevel;
/// Working hours
@override final  String? workingHours;
/// Working days
@override final  String? workingDays;
/// Contact phone number
@override final  String? phone;
/// Application URL
@override final  String? applyUrl;
/// Application email
@override final  String? applicationEmail;
/// Job source (where it was posted)
@override final  String? source;
/// Nationality requirement
@override final  String? nationality;
/// Gender requirement
@override final  String? gender;
/// Academic qualifications required
@override final  String? academicQualification;
/// Date when the job was posted
@override final  String? postedDate;
/// Is job saved by user
@override final  bool? isSaved;

/// Create a copy of JobDetails
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobDetailsCopyWith<_JobDetails> get copyWith => __$JobDetailsCopyWithImpl<_JobDetails>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JobDetailsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobDetails&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.company, company) || other.company == company)&&(identical(other.location, location) || other.location == location)&&(identical(other.salary, salary) || other.salary == salary)&&(identical(other.matchPercentage, matchPercentage) || other.matchPercentage == matchPercentage)&&const DeepCollectionEquality().equals(other._tags, _tags)&&const DeepCollectionEquality().equals(other._requirements, _requirements)&&const DeepCollectionEquality().equals(other._skills, _skills)&&(identical(other.employmentType, employmentType) || other.employmentType == employmentType)&&(identical(other.experienceLevel, experienceLevel) || other.experienceLevel == experienceLevel)&&(identical(other.workingHours, workingHours) || other.workingHours == workingHours)&&(identical(other.workingDays, workingDays) || other.workingDays == workingDays)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.applyUrl, applyUrl) || other.applyUrl == applyUrl)&&(identical(other.applicationEmail, applicationEmail) || other.applicationEmail == applicationEmail)&&(identical(other.source, source) || other.source == source)&&(identical(other.nationality, nationality) || other.nationality == nationality)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.academicQualification, academicQualification) || other.academicQualification == academicQualification)&&(identical(other.postedDate, postedDate) || other.postedDate == postedDate)&&(identical(other.isSaved, isSaved) || other.isSaved == isSaved));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,description,company,location,salary,matchPercentage,const DeepCollectionEquality().hash(_tags),const DeepCollectionEquality().hash(_requirements),const DeepCollectionEquality().hash(_skills),employmentType,experienceLevel,workingHours,workingDays,phone,applyUrl,applicationEmail,source,nationality,gender,academicQualification,postedDate,isSaved]);

@override
String toString() {
  return 'JobDetails(id: $id, title: $title, description: $description, company: $company, location: $location, salary: $salary, matchPercentage: $matchPercentage, tags: $tags, requirements: $requirements, skills: $skills, employmentType: $employmentType, experienceLevel: $experienceLevel, workingHours: $workingHours, workingDays: $workingDays, phone: $phone, applyUrl: $applyUrl, applicationEmail: $applicationEmail, source: $source, nationality: $nationality, gender: $gender, academicQualification: $academicQualification, postedDate: $postedDate, isSaved: $isSaved)';
}


}

/// @nodoc
abstract mixin class _$JobDetailsCopyWith<$Res> implements $JobDetailsCopyWith<$Res> {
  factory _$JobDetailsCopyWith(_JobDetails value, $Res Function(_JobDetails) _then) = __$JobDetailsCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, String company, String location, String salary, String matchPercentage, List<String> tags, List<String> requirements, List<String> skills, String? employmentType, String? experienceLevel, String? workingHours, String? workingDays, String? phone, String? applyUrl, String? applicationEmail, String? source, String? nationality, String? gender, String? academicQualification, String? postedDate, bool? isSaved
});




}
/// @nodoc
class __$JobDetailsCopyWithImpl<$Res>
    implements _$JobDetailsCopyWith<$Res> {
  __$JobDetailsCopyWithImpl(this._self, this._then);

  final _JobDetails _self;
  final $Res Function(_JobDetails) _then;

/// Create a copy of JobDetails
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? company = null,Object? location = null,Object? salary = null,Object? matchPercentage = null,Object? tags = null,Object? requirements = null,Object? skills = null,Object? employmentType = freezed,Object? experienceLevel = freezed,Object? workingHours = freezed,Object? workingDays = freezed,Object? phone = freezed,Object? applyUrl = freezed,Object? applicationEmail = freezed,Object? source = freezed,Object? nationality = freezed,Object? gender = freezed,Object? academicQualification = freezed,Object? postedDate = freezed,Object? isSaved = freezed,}) {
  return _then(_JobDetails(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,salary: null == salary ? _self.salary : salary // ignore: cast_nullable_to_non_nullable
as String,matchPercentage: null == matchPercentage ? _self.matchPercentage : matchPercentage // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,requirements: null == requirements ? _self._requirements : requirements // ignore: cast_nullable_to_non_nullable
as List<String>,skills: null == skills ? _self._skills : skills // ignore: cast_nullable_to_non_nullable
as List<String>,employmentType: freezed == employmentType ? _self.employmentType : employmentType // ignore: cast_nullable_to_non_nullable
as String?,experienceLevel: freezed == experienceLevel ? _self.experienceLevel : experienceLevel // ignore: cast_nullable_to_non_nullable
as String?,workingHours: freezed == workingHours ? _self.workingHours : workingHours // ignore: cast_nullable_to_non_nullable
as String?,workingDays: freezed == workingDays ? _self.workingDays : workingDays // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,applyUrl: freezed == applyUrl ? _self.applyUrl : applyUrl // ignore: cast_nullable_to_non_nullable
as String?,applicationEmail: freezed == applicationEmail ? _self.applicationEmail : applicationEmail // ignore: cast_nullable_to_non_nullable
as String?,source: freezed == source ? _self.source : source // ignore: cast_nullable_to_non_nullable
as String?,nationality: freezed == nationality ? _self.nationality : nationality // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,academicQualification: freezed == academicQualification ? _self.academicQualification : academicQualification // ignore: cast_nullable_to_non_nullable
as String?,postedDate: freezed == postedDate ? _self.postedDate : postedDate // ignore: cast_nullable_to_non_nullable
as String?,isSaved: freezed == isSaved ? _self.isSaved : isSaved // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}

// dart format on
