// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'professional_info_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProfessionalInfoRequest {

 String get summary; String? get jobType; String? get experience; String? get education; String? get degree; List<EmploymentHistoryItem>? get employmentHistory; List<EducationItem>? get educationList; List<SkillItem>? get skills; List<LanguageItem>? get languages;
/// Create a copy of ProfessionalInfoRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfessionalInfoRequestCopyWith<ProfessionalInfoRequest> get copyWith => _$ProfessionalInfoRequestCopyWithImpl<ProfessionalInfoRequest>(this as ProfessionalInfoRequest, _$identity);

  /// Serializes this ProfessionalInfoRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfessionalInfoRequest&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.jobType, jobType) || other.jobType == jobType)&&(identical(other.experience, experience) || other.experience == experience)&&(identical(other.education, education) || other.education == education)&&(identical(other.degree, degree) || other.degree == degree)&&const DeepCollectionEquality().equals(other.employmentHistory, employmentHistory)&&const DeepCollectionEquality().equals(other.educationList, educationList)&&const DeepCollectionEquality().equals(other.skills, skills)&&const DeepCollectionEquality().equals(other.languages, languages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,summary,jobType,experience,education,degree,const DeepCollectionEquality().hash(employmentHistory),const DeepCollectionEquality().hash(educationList),const DeepCollectionEquality().hash(skills),const DeepCollectionEquality().hash(languages));

@override
String toString() {
  return 'ProfessionalInfoRequest(summary: $summary, jobType: $jobType, experience: $experience, education: $education, degree: $degree, employmentHistory: $employmentHistory, educationList: $educationList, skills: $skills, languages: $languages)';
}


}

/// @nodoc
abstract mixin class $ProfessionalInfoRequestCopyWith<$Res>  {
  factory $ProfessionalInfoRequestCopyWith(ProfessionalInfoRequest value, $Res Function(ProfessionalInfoRequest) _then) = _$ProfessionalInfoRequestCopyWithImpl;
@useResult
$Res call({
 String summary, String? jobType, String? experience, String? education, String? degree, List<EmploymentHistoryItem>? employmentHistory, List<EducationItem>? educationList, List<SkillItem>? skills, List<LanguageItem>? languages
});




}
/// @nodoc
class _$ProfessionalInfoRequestCopyWithImpl<$Res>
    implements $ProfessionalInfoRequestCopyWith<$Res> {
  _$ProfessionalInfoRequestCopyWithImpl(this._self, this._then);

  final ProfessionalInfoRequest _self;
  final $Res Function(ProfessionalInfoRequest) _then;

/// Create a copy of ProfessionalInfoRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? summary = null,Object? jobType = freezed,Object? experience = freezed,Object? education = freezed,Object? degree = freezed,Object? employmentHistory = freezed,Object? educationList = freezed,Object? skills = freezed,Object? languages = freezed,}) {
  return _then(_self.copyWith(
summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,jobType: freezed == jobType ? _self.jobType : jobType // ignore: cast_nullable_to_non_nullable
as String?,experience: freezed == experience ? _self.experience : experience // ignore: cast_nullable_to_non_nullable
as String?,education: freezed == education ? _self.education : education // ignore: cast_nullable_to_non_nullable
as String?,degree: freezed == degree ? _self.degree : degree // ignore: cast_nullable_to_non_nullable
as String?,employmentHistory: freezed == employmentHistory ? _self.employmentHistory : employmentHistory // ignore: cast_nullable_to_non_nullable
as List<EmploymentHistoryItem>?,educationList: freezed == educationList ? _self.educationList : educationList // ignore: cast_nullable_to_non_nullable
as List<EducationItem>?,skills: freezed == skills ? _self.skills : skills // ignore: cast_nullable_to_non_nullable
as List<SkillItem>?,languages: freezed == languages ? _self.languages : languages // ignore: cast_nullable_to_non_nullable
as List<LanguageItem>?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfessionalInfoRequest].
extension ProfessionalInfoRequestPatterns on ProfessionalInfoRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfessionalInfoRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfessionalInfoRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfessionalInfoRequest value)  $default,){
final _that = this;
switch (_that) {
case _ProfessionalInfoRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfessionalInfoRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ProfessionalInfoRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String summary,  String? jobType,  String? experience,  String? education,  String? degree,  List<EmploymentHistoryItem>? employmentHistory,  List<EducationItem>? educationList,  List<SkillItem>? skills,  List<LanguageItem>? languages)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfessionalInfoRequest() when $default != null:
return $default(_that.summary,_that.jobType,_that.experience,_that.education,_that.degree,_that.employmentHistory,_that.educationList,_that.skills,_that.languages);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String summary,  String? jobType,  String? experience,  String? education,  String? degree,  List<EmploymentHistoryItem>? employmentHistory,  List<EducationItem>? educationList,  List<SkillItem>? skills,  List<LanguageItem>? languages)  $default,) {final _that = this;
switch (_that) {
case _ProfessionalInfoRequest():
return $default(_that.summary,_that.jobType,_that.experience,_that.education,_that.degree,_that.employmentHistory,_that.educationList,_that.skills,_that.languages);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String summary,  String? jobType,  String? experience,  String? education,  String? degree,  List<EmploymentHistoryItem>? employmentHistory,  List<EducationItem>? educationList,  List<SkillItem>? skills,  List<LanguageItem>? languages)?  $default,) {final _that = this;
switch (_that) {
case _ProfessionalInfoRequest() when $default != null:
return $default(_that.summary,_that.jobType,_that.experience,_that.education,_that.degree,_that.employmentHistory,_that.educationList,_that.skills,_that.languages);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfessionalInfoRequest implements ProfessionalInfoRequest {
  const _ProfessionalInfoRequest({required this.summary, this.jobType, this.experience, this.education, this.degree, final  List<EmploymentHistoryItem>? employmentHistory, final  List<EducationItem>? educationList, final  List<SkillItem>? skills, final  List<LanguageItem>? languages}): _employmentHistory = employmentHistory,_educationList = educationList,_skills = skills,_languages = languages;
  factory _ProfessionalInfoRequest.fromJson(Map<String, dynamic> json) => _$ProfessionalInfoRequestFromJson(json);

@override final  String summary;
@override final  String? jobType;
@override final  String? experience;
@override final  String? education;
@override final  String? degree;
 final  List<EmploymentHistoryItem>? _employmentHistory;
@override List<EmploymentHistoryItem>? get employmentHistory {
  final value = _employmentHistory;
  if (value == null) return null;
  if (_employmentHistory is EqualUnmodifiableListView) return _employmentHistory;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<EducationItem>? _educationList;
@override List<EducationItem>? get educationList {
  final value = _educationList;
  if (value == null) return null;
  if (_educationList is EqualUnmodifiableListView) return _educationList;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<SkillItem>? _skills;
@override List<SkillItem>? get skills {
  final value = _skills;
  if (value == null) return null;
  if (_skills is EqualUnmodifiableListView) return _skills;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

 final  List<LanguageItem>? _languages;
@override List<LanguageItem>? get languages {
  final value = _languages;
  if (value == null) return null;
  if (_languages is EqualUnmodifiableListView) return _languages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of ProfessionalInfoRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfessionalInfoRequestCopyWith<_ProfessionalInfoRequest> get copyWith => __$ProfessionalInfoRequestCopyWithImpl<_ProfessionalInfoRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfessionalInfoRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfessionalInfoRequest&&(identical(other.summary, summary) || other.summary == summary)&&(identical(other.jobType, jobType) || other.jobType == jobType)&&(identical(other.experience, experience) || other.experience == experience)&&(identical(other.education, education) || other.education == education)&&(identical(other.degree, degree) || other.degree == degree)&&const DeepCollectionEquality().equals(other._employmentHistory, _employmentHistory)&&const DeepCollectionEquality().equals(other._educationList, _educationList)&&const DeepCollectionEquality().equals(other._skills, _skills)&&const DeepCollectionEquality().equals(other._languages, _languages));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,summary,jobType,experience,education,degree,const DeepCollectionEquality().hash(_employmentHistory),const DeepCollectionEquality().hash(_educationList),const DeepCollectionEquality().hash(_skills),const DeepCollectionEquality().hash(_languages));

@override
String toString() {
  return 'ProfessionalInfoRequest(summary: $summary, jobType: $jobType, experience: $experience, education: $education, degree: $degree, employmentHistory: $employmentHistory, educationList: $educationList, skills: $skills, languages: $languages)';
}


}

/// @nodoc
abstract mixin class _$ProfessionalInfoRequestCopyWith<$Res> implements $ProfessionalInfoRequestCopyWith<$Res> {
  factory _$ProfessionalInfoRequestCopyWith(_ProfessionalInfoRequest value, $Res Function(_ProfessionalInfoRequest) _then) = __$ProfessionalInfoRequestCopyWithImpl;
@override @useResult
$Res call({
 String summary, String? jobType, String? experience, String? education, String? degree, List<EmploymentHistoryItem>? employmentHistory, List<EducationItem>? educationList, List<SkillItem>? skills, List<LanguageItem>? languages
});




}
/// @nodoc
class __$ProfessionalInfoRequestCopyWithImpl<$Res>
    implements _$ProfessionalInfoRequestCopyWith<$Res> {
  __$ProfessionalInfoRequestCopyWithImpl(this._self, this._then);

  final _ProfessionalInfoRequest _self;
  final $Res Function(_ProfessionalInfoRequest) _then;

/// Create a copy of ProfessionalInfoRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? summary = null,Object? jobType = freezed,Object? experience = freezed,Object? education = freezed,Object? degree = freezed,Object? employmentHistory = freezed,Object? educationList = freezed,Object? skills = freezed,Object? languages = freezed,}) {
  return _then(_ProfessionalInfoRequest(
summary: null == summary ? _self.summary : summary // ignore: cast_nullable_to_non_nullable
as String,jobType: freezed == jobType ? _self.jobType : jobType // ignore: cast_nullable_to_non_nullable
as String?,experience: freezed == experience ? _self.experience : experience // ignore: cast_nullable_to_non_nullable
as String?,education: freezed == education ? _self.education : education // ignore: cast_nullable_to_non_nullable
as String?,degree: freezed == degree ? _self.degree : degree // ignore: cast_nullable_to_non_nullable
as String?,employmentHistory: freezed == employmentHistory ? _self._employmentHistory : employmentHistory // ignore: cast_nullable_to_non_nullable
as List<EmploymentHistoryItem>?,educationList: freezed == educationList ? _self._educationList : educationList // ignore: cast_nullable_to_non_nullable
as List<EducationItem>?,skills: freezed == skills ? _self._skills : skills // ignore: cast_nullable_to_non_nullable
as List<SkillItem>?,languages: freezed == languages ? _self._languages : languages // ignore: cast_nullable_to_non_nullable
as List<LanguageItem>?,
  ));
}


}


/// @nodoc
mixin _$EmploymentHistoryItem {

 String? get company; String? get position; String? get startDate; String? get endDate; String? get country; String? get city; bool? get current; String? get description; List<String>? get achievements;
/// Create a copy of EmploymentHistoryItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EmploymentHistoryItemCopyWith<EmploymentHistoryItem> get copyWith => _$EmploymentHistoryItemCopyWithImpl<EmploymentHistoryItem>(this as EmploymentHistoryItem, _$identity);

  /// Serializes this EmploymentHistoryItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EmploymentHistoryItem&&(identical(other.company, company) || other.company == company)&&(identical(other.position, position) || other.position == position)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.country, country) || other.country == country)&&(identical(other.city, city) || other.city == city)&&(identical(other.current, current) || other.current == current)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other.achievements, achievements));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,company,position,startDate,endDate,country,city,current,description,const DeepCollectionEquality().hash(achievements));

@override
String toString() {
  return 'EmploymentHistoryItem(company: $company, position: $position, startDate: $startDate, endDate: $endDate, country: $country, city: $city, current: $current, description: $description, achievements: $achievements)';
}


}

/// @nodoc
abstract mixin class $EmploymentHistoryItemCopyWith<$Res>  {
  factory $EmploymentHistoryItemCopyWith(EmploymentHistoryItem value, $Res Function(EmploymentHistoryItem) _then) = _$EmploymentHistoryItemCopyWithImpl;
@useResult
$Res call({
 String? company, String? position, String? startDate, String? endDate, String? country, String? city, bool? current, String? description, List<String>? achievements
});




}
/// @nodoc
class _$EmploymentHistoryItemCopyWithImpl<$Res>
    implements $EmploymentHistoryItemCopyWith<$Res> {
  _$EmploymentHistoryItemCopyWithImpl(this._self, this._then);

  final EmploymentHistoryItem _self;
  final $Res Function(EmploymentHistoryItem) _then;

/// Create a copy of EmploymentHistoryItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? company = freezed,Object? position = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? country = freezed,Object? city = freezed,Object? current = freezed,Object? description = freezed,Object? achievements = freezed,}) {
  return _then(_self.copyWith(
company: freezed == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String?,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,current: freezed == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as bool?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,achievements: freezed == achievements ? _self.achievements : achievements // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [EmploymentHistoryItem].
extension EmploymentHistoryItemPatterns on EmploymentHistoryItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EmploymentHistoryItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EmploymentHistoryItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EmploymentHistoryItem value)  $default,){
final _that = this;
switch (_that) {
case _EmploymentHistoryItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EmploymentHistoryItem value)?  $default,){
final _that = this;
switch (_that) {
case _EmploymentHistoryItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? company,  String? position,  String? startDate,  String? endDate,  String? country,  String? city,  bool? current,  String? description,  List<String>? achievements)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EmploymentHistoryItem() when $default != null:
return $default(_that.company,_that.position,_that.startDate,_that.endDate,_that.country,_that.city,_that.current,_that.description,_that.achievements);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? company,  String? position,  String? startDate,  String? endDate,  String? country,  String? city,  bool? current,  String? description,  List<String>? achievements)  $default,) {final _that = this;
switch (_that) {
case _EmploymentHistoryItem():
return $default(_that.company,_that.position,_that.startDate,_that.endDate,_that.country,_that.city,_that.current,_that.description,_that.achievements);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? company,  String? position,  String? startDate,  String? endDate,  String? country,  String? city,  bool? current,  String? description,  List<String>? achievements)?  $default,) {final _that = this;
switch (_that) {
case _EmploymentHistoryItem() when $default != null:
return $default(_that.company,_that.position,_that.startDate,_that.endDate,_that.country,_that.city,_that.current,_that.description,_that.achievements);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EmploymentHistoryItem implements EmploymentHistoryItem {
  const _EmploymentHistoryItem({this.company, this.position, this.startDate, this.endDate, this.country, this.city, this.current, this.description, final  List<String>? achievements}): _achievements = achievements;
  factory _EmploymentHistoryItem.fromJson(Map<String, dynamic> json) => _$EmploymentHistoryItemFromJson(json);

@override final  String? company;
@override final  String? position;
@override final  String? startDate;
@override final  String? endDate;
@override final  String? country;
@override final  String? city;
@override final  bool? current;
@override final  String? description;
 final  List<String>? _achievements;
@override List<String>? get achievements {
  final value = _achievements;
  if (value == null) return null;
  if (_achievements is EqualUnmodifiableListView) return _achievements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of EmploymentHistoryItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EmploymentHistoryItemCopyWith<_EmploymentHistoryItem> get copyWith => __$EmploymentHistoryItemCopyWithImpl<_EmploymentHistoryItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EmploymentHistoryItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EmploymentHistoryItem&&(identical(other.company, company) || other.company == company)&&(identical(other.position, position) || other.position == position)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.country, country) || other.country == country)&&(identical(other.city, city) || other.city == city)&&(identical(other.current, current) || other.current == current)&&(identical(other.description, description) || other.description == description)&&const DeepCollectionEquality().equals(other._achievements, _achievements));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,company,position,startDate,endDate,country,city,current,description,const DeepCollectionEquality().hash(_achievements));

@override
String toString() {
  return 'EmploymentHistoryItem(company: $company, position: $position, startDate: $startDate, endDate: $endDate, country: $country, city: $city, current: $current, description: $description, achievements: $achievements)';
}


}

/// @nodoc
abstract mixin class _$EmploymentHistoryItemCopyWith<$Res> implements $EmploymentHistoryItemCopyWith<$Res> {
  factory _$EmploymentHistoryItemCopyWith(_EmploymentHistoryItem value, $Res Function(_EmploymentHistoryItem) _then) = __$EmploymentHistoryItemCopyWithImpl;
@override @useResult
$Res call({
 String? company, String? position, String? startDate, String? endDate, String? country, String? city, bool? current, String? description, List<String>? achievements
});




}
/// @nodoc
class __$EmploymentHistoryItemCopyWithImpl<$Res>
    implements _$EmploymentHistoryItemCopyWith<$Res> {
  __$EmploymentHistoryItemCopyWithImpl(this._self, this._then);

  final _EmploymentHistoryItem _self;
  final $Res Function(_EmploymentHistoryItem) _then;

/// Create a copy of EmploymentHistoryItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? company = freezed,Object? position = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? country = freezed,Object? city = freezed,Object? current = freezed,Object? description = freezed,Object? achievements = freezed,}) {
  return _then(_EmploymentHistoryItem(
company: freezed == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String?,position: freezed == position ? _self.position : position // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,country: freezed == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,current: freezed == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as bool?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,achievements: freezed == achievements ? _self._achievements : achievements // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}


/// @nodoc
mixin _$EducationItem {

 String? get institution; String? get degree; String? get field; String? get city; String? get startDate; String? get endDate; bool? get current; double? get gpa; List<String>? get achievements;
/// Create a copy of EducationItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EducationItemCopyWith<EducationItem> get copyWith => _$EducationItemCopyWithImpl<EducationItem>(this as EducationItem, _$identity);

  /// Serializes this EducationItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is EducationItem&&(identical(other.institution, institution) || other.institution == institution)&&(identical(other.degree, degree) || other.degree == degree)&&(identical(other.field, field) || other.field == field)&&(identical(other.city, city) || other.city == city)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.current, current) || other.current == current)&&(identical(other.gpa, gpa) || other.gpa == gpa)&&const DeepCollectionEquality().equals(other.achievements, achievements));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,institution,degree,field,city,startDate,endDate,current,gpa,const DeepCollectionEquality().hash(achievements));

@override
String toString() {
  return 'EducationItem(institution: $institution, degree: $degree, field: $field, city: $city, startDate: $startDate, endDate: $endDate, current: $current, gpa: $gpa, achievements: $achievements)';
}


}

/// @nodoc
abstract mixin class $EducationItemCopyWith<$Res>  {
  factory $EducationItemCopyWith(EducationItem value, $Res Function(EducationItem) _then) = _$EducationItemCopyWithImpl;
@useResult
$Res call({
 String? institution, String? degree, String? field, String? city, String? startDate, String? endDate, bool? current, double? gpa, List<String>? achievements
});




}
/// @nodoc
class _$EducationItemCopyWithImpl<$Res>
    implements $EducationItemCopyWith<$Res> {
  _$EducationItemCopyWithImpl(this._self, this._then);

  final EducationItem _self;
  final $Res Function(EducationItem) _then;

/// Create a copy of EducationItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? institution = freezed,Object? degree = freezed,Object? field = freezed,Object? city = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? current = freezed,Object? gpa = freezed,Object? achievements = freezed,}) {
  return _then(_self.copyWith(
institution: freezed == institution ? _self.institution : institution // ignore: cast_nullable_to_non_nullable
as String?,degree: freezed == degree ? _self.degree : degree // ignore: cast_nullable_to_non_nullable
as String?,field: freezed == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,current: freezed == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as bool?,gpa: freezed == gpa ? _self.gpa : gpa // ignore: cast_nullable_to_non_nullable
as double?,achievements: freezed == achievements ? _self.achievements : achievements // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [EducationItem].
extension EducationItemPatterns on EducationItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _EducationItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _EducationItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _EducationItem value)  $default,){
final _that = this;
switch (_that) {
case _EducationItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _EducationItem value)?  $default,){
final _that = this;
switch (_that) {
case _EducationItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? institution,  String? degree,  String? field,  String? city,  String? startDate,  String? endDate,  bool? current,  double? gpa,  List<String>? achievements)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _EducationItem() when $default != null:
return $default(_that.institution,_that.degree,_that.field,_that.city,_that.startDate,_that.endDate,_that.current,_that.gpa,_that.achievements);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? institution,  String? degree,  String? field,  String? city,  String? startDate,  String? endDate,  bool? current,  double? gpa,  List<String>? achievements)  $default,) {final _that = this;
switch (_that) {
case _EducationItem():
return $default(_that.institution,_that.degree,_that.field,_that.city,_that.startDate,_that.endDate,_that.current,_that.gpa,_that.achievements);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? institution,  String? degree,  String? field,  String? city,  String? startDate,  String? endDate,  bool? current,  double? gpa,  List<String>? achievements)?  $default,) {final _that = this;
switch (_that) {
case _EducationItem() when $default != null:
return $default(_that.institution,_that.degree,_that.field,_that.city,_that.startDate,_that.endDate,_that.current,_that.gpa,_that.achievements);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _EducationItem implements EducationItem {
  const _EducationItem({this.institution, this.degree, this.field, this.city, this.startDate, this.endDate, this.current, this.gpa, final  List<String>? achievements}): _achievements = achievements;
  factory _EducationItem.fromJson(Map<String, dynamic> json) => _$EducationItemFromJson(json);

@override final  String? institution;
@override final  String? degree;
@override final  String? field;
@override final  String? city;
@override final  String? startDate;
@override final  String? endDate;
@override final  bool? current;
@override final  double? gpa;
 final  List<String>? _achievements;
@override List<String>? get achievements {
  final value = _achievements;
  if (value == null) return null;
  if (_achievements is EqualUnmodifiableListView) return _achievements;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of EducationItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$EducationItemCopyWith<_EducationItem> get copyWith => __$EducationItemCopyWithImpl<_EducationItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$EducationItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _EducationItem&&(identical(other.institution, institution) || other.institution == institution)&&(identical(other.degree, degree) || other.degree == degree)&&(identical(other.field, field) || other.field == field)&&(identical(other.city, city) || other.city == city)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.current, current) || other.current == current)&&(identical(other.gpa, gpa) || other.gpa == gpa)&&const DeepCollectionEquality().equals(other._achievements, _achievements));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,institution,degree,field,city,startDate,endDate,current,gpa,const DeepCollectionEquality().hash(_achievements));

@override
String toString() {
  return 'EducationItem(institution: $institution, degree: $degree, field: $field, city: $city, startDate: $startDate, endDate: $endDate, current: $current, gpa: $gpa, achievements: $achievements)';
}


}

/// @nodoc
abstract mixin class _$EducationItemCopyWith<$Res> implements $EducationItemCopyWith<$Res> {
  factory _$EducationItemCopyWith(_EducationItem value, $Res Function(_EducationItem) _then) = __$EducationItemCopyWithImpl;
@override @useResult
$Res call({
 String? institution, String? degree, String? field, String? city, String? startDate, String? endDate, bool? current, double? gpa, List<String>? achievements
});




}
/// @nodoc
class __$EducationItemCopyWithImpl<$Res>
    implements _$EducationItemCopyWith<$Res> {
  __$EducationItemCopyWithImpl(this._self, this._then);

  final _EducationItem _self;
  final $Res Function(_EducationItem) _then;

/// Create a copy of EducationItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? institution = freezed,Object? degree = freezed,Object? field = freezed,Object? city = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? current = freezed,Object? gpa = freezed,Object? achievements = freezed,}) {
  return _then(_EducationItem(
institution: freezed == institution ? _self.institution : institution // ignore: cast_nullable_to_non_nullable
as String?,degree: freezed == degree ? _self.degree : degree // ignore: cast_nullable_to_non_nullable
as String?,field: freezed == field ? _self.field : field // ignore: cast_nullable_to_non_nullable
as String?,city: freezed == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,current: freezed == current ? _self.current : current // ignore: cast_nullable_to_non_nullable
as bool?,gpa: freezed == gpa ? _self.gpa : gpa // ignore: cast_nullable_to_non_nullable
as double?,achievements: freezed == achievements ? _self._achievements : achievements // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}


/// @nodoc
mixin _$SkillItem {

 String get category; String get name; String? get level;
/// Create a copy of SkillItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SkillItemCopyWith<SkillItem> get copyWith => _$SkillItemCopyWithImpl<SkillItem>(this as SkillItem, _$identity);

  /// Serializes this SkillItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SkillItem&&(identical(other.category, category) || other.category == category)&&(identical(other.name, name) || other.name == name)&&(identical(other.level, level) || other.level == level));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,category,name,level);

@override
String toString() {
  return 'SkillItem(category: $category, name: $name, level: $level)';
}


}

/// @nodoc
abstract mixin class $SkillItemCopyWith<$Res>  {
  factory $SkillItemCopyWith(SkillItem value, $Res Function(SkillItem) _then) = _$SkillItemCopyWithImpl;
@useResult
$Res call({
 String category, String name, String? level
});




}
/// @nodoc
class _$SkillItemCopyWithImpl<$Res>
    implements $SkillItemCopyWith<$Res> {
  _$SkillItemCopyWithImpl(this._self, this._then);

  final SkillItem _self;
  final $Res Function(SkillItem) _then;

/// Create a copy of SkillItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? category = null,Object? name = null,Object? level = freezed,}) {
  return _then(_self.copyWith(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,level: freezed == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [SkillItem].
extension SkillItemPatterns on SkillItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SkillItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SkillItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SkillItem value)  $default,){
final _that = this;
switch (_that) {
case _SkillItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SkillItem value)?  $default,){
final _that = this;
switch (_that) {
case _SkillItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String category,  String name,  String? level)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SkillItem() when $default != null:
return $default(_that.category,_that.name,_that.level);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String category,  String name,  String? level)  $default,) {final _that = this;
switch (_that) {
case _SkillItem():
return $default(_that.category,_that.name,_that.level);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String category,  String name,  String? level)?  $default,) {final _that = this;
switch (_that) {
case _SkillItem() when $default != null:
return $default(_that.category,_that.name,_that.level);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SkillItem implements SkillItem {
  const _SkillItem({required this.category, required this.name, this.level});
  factory _SkillItem.fromJson(Map<String, dynamic> json) => _$SkillItemFromJson(json);

@override final  String category;
@override final  String name;
@override final  String? level;

/// Create a copy of SkillItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SkillItemCopyWith<_SkillItem> get copyWith => __$SkillItemCopyWithImpl<_SkillItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SkillItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SkillItem&&(identical(other.category, category) || other.category == category)&&(identical(other.name, name) || other.name == name)&&(identical(other.level, level) || other.level == level));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,category,name,level);

@override
String toString() {
  return 'SkillItem(category: $category, name: $name, level: $level)';
}


}

/// @nodoc
abstract mixin class _$SkillItemCopyWith<$Res> implements $SkillItemCopyWith<$Res> {
  factory _$SkillItemCopyWith(_SkillItem value, $Res Function(_SkillItem) _then) = __$SkillItemCopyWithImpl;
@override @useResult
$Res call({
 String category, String name, String? level
});




}
/// @nodoc
class __$SkillItemCopyWithImpl<$Res>
    implements _$SkillItemCopyWith<$Res> {
  __$SkillItemCopyWithImpl(this._self, this._then);

  final _SkillItem _self;
  final $Res Function(_SkillItem) _then;

/// Create a copy of SkillItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? category = null,Object? name = null,Object? level = freezed,}) {
  return _then(_SkillItem(
category: null == category ? _self.category : category // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,level: freezed == level ? _self.level : level // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$LanguageItem {

 String get name; String get proficiency;
/// Create a copy of LanguageItem
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$LanguageItemCopyWith<LanguageItem> get copyWith => _$LanguageItemCopyWithImpl<LanguageItem>(this as LanguageItem, _$identity);

  /// Serializes this LanguageItem to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is LanguageItem&&(identical(other.name, name) || other.name == name)&&(identical(other.proficiency, proficiency) || other.proficiency == proficiency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,proficiency);

@override
String toString() {
  return 'LanguageItem(name: $name, proficiency: $proficiency)';
}


}

/// @nodoc
abstract mixin class $LanguageItemCopyWith<$Res>  {
  factory $LanguageItemCopyWith(LanguageItem value, $Res Function(LanguageItem) _then) = _$LanguageItemCopyWithImpl;
@useResult
$Res call({
 String name, String proficiency
});




}
/// @nodoc
class _$LanguageItemCopyWithImpl<$Res>
    implements $LanguageItemCopyWith<$Res> {
  _$LanguageItemCopyWithImpl(this._self, this._then);

  final LanguageItem _self;
  final $Res Function(LanguageItem) _then;

/// Create a copy of LanguageItem
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? proficiency = null,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,proficiency: null == proficiency ? _self.proficiency : proficiency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [LanguageItem].
extension LanguageItemPatterns on LanguageItem {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _LanguageItem value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _LanguageItem() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _LanguageItem value)  $default,){
final _that = this;
switch (_that) {
case _LanguageItem():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _LanguageItem value)?  $default,){
final _that = this;
switch (_that) {
case _LanguageItem() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String proficiency)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _LanguageItem() when $default != null:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String proficiency)  $default,) {final _that = this;
switch (_that) {
case _LanguageItem():
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String proficiency)?  $default,) {final _that = this;
switch (_that) {
case _LanguageItem() when $default != null:
return $default(_that.name,_that.proficiency);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _LanguageItem implements LanguageItem {
  const _LanguageItem({required this.name, required this.proficiency});
  factory _LanguageItem.fromJson(Map<String, dynamic> json) => _$LanguageItemFromJson(json);

@override final  String name;
@override final  String proficiency;

/// Create a copy of LanguageItem
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$LanguageItemCopyWith<_LanguageItem> get copyWith => __$LanguageItemCopyWithImpl<_LanguageItem>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$LanguageItemToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _LanguageItem&&(identical(other.name, name) || other.name == name)&&(identical(other.proficiency, proficiency) || other.proficiency == proficiency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,proficiency);

@override
String toString() {
  return 'LanguageItem(name: $name, proficiency: $proficiency)';
}


}

/// @nodoc
abstract mixin class _$LanguageItemCopyWith<$Res> implements $LanguageItemCopyWith<$Res> {
  factory _$LanguageItemCopyWith(_LanguageItem value, $Res Function(_LanguageItem) _then) = __$LanguageItemCopyWithImpl;
@override @useResult
$Res call({
 String name, String proficiency
});




}
/// @nodoc
class __$LanguageItemCopyWithImpl<$Res>
    implements _$LanguageItemCopyWith<$Res> {
  __$LanguageItemCopyWithImpl(this._self, this._then);

  final _LanguageItem _self;
  final $Res Function(_LanguageItem) _then;

/// Create a copy of LanguageItem
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? proficiency = null,}) {
  return _then(_LanguageItem(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,proficiency: null == proficiency ? _self.proficiency : proficiency // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
