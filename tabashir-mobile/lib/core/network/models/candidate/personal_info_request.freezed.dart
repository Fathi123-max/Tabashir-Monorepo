// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'personal_info_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$PersonalInfoRequest {

 String get fullName; String get email; String get phone; String get country; String get city; String? get dateOfBirth; String? get nationality; String? get gender; String? get profilePicture; List<String>? get languages; int? get age; List<String>? get skills;
/// Create a copy of PersonalInfoRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PersonalInfoRequestCopyWith<PersonalInfoRequest> get copyWith => _$PersonalInfoRequestCopyWithImpl<PersonalInfoRequest>(this as PersonalInfoRequest, _$identity);

  /// Serializes this PersonalInfoRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PersonalInfoRequest&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.country, country) || other.country == country)&&(identical(other.city, city) || other.city == city)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.nationality, nationality) || other.nationality == nationality)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.profilePicture, profilePicture) || other.profilePicture == profilePicture)&&const DeepCollectionEquality().equals(other.languages, languages)&&(identical(other.age, age) || other.age == age)&&const DeepCollectionEquality().equals(other.skills, skills));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullName,email,phone,country,city,dateOfBirth,nationality,gender,profilePicture,const DeepCollectionEquality().hash(languages),age,const DeepCollectionEquality().hash(skills));

@override
String toString() {
  return 'PersonalInfoRequest(fullName: $fullName, email: $email, phone: $phone, country: $country, city: $city, dateOfBirth: $dateOfBirth, nationality: $nationality, gender: $gender, profilePicture: $profilePicture, languages: $languages, age: $age, skills: $skills)';
}


}

/// @nodoc
abstract mixin class $PersonalInfoRequestCopyWith<$Res>  {
  factory $PersonalInfoRequestCopyWith(PersonalInfoRequest value, $Res Function(PersonalInfoRequest) _then) = _$PersonalInfoRequestCopyWithImpl;
@useResult
$Res call({
 String fullName, String email, String phone, String country, String city, String? dateOfBirth, String? nationality, String? gender, String? profilePicture, List<String>? languages, int? age, List<String>? skills
});




}
/// @nodoc
class _$PersonalInfoRequestCopyWithImpl<$Res>
    implements $PersonalInfoRequestCopyWith<$Res> {
  _$PersonalInfoRequestCopyWithImpl(this._self, this._then);

  final PersonalInfoRequest _self;
  final $Res Function(PersonalInfoRequest) _then;

/// Create a copy of PersonalInfoRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fullName = null,Object? email = null,Object? phone = null,Object? country = null,Object? city = null,Object? dateOfBirth = freezed,Object? nationality = freezed,Object? gender = freezed,Object? profilePicture = freezed,Object? languages = freezed,Object? age = freezed,Object? skills = freezed,}) {
  return _then(_self.copyWith(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as String?,nationality: freezed == nationality ? _self.nationality : nationality // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,profilePicture: freezed == profilePicture ? _self.profilePicture : profilePicture // ignore: cast_nullable_to_non_nullable
as String?,languages: freezed == languages ? _self.languages : languages // ignore: cast_nullable_to_non_nullable
as List<String>?,age: freezed == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int?,skills: freezed == skills ? _self.skills : skills // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}

}


/// Adds pattern-matching-related methods to [PersonalInfoRequest].
extension PersonalInfoRequestPatterns on PersonalInfoRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PersonalInfoRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PersonalInfoRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PersonalInfoRequest value)  $default,){
final _that = this;
switch (_that) {
case _PersonalInfoRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PersonalInfoRequest value)?  $default,){
final _that = this;
switch (_that) {
case _PersonalInfoRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String fullName,  String email,  String phone,  String country,  String city,  String? dateOfBirth,  String? nationality,  String? gender,  String? profilePicture,  List<String>? languages,  int? age,  List<String>? skills)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PersonalInfoRequest() when $default != null:
return $default(_that.fullName,_that.email,_that.phone,_that.country,_that.city,_that.dateOfBirth,_that.nationality,_that.gender,_that.profilePicture,_that.languages,_that.age,_that.skills);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String fullName,  String email,  String phone,  String country,  String city,  String? dateOfBirth,  String? nationality,  String? gender,  String? profilePicture,  List<String>? languages,  int? age,  List<String>? skills)  $default,) {final _that = this;
switch (_that) {
case _PersonalInfoRequest():
return $default(_that.fullName,_that.email,_that.phone,_that.country,_that.city,_that.dateOfBirth,_that.nationality,_that.gender,_that.profilePicture,_that.languages,_that.age,_that.skills);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String fullName,  String email,  String phone,  String country,  String city,  String? dateOfBirth,  String? nationality,  String? gender,  String? profilePicture,  List<String>? languages,  int? age,  List<String>? skills)?  $default,) {final _that = this;
switch (_that) {
case _PersonalInfoRequest() when $default != null:
return $default(_that.fullName,_that.email,_that.phone,_that.country,_that.city,_that.dateOfBirth,_that.nationality,_that.gender,_that.profilePicture,_that.languages,_that.age,_that.skills);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PersonalInfoRequest implements PersonalInfoRequest {
  const _PersonalInfoRequest({required this.fullName, required this.email, required this.phone, required this.country, required this.city, this.dateOfBirth, this.nationality, this.gender, this.profilePicture, final  List<String>? languages, this.age, final  List<String>? skills}): _languages = languages,_skills = skills;
  factory _PersonalInfoRequest.fromJson(Map<String, dynamic> json) => _$PersonalInfoRequestFromJson(json);

@override final  String fullName;
@override final  String email;
@override final  String phone;
@override final  String country;
@override final  String city;
@override final  String? dateOfBirth;
@override final  String? nationality;
@override final  String? gender;
@override final  String? profilePicture;
 final  List<String>? _languages;
@override List<String>? get languages {
  final value = _languages;
  if (value == null) return null;
  if (_languages is EqualUnmodifiableListView) return _languages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  int? age;
 final  List<String>? _skills;
@override List<String>? get skills {
  final value = _skills;
  if (value == null) return null;
  if (_skills is EqualUnmodifiableListView) return _skills;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}


/// Create a copy of PersonalInfoRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PersonalInfoRequestCopyWith<_PersonalInfoRequest> get copyWith => __$PersonalInfoRequestCopyWithImpl<_PersonalInfoRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PersonalInfoRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PersonalInfoRequest&&(identical(other.fullName, fullName) || other.fullName == fullName)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.country, country) || other.country == country)&&(identical(other.city, city) || other.city == city)&&(identical(other.dateOfBirth, dateOfBirth) || other.dateOfBirth == dateOfBirth)&&(identical(other.nationality, nationality) || other.nationality == nationality)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.profilePicture, profilePicture) || other.profilePicture == profilePicture)&&const DeepCollectionEquality().equals(other._languages, _languages)&&(identical(other.age, age) || other.age == age)&&const DeepCollectionEquality().equals(other._skills, _skills));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fullName,email,phone,country,city,dateOfBirth,nationality,gender,profilePicture,const DeepCollectionEquality().hash(_languages),age,const DeepCollectionEquality().hash(_skills));

@override
String toString() {
  return 'PersonalInfoRequest(fullName: $fullName, email: $email, phone: $phone, country: $country, city: $city, dateOfBirth: $dateOfBirth, nationality: $nationality, gender: $gender, profilePicture: $profilePicture, languages: $languages, age: $age, skills: $skills)';
}


}

/// @nodoc
abstract mixin class _$PersonalInfoRequestCopyWith<$Res> implements $PersonalInfoRequestCopyWith<$Res> {
  factory _$PersonalInfoRequestCopyWith(_PersonalInfoRequest value, $Res Function(_PersonalInfoRequest) _then) = __$PersonalInfoRequestCopyWithImpl;
@override @useResult
$Res call({
 String fullName, String email, String phone, String country, String city, String? dateOfBirth, String? nationality, String? gender, String? profilePicture, List<String>? languages, int? age, List<String>? skills
});




}
/// @nodoc
class __$PersonalInfoRequestCopyWithImpl<$Res>
    implements _$PersonalInfoRequestCopyWith<$Res> {
  __$PersonalInfoRequestCopyWithImpl(this._self, this._then);

  final _PersonalInfoRequest _self;
  final $Res Function(_PersonalInfoRequest) _then;

/// Create a copy of PersonalInfoRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fullName = null,Object? email = null,Object? phone = null,Object? country = null,Object? city = null,Object? dateOfBirth = freezed,Object? nationality = freezed,Object? gender = freezed,Object? profilePicture = freezed,Object? languages = freezed,Object? age = freezed,Object? skills = freezed,}) {
  return _then(_PersonalInfoRequest(
fullName: null == fullName ? _self.fullName : fullName // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,country: null == country ? _self.country : country // ignore: cast_nullable_to_non_nullable
as String,city: null == city ? _self.city : city // ignore: cast_nullable_to_non_nullable
as String,dateOfBirth: freezed == dateOfBirth ? _self.dateOfBirth : dateOfBirth // ignore: cast_nullable_to_non_nullable
as String?,nationality: freezed == nationality ? _self.nationality : nationality // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,profilePicture: freezed == profilePicture ? _self.profilePicture : profilePicture // ignore: cast_nullable_to_non_nullable
as String?,languages: freezed == languages ? _self._languages : languages // ignore: cast_nullable_to_non_nullable
as List<String>?,age: freezed == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int?,skills: freezed == skills ? _self._skills : skills // ignore: cast_nullable_to_non_nullable
as List<String>?,
  ));
}


}

// dart format on
