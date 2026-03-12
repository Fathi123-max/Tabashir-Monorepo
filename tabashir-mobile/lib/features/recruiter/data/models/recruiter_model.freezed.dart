// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'recruiter_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$RecruiterProfile {

 String get id; String get name; String get email; String get company; String get position; String? get phone; String? get bio; List<String> get postedJobs; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of RecruiterProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecruiterProfileCopyWith<RecruiterProfile> get copyWith => _$RecruiterProfileCopyWithImpl<RecruiterProfile>(this as RecruiterProfile, _$identity);

  /// Serializes this RecruiterProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecruiterProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.company, company) || other.company == company)&&(identical(other.position, position) || other.position == position)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.bio, bio) || other.bio == bio)&&const DeepCollectionEquality().equals(other.postedJobs, postedJobs)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,email,company,position,phone,bio,const DeepCollectionEquality().hash(postedJobs),createdAt,updatedAt);

@override
String toString() {
  return 'RecruiterProfile(id: $id, name: $name, email: $email, company: $company, position: $position, phone: $phone, bio: $bio, postedJobs: $postedJobs, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $RecruiterProfileCopyWith<$Res>  {
  factory $RecruiterProfileCopyWith(RecruiterProfile value, $Res Function(RecruiterProfile) _then) = _$RecruiterProfileCopyWithImpl;
@useResult
$Res call({
 String id, String name, String email, String company, String position, String? phone, String? bio, List<String> postedJobs, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$RecruiterProfileCopyWithImpl<$Res>
    implements $RecruiterProfileCopyWith<$Res> {
  _$RecruiterProfileCopyWithImpl(this._self, this._then);

  final RecruiterProfile _self;
  final $Res Function(RecruiterProfile) _then;

/// Create a copy of RecruiterProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? email = null,Object? company = null,Object? position = null,Object? phone = freezed,Object? bio = freezed,Object? postedJobs = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,postedJobs: null == postedJobs ? _self.postedJobs : postedJobs // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [RecruiterProfile].
extension RecruiterProfilePatterns on RecruiterProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecruiterProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecruiterProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecruiterProfile value)  $default,){
final _that = this;
switch (_that) {
case _RecruiterProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecruiterProfile value)?  $default,){
final _that = this;
switch (_that) {
case _RecruiterProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String email,  String company,  String position,  String? phone,  String? bio,  List<String> postedJobs,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecruiterProfile() when $default != null:
return $default(_that.id,_that.name,_that.email,_that.company,_that.position,_that.phone,_that.bio,_that.postedJobs,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String email,  String company,  String position,  String? phone,  String? bio,  List<String> postedJobs,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _RecruiterProfile():
return $default(_that.id,_that.name,_that.email,_that.company,_that.position,_that.phone,_that.bio,_that.postedJobs,_that.createdAt,_that.updatedAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String email,  String company,  String position,  String? phone,  String? bio,  List<String> postedJobs,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _RecruiterProfile() when $default != null:
return $default(_that.id,_that.name,_that.email,_that.company,_that.position,_that.phone,_that.bio,_that.postedJobs,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RecruiterProfile implements RecruiterProfile {
  const _RecruiterProfile({required this.id, required this.name, required this.email, required this.company, required this.position, this.phone, this.bio, final  List<String> postedJobs = const [], this.createdAt, this.updatedAt}): _postedJobs = postedJobs;
  factory _RecruiterProfile.fromJson(Map<String, dynamic> json) => _$RecruiterProfileFromJson(json);

@override final  String id;
@override final  String name;
@override final  String email;
@override final  String company;
@override final  String position;
@override final  String? phone;
@override final  String? bio;
 final  List<String> _postedJobs;
@override@JsonKey() List<String> get postedJobs {
  if (_postedJobs is EqualUnmodifiableListView) return _postedJobs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_postedJobs);
}

@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of RecruiterProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecruiterProfileCopyWith<_RecruiterProfile> get copyWith => __$RecruiterProfileCopyWithImpl<_RecruiterProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecruiterProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecruiterProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.company, company) || other.company == company)&&(identical(other.position, position) || other.position == position)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.bio, bio) || other.bio == bio)&&const DeepCollectionEquality().equals(other._postedJobs, _postedJobs)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,email,company,position,phone,bio,const DeepCollectionEquality().hash(_postedJobs),createdAt,updatedAt);

@override
String toString() {
  return 'RecruiterProfile(id: $id, name: $name, email: $email, company: $company, position: $position, phone: $phone, bio: $bio, postedJobs: $postedJobs, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$RecruiterProfileCopyWith<$Res> implements $RecruiterProfileCopyWith<$Res> {
  factory _$RecruiterProfileCopyWith(_RecruiterProfile value, $Res Function(_RecruiterProfile) _then) = __$RecruiterProfileCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String email, String company, String position, String? phone, String? bio, List<String> postedJobs, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$RecruiterProfileCopyWithImpl<$Res>
    implements _$RecruiterProfileCopyWith<$Res> {
  __$RecruiterProfileCopyWithImpl(this._self, this._then);

  final _RecruiterProfile _self;
  final $Res Function(_RecruiterProfile) _then;

/// Create a copy of RecruiterProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? email = null,Object? company = null,Object? position = null,Object? phone = freezed,Object? bio = freezed,Object? postedJobs = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_RecruiterProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,position: null == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,bio: freezed == bio ? _self.bio : bio // ignore: cast_nullable_to_non_nullable
as String?,postedJobs: null == postedJobs ? _self._postedJobs : postedJobs // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$JobPosting {

 String get id; String get title; String get description; String get company; String get location; String get employmentType;// Full-time, Part-time, Contract
 double get salaryMin; double get salaryMax; String get recruiterId; List<String> get requirements; List<String> get tags; JobStatus get status; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of JobPosting
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobPostingCopyWith<JobPosting> get copyWith => _$JobPostingCopyWithImpl<JobPosting>(this as JobPosting, _$identity);

  /// Serializes this JobPosting to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobPosting&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.company, company) || other.company == company)&&(identical(other.location, location) || other.location == location)&&(identical(other.employmentType, employmentType) || other.employmentType == employmentType)&&(identical(other.salaryMin, salaryMin) || other.salaryMin == salaryMin)&&(identical(other.salaryMax, salaryMax) || other.salaryMax == salaryMax)&&(identical(other.recruiterId, recruiterId) || other.recruiterId == recruiterId)&&const DeepCollectionEquality().equals(other.requirements, requirements)&&const DeepCollectionEquality().equals(other.tags, tags)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,company,location,employmentType,salaryMin,salaryMax,recruiterId,const DeepCollectionEquality().hash(requirements),const DeepCollectionEquality().hash(tags),status,createdAt,updatedAt);

@override
String toString() {
  return 'JobPosting(id: $id, title: $title, description: $description, company: $company, location: $location, employmentType: $employmentType, salaryMin: $salaryMin, salaryMax: $salaryMax, recruiterId: $recruiterId, requirements: $requirements, tags: $tags, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $JobPostingCopyWith<$Res>  {
  factory $JobPostingCopyWith(JobPosting value, $Res Function(JobPosting) _then) = _$JobPostingCopyWithImpl;
@useResult
$Res call({
 String id, String title, String description, String company, String location, String employmentType, double salaryMin, double salaryMax, String recruiterId, List<String> requirements, List<String> tags, JobStatus status, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$JobPostingCopyWithImpl<$Res>
    implements $JobPostingCopyWith<$Res> {
  _$JobPostingCopyWithImpl(this._self, this._then);

  final JobPosting _self;
  final $Res Function(JobPosting) _then;

/// Create a copy of JobPosting
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? title = null,Object? description = null,Object? company = null,Object? location = null,Object? employmentType = null,Object? salaryMin = null,Object? salaryMax = null,Object? recruiterId = null,Object? requirements = null,Object? tags = null,Object? status = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,employmentType: null == employmentType ? _self.employmentType : employmentType // ignore: cast_nullable_to_non_nullable
as String,salaryMin: null == salaryMin ? _self.salaryMin : salaryMin // ignore: cast_nullable_to_non_nullable
as double,salaryMax: null == salaryMax ? _self.salaryMax : salaryMax // ignore: cast_nullable_to_non_nullable
as double,recruiterId: null == recruiterId ? _self.recruiterId : recruiterId // ignore: cast_nullable_to_non_nullable
as String,requirements: null == requirements ? _self.requirements : requirements // ignore: cast_nullable_to_non_nullable
as List<String>,tags: null == tags ? _self.tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as JobStatus,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [JobPosting].
extension JobPostingPatterns on JobPosting {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobPosting value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobPosting() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobPosting value)  $default,){
final _that = this;
switch (_that) {
case _JobPosting():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobPosting value)?  $default,){
final _that = this;
switch (_that) {
case _JobPosting() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String title,  String description,  String company,  String location,  String employmentType,  double salaryMin,  double salaryMax,  String recruiterId,  List<String> requirements,  List<String> tags,  JobStatus status,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobPosting() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.company,_that.location,_that.employmentType,_that.salaryMin,_that.salaryMax,_that.recruiterId,_that.requirements,_that.tags,_that.status,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String title,  String description,  String company,  String location,  String employmentType,  double salaryMin,  double salaryMax,  String recruiterId,  List<String> requirements,  List<String> tags,  JobStatus status,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _JobPosting():
return $default(_that.id,_that.title,_that.description,_that.company,_that.location,_that.employmentType,_that.salaryMin,_that.salaryMax,_that.recruiterId,_that.requirements,_that.tags,_that.status,_that.createdAt,_that.updatedAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String title,  String description,  String company,  String location,  String employmentType,  double salaryMin,  double salaryMax,  String recruiterId,  List<String> requirements,  List<String> tags,  JobStatus status,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _JobPosting() when $default != null:
return $default(_that.id,_that.title,_that.description,_that.company,_that.location,_that.employmentType,_that.salaryMin,_that.salaryMax,_that.recruiterId,_that.requirements,_that.tags,_that.status,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JobPosting implements JobPosting {
  const _JobPosting({required this.id, required this.title, required this.description, required this.company, required this.location, required this.employmentType, required this.salaryMin, required this.salaryMax, required this.recruiterId, final  List<String> requirements = const [], final  List<String> tags = const [], this.status = JobStatus.draft, this.createdAt, this.updatedAt}): _requirements = requirements,_tags = tags;
  factory _JobPosting.fromJson(Map<String, dynamic> json) => _$JobPostingFromJson(json);

@override final  String id;
@override final  String title;
@override final  String description;
@override final  String company;
@override final  String location;
@override final  String employmentType;
// Full-time, Part-time, Contract
@override final  double salaryMin;
@override final  double salaryMax;
@override final  String recruiterId;
 final  List<String> _requirements;
@override@JsonKey() List<String> get requirements {
  if (_requirements is EqualUnmodifiableListView) return _requirements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_requirements);
}

 final  List<String> _tags;
@override@JsonKey() List<String> get tags {
  if (_tags is EqualUnmodifiableListView) return _tags;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_tags);
}

@override@JsonKey() final  JobStatus status;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of JobPosting
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobPostingCopyWith<_JobPosting> get copyWith => __$JobPostingCopyWithImpl<_JobPosting>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JobPostingToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobPosting&&(identical(other.id, id) || other.id == id)&&(identical(other.title, title) || other.title == title)&&(identical(other.description, description) || other.description == description)&&(identical(other.company, company) || other.company == company)&&(identical(other.location, location) || other.location == location)&&(identical(other.employmentType, employmentType) || other.employmentType == employmentType)&&(identical(other.salaryMin, salaryMin) || other.salaryMin == salaryMin)&&(identical(other.salaryMax, salaryMax) || other.salaryMax == salaryMax)&&(identical(other.recruiterId, recruiterId) || other.recruiterId == recruiterId)&&const DeepCollectionEquality().equals(other._requirements, _requirements)&&const DeepCollectionEquality().equals(other._tags, _tags)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,title,description,company,location,employmentType,salaryMin,salaryMax,recruiterId,const DeepCollectionEquality().hash(_requirements),const DeepCollectionEquality().hash(_tags),status,createdAt,updatedAt);

@override
String toString() {
  return 'JobPosting(id: $id, title: $title, description: $description, company: $company, location: $location, employmentType: $employmentType, salaryMin: $salaryMin, salaryMax: $salaryMax, recruiterId: $recruiterId, requirements: $requirements, tags: $tags, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$JobPostingCopyWith<$Res> implements $JobPostingCopyWith<$Res> {
  factory _$JobPostingCopyWith(_JobPosting value, $Res Function(_JobPosting) _then) = __$JobPostingCopyWithImpl;
@override @useResult
$Res call({
 String id, String title, String description, String company, String location, String employmentType, double salaryMin, double salaryMax, String recruiterId, List<String> requirements, List<String> tags, JobStatus status, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$JobPostingCopyWithImpl<$Res>
    implements _$JobPostingCopyWith<$Res> {
  __$JobPostingCopyWithImpl(this._self, this._then);

  final _JobPosting _self;
  final $Res Function(_JobPosting) _then;

/// Create a copy of JobPosting
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? title = null,Object? description = null,Object? company = null,Object? location = null,Object? employmentType = null,Object? salaryMin = null,Object? salaryMax = null,Object? recruiterId = null,Object? requirements = null,Object? tags = null,Object? status = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_JobPosting(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,employmentType: null == employmentType ? _self.employmentType : employmentType // ignore: cast_nullable_to_non_nullable
as String,salaryMin: null == salaryMin ? _self.salaryMin : salaryMin // ignore: cast_nullable_to_non_nullable
as double,salaryMax: null == salaryMax ? _self.salaryMax : salaryMax // ignore: cast_nullable_to_non_nullable
as double,recruiterId: null == recruiterId ? _self.recruiterId : recruiterId // ignore: cast_nullable_to_non_nullable
as String,requirements: null == requirements ? _self._requirements : requirements // ignore: cast_nullable_to_non_nullable
as List<String>,tags: null == tags ? _self._tags : tags // ignore: cast_nullable_to_non_nullable
as List<String>,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as JobStatus,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$JobApplication {

 String get id; String get jobId; String get candidateId; String get candidateName; String get candidateEmail; String? get candidateResumeUrl; ApplicationStatus get status; String? get notes; DateTime? get appliedAt; DateTime? get updatedAt;
/// Create a copy of JobApplication
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobApplicationCopyWith<JobApplication> get copyWith => _$JobApplicationCopyWithImpl<JobApplication>(this as JobApplication, _$identity);

  /// Serializes this JobApplication to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobApplication&&(identical(other.id, id) || other.id == id)&&(identical(other.jobId, jobId) || other.jobId == jobId)&&(identical(other.candidateId, candidateId) || other.candidateId == candidateId)&&(identical(other.candidateName, candidateName) || other.candidateName == candidateName)&&(identical(other.candidateEmail, candidateEmail) || other.candidateEmail == candidateEmail)&&(identical(other.candidateResumeUrl, candidateResumeUrl) || other.candidateResumeUrl == candidateResumeUrl)&&(identical(other.status, status) || other.status == status)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.appliedAt, appliedAt) || other.appliedAt == appliedAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,jobId,candidateId,candidateName,candidateEmail,candidateResumeUrl,status,notes,appliedAt,updatedAt);

@override
String toString() {
  return 'JobApplication(id: $id, jobId: $jobId, candidateId: $candidateId, candidateName: $candidateName, candidateEmail: $candidateEmail, candidateResumeUrl: $candidateResumeUrl, status: $status, notes: $notes, appliedAt: $appliedAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $JobApplicationCopyWith<$Res>  {
  factory $JobApplicationCopyWith(JobApplication value, $Res Function(JobApplication) _then) = _$JobApplicationCopyWithImpl;
@useResult
$Res call({
 String id, String jobId, String candidateId, String candidateName, String candidateEmail, String? candidateResumeUrl, ApplicationStatus status, String? notes, DateTime? appliedAt, DateTime? updatedAt
});




}
/// @nodoc
class _$JobApplicationCopyWithImpl<$Res>
    implements $JobApplicationCopyWith<$Res> {
  _$JobApplicationCopyWithImpl(this._self, this._then);

  final JobApplication _self;
  final $Res Function(JobApplication) _then;

/// Create a copy of JobApplication
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? jobId = null,Object? candidateId = null,Object? candidateName = null,Object? candidateEmail = null,Object? candidateResumeUrl = freezed,Object? status = null,Object? notes = freezed,Object? appliedAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,jobId: null == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String,candidateId: null == candidateId ? _self.candidateId : candidateId // ignore: cast_nullable_to_non_nullable
as String,candidateName: null == candidateName ? _self.candidateName : candidateName // ignore: cast_nullable_to_non_nullable
as String,candidateEmail: null == candidateEmail ? _self.candidateEmail : candidateEmail // ignore: cast_nullable_to_non_nullable
as String,candidateResumeUrl: freezed == candidateResumeUrl ? _self.candidateResumeUrl : candidateResumeUrl // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ApplicationStatus,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,appliedAt: freezed == appliedAt ? _self.appliedAt : appliedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [JobApplication].
extension JobApplicationPatterns on JobApplication {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobApplication value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobApplication() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobApplication value)  $default,){
final _that = this;
switch (_that) {
case _JobApplication():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobApplication value)?  $default,){
final _that = this;
switch (_that) {
case _JobApplication() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String jobId,  String candidateId,  String candidateName,  String candidateEmail,  String? candidateResumeUrl,  ApplicationStatus status,  String? notes,  DateTime? appliedAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobApplication() when $default != null:
return $default(_that.id,_that.jobId,_that.candidateId,_that.candidateName,_that.candidateEmail,_that.candidateResumeUrl,_that.status,_that.notes,_that.appliedAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String jobId,  String candidateId,  String candidateName,  String candidateEmail,  String? candidateResumeUrl,  ApplicationStatus status,  String? notes,  DateTime? appliedAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _JobApplication():
return $default(_that.id,_that.jobId,_that.candidateId,_that.candidateName,_that.candidateEmail,_that.candidateResumeUrl,_that.status,_that.notes,_that.appliedAt,_that.updatedAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String jobId,  String candidateId,  String candidateName,  String candidateEmail,  String? candidateResumeUrl,  ApplicationStatus status,  String? notes,  DateTime? appliedAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _JobApplication() when $default != null:
return $default(_that.id,_that.jobId,_that.candidateId,_that.candidateName,_that.candidateEmail,_that.candidateResumeUrl,_that.status,_that.notes,_that.appliedAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JobApplication implements JobApplication {
  const _JobApplication({required this.id, required this.jobId, required this.candidateId, required this.candidateName, required this.candidateEmail, this.candidateResumeUrl, this.status = ApplicationStatus.pending, this.notes, this.appliedAt, this.updatedAt});
  factory _JobApplication.fromJson(Map<String, dynamic> json) => _$JobApplicationFromJson(json);

@override final  String id;
@override final  String jobId;
@override final  String candidateId;
@override final  String candidateName;
@override final  String candidateEmail;
@override final  String? candidateResumeUrl;
@override@JsonKey() final  ApplicationStatus status;
@override final  String? notes;
@override final  DateTime? appliedAt;
@override final  DateTime? updatedAt;

/// Create a copy of JobApplication
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobApplicationCopyWith<_JobApplication> get copyWith => __$JobApplicationCopyWithImpl<_JobApplication>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JobApplicationToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobApplication&&(identical(other.id, id) || other.id == id)&&(identical(other.jobId, jobId) || other.jobId == jobId)&&(identical(other.candidateId, candidateId) || other.candidateId == candidateId)&&(identical(other.candidateName, candidateName) || other.candidateName == candidateName)&&(identical(other.candidateEmail, candidateEmail) || other.candidateEmail == candidateEmail)&&(identical(other.candidateResumeUrl, candidateResumeUrl) || other.candidateResumeUrl == candidateResumeUrl)&&(identical(other.status, status) || other.status == status)&&(identical(other.notes, notes) || other.notes == notes)&&(identical(other.appliedAt, appliedAt) || other.appliedAt == appliedAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,jobId,candidateId,candidateName,candidateEmail,candidateResumeUrl,status,notes,appliedAt,updatedAt);

@override
String toString() {
  return 'JobApplication(id: $id, jobId: $jobId, candidateId: $candidateId, candidateName: $candidateName, candidateEmail: $candidateEmail, candidateResumeUrl: $candidateResumeUrl, status: $status, notes: $notes, appliedAt: $appliedAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$JobApplicationCopyWith<$Res> implements $JobApplicationCopyWith<$Res> {
  factory _$JobApplicationCopyWith(_JobApplication value, $Res Function(_JobApplication) _then) = __$JobApplicationCopyWithImpl;
@override @useResult
$Res call({
 String id, String jobId, String candidateId, String candidateName, String candidateEmail, String? candidateResumeUrl, ApplicationStatus status, String? notes, DateTime? appliedAt, DateTime? updatedAt
});




}
/// @nodoc
class __$JobApplicationCopyWithImpl<$Res>
    implements _$JobApplicationCopyWith<$Res> {
  __$JobApplicationCopyWithImpl(this._self, this._then);

  final _JobApplication _self;
  final $Res Function(_JobApplication) _then;

/// Create a copy of JobApplication
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? jobId = null,Object? candidateId = null,Object? candidateName = null,Object? candidateEmail = null,Object? candidateResumeUrl = freezed,Object? status = null,Object? notes = freezed,Object? appliedAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_JobApplication(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,jobId: null == jobId ? _self.jobId : jobId // ignore: cast_nullable_to_non_nullable
as String,candidateId: null == candidateId ? _self.candidateId : candidateId // ignore: cast_nullable_to_non_nullable
as String,candidateName: null == candidateName ? _self.candidateName : candidateName // ignore: cast_nullable_to_non_nullable
as String,candidateEmail: null == candidateEmail ? _self.candidateEmail : candidateEmail // ignore: cast_nullable_to_non_nullable
as String,candidateResumeUrl: freezed == candidateResumeUrl ? _self.candidateResumeUrl : candidateResumeUrl // ignore: cast_nullable_to_non_nullable
as String?,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ApplicationStatus,notes: freezed == notes ? _self.notes : notes // ignore: cast_nullable_to_non_nullable
as String?,appliedAt: freezed == appliedAt ? _self.appliedAt : appliedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
