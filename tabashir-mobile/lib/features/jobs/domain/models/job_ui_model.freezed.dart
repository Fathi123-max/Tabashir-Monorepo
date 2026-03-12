// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'job_ui_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$JobUI {

/// Unique job identifier
 String get id;/// Job title
 String get title;/// Company name
 String get company;/// Job location
 String get location;/// Salary information (formatted string)
 String get salary;/// Numeric salary value for filtering
 int get salaryValue;/// Match percentage (e.g., "90% Match")
 String get matchPercentage;/// Job tags (jobType, experience, languages)
 List<String> get tags;/// Skills match description
 String get skillsMatch;/// Whether job is saved by user
 bool get isSaved;/// Whether user has already applied to this job
 bool get isApplied;/// Job type (Full-time, Part-time, etc.)
 String? get jobType;/// Experience level required
 String? get experienceLevel;/// Required skills
 List<String> get skills;/// Work mode (Remote, On-site, Hybrid)
 String? get workMode;/// Job description
 String? get description;/// Job requirements
 List<String> get requirements;/// Posted date (formatted, e.g., "2 days ago")
 String? get postedDate;/// Working days
 String? get workingDays;
/// Create a copy of JobUI
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobUICopyWith<JobUI> get copyWith => _$JobUICopyWithImpl<JobUI>(this as JobUI, _$identity);

  /// Serializes this JobUI to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobUI&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.company, company) || other.company == company)&&(identical(other.location, location) || other.location == location)&&(identical(other.salary, salary) || other.salary == salary)&&(identical(other.salaryValue, salaryValue) || other.salaryValue == salaryValue)&&(identical(other.matchPercentage, matchPercentage) || other.matchPercentage == matchPercentage)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.skillsMatch, skillsMatch) || other.skillsMatch == skillsMatch)&&(identical(other.isSaved, isSaved) || other.isSaved == isSaved)&&(identical(other.isApplied, isApplied) || other.isApplied == isApplied)&&(identical(other.jobType, jobType) || other.jobType == jobType)&&(identical(other.experienceLevel, experienceLevel) || other.experienceLevel == experienceLevel)&&const DeepCollectionEquality().equals(other.skills, skills)&&(identical(other.workMode, workMode) || other.workMode == workMode)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.requirements, requirements)&&(identical(other.postedDate, postedDate) || other.postedDate == postedDate)&&(identical(other.workingDays, workingDays) || other.workingDays == workingDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,company,location,salary,salaryValue,matchPercentage,const DeepCollectionEquality().hash(tags),skillsMatch,isSaved,isApplied,jobType,experienceLevel,const DeepCollectionEquality().hash(skills),workMode,description,const DeepCollectionEquality().hash(requirements),postedDate,workingDays]);

@override
String toString() {
  return 'JobUI(id: $id, title: $title, company: $company, location: $location, salary: $salary, salaryValue: $salaryValue, matchPercentage: $matchPercentage, tags: $tags, skillsMatch: $skillsMatch, isSaved: $isSaved, isApplied: $isApplied, jobType: $jobType, experienceLevel: $experienceLevel, skills: $skills, workMode: $workMode, description: $description, requirements: $requirements, postedDate: $postedDate, workingDays: $workingDays)';
}


}

/// @nodoc
abstract mixin class $JobUICopyWith<$Res>  {
  factory $JobUICopyWith(JobUI value, $Res Function(JobUI) _then) = _$JobUICopyWithImpl;
@useResult
$Res call({
 String id, String title, String company, String location, String salary, int salaryValue, String matchPercentage, List<String> tags, String skillsMatch, bool isSaved, bool isApplied, String? jobType, String? experienceLevel, List<String> skills, String? workMode, String? description, List<String> requirements, String? postedDate, String? workingDays
});




}
/// @nodoc
class _$JobUICopyWithImpl<$Res>
    implements $JobUICopyWith<$Res> {
  _$JobUICopyWithImpl(this._self, this._then);

  final JobUI _self;
  final $Res Function(JobUI) _then;

/// Create a copy of JobUI
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? company = null,Object? location = null,Object? salary = null,Object? salaryValue = null,Object? matchPercentage = null,Object? tags = null,Object? skillsMatch = null,Object? isSaved = null,Object? isApplied = null,Object? jobType = freezed,Object? experienceLevel = freezed,Object? skills = null,Object? workMode = freezed,Object? description = freezed,Object? requirements = null,Object? postedDate = freezed,Object? workingDays = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,salary: null == salary ? _self.salary : salary // ignore: cast_nullable_to_non_nullable
as String,salaryValue: null == salaryValue ? _self.salaryValue : salaryValue // ignore: cast_nullable_to_non_nullable
as int,matchPercentage: null == matchPercentage ? _self.matchPercentage : matchPercentage // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,skillsMatch: null == skillsMatch ? _self.skillsMatch : skillsMatch // ignore: cast_nullable_to_non_nullable
as String,isSaved: null == isSaved ? _self.isSaved : isSaved // ignore: cast_nullable_to_non_nullable
as bool,isApplied: null == isApplied ? _self.isApplied : isApplied // ignore: cast_nullable_to_non_nullable
as bool,jobType: freezed == jobType ? _self.jobType : jobType // ignore: cast_nullable_to_non_nullable
as String?,experienceLevel: freezed == experienceLevel ? _self.experienceLevel : experienceLevel // ignore: cast_nullable_to_non_nullable
as String?,skills: null == skills ? _self.skills : skills // ignore: cast_nullable_to_non_nullable
as List<String>,workMode: freezed == workMode ? _self.workMode : workMode // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,requirements: null == requirements ? _self.requirements : requirements // ignore: cast_nullable_to_non_nullable
as List<String>,postedDate: freezed == postedDate ? _self.postedDate : postedDate // ignore: cast_nullable_to_non_nullable
as String?,workingDays: freezed == workingDays ? _self.workingDays : workingDays // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [JobUI].
extension JobUIPatterns on JobUI {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobUI value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobUI() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobUI value)  $default,){
final _that = this;
switch (_that) {
case _JobUI():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobUI value)?  $default,){
final _that = this;
switch (_that) {
case _JobUI() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String company,  String location,  String salary,  int salaryValue,  String matchPercentage,  List<String> tags,  String skillsMatch,  bool isSaved,  bool isApplied,  String? jobType,  String? experienceLevel,  List<String> skills,  String? workMode,  String? description,  List<String> requirements,  String? postedDate,  String? workingDays)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobUI() when $default != null:
return $default(_that.id,_that.title,_that.company,_that.location,_that.salary,_that.salaryValue,_that.matchPercentage,_that.tags,_that.skillsMatch,_that.isSaved,_that.isApplied,_that.jobType,_that.experienceLevel,_that.skills,_that.workMode,_that.description,_that.requirements,_that.postedDate,_that.workingDays);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String company,  String location,  String salary,  int salaryValue,  String matchPercentage,  List<String> tags,  String skillsMatch,  bool isSaved,  bool isApplied,  String? jobType,  String? experienceLevel,  List<String> skills,  String? workMode,  String? description,  List<String> requirements,  String? postedDate,  String? workingDays)  $default,) {final _that = this;
switch (_that) {
case _JobUI():
return $default(_that.id,_that.title,_that.company,_that.location,_that.salary,_that.salaryValue,_that.matchPercentage,_that.tags,_that.skillsMatch,_that.isSaved,_that.isApplied,_that.jobType,_that.experienceLevel,_that.skills,_that.workMode,_that.description,_that.requirements,_that.postedDate,_that.workingDays);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String company,  String location,  String salary,  int salaryValue,  String matchPercentage,  List<String> tags,  String skillsMatch,  bool isSaved,  bool isApplied,  String? jobType,  String? experienceLevel,  List<String> skills,  String? workMode,  String? description,  List<String> requirements,  String? postedDate,  String? workingDays)?  $default,) {final _that = this;
switch (_that) {
case _JobUI() when $default != null:
return $default(_that.id,_that.title,_that.company,_that.location,_that.salary,_that.salaryValue,_that.matchPercentage,_that.tags,_that.skillsMatch,_that.isSaved,_that.isApplied,_that.jobType,_that.experienceLevel,_that.skills,_that.workMode,_that.description,_that.requirements,_that.postedDate,_that.workingDays);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JobUI implements JobUI {
  const _JobUI({required this.id, required this.title, required this.company, required this.location, required this.salary, this.salaryValue = 0, required this.matchPercentage, final  List<String> tags = const [], required this.skillsMatch, this.isSaved = false, this.isApplied = false, this.jobType, this.experienceLevel, final  List<String> skills = const [], this.workMode, this.description, final  List<String> requirements = const [], this.postedDate, this.workingDays}): _tags = tags,_skills = skills,_requirements = requirements;
  factory _JobUI.fromJson(Map<String, dynamic> json) => _$JobUIFromJson(json);

/// Unique job identifier
@override final  String id;
/// Job title
@override final  String title;
/// Company name
@override final  String company;
/// Job location
@override final  String location;
/// Salary information (formatted string)
@override final  String salary;
/// Numeric salary value for filtering
@override@JsonKey() final  int salaryValue;
/// Match percentage (e.g., "90% Match")
@override final  String matchPercentage;
/// Job tags (jobType, experience, languages)
 final  List<String> _tags;
/// Job tags (jobType, experience, languages)
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

/// Skills match description
@override final  String skillsMatch;
/// Whether job is saved by user
@override@JsonKey() final  bool isSaved;
/// Whether user has already applied to this job
@override@JsonKey() final  bool isApplied;
/// Job type (Full-time, Part-time, etc.)
@override final  String? jobType;
/// Experience level required
@override final  String? experienceLevel;
/// Required skills
 final  List<String> _skills;
/// Required skills
@override@JsonKey() List<String> get skills {
  if (_skills is EqualUnmodifiableListView) return _skills;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_skills);
}

/// Work mode (Remote, On-site, Hybrid)
@override final  String? workMode;
/// Job description
@override final  String? description;
/// Job requirements
 final  List<String> _requirements;
/// Job requirements
@override@JsonKey() List<String> get requirements {
  if (_requirements is EqualUnmodifiableListView) return _requirements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_requirements);
}

/// Posted date (formatted, e.g., "2 days ago")
@override final  String? postedDate;
/// Working days
@override final  String? workingDays;

/// Create a copy of JobUI
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobUICopyWith<_JobUI> get copyWith => __$JobUICopyWithImpl<_JobUI>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JobUIToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobUI&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.company, company) || other.company == company)&&(identical(other.location, location) || other.location == location)&&(identical(other.salary, salary) || other.salary == salary)&&(identical(other.salaryValue, salaryValue) || other.salaryValue == salaryValue)&&(identical(other.matchPercentage, matchPercentage) || other.matchPercentage == matchPercentage)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.skillsMatch, skillsMatch) || other.skillsMatch == skillsMatch)&&(identical(other.isSaved, isSaved) || other.isSaved == isSaved)&&(identical(other.isApplied, isApplied) || other.isApplied == isApplied)&&(identical(other.jobType, jobType) || other.jobType == jobType)&&(identical(other.experienceLevel, experienceLevel) || other.experienceLevel == experienceLevel)&&const DeepCollectionEquality().equals(other._skills, _skills)&&(identical(other.workMode, workMode) || other.workMode == workMode)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._requirements, _requirements)&&(identical(other.postedDate, postedDate) || other.postedDate == postedDate)&&(identical(other.workingDays, workingDays) || other.workingDays == workingDays));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hashAll([runtimeType,id,title,company,location,salary,salaryValue,matchPercentage,const DeepCollectionEquality().hash(_tags),skillsMatch,isSaved,isApplied,jobType,experienceLevel,const DeepCollectionEquality().hash(_skills),workMode,description,const DeepCollectionEquality().hash(_requirements),postedDate,workingDays]);

@override
String toString() {
  return 'JobUI(id: $id, title: $title, company: $company, location: $location, salary: $salary, salaryValue: $salaryValue, matchPercentage: $matchPercentage, tags: $tags, skillsMatch: $skillsMatch, isSaved: $isSaved, isApplied: $isApplied, jobType: $jobType, experienceLevel: $experienceLevel, skills: $skills, workMode: $workMode, description: $description, requirements: $requirements, postedDate: $postedDate, workingDays: $workingDays)';
}


}

/// @nodoc
abstract mixin class _$JobUICopyWith<$Res> implements $JobUICopyWith<$Res> {
  factory _$JobUICopyWith(_JobUI value, $Res Function(_JobUI) _then) = __$JobUICopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String company, String location, String salary, int salaryValue, String matchPercentage, List<String> tags, String skillsMatch, bool isSaved, bool isApplied, String? jobType, String? experienceLevel, List<String> skills, String? workMode, String? description, List<String> requirements, String? postedDate, String? workingDays
});




}
/// @nodoc
class __$JobUICopyWithImpl<$Res>
    implements _$JobUICopyWith<$Res> {
  __$JobUICopyWithImpl(this._self, this._then);

  final _JobUI _self;
  final $Res Function(_JobUI) _then;

/// Create a copy of JobUI
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? company = null,Object? location = null,Object? salary = null,Object? salaryValue = null,Object? matchPercentage = null,Object? tags = null,Object? skillsMatch = null,Object? isSaved = null,Object? isApplied = null,Object? jobType = freezed,Object? experienceLevel = freezed,Object? skills = null,Object? workMode = freezed,Object? description = freezed,Object? requirements = null,Object? postedDate = freezed,Object? workingDays = freezed,}) {
  return _then(_JobUI(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,salary: null == salary ? _self.salary : salary // ignore: cast_nullable_to_non_nullable
as String,salaryValue: null == salaryValue ? _self.salaryValue : salaryValue // ignore: cast_nullable_to_non_nullable
as int,matchPercentage: null == matchPercentage ? _self.matchPercentage : matchPercentage // ignore: cast_nullable_to_non_nullable
as String,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,skillsMatch: null == skillsMatch ? _self.skillsMatch : skillsMatch // ignore: cast_nullable_to_non_nullable
as String,isSaved: null == isSaved ? _self.isSaved : isSaved // ignore: cast_nullable_to_non_nullable
as bool,isApplied: null == isApplied ? _self.isApplied : isApplied // ignore: cast_nullable_to_non_nullable
as bool,jobType: freezed == jobType ? _self.jobType : jobType // ignore: cast_nullable_to_non_nullable
as String?,experienceLevel: freezed == experienceLevel ? _self.experienceLevel : experienceLevel // ignore: cast_nullable_to_non_nullable
as String?,skills: null == skills ? _self._skills : skills // ignore: cast_nullable_to_non_nullable
as List<String>,workMode: freezed == workMode ? _self.workMode : workMode // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,requirements: null == requirements ? _self._requirements : requirements // ignore: cast_nullable_to_non_nullable
as List<String>,postedDate: freezed == postedDate ? _self.postedDate : postedDate // ignore: cast_nullable_to_non_nullable
as String?,workingDays: freezed == workingDays ? _self.workingDays : workingDays // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
