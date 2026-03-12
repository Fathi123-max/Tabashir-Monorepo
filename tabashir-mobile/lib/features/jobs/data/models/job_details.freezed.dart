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
 String get company;/// Industry sector of the company
 String get industry;/// Location of the job
 String get location;/// Salary range for the position
 String get salary;/// Match percentage based on user profile
 String get matchPercentage;/// Size of the company
 int get companySize;/// Year the company was founded
 int get foundedYear;/// Whether the company is verified
 bool get isVerified;/// Tags associated with the job
 List<String> get tags;/// List of responsibilities in this role
 List<String> get responsibilities;/// List of requirements for the position
 List<String> get requirements;/// Skills required for the position
 List<String> get skills;/// List of similar job opportunities
 List<SimilarJob> get similarOpportunities;/// Overview of the company
 String? get overview;/// Benefits offered with the position
 String? get benefits;/// Type of employment (full-time, part-time, etc.)
 String? get employmentType;/// Required experience level
 String? get experienceLevel;/// Date when the job was posted
 String? get postedDate;
/// Create a copy of JobDetails
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobDetailsCopyWith<JobDetails> get copyWith => _$JobDetailsCopyWithImpl<JobDetails>(this as JobDetails, _$identity);

  /// Serializes this JobDetails to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobDetails&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.company, company) || other.company == company)&&(identical(other.industry, industry) || other.industry == industry)&&(identical(other.location, location) || other.location == location)&&(identical(other.salary, salary) || other.salary == salary)&&(identical(other.matchPercentage, matchPercentage) || other.matchPercentage == matchPercentage)&&(identical(other.companySize, companySize) || other.companySize == companySize)&&(identical(other.foundedYear, foundedYear) || other.foundedYear == foundedYear)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&const DeepCollectionEquality().equals(other.tags, tags)&&const DeepCollectionEquality().equals(other.responsibilities, responsibilities)&&const DeepCollectionEquality().equals(other.requirements, requirements)&&const DeepCollectionEquality().equals(other.skills, skills)&&const DeepCollectionEquality().equals(other.similarOpportunities, similarOpportunities)&&(identical(other.overview, overview) || other.overview == overview)&&(identical(other.benefits, benefits) || other.benefits == benefits)&&(identical(other.employmentType, employmentType) || other.employmentType == employmentType)&&(identical(other.experienceLevel, experienceLevel) || other.experienceLevel == experienceLevel)&&(identical(other.postedDate, postedDate) || other.postedDate == postedDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,description,company,industry,location,salary,matchPercentage,companySize,foundedYear,isVerified,const DeepCollectionEquality().hash(tags),const DeepCollectionEquality().hash(responsibilities),const DeepCollectionEquality().hash(requirements),const DeepCollectionEquality().hash(skills),const DeepCollectionEquality().hash(similarOpportunities),overview,benefits,employmentType,experienceLevel,postedDate]);

@override
String toString() {
  return 'JobDetails(id: $id, title: $title, description: $description, company: $company, industry: $industry, location: $location, salary: $salary, matchPercentage: $matchPercentage, companySize: $companySize, foundedYear: $foundedYear, isVerified: $isVerified, tags: $tags, responsibilities: $responsibilities, requirements: $requirements, skills: $skills, similarOpportunities: $similarOpportunities, overview: $overview, benefits: $benefits, employmentType: $employmentType, experienceLevel: $experienceLevel, postedDate: $postedDate)';
}


}

/// @nodoc
abstract mixin class $JobDetailsCopyWith<$Res>  {
  factory $JobDetailsCopyWith(JobDetails value, $Res Function(JobDetails) _then) = _$JobDetailsCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, String company, String industry, String location, String salary, String matchPercentage, int companySize, int foundedYear, bool isVerified, List<String> tags, List<String> responsibilities, List<String> requirements, List<String> skills, List<SimilarJob> similarOpportunities, String? overview, String? benefits, String? employmentType, String? experienceLevel, String? postedDate
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
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? company = null,Object? industry = null,Object? location = null,Object? salary = null,Object? matchPercentage = null,Object? companySize = null,Object? foundedYear = null,Object? isVerified = null,Object? tags = null,Object? responsibilities = null,Object? requirements = null,Object? skills = null,Object? similarOpportunities = null,Object? overview = freezed,Object? benefits = freezed,Object? employmentType = freezed,Object? experienceLevel = freezed,Object? postedDate = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,industry: null == industry ? _self.industry : industry // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,salary: null == salary ? _self.salary : salary // ignore: cast_nullable_to_non_nullable
as String,matchPercentage: null == matchPercentage ? _self.matchPercentage : matchPercentage // ignore: cast_nullable_to_non_nullable
as String,companySize: null == companySize ? _self.companySize : companySize // ignore: cast_nullable_to_non_nullable
as int,foundedYear: null == foundedYear ? _self.foundedYear : foundedYear // ignore: cast_nullable_to_non_nullable
as int,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,responsibilities: null == responsibilities ? _self.responsibilities : responsibilities // ignore: cast_nullable_to_non_nullable
as List<String>,requirements: null == requirements ? _self.requirements : requirements // ignore: cast_nullable_to_non_nullable
as List<String>,skills: null == skills ? _self.skills : skills // ignore: cast_nullable_to_non_nullable
as List<String>,similarOpportunities: null == similarOpportunities ? _self.similarOpportunities : similarOpportunities // ignore: cast_nullable_to_non_nullable
as List<SimilarJob>,overview: freezed == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as String?,benefits: freezed == benefits ? _self.benefits : benefits // ignore: cast_nullable_to_non_nullable
as String?,employmentType: freezed == employmentType ? _self.employmentType : employmentType // ignore: cast_nullable_to_non_nullable
as String?,experienceLevel: freezed == experienceLevel ? _self.experienceLevel : experienceLevel // ignore: cast_nullable_to_non_nullable
as String?,postedDate: freezed == postedDate ? _self.postedDate : postedDate // ignore: cast_nullable_to_non_nullable
as String?,
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description,  String company,  String industry,  String location,  String salary,  String matchPercentage,  int companySize,  int foundedYear,  bool isVerified,  List<String> tags,  List<String> responsibilities,  List<String> requirements,  List<String> skills,  List<SimilarJob> similarOpportunities,  String? overview,  String? benefits,  String? employmentType,  String? experienceLevel,  String? postedDate)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobDetails() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.company,_that.industry,_that.location,_that.salary,_that.matchPercentage,_that.companySize,_that.foundedYear,_that.isVerified,_that.tags,_that.responsibilities,_that.requirements,_that.skills,_that.similarOpportunities,_that.overview,_that.benefits,_that.employmentType,_that.experienceLevel,_that.postedDate);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description,  String company,  String industry,  String location,  String salary,  String matchPercentage,  int companySize,  int foundedYear,  bool isVerified,  List<String> tags,  List<String> responsibilities,  List<String> requirements,  List<String> skills,  List<SimilarJob> similarOpportunities,  String? overview,  String? benefits,  String? employmentType,  String? experienceLevel,  String? postedDate)  $default,) {final _that = this;
switch (_that) {
case _JobDetails():
return $default(_that.id,_that.title,_that.description,_that.company,_that.industry,_that.location,_that.salary,_that.matchPercentage,_that.companySize,_that.foundedYear,_that.isVerified,_that.tags,_that.responsibilities,_that.requirements,_that.skills,_that.similarOpportunities,_that.overview,_that.benefits,_that.employmentType,_that.experienceLevel,_that.postedDate);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description,  String company,  String industry,  String location,  String salary,  String matchPercentage,  int companySize,  int foundedYear,  bool isVerified,  List<String> tags,  List<String> responsibilities,  List<String> requirements,  List<String> skills,  List<SimilarJob> similarOpportunities,  String? overview,  String? benefits,  String? employmentType,  String? experienceLevel,  String? postedDate)?  $default,) {final _that = this;
switch (_that) {
case _JobDetails() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.company,_that.industry,_that.location,_that.salary,_that.matchPercentage,_that.companySize,_that.foundedYear,_that.isVerified,_that.tags,_that.responsibilities,_that.requirements,_that.skills,_that.similarOpportunities,_that.overview,_that.benefits,_that.employmentType,_that.experienceLevel,_that.postedDate);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JobDetails implements JobDetails {
  const _JobDetails({required this.id, required this.title, required this.description, required this.company, required this.industry, required this.location, required this.salary, required this.matchPercentage, required this.companySize, required this.foundedYear, required this.isVerified, required final  List<String> tags, required final  List<String> responsibilities, required final  List<String> requirements, required final  List<String> skills, required final  List<SimilarJob> similarOpportunities, this.overview, this.benefits, this.employmentType, this.experienceLevel, this.postedDate}): _tags = tags,_responsibilities = responsibilities,_requirements = requirements,_skills = skills,_similarOpportunities = similarOpportunities;
  factory _JobDetails.fromJson(Map<String, dynamic> json) => _$JobDetailsFromJson(json);

/// Unique identifier for the job
@override final  String id;
/// Title of the job position
@override final  String title;
/// Description of the job role and responsibilities
@override final  String description;
/// Name of the company offering the position
@override final  String company;
/// Industry sector of the company
@override final  String industry;
/// Location of the job
@override final  String location;
/// Salary range for the position
@override final  String salary;
/// Match percentage based on user profile
@override final  String matchPercentage;
/// Size of the company
@override final  int companySize;
/// Year the company was founded
@override final  int foundedYear;
/// Whether the company is verified
@override final  bool isVerified;
/// Tags associated with the job
 final  List<String> _tags;
/// Tags associated with the job
@override List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

/// List of responsibilities in this role
 final  List<String> _responsibilities;
/// List of responsibilities in this role
@override List<String> get responsibilities {
  if (_responsibilities is EqualUnmodifiableListView) return _responsibilities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_responsibilities);
}

/// List of requirements for the position
 final  List<String> _requirements;
/// List of requirements for the position
@override List<String> get requirements {
  if (_requirements is EqualUnmodifiableListView) return _requirements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_requirements);
}

/// Skills required for the position
 final  List<String> _skills;
/// Skills required for the position
@override List<String> get skills {
  if (_skills is EqualUnmodifiableListView) return _skills;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_skills);
}

/// List of similar job opportunities
 final  List<SimilarJob> _similarOpportunities;
/// List of similar job opportunities
@override List<SimilarJob> get similarOpportunities {
  if (_similarOpportunities is EqualUnmodifiableListView) return _similarOpportunities;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_similarOpportunities);
}

/// Overview of the company
@override final  String? overview;
/// Benefits offered with the position
@override final  String? benefits;
/// Type of employment (full-time, part-time, etc.)
@override final  String? employmentType;
/// Required experience level
@override final  String? experienceLevel;
/// Date when the job was posted
@override final  String? postedDate;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobDetails&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.company, company) || other.company == company)&&(identical(other.industry, industry) || other.industry == industry)&&(identical(other.location, location) || other.location == location)&&(identical(other.salary, salary) || other.salary == salary)&&(identical(other.matchPercentage, matchPercentage) || other.matchPercentage == matchPercentage)&&(identical(other.companySize, companySize) || other.companySize == companySize)&&(identical(other.foundedYear, foundedYear) || other.foundedYear == foundedYear)&&(identical(other.isVerified, isVerified) || other.isVerified == isVerified)&&const DeepCollectionEquality().equals(other._tags, _tags)&&const DeepCollectionEquality().equals(other._responsibilities, _responsibilities)&&const DeepCollectionEquality().equals(other._requirements, _requirements)&&const DeepCollectionEquality().equals(other._skills, _skills)&&const DeepCollectionEquality().equals(other._similarOpportunities, _similarOpportunities)&&(identical(other.overview, overview) || other.overview == overview)&&(identical(other.benefits, benefits) || other.benefits == benefits)&&(identical(other.employmentType, employmentType) || other.employmentType == employmentType)&&(identical(other.experienceLevel, experienceLevel) || other.experienceLevel == experienceLevel)&&(identical(other.postedDate, postedDate) || other.postedDate == postedDate));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,description,company,industry,location,salary,matchPercentage,companySize,foundedYear,isVerified,const DeepCollectionEquality().hash(_tags),const DeepCollectionEquality().hash(_responsibilities),const DeepCollectionEquality().hash(_requirements),const DeepCollectionEquality().hash(_skills),const DeepCollectionEquality().hash(_similarOpportunities),overview,benefits,employmentType,experienceLevel,postedDate]);

@override
String toString() {
  return 'JobDetails(id: $id, title: $title, description: $description, company: $company, industry: $industry, location: $location, salary: $salary, matchPercentage: $matchPercentage, companySize: $companySize, foundedYear: $foundedYear, isVerified: $isVerified, tags: $tags, responsibilities: $responsibilities, requirements: $requirements, skills: $skills, similarOpportunities: $similarOpportunities, overview: $overview, benefits: $benefits, employmentType: $employmentType, experienceLevel: $experienceLevel, postedDate: $postedDate)';
}


}

/// @nodoc
abstract mixin class _$JobDetailsCopyWith<$Res> implements $JobDetailsCopyWith<$Res> {
  factory _$JobDetailsCopyWith(_JobDetails value, $Res Function(_JobDetails) _then) = __$JobDetailsCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, String company, String industry, String location, String salary, String matchPercentage, int companySize, int foundedYear, bool isVerified, List<String> tags, List<String> responsibilities, List<String> requirements, List<String> skills, List<SimilarJob> similarOpportunities, String? overview, String? benefits, String? employmentType, String? experienceLevel, String? postedDate
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
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? company = null,Object? industry = null,Object? location = null,Object? salary = null,Object? matchPercentage = null,Object? companySize = null,Object? foundedYear = null,Object? isVerified = null,Object? tags = null,Object? responsibilities = null,Object? requirements = null,Object? skills = null,Object? similarOpportunities = null,Object? overview = freezed,Object? benefits = freezed,Object? employmentType = freezed,Object? experienceLevel = freezed,Object? postedDate = freezed,}) {
  return _then(_JobDetails(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,industry: null == industry ? _self.industry : industry // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,salary: null == salary ? _self.salary : salary // ignore: cast_nullable_to_non_nullable
as String,matchPercentage: null == matchPercentage ? _self.matchPercentage : matchPercentage // ignore: cast_nullable_to_non_nullable
as String,companySize: null == companySize ? _self.companySize : companySize // ignore: cast_nullable_to_non_nullable
as int,foundedYear: null == foundedYear ? _self.foundedYear : foundedYear // ignore: cast_nullable_to_non_nullable
as int,isVerified: null == isVerified ? _self.isVerified : isVerified // ignore: cast_nullable_to_non_nullable
as bool,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,responsibilities: null == responsibilities ? _self._responsibilities : responsibilities // ignore: cast_nullable_to_non_nullable
as List<String>,requirements: null == requirements ? _self._requirements : requirements // ignore: cast_nullable_to_non_nullable
as List<String>,skills: null == skills ? _self._skills : skills // ignore: cast_nullable_to_non_nullable
as List<String>,similarOpportunities: null == similarOpportunities ? _self._similarOpportunities : similarOpportunities // ignore: cast_nullable_to_non_nullable
as List<SimilarJob>,overview: freezed == overview ? _self.overview : overview // ignore: cast_nullable_to_non_nullable
as String?,benefits: freezed == benefits ? _self.benefits : benefits // ignore: cast_nullable_to_non_nullable
as String?,employmentType: freezed == employmentType ? _self.employmentType : employmentType // ignore: cast_nullable_to_non_nullable
as String?,experienceLevel: freezed == experienceLevel ? _self.experienceLevel : experienceLevel // ignore: cast_nullable_to_non_nullable
as String?,postedDate: freezed == postedDate ? _self.postedDate : postedDate // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$SimilarJob {

/// Unique identifier for the similar job
 String get id;/// Title of the similar job position
 String get title;/// Name of the company for the similar job
 String get company;/// Match percentage based on user profile
 String get matchPercentage;/// Tags associated with the similar job
 List<String> get tags;
/// Create a copy of SimilarJob
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SimilarJobCopyWith<SimilarJob> get copyWith => _$SimilarJobCopyWithImpl<SimilarJob>(this as SimilarJob, _$identity);

  /// Serializes this SimilarJob to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SimilarJob&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.company, company) || other.company == company)&&(identical(other.matchPercentage, matchPercentage) || other.matchPercentage == matchPercentage)&&const DeepCollectionEquality().equals(other.tags, tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,company,matchPercentage,const DeepCollectionEquality().hash(tags));

@override
String toString() {
  return 'SimilarJob(id: $id, title: $title, company: $company, matchPercentage: $matchPercentage, tags: $tags)';
}


}

/// @nodoc
abstract mixin class $SimilarJobCopyWith<$Res>  {
  factory $SimilarJobCopyWith(SimilarJob value, $Res Function(SimilarJob) _then) = _$SimilarJobCopyWithImpl;
@useResult
$Res call({
 String id, String title, String company, String matchPercentage, List<String> tags
});




}
/// @nodoc
class _$SimilarJobCopyWithImpl<$Res>
    implements $SimilarJobCopyWith<$Res> {
  _$SimilarJobCopyWithImpl(this._self, this._then);

  final SimilarJob _self;
  final $Res Function(SimilarJob) _then;

/// Create a copy of SimilarJob
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? company = null,Object? matchPercentage = null,Object? tags = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,matchPercentage: null == matchPercentage ? _self.matchPercentage : matchPercentage // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}

}


/// Adds pattern-matching-related methods to [SimilarJob].
extension SimilarJobPatterns on SimilarJob {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SimilarJob value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SimilarJob() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SimilarJob value)  $default,){
final _that = this;
switch (_that) {
case _SimilarJob():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SimilarJob value)?  $default,){
final _that = this;
switch (_that) {
case _SimilarJob() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String company,  String matchPercentage,  List<String> tags)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SimilarJob() when $default != null:
return $default(_that.id,_that.title,_that.company,_that.matchPercentage,_that.tags);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String company,  String matchPercentage,  List<String> tags)  $default,) {final _that = this;
switch (_that) {
case _SimilarJob():
return $default(_that.id,_that.title,_that.company,_that.matchPercentage,_that.tags);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String company,  String matchPercentage,  List<String> tags)?  $default,) {final _that = this;
switch (_that) {
case _SimilarJob() when $default != null:
return $default(_that.id,_that.title,_that.company,_that.matchPercentage,_that.tags);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SimilarJob implements SimilarJob {
  const _SimilarJob({required this.id, required this.title, required this.company, required this.matchPercentage, required final  List<String> tags}): _tags = tags;
  factory _SimilarJob.fromJson(Map<String, dynamic> json) => _$SimilarJobFromJson(json);

/// Unique identifier for the similar job
@override final  String id;
/// Title of the similar job position
@override final  String title;
/// Name of the company for the similar job
@override final  String company;
/// Match percentage based on user profile
@override final  String matchPercentage;
/// Tags associated with the similar job
 final  List<String> _tags;
/// Tags associated with the similar job
@override List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}


/// Create a copy of SimilarJob
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SimilarJobCopyWith<_SimilarJob> get copyWith => __$SimilarJobCopyWithImpl<_SimilarJob>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SimilarJobToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SimilarJob&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.company, company) || other.company == company)&&(identical(other.matchPercentage, matchPercentage) || other.matchPercentage == matchPercentage)&&const DeepCollectionEquality().equals(other._tags, _tags));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,company,matchPercentage,const DeepCollectionEquality().hash(_tags));

@override
String toString() {
  return 'SimilarJob(id: $id, title: $title, company: $company, matchPercentage: $matchPercentage, tags: $tags)';
}


}

/// @nodoc
abstract mixin class _$SimilarJobCopyWith<$Res> implements $SimilarJobCopyWith<$Res> {
  factory _$SimilarJobCopyWith(_SimilarJob value, $Res Function(_SimilarJob) _then) = __$SimilarJobCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String company, String matchPercentage, List<String> tags
});




}
/// @nodoc
class __$SimilarJobCopyWithImpl<$Res>
    implements _$SimilarJobCopyWith<$Res> {
  __$SimilarJobCopyWithImpl(this._self, this._then);

  final _SimilarJob _self;
  final $Res Function(_SimilarJob) _then;

/// Create a copy of SimilarJob
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? company = null,Object? matchPercentage = null,Object? tags = null,}) {
  return _then(_SimilarJob(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,matchPercentage: null == matchPercentage ? _self.matchPercentage : matchPercentage // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,
  ));
}


}

// dart format on
