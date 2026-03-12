// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'company_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CompanyProfile {

 String get id; String get name; String get industry; String get description; String get location; String? get website; String? get logoUrl; String? get coverImageUrl; CompanySize get size; CompanyType get type; int? get foundedYear; List<String> get specializations; List<String> get benefits; int? get employeeCount; CompanyRating get rating; List<String> get postedJobs; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of CompanyProfile
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompanyProfileCopyWith<CompanyProfile> get copyWith => _$CompanyProfileCopyWithImpl<CompanyProfile>(this as CompanyProfile, _$identity);

  /// Serializes this CompanyProfile to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanyProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.industry, industry) || other.industry == industry)&&(identical(other.description, description) || other.description == description)&&(identical(other.location, location) || other.location == location)&&(identical(other.website, website) || other.website == website)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.size, size) || other.size == size)&&(identical(other.type, type) || other.type == type)&&(identical(other.foundedYear, foundedYear) || other.foundedYear == foundedYear)&&const DeepCollectionEquality().equals(other.specializations, specializations)&&const DeepCollectionEquality().equals(other.benefits, benefits)&&(identical(other.employeeCount, employeeCount) || other.employeeCount == employeeCount)&&(identical(other.rating, rating) || other.rating == rating)&&const DeepCollectionEquality().equals(other.postedJobs, postedJobs)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,industry,description,location,website,logoUrl,coverImageUrl,size,type,foundedYear,const DeepCollectionEquality().hash(specializations),const DeepCollectionEquality().hash(benefits),employeeCount,rating,const DeepCollectionEquality().hash(postedJobs),createdAt,updatedAt);

@override
String toString() {
  return 'CompanyProfile(id: $id, name: $name, industry: $industry, description: $description, location: $location, website: $website, logoUrl: $logoUrl, coverImageUrl: $coverImageUrl, size: $size, type: $type, foundedYear: $foundedYear, specializations: $specializations, benefits: $benefits, employeeCount: $employeeCount, rating: $rating, postedJobs: $postedJobs, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $CompanyProfileCopyWith<$Res>  {
  factory $CompanyProfileCopyWith(CompanyProfile value, $Res Function(CompanyProfile) _then) = _$CompanyProfileCopyWithImpl;
@useResult
$Res call({
 String id, String name, String industry, String description, String location, String? website, String? logoUrl, String? coverImageUrl, CompanySize size, CompanyType type, int? foundedYear, List<String> specializations, List<String> benefits, int? employeeCount, CompanyRating rating, List<String> postedJobs, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$CompanyProfileCopyWithImpl<$Res>
    implements $CompanyProfileCopyWith<$Res> {
  _$CompanyProfileCopyWithImpl(this._self, this._then);

  final CompanyProfile _self;
  final $Res Function(CompanyProfile) _then;

/// Create a copy of CompanyProfile
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? industry = null,Object? description = null,Object? location = null,Object? website = freezed,Object? logoUrl = freezed,Object? coverImageUrl = freezed,Object? size = null,Object? type = null,Object? foundedYear = freezed,Object? specializations = null,Object? benefits = null,Object? employeeCount = freezed,Object? rating = null,Object? postedJobs = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,industry: null == industry ? _self.industry : industry // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as CompanySize,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CompanyType,foundedYear: freezed == foundedYear ? _self.foundedYear : foundedYear // ignore: cast_nullable_to_non_nullable
as int?,specializations: null == specializations ? _self.specializations : specializations // ignore: cast_nullable_to_non_nullable
as List<String>,benefits: null == benefits ? _self.benefits : benefits // ignore: cast_nullable_to_non_nullable
as List<String>,employeeCount: freezed == employeeCount ? _self.employeeCount : employeeCount // ignore: cast_nullable_to_non_nullable
as int?,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as CompanyRating,postedJobs: null == postedJobs ? _self.postedJobs : postedJobs // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [CompanyProfile].
extension CompanyProfilePatterns on CompanyProfile {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompanyProfile value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompanyProfile() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompanyProfile value)  $default,){
final _that = this;
switch (_that) {
case _CompanyProfile():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompanyProfile value)?  $default,){
final _that = this;
switch (_that) {
case _CompanyProfile() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String industry,  String description,  String location,  String? website,  String? logoUrl,  String? coverImageUrl,  CompanySize size,  CompanyType type,  int? foundedYear,  List<String> specializations,  List<String> benefits,  int? employeeCount,  CompanyRating rating,  List<String> postedJobs,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompanyProfile() when $default != null:
return $default(_that.id,_that.name,_that.industry,_that.description,_that.location,_that.website,_that.logoUrl,_that.coverImageUrl,_that.size,_that.type,_that.foundedYear,_that.specializations,_that.benefits,_that.employeeCount,_that.rating,_that.postedJobs,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String industry,  String description,  String location,  String? website,  String? logoUrl,  String? coverImageUrl,  CompanySize size,  CompanyType type,  int? foundedYear,  List<String> specializations,  List<String> benefits,  int? employeeCount,  CompanyRating rating,  List<String> postedJobs,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _CompanyProfile():
return $default(_that.id,_that.name,_that.industry,_that.description,_that.location,_that.website,_that.logoUrl,_that.coverImageUrl,_that.size,_that.type,_that.foundedYear,_that.specializations,_that.benefits,_that.employeeCount,_that.rating,_that.postedJobs,_that.createdAt,_that.updatedAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String industry,  String description,  String location,  String? website,  String? logoUrl,  String? coverImageUrl,  CompanySize size,  CompanyType type,  int? foundedYear,  List<String> specializations,  List<String> benefits,  int? employeeCount,  CompanyRating rating,  List<String> postedJobs,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _CompanyProfile() when $default != null:
return $default(_that.id,_that.name,_that.industry,_that.description,_that.location,_that.website,_that.logoUrl,_that.coverImageUrl,_that.size,_that.type,_that.foundedYear,_that.specializations,_that.benefits,_that.employeeCount,_that.rating,_that.postedJobs,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CompanyProfile implements CompanyProfile {
  const _CompanyProfile({required this.id, required this.name, required this.industry, required this.description, required this.location, this.website, this.logoUrl, this.coverImageUrl, this.size = CompanySize.small, this.type = CompanyType.private, this.foundedYear, final  List<String> specializations = const [], final  List<String> benefits = const [], this.employeeCount, this.rating = CompanyRating.one, final  List<String> postedJobs = const [], this.createdAt, this.updatedAt}): _specializations = specializations,_benefits = benefits,_postedJobs = postedJobs;
  factory _CompanyProfile.fromJson(Map<String, dynamic> json) => _$CompanyProfileFromJson(json);

@override final  String id;
@override final  String name;
@override final  String industry;
@override final  String description;
@override final  String location;
@override final  String? website;
@override final  String? logoUrl;
@override final  String? coverImageUrl;
@override@JsonKey() final  CompanySize size;
@override@JsonKey() final  CompanyType type;
@override final  int? foundedYear;
 final  List<String> _specializations;
@override@JsonKey() List<String> get specializations {
  if (_specializations is EqualUnmodifiableListView) return _specializations;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_specializations);
}

 final  List<String> _benefits;
@override@JsonKey() List<String> get benefits {
  if (_benefits is EqualUnmodifiableListView) return _benefits;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_benefits);
}

@override final  int? employeeCount;
@override@JsonKey() final  CompanyRating rating;
 final  List<String> _postedJobs;
@override@JsonKey() List<String> get postedJobs {
  if (_postedJobs is EqualUnmodifiableListView) return _postedJobs;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_postedJobs);
}

@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of CompanyProfile
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompanyProfileCopyWith<_CompanyProfile> get copyWith => __$CompanyProfileCopyWithImpl<_CompanyProfile>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CompanyProfileToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompanyProfile&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.industry, industry) || other.industry == industry)&&(identical(other.description, description) || other.description == description)&&(identical(other.location, location) || other.location == location)&&(identical(other.website, website) || other.website == website)&&(identical(other.logoUrl, logoUrl) || other.logoUrl == logoUrl)&&(identical(other.coverImageUrl, coverImageUrl) || other.coverImageUrl == coverImageUrl)&&(identical(other.size, size) || other.size == size)&&(identical(other.type, type) || other.type == type)&&(identical(other.foundedYear, foundedYear) || other.foundedYear == foundedYear)&&const DeepCollectionEquality().equals(other._specializations, _specializations)&&const DeepCollectionEquality().equals(other._benefits, _benefits)&&(identical(other.employeeCount, employeeCount) || other.employeeCount == employeeCount)&&(identical(other.rating, rating) || other.rating == rating)&&const DeepCollectionEquality().equals(other._postedJobs, _postedJobs)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,industry,description,location,website,logoUrl,coverImageUrl,size,type,foundedYear,const DeepCollectionEquality().hash(_specializations),const DeepCollectionEquality().hash(_benefits),employeeCount,rating,const DeepCollectionEquality().hash(_postedJobs),createdAt,updatedAt);

@override
String toString() {
  return 'CompanyProfile(id: $id, name: $name, industry: $industry, description: $description, location: $location, website: $website, logoUrl: $logoUrl, coverImageUrl: $coverImageUrl, size: $size, type: $type, foundedYear: $foundedYear, specializations: $specializations, benefits: $benefits, employeeCount: $employeeCount, rating: $rating, postedJobs: $postedJobs, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$CompanyProfileCopyWith<$Res> implements $CompanyProfileCopyWith<$Res> {
  factory _$CompanyProfileCopyWith(_CompanyProfile value, $Res Function(_CompanyProfile) _then) = __$CompanyProfileCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String industry, String description, String location, String? website, String? logoUrl, String? coverImageUrl, CompanySize size, CompanyType type, int? foundedYear, List<String> specializations, List<String> benefits, int? employeeCount, CompanyRating rating, List<String> postedJobs, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$CompanyProfileCopyWithImpl<$Res>
    implements _$CompanyProfileCopyWith<$Res> {
  __$CompanyProfileCopyWithImpl(this._self, this._then);

  final _CompanyProfile _self;
  final $Res Function(_CompanyProfile) _then;

/// Create a copy of CompanyProfile
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? industry = null,Object? description = null,Object? location = null,Object? website = freezed,Object? logoUrl = freezed,Object? coverImageUrl = freezed,Object? size = null,Object? type = null,Object? foundedYear = freezed,Object? specializations = null,Object? benefits = null,Object? employeeCount = freezed,Object? rating = null,Object? postedJobs = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_CompanyProfile(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,industry: null == industry ? _self.industry : industry // ignore: cast_nullable_to_non_nullable
as String,description: null == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,website: freezed == website ? _self.website : website // ignore: cast_nullable_to_non_nullable
as String?,logoUrl: freezed == logoUrl ? _self.logoUrl : logoUrl // ignore: cast_nullable_to_non_nullable
as String?,coverImageUrl: freezed == coverImageUrl ? _self.coverImageUrl : coverImageUrl // ignore: cast_nullable_to_non_nullable
as String?,size: null == size ? _self.size : size // ignore: cast_nullable_to_non_nullable
as CompanySize,type: null == type ? _self.type : type // ignore: cast_nullable_to_non_nullable
as CompanyType,foundedYear: freezed == foundedYear ? _self.foundedYear : foundedYear // ignore: cast_nullable_to_non_nullable
as int?,specializations: null == specializations ? _self._specializations : specializations // ignore: cast_nullable_to_non_nullable
as List<String>,benefits: null == benefits ? _self._benefits : benefits // ignore: cast_nullable_to_non_nullable
as List<String>,employeeCount: freezed == employeeCount ? _self.employeeCount : employeeCount // ignore: cast_nullable_to_non_nullable
as int?,rating: null == rating ? _self.rating : rating // ignore: cast_nullable_to_non_nullable
as CompanyRating,postedJobs: null == postedJobs ? _self._postedJobs : postedJobs // ignore: cast_nullable_to_non_nullable
as List<String>,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$CompanyReview {

 String get id; String get companyId; String get reviewerName; String get reviewerEmail; CompanyRating get overallRating; CompanyRating get cultureRating; CompanyRating get salaryRating; CompanyRating get workLifeBalanceRating; String get title; String get content; ReviewStatus get status; DateTime? get createdAt; DateTime? get updatedAt;
/// Create a copy of CompanyReview
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompanyReviewCopyWith<CompanyReview> get copyWith => _$CompanyReviewCopyWithImpl<CompanyReview>(this as CompanyReview, _$identity);

  /// Serializes this CompanyReview to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompanyReview&&(identical(other.id, id) || other.id == id)&&(identical(other.companyId, companyId) || other.companyId == companyId)&&(identical(other.reviewerName, reviewerName) || other.reviewerName == reviewerName)&&(identical(other.reviewerEmail, reviewerEmail) || other.reviewerEmail == reviewerEmail)&&(identical(other.overallRating, overallRating) || other.overallRating == overallRating)&&(identical(other.cultureRating, cultureRating) || other.cultureRating == cultureRating)&&(identical(other.salaryRating, salaryRating) || other.salaryRating == salaryRating)&&(identical(other.workLifeBalanceRating, workLifeBalanceRating) || other.workLifeBalanceRating == workLifeBalanceRating)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,companyId,reviewerName,reviewerEmail,overallRating,cultureRating,salaryRating,workLifeBalanceRating,title,content,status,createdAt,updatedAt);

@override
String toString() {
  return 'CompanyReview(id: $id, companyId: $companyId, reviewerName: $reviewerName, reviewerEmail: $reviewerEmail, overallRating: $overallRating, cultureRating: $cultureRating, salaryRating: $salaryRating, workLifeBalanceRating: $workLifeBalanceRating, title: $title, content: $content, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $CompanyReviewCopyWith<$Res>  {
  factory $CompanyReviewCopyWith(CompanyReview value, $Res Function(CompanyReview) _then) = _$CompanyReviewCopyWithImpl;
@useResult
$Res call({
 String id, String companyId, String reviewerName, String reviewerEmail, CompanyRating overallRating, CompanyRating cultureRating, CompanyRating salaryRating, CompanyRating workLifeBalanceRating, String title, String content, ReviewStatus status, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class _$CompanyReviewCopyWithImpl<$Res>
    implements $CompanyReviewCopyWith<$Res> {
  _$CompanyReviewCopyWithImpl(this._self, this._then);

  final CompanyReview _self;
  final $Res Function(CompanyReview) _then;

/// Create a copy of CompanyReview
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? companyId = null,Object? reviewerName = null,Object? reviewerEmail = null,Object? overallRating = null,Object? cultureRating = null,Object? salaryRating = null,Object? workLifeBalanceRating = null,Object? title = null,Object? content = null,Object? status = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,companyId: null == companyId ? _self.companyId : companyId // ignore: cast_nullable_to_non_nullable
as String,reviewerName: null == reviewerName ? _self.reviewerName : reviewerName // ignore: cast_nullable_to_non_nullable
as String,reviewerEmail: null == reviewerEmail ? _self.reviewerEmail : reviewerEmail // ignore: cast_nullable_to_non_nullable
as String,overallRating: null == overallRating ? _self.overallRating : overallRating // ignore: cast_nullable_to_non_nullable
as CompanyRating,cultureRating: null == cultureRating ? _self.cultureRating : cultureRating // ignore: cast_nullable_to_non_nullable
as CompanyRating,salaryRating: null == salaryRating ? _self.salaryRating : salaryRating // ignore: cast_nullable_to_non_nullable
as CompanyRating,workLifeBalanceRating: null == workLifeBalanceRating ? _self.workLifeBalanceRating : workLifeBalanceRating // ignore: cast_nullable_to_non_nullable
as CompanyRating,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReviewStatus,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [CompanyReview].
extension CompanyReviewPatterns on CompanyReview {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CompanyReview value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CompanyReview() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CompanyReview value)  $default,){
final _that = this;
switch (_that) {
case _CompanyReview():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CompanyReview value)?  $default,){
final _that = this;
switch (_that) {
case _CompanyReview() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String companyId,  String reviewerName,  String reviewerEmail,  CompanyRating overallRating,  CompanyRating cultureRating,  CompanyRating salaryRating,  CompanyRating workLifeBalanceRating,  String title,  String content,  ReviewStatus status,  DateTime? createdAt,  DateTime? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CompanyReview() when $default != null:
return $default(_that.id,_that.companyId,_that.reviewerName,_that.reviewerEmail,_that.overallRating,_that.cultureRating,_that.salaryRating,_that.workLifeBalanceRating,_that.title,_that.content,_that.status,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String companyId,  String reviewerName,  String reviewerEmail,  CompanyRating overallRating,  CompanyRating cultureRating,  CompanyRating salaryRating,  CompanyRating workLifeBalanceRating,  String title,  String content,  ReviewStatus status,  DateTime? createdAt,  DateTime? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _CompanyReview():
return $default(_that.id,_that.companyId,_that.reviewerName,_that.reviewerEmail,_that.overallRating,_that.cultureRating,_that.salaryRating,_that.workLifeBalanceRating,_that.title,_that.content,_that.status,_that.createdAt,_that.updatedAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String companyId,  String reviewerName,  String reviewerEmail,  CompanyRating overallRating,  CompanyRating cultureRating,  CompanyRating salaryRating,  CompanyRating workLifeBalanceRating,  String title,  String content,  ReviewStatus status,  DateTime? createdAt,  DateTime? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _CompanyReview() when $default != null:
return $default(_that.id,_that.companyId,_that.reviewerName,_that.reviewerEmail,_that.overallRating,_that.cultureRating,_that.salaryRating,_that.workLifeBalanceRating,_that.title,_that.content,_that.status,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CompanyReview implements CompanyReview {
  const _CompanyReview({required this.id, required this.companyId, required this.reviewerName, required this.reviewerEmail, required this.overallRating, required this.cultureRating, required this.salaryRating, required this.workLifeBalanceRating, required this.title, required this.content, this.status = ReviewStatus.pending, this.createdAt, this.updatedAt});
  factory _CompanyReview.fromJson(Map<String, dynamic> json) => _$CompanyReviewFromJson(json);

@override final  String id;
@override final  String companyId;
@override final  String reviewerName;
@override final  String reviewerEmail;
@override final  CompanyRating overallRating;
@override final  CompanyRating cultureRating;
@override final  CompanyRating salaryRating;
@override final  CompanyRating workLifeBalanceRating;
@override final  String title;
@override final  String content;
@override@JsonKey() final  ReviewStatus status;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;

/// Create a copy of CompanyReview
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CompanyReviewCopyWith<_CompanyReview> get copyWith => __$CompanyReviewCopyWithImpl<_CompanyReview>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CompanyReviewToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CompanyReview&&(identical(other.id, id) || other.id == id)&&(identical(other.companyId, companyId) || other.companyId == companyId)&&(identical(other.reviewerName, reviewerName) || other.reviewerName == reviewerName)&&(identical(other.reviewerEmail, reviewerEmail) || other.reviewerEmail == reviewerEmail)&&(identical(other.overallRating, overallRating) || other.overallRating == overallRating)&&(identical(other.cultureRating, cultureRating) || other.cultureRating == cultureRating)&&(identical(other.salaryRating, salaryRating) || other.salaryRating == salaryRating)&&(identical(other.workLifeBalanceRating, workLifeBalanceRating) || other.workLifeBalanceRating == workLifeBalanceRating)&&(identical(other.title, title) || other.title == title)&&(identical(other.content, content) || other.content == content)&&(identical(other.status, status) || other.status == status)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,companyId,reviewerName,reviewerEmail,overallRating,cultureRating,salaryRating,workLifeBalanceRating,title,content,status,createdAt,updatedAt);

@override
String toString() {
  return 'CompanyReview(id: $id, companyId: $companyId, reviewerName: $reviewerName, reviewerEmail: $reviewerEmail, overallRating: $overallRating, cultureRating: $cultureRating, salaryRating: $salaryRating, workLifeBalanceRating: $workLifeBalanceRating, title: $title, content: $content, status: $status, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$CompanyReviewCopyWith<$Res> implements $CompanyReviewCopyWith<$Res> {
  factory _$CompanyReviewCopyWith(_CompanyReview value, $Res Function(_CompanyReview) _then) = __$CompanyReviewCopyWithImpl;
@override @useResult
$Res call({
 String id, String companyId, String reviewerName, String reviewerEmail, CompanyRating overallRating, CompanyRating cultureRating, CompanyRating salaryRating, CompanyRating workLifeBalanceRating, String title, String content, ReviewStatus status, DateTime? createdAt, DateTime? updatedAt
});




}
/// @nodoc
class __$CompanyReviewCopyWithImpl<$Res>
    implements _$CompanyReviewCopyWith<$Res> {
  __$CompanyReviewCopyWithImpl(this._self, this._then);

  final _CompanyReview _self;
  final $Res Function(_CompanyReview) _then;

/// Create a copy of CompanyReview
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? companyId = null,Object? reviewerName = null,Object? reviewerEmail = null,Object? overallRating = null,Object? cultureRating = null,Object? salaryRating = null,Object? workLifeBalanceRating = null,Object? title = null,Object? content = null,Object? status = null,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_CompanyReview(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,companyId: null == companyId ? _self.companyId : companyId // ignore: cast_nullable_to_non_nullable
as String,reviewerName: null == reviewerName ? _self.reviewerName : reviewerName // ignore: cast_nullable_to_non_nullable
as String,reviewerEmail: null == reviewerEmail ? _self.reviewerEmail : reviewerEmail // ignore: cast_nullable_to_non_nullable
as String,overallRating: null == overallRating ? _self.overallRating : overallRating // ignore: cast_nullable_to_non_nullable
as CompanyRating,cultureRating: null == cultureRating ? _self.cultureRating : cultureRating // ignore: cast_nullable_to_non_nullable
as CompanyRating,salaryRating: null == salaryRating ? _self.salaryRating : salaryRating // ignore: cast_nullable_to_non_nullable
as CompanyRating,workLifeBalanceRating: null == workLifeBalanceRating ? _self.workLifeBalanceRating : workLifeBalanceRating // ignore: cast_nullable_to_non_nullable
as CompanyRating,title: null == title ? _self.title : title // ignore: cast_nullable_to_non_nullable
as String,content: null == content ? _self.content : content // ignore: cast_nullable_to_non_nullable
as String,status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ReviewStatus,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
