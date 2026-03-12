// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cv_parsed_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$CVParsedResponse {

/// Personal information
 PersonalInfo? get personalInfo;/// Education
 List<Education>? get education;/// Experience
 List<Experience>? get experience;/// Skills
 List<String>? get skills;
/// Create a copy of CVParsedResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CVParsedResponseCopyWith<CVParsedResponse> get copyWith => _$CVParsedResponseCopyWithImpl<CVParsedResponse>(this as CVParsedResponse, _$identity);

  /// Serializes this CVParsedResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CVParsedResponse&&(identical(other.personalInfo, personalInfo) || other.personalInfo == personalInfo)&&const DeepCollectionEquality().equals(other.education, education)&&const DeepCollectionEquality().equals(other.experience, experience)&&const DeepCollectionEquality().equals(other.skills, skills));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,personalInfo,const DeepCollectionEquality().hash(education),const DeepCollectionEquality().hash(experience),const DeepCollectionEquality().hash(skills));

@override
String toString() {
  return 'CVParsedResponse(personalInfo: $personalInfo, education: $education, experience: $experience, skills: $skills)';
}


}

/// @nodoc
abstract mixin class $CVParsedResponseCopyWith<$Res>  {
  factory $CVParsedResponseCopyWith(CVParsedResponse value, $Res Function(CVParsedResponse) _then) = _$CVParsedResponseCopyWithImpl;
@useResult
$Res call({
 PersonalInfo? personalInfo, List<Education>? education, List<Experience>? experience, List<String>? skills
});


$PersonalInfoCopyWith<$Res>? get personalInfo;

}
/// @nodoc
class _$CVParsedResponseCopyWithImpl<$Res>
    implements $CVParsedResponseCopyWith<$Res> {
  _$CVParsedResponseCopyWithImpl(this._self, this._then);

  final CVParsedResponse _self;
  final $Res Function(CVParsedResponse) _then;

/// Create a copy of CVParsedResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? personalInfo = freezed,Object? education = freezed,Object? experience = freezed,Object? skills = freezed,}) {
  return _then(_self.copyWith(
personalInfo: freezed == personalInfo ? _self.personalInfo : personalInfo // ignore: cast_nullable_to_non_nullable
as PersonalInfo?,education: freezed == education ? _self.education : education // ignore: cast_nullable_to_non_nullable
as List<Education>?,experience: freezed == experience ? _self.experience : experience // ignore: cast_nullable_to_non_nullable
as List<Experience>?,skills: freezed == skills ? _self.skills : skills // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}
/// Create a copy of CVParsedResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonalInfoCopyWith<$Res>? get personalInfo {
    if (_self.personalInfo == null) {
    return null;
  }

  return $PersonalInfoCopyWith<$Res>(_self.personalInfo!, (value) {
    return _then(_self.copyWith(personalInfo: value));
  });
}
}


/// Adds pattern-matching-related methods to [CVParsedResponse].
extension CVParsedResponsePatterns on CVParsedResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CVParsedResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CVParsedResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CVParsedResponse value)  $default,){
final _that = this;
switch (_that) {
case _CVParsedResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CVParsedResponse value)?  $default,){
final _that = this;
switch (_that) {
case _CVParsedResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( PersonalInfo? personalInfo,  List<Education>? education,  List<Experience>? experience,  List<String>? skills)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CVParsedResponse() when $default != null:
return $default(_that.personalInfo,_that.education,_that.experience,_that.skills);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( PersonalInfo? personalInfo,  List<Education>? education,  List<Experience>? experience,  List<String>? skills)  $default,) {final _that = this;
switch (_that) {
case _CVParsedResponse():
return $default(_that.personalInfo,_that.education,_that.experience,_that.skills);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( PersonalInfo? personalInfo,  List<Education>? education,  List<Experience>? experience,  List<String>? skills)?  $default,) {final _that = this;
switch (_that) {
case _CVParsedResponse() when $default != null:
return $default(_that.personalInfo,_that.education,_that.experience,_that.skills);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CVParsedResponse implements CVParsedResponse {
  const _CVParsedResponse({this.personalInfo, final  List<Education>? education, final  List<Experience>? experience, final  List<String>? skills}): _education = education,_experience = experience,_skills = skills;
  factory _CVParsedResponse.fromJson(Map<String, dynamic> json) => _$CVParsedResponseFromJson(json);

/// Personal information
@override final  PersonalInfo? personalInfo;
/// Education
 final  List<Education>? _education;
/// Education
@override List<Education>? get education {
  final value = _education;
  if (value == null) return null;
  if (_education is EqualUnmodifiableListView) return _education;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Experience
 final  List<Experience>? _experience;
/// Experience
@override List<Experience>? get experience {
  final value = _experience;
  if (value == null) return null;
  if (_experience is EqualUnmodifiableListView) return _experience;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

/// Skills
 final  List<String>? _skills;
/// Skills
@override List<String>? get skills {
  final value = _skills;
  if (value == null) return null;
  if (_skills is EqualUnmodifiableListView) return _skills;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of CVParsedResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CVParsedResponseCopyWith<_CVParsedResponse> get copyWith => __$CVParsedResponseCopyWithImpl<_CVParsedResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CVParsedResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CVParsedResponse&&(identical(other.personalInfo, personalInfo) || other.personalInfo == personalInfo)&&const DeepCollectionEquality().equals(other._education, _education)&&const DeepCollectionEquality().equals(other._experience, _experience)&&const DeepCollectionEquality().equals(other._skills, _skills));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,personalInfo,const DeepCollectionEquality().hash(_education),const DeepCollectionEquality().hash(_experience),const DeepCollectionEquality().hash(_skills));

@override
String toString() {
  return 'CVParsedResponse(personalInfo: $personalInfo, education: $education, experience: $experience, skills: $skills)';
}


}

/// @nodoc
abstract mixin class _$CVParsedResponseCopyWith<$Res> implements $CVParsedResponseCopyWith<$Res> {
  factory _$CVParsedResponseCopyWith(_CVParsedResponse value, $Res Function(_CVParsedResponse) _then) = __$CVParsedResponseCopyWithImpl;
@override @useResult
$Res call({
 PersonalInfo? personalInfo, List<Education>? education, List<Experience>? experience, List<String>? skills
});


@override $PersonalInfoCopyWith<$Res>? get personalInfo;

}
/// @nodoc
class __$CVParsedResponseCopyWithImpl<$Res>
    implements _$CVParsedResponseCopyWith<$Res> {
  __$CVParsedResponseCopyWithImpl(this._self, this._then);

  final _CVParsedResponse _self;
  final $Res Function(_CVParsedResponse) _then;

/// Create a copy of CVParsedResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? personalInfo = freezed,Object? education = freezed,Object? experience = freezed,Object? skills = freezed,}) {
  return _then(_CVParsedResponse(
personalInfo: freezed == personalInfo ? _self.personalInfo : personalInfo // ignore: cast_nullable_to_non_nullable
as PersonalInfo?,education: freezed == education ? _self._education : education // ignore: cast_nullable_to_non_nullable
as List<Education>?,experience: freezed == experience ? _self._experience : experience // ignore: cast_nullable_to_non_nullable
as List<Experience>?,skills: freezed == skills ? _self._skills : skills // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

/// Create a copy of CVParsedResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PersonalInfoCopyWith<$Res>? get personalInfo {
    if (_self.personalInfo == null) {
    return null;
  }

  return $PersonalInfoCopyWith<$Res>(_self.personalInfo!, (value) {
    return _then(_self.copyWith(personalInfo: value));
  });
}
}


/// @nodoc
mixin _$PersonalInfo {

/// Full name
 String? get fullName;/// Email
 String? get email;/// Phone
 String? get phone;/// Address
 String? get address;
/// Create a copy of PersonalInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonalInfoCopyWith<PersonalInfo> get copyWith => _$PersonalInfoCopyWithImpl<PersonalInfo>(this as PersonalInfo, _$identity);

  /// Serializes this PersonalInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersonalInfo&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.address, address) || other.address == address));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullName,email,phone,address);

@override
String toString() {
  return 'PersonalInfo(fullName: $fullName, email: $email, phone: $phone, address: $address)';
}


}

/// @nodoc
abstract mixin class $PersonalInfoCopyWith<$Res>  {
  factory $PersonalInfoCopyWith(PersonalInfo value, $Res Function(PersonalInfo) _then) = _$PersonalInfoCopyWithImpl;
@useResult
$Res call({
 String? fullName, String? email, String? phone, String? address
});




}
/// @nodoc
class _$PersonalInfoCopyWithImpl<$Res>
    implements $PersonalInfoCopyWith<$Res> {
  _$PersonalInfoCopyWithImpl(this._self, this._then);

  final PersonalInfo _self;
  final $Res Function(PersonalInfo) _then;

/// Create a copy of PersonalInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fullName = freezed,Object? email = freezed,Object? phone = freezed,Object? address = freezed,}) {
  return _then(_self.copyWith(
fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PersonalInfo].
extension PersonalInfoPatterns on PersonalInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PersonalInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PersonalInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PersonalInfo value)  $default,){
final _that = this;
switch (_that) {
case _PersonalInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PersonalInfo value)?  $default,){
final _that = this;
switch (_that) {
case _PersonalInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? fullName,  String? email,  String? phone,  String? address)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PersonalInfo() when $default != null:
return $default(_that.fullName,_that.email,_that.phone,_that.address);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? fullName,  String? email,  String? phone,  String? address)  $default,) {final _that = this;
switch (_that) {
case _PersonalInfo():
return $default(_that.fullName,_that.email,_that.phone,_that.address);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? fullName,  String? email,  String? phone,  String? address)?  $default,) {final _that = this;
switch (_that) {
case _PersonalInfo() when $default != null:
return $default(_that.fullName,_that.email,_that.phone,_that.address);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PersonalInfo implements PersonalInfo {
  const _PersonalInfo({this.fullName, this.email, this.phone, this.address});
  factory _PersonalInfo.fromJson(Map<String, dynamic> json) => _$PersonalInfoFromJson(json);

/// Full name
@override final  String? fullName;
/// Email
@override final  String? email;
/// Phone
@override final  String? phone;
/// Address
@override final  String? address;

/// Create a copy of PersonalInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersonalInfoCopyWith<_PersonalInfo> get copyWith => __$PersonalInfoCopyWithImpl<_PersonalInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PersonalInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PersonalInfo&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.address, address) || other.address == address));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullName,email,phone,address);

@override
String toString() {
  return 'PersonalInfo(fullName: $fullName, email: $email, phone: $phone, address: $address)';
}


}

/// @nodoc
abstract mixin class _$PersonalInfoCopyWith<$Res> implements $PersonalInfoCopyWith<$Res> {
  factory _$PersonalInfoCopyWith(_PersonalInfo value, $Res Function(_PersonalInfo) _then) = __$PersonalInfoCopyWithImpl;
@override @useResult
$Res call({
 String? fullName, String? email, String? phone, String? address
});




}
/// @nodoc
class __$PersonalInfoCopyWithImpl<$Res>
    implements _$PersonalInfoCopyWith<$Res> {
  __$PersonalInfoCopyWithImpl(this._self, this._then);

  final _PersonalInfo _self;
  final $Res Function(_PersonalInfo) _then;

/// Create a copy of PersonalInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fullName = freezed,Object? email = freezed,Object? phone = freezed,Object? address = freezed,}) {
  return _then(_PersonalInfo(
fullName: freezed == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,address: freezed == address ? _self.address : address // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$Education {

/// Degree
 String? get degree;/// Institution
 String? get institution;/// Year
 String? get year;
/// Create a copy of Education
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$EducationCopyWith<Education> get copyWith => _$EducationCopyWithImpl<Education>(this as Education, _$identity);

  /// Serializes this Education to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Education&&(identical(other.degree, degree) || other.degree == degree)&&(identical(other.institution, institution) || other.institution == institution)&&(identical(other.year, year) || other.year == year));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,degree,institution,year);

@override
String toString() {
  return 'Education(degree: $degree, institution: $institution, year: $year)';
}


}

/// @nodoc
abstract mixin class $EducationCopyWith<$Res>  {
  factory $EducationCopyWith(Education value, $Res Function(Education) _then) = _$EducationCopyWithImpl;
@useResult
$Res call({
 String? degree, String? institution, String? year
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
@pragma('vm:prefer-inline') @override $Res call({Object? degree = freezed,Object? institution = freezed,Object? year = freezed,}) {
  return _then(_self.copyWith(
degree: freezed == degree ? _self.degree : degree // ignore: cast_nullable_to_non_nullable
as String?,institution: freezed == institution ? _self.institution : institution // ignore: cast_nullable_to_non_nullable
as String?,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? degree,  String? institution,  String? year)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Education() when $default != null:
return $default(_that.degree,_that.institution,_that.year);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? degree,  String? institution,  String? year)  $default,) {final _that = this;
switch (_that) {
case _Education():
return $default(_that.degree,_that.institution,_that.year);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? degree,  String? institution,  String? year)?  $default,) {final _that = this;
switch (_that) {
case _Education() when $default != null:
return $default(_that.degree,_that.institution,_that.year);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Education implements Education {
  const _Education({this.degree, this.institution, this.year});
  factory _Education.fromJson(Map<String, dynamic> json) => _$EducationFromJson(json);

/// Degree
@override final  String? degree;
/// Institution
@override final  String? institution;
/// Year
@override final  String? year;

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
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Education&&(identical(other.degree, degree) || other.degree == degree)&&(identical(other.institution, institution) || other.institution == institution)&&(identical(other.year, year) || other.year == year));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,degree,institution,year);

@override
String toString() {
  return 'Education(degree: $degree, institution: $institution, year: $year)';
}


}

/// @nodoc
abstract mixin class _$EducationCopyWith<$Res> implements $EducationCopyWith<$Res> {
  factory _$EducationCopyWith(_Education value, $Res Function(_Education) _then) = __$EducationCopyWithImpl;
@override @useResult
$Res call({
 String? degree, String? institution, String? year
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
@override @pragma('vm:prefer-inline') $Res call({Object? degree = freezed,Object? institution = freezed,Object? year = freezed,}) {
  return _then(_Education(
degree: freezed == degree ? _self.degree : degree // ignore: cast_nullable_to_non_nullable
as String?,institution: freezed == institution ? _self.institution : institution // ignore: cast_nullable_to_non_nullable
as String?,year: freezed == year ? _self.year : year // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$Experience {

/// Job title
 String? get jobTitle;/// Company
 String? get company;/// Start date
 String? get startDate;/// End date
 String? get endDate;/// Description
 String? get description;
/// Create a copy of Experience
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ExperienceCopyWith<Experience> get copyWith => _$ExperienceCopyWithImpl<Experience>(this as Experience, _$identity);

  /// Serializes this Experience to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Experience&&(identical(other.jobTitle, jobTitle) || other.jobTitle == jobTitle)&&(identical(other.company, company) || other.company == company)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,jobTitle,company,startDate,endDate,description);

@override
String toString() {
  return 'Experience(jobTitle: $jobTitle, company: $company, startDate: $startDate, endDate: $endDate, description: $description)';
}


}

/// @nodoc
abstract mixin class $ExperienceCopyWith<$Res>  {
  factory $ExperienceCopyWith(Experience value, $Res Function(Experience) _then) = _$ExperienceCopyWithImpl;
@useResult
$Res call({
 String? jobTitle, String? company, String? startDate, String? endDate, String? description
});




}
/// @nodoc
class _$ExperienceCopyWithImpl<$Res>
    implements $ExperienceCopyWith<$Res> {
  _$ExperienceCopyWithImpl(this._self, this._then);

  final Experience _self;
  final $Res Function(Experience) _then;

/// Create a copy of Experience
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? jobTitle = freezed,Object? company = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? description = freezed,}) {
  return _then(_self.copyWith(
jobTitle: freezed == jobTitle ? _self.jobTitle : jobTitle // ignore: cast_nullable_to_non_nullable
as String?,company: freezed == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [Experience].
extension ExperiencePatterns on Experience {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Experience value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Experience() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Experience value)  $default,){
final _that = this;
switch (_that) {
case _Experience():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Experience value)?  $default,){
final _that = this;
switch (_that) {
case _Experience() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? jobTitle,  String? company,  String? startDate,  String? endDate,  String? description)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Experience() when $default != null:
return $default(_that.jobTitle,_that.company,_that.startDate,_that.endDate,_that.description);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? jobTitle,  String? company,  String? startDate,  String? endDate,  String? description)  $default,) {final _that = this;
switch (_that) {
case _Experience():
return $default(_that.jobTitle,_that.company,_that.startDate,_that.endDate,_that.description);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? jobTitle,  String? company,  String? startDate,  String? endDate,  String? description)?  $default,) {final _that = this;
switch (_that) {
case _Experience() when $default != null:
return $default(_that.jobTitle,_that.company,_that.startDate,_that.endDate,_that.description);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _Experience implements Experience {
  const _Experience({this.jobTitle, this.company, this.startDate, this.endDate, this.description});
  factory _Experience.fromJson(Map<String, dynamic> json) => _$ExperienceFromJson(json);

/// Job title
@override final  String? jobTitle;
/// Company
@override final  String? company;
/// Start date
@override final  String? startDate;
/// End date
@override final  String? endDate;
/// Description
@override final  String? description;

/// Create a copy of Experience
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ExperienceCopyWith<_Experience> get copyWith => __$ExperienceCopyWithImpl<_Experience>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ExperienceToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Experience&&(identical(other.jobTitle, jobTitle) || other.jobTitle == jobTitle)&&(identical(other.company, company) || other.company == company)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.description, description) || other.description == description));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,jobTitle,company,startDate,endDate,description);

@override
String toString() {
  return 'Experience(jobTitle: $jobTitle, company: $company, startDate: $startDate, endDate: $endDate, description: $description)';
}


}

/// @nodoc
abstract mixin class _$ExperienceCopyWith<$Res> implements $ExperienceCopyWith<$Res> {
  factory _$ExperienceCopyWith(_Experience value, $Res Function(_Experience) _then) = __$ExperienceCopyWithImpl;
@override @useResult
$Res call({
 String? jobTitle, String? company, String? startDate, String? endDate, String? description
});




}
/// @nodoc
class __$ExperienceCopyWithImpl<$Res>
    implements _$ExperienceCopyWith<$Res> {
  __$ExperienceCopyWithImpl(this._self, this._then);

  final _Experience _self;
  final $Res Function(_Experience) _then;

/// Create a copy of Experience
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? jobTitle = freezed,Object? company = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? description = freezed,}) {
  return _then(_Experience(
jobTitle: freezed == jobTitle ? _self.jobTitle : jobTitle // ignore: cast_nullable_to_non_nullable
as String?,company: freezed == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as String?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as String?,description: freezed == description ? _self.description : description // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
