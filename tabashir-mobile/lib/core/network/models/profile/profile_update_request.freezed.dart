// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_update_request.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$ProfileUpdateRequest {

 String get name; String get email; String get phone; String get nationality; String get gender; String get jobTitle; String? get location; String get company; String get education; String? get linkedin;
/// Create a copy of ProfileUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileUpdateRequestCopyWith<ProfileUpdateRequest> get copyWith => _$ProfileUpdateRequestCopyWithImpl<ProfileUpdateRequest>(this as ProfileUpdateRequest, _$identity);

  /// Serializes this ProfileUpdateRequest to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileUpdateRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.nationality, nationality) || other.nationality == nationality)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.jobTitle, jobTitle) || other.jobTitle == jobTitle)&&(identical(other.location, location) || other.location == location)&&(identical(other.company, company) || other.company == company)&&(identical(other.education, education) || other.education == education)&&(identical(other.linkedin, linkedin) || other.linkedin == linkedin));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,email,phone,nationality,gender,jobTitle,location,company,education,linkedin);

@override
String toString() {
  return 'ProfileUpdateRequest(name: $name, email: $email, phone: $phone, nationality: $nationality, gender: $gender, jobTitle: $jobTitle, location: $location, company: $company, education: $education, linkedin: $linkedin)';
}


}

/// @nodoc
abstract mixin class $ProfileUpdateRequestCopyWith<$Res>  {
  factory $ProfileUpdateRequestCopyWith(ProfileUpdateRequest value, $Res Function(ProfileUpdateRequest) _then) = _$ProfileUpdateRequestCopyWithImpl;
@useResult
$Res call({
 String name, String email, String phone, String nationality, String gender, String jobTitle, String? location, String company, String education, String? linkedin
});




}
/// @nodoc
class _$ProfileUpdateRequestCopyWithImpl<$Res>
    implements $ProfileUpdateRequestCopyWith<$Res> {
  _$ProfileUpdateRequestCopyWithImpl(this._self, this._then);

  final ProfileUpdateRequest _self;
  final $Res Function(ProfileUpdateRequest) _then;

/// Create a copy of ProfileUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? email = null,Object? phone = null,Object? nationality = null,Object? gender = null,Object? jobTitle = null,Object? location = freezed,Object? company = null,Object? education = null,Object? linkedin = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,nationality: null == nationality ? _self.nationality : nationality // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,jobTitle: null == jobTitle ? _self.jobTitle : jobTitle // ignore: cast_nullable_to_non_nullable
as String,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,education: null == education ? _self.education : education // ignore: cast_nullable_to_non_nullable
as String,linkedin: freezed == linkedin ? _self.linkedin : linkedin // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ProfileUpdateRequest].
extension ProfileUpdateRequestPatterns on ProfileUpdateRequest {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileUpdateRequest value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileUpdateRequest() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileUpdateRequest value)  $default,){
final _that = this;
switch (_that) {
case _ProfileUpdateRequest():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileUpdateRequest value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileUpdateRequest() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String email,  String phone,  String nationality,  String gender,  String jobTitle,  String? location,  String company,  String education,  String? linkedin)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileUpdateRequest() when $default != null:
return $default(_that.name,_that.email,_that.phone,_that.nationality,_that.gender,_that.jobTitle,_that.location,_that.company,_that.education,_that.linkedin);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String email,  String phone,  String nationality,  String gender,  String jobTitle,  String? location,  String company,  String education,  String? linkedin)  $default,) {final _that = this;
switch (_that) {
case _ProfileUpdateRequest():
return $default(_that.name,_that.email,_that.phone,_that.nationality,_that.gender,_that.jobTitle,_that.location,_that.company,_that.education,_that.linkedin);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String email,  String phone,  String nationality,  String gender,  String jobTitle,  String? location,  String company,  String education,  String? linkedin)?  $default,) {final _that = this;
switch (_that) {
case _ProfileUpdateRequest() when $default != null:
return $default(_that.name,_that.email,_that.phone,_that.nationality,_that.gender,_that.jobTitle,_that.location,_that.company,_that.education,_that.linkedin);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileUpdateRequest implements ProfileUpdateRequest {
  const _ProfileUpdateRequest({required this.name, required this.email, required this.phone, required this.nationality, required this.gender, required this.jobTitle, this.location, required this.company, required this.education, this.linkedin});
  factory _ProfileUpdateRequest.fromJson(Map<String, dynamic> json) => _$ProfileUpdateRequestFromJson(json);

@override final  String name;
@override final  String email;
@override final  String phone;
@override final  String nationality;
@override final  String gender;
@override final  String jobTitle;
@override final  String? location;
@override final  String company;
@override final  String education;
@override final  String? linkedin;

/// Create a copy of ProfileUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileUpdateRequestCopyWith<_ProfileUpdateRequest> get copyWith => __$ProfileUpdateRequestCopyWithImpl<_ProfileUpdateRequest>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileUpdateRequestToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileUpdateRequest&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.nationality, nationality) || other.nationality == nationality)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.jobTitle, jobTitle) || other.jobTitle == jobTitle)&&(identical(other.location, location) || other.location == location)&&(identical(other.company, company) || other.company == company)&&(identical(other.education, education) || other.education == education)&&(identical(other.linkedin, linkedin) || other.linkedin == linkedin));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,name,email,phone,nationality,gender,jobTitle,location,company,education,linkedin);

@override
String toString() {
  return 'ProfileUpdateRequest(name: $name, email: $email, phone: $phone, nationality: $nationality, gender: $gender, jobTitle: $jobTitle, location: $location, company: $company, education: $education, linkedin: $linkedin)';
}


}

/// @nodoc
abstract mixin class _$ProfileUpdateRequestCopyWith<$Res> implements $ProfileUpdateRequestCopyWith<$Res> {
  factory _$ProfileUpdateRequestCopyWith(_ProfileUpdateRequest value, $Res Function(_ProfileUpdateRequest) _then) = __$ProfileUpdateRequestCopyWithImpl;
@override @useResult
$Res call({
 String name, String email, String phone, String nationality, String gender, String jobTitle, String? location, String company, String education, String? linkedin
});




}
/// @nodoc
class __$ProfileUpdateRequestCopyWithImpl<$Res>
    implements _$ProfileUpdateRequestCopyWith<$Res> {
  __$ProfileUpdateRequestCopyWithImpl(this._self, this._then);

  final _ProfileUpdateRequest _self;
  final $Res Function(_ProfileUpdateRequest) _then;

/// Create a copy of ProfileUpdateRequest
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? email = null,Object? phone = null,Object? nationality = null,Object? gender = null,Object? jobTitle = null,Object? location = freezed,Object? company = null,Object? education = null,Object? linkedin = freezed,}) {
  return _then(_ProfileUpdateRequest(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,nationality: null == nationality ? _self.nationality : nationality // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,jobTitle: null == jobTitle ? _self.jobTitle : jobTitle // ignore: cast_nullable_to_non_nullable
as String,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,education: null == education ? _self.education : education // ignore: cast_nullable_to_non_nullable
as String,linkedin: freezed == linkedin ? _self.linkedin : linkedin // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}

// dart format on
