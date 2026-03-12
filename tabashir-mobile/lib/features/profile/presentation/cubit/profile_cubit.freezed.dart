// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'profile_cubit.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ProfileState {

 ProfileStatus get status; ProfileData? get profile; UserProfileResponse? get userProfileResponse;// Raw API response with candidateProfile
 String? get errorMessage; bool get requiresReauth;
/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileStateCopyWith<ProfileState> get copyWith => _$ProfileStateCopyWithImpl<ProfileState>(this as ProfileState, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileState&&(identical(other.status, status) || other.status == status)&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.userProfileResponse, userProfileResponse) || other.userProfileResponse == userProfileResponse)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.requiresReauth, requiresReauth) || other.requiresReauth == requiresReauth));
}


@override
int get hashCode => Object.hash(runtimeType,status,profile,userProfileResponse,errorMessage,requiresReauth);

@override
String toString() {
  return 'ProfileState(status: $status, profile: $profile, userProfileResponse: $userProfileResponse, errorMessage: $errorMessage, requiresReauth: $requiresReauth)';
}


}

/// @nodoc
abstract mixin class $ProfileStateCopyWith<$Res>  {
  factory $ProfileStateCopyWith(ProfileState value, $Res Function(ProfileState) _then) = _$ProfileStateCopyWithImpl;
@useResult
$Res call({
 ProfileStatus status, ProfileData? profile, UserProfileResponse? userProfileResponse, String? errorMessage, bool requiresReauth
});


$ProfileDataCopyWith<$Res>? get profile;$UserProfileResponseCopyWith<$Res>? get userProfileResponse;

}
/// @nodoc
class _$ProfileStateCopyWithImpl<$Res>
    implements $ProfileStateCopyWith<$Res> {
  _$ProfileStateCopyWithImpl(this._self, this._then);

  final ProfileState _self;
  final $Res Function(ProfileState) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? status = null,Object? profile = freezed,Object? userProfileResponse = freezed,Object? errorMessage = freezed,Object? requiresReauth = null,}) {
  return _then(_self.copyWith(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ProfileStatus,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as ProfileData?,userProfileResponse: freezed == userProfileResponse ? _self.userProfileResponse : userProfileResponse // ignore: cast_nullable_to_non_nullable
as UserProfileResponse?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,requiresReauth: null == requiresReauth ? _self.requiresReauth : requiresReauth // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}
/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileDataCopyWith<$Res>? get profile {
    if (_self.profile == null) {
    return null;
  }

  return $ProfileDataCopyWith<$Res>(_self.profile!, (value) {
    return _then(_self.copyWith(profile: value));
  });
}/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserProfileResponseCopyWith<$Res>? get userProfileResponse {
    if (_self.userProfileResponse == null) {
    return null;
  }

  return $UserProfileResponseCopyWith<$Res>(_self.userProfileResponse!, (value) {
    return _then(_self.copyWith(userProfileResponse: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProfileState].
extension ProfileStatePatterns on ProfileState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileState value)  $default,){
final _that = this;
switch (_that) {
case _ProfileState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileState value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( ProfileStatus status,  ProfileData? profile,  UserProfileResponse? userProfileResponse,  String? errorMessage,  bool requiresReauth)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileState() when $default != null:
return $default(_that.status,_that.profile,_that.userProfileResponse,_that.errorMessage,_that.requiresReauth);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( ProfileStatus status,  ProfileData? profile,  UserProfileResponse? userProfileResponse,  String? errorMessage,  bool requiresReauth)  $default,) {final _that = this;
switch (_that) {
case _ProfileState():
return $default(_that.status,_that.profile,_that.userProfileResponse,_that.errorMessage,_that.requiresReauth);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( ProfileStatus status,  ProfileData? profile,  UserProfileResponse? userProfileResponse,  String? errorMessage,  bool requiresReauth)?  $default,) {final _that = this;
switch (_that) {
case _ProfileState() when $default != null:
return $default(_that.status,_that.profile,_that.userProfileResponse,_that.errorMessage,_that.requiresReauth);case _:
  return null;

}
}

}

/// @nodoc


class _ProfileState implements ProfileState {
  const _ProfileState({this.status = ProfileStatus.initial, this.profile, this.userProfileResponse, this.errorMessage, this.requiresReauth = false});
  

@override@JsonKey() final  ProfileStatus status;
@override final  ProfileData? profile;
@override final  UserProfileResponse? userProfileResponse;
// Raw API response with candidateProfile
@override final  String? errorMessage;
@override@JsonKey() final  bool requiresReauth;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileStateCopyWith<_ProfileState> get copyWith => __$ProfileStateCopyWithImpl<_ProfileState>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileState&&(identical(other.status, status) || other.status == status)&&(identical(other.profile, profile) || other.profile == profile)&&(identical(other.userProfileResponse, userProfileResponse) || other.userProfileResponse == userProfileResponse)&&(identical(other.errorMessage, errorMessage) || other.errorMessage == errorMessage)&&(identical(other.requiresReauth, requiresReauth) || other.requiresReauth == requiresReauth));
}


@override
int get hashCode => Object.hash(runtimeType,status,profile,userProfileResponse,errorMessage,requiresReauth);

@override
String toString() {
  return 'ProfileState(status: $status, profile: $profile, userProfileResponse: $userProfileResponse, errorMessage: $errorMessage, requiresReauth: $requiresReauth)';
}


}

/// @nodoc
abstract mixin class _$ProfileStateCopyWith<$Res> implements $ProfileStateCopyWith<$Res> {
  factory _$ProfileStateCopyWith(_ProfileState value, $Res Function(_ProfileState) _then) = __$ProfileStateCopyWithImpl;
@override @useResult
$Res call({
 ProfileStatus status, ProfileData? profile, UserProfileResponse? userProfileResponse, String? errorMessage, bool requiresReauth
});


@override $ProfileDataCopyWith<$Res>? get profile;@override $UserProfileResponseCopyWith<$Res>? get userProfileResponse;

}
/// @nodoc
class __$ProfileStateCopyWithImpl<$Res>
    implements _$ProfileStateCopyWith<$Res> {
  __$ProfileStateCopyWithImpl(this._self, this._then);

  final _ProfileState _self;
  final $Res Function(_ProfileState) _then;

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? status = null,Object? profile = freezed,Object? userProfileResponse = freezed,Object? errorMessage = freezed,Object? requiresReauth = null,}) {
  return _then(_ProfileState(
status: null == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as ProfileStatus,profile: freezed == profile ? _self.profile : profile // ignore: cast_nullable_to_non_nullable
as ProfileData?,userProfileResponse: freezed == userProfileResponse ? _self.userProfileResponse : userProfileResponse // ignore: cast_nullable_to_non_nullable
as UserProfileResponse?,errorMessage: freezed == errorMessage ? _self.errorMessage : errorMessage // ignore: cast_nullable_to_non_nullable
as String?,requiresReauth: null == requiresReauth ? _self.requiresReauth : requiresReauth // ignore: cast_nullable_to_non_nullable
as bool,
  ));
}

/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileDataCopyWith<$Res>? get profile {
    if (_self.profile == null) {
    return null;
  }

  return $ProfileDataCopyWith<$Res>(_self.profile!, (value) {
    return _then(_self.copyWith(profile: value));
  });
}/// Create a copy of ProfileState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserProfileResponseCopyWith<$Res>? get userProfileResponse {
    if (_self.userProfileResponse == null) {
    return null;
  }

  return $UserProfileResponseCopyWith<$Res>(_self.userProfileResponse!, (value) {
    return _then(_self.copyWith(userProfileResponse: value));
  });
}
}

/// @nodoc
mixin _$ProfileData {

// Basic user info
 String get name; String get jobTitle; String get location; String get email; String get phone; String get nationality; String get gender; String get company; String get education; String get linkedin; int get profileStrength; String? get profileImage;// Extended user data from comprehensive API
 String? get userType; String? get subscriptionPlan; String? get subscriptionStatus; int? get totalResumes; int? get totalApplications; int? get savedJobs; List<String> get adminPermissions; PaymentStatsData? get paymentStats; JobStatsData? get jobStats; List<ConnectedAccountData> get connectedAccounts; AiResumeStatsData? get aiResumeStats; SecurityData? get security;
/// Create a copy of ProfileData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileDataCopyWith<ProfileData> get copyWith => _$ProfileDataCopyWithImpl<ProfileData>(this as ProfileData, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileData&&(identical(other.name, name) || other.name == name)&&(identical(other.jobTitle, jobTitle) || other.jobTitle == jobTitle)&&(identical(other.location, location) || other.location == location)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.nationality, nationality) || other.nationality == nationality)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.company, company) || other.company == company)&&(identical(other.education, education) || other.education == education)&&(identical(other.linkedin, linkedin) || other.linkedin == linkedin)&&(identical(other.profileStrength, profileStrength) || other.profileStrength == profileStrength)&&(identical(other.profileImage, profileImage) || other.profileImage == profileImage)&&(identical(other.userType, userType) || other.userType == userType)&&(identical(other.subscriptionPlan, subscriptionPlan) || other.subscriptionPlan == subscriptionPlan)&&(identical(other.subscriptionStatus, subscriptionStatus) || other.subscriptionStatus == subscriptionStatus)&&(identical(other.totalResumes, totalResumes) || other.totalResumes == totalResumes)&&(identical(other.totalApplications, totalApplications) || other.totalApplications == totalApplications)&&(identical(other.savedJobs, savedJobs) || other.savedJobs == savedJobs)&&const DeepCollectionEquality().equals(other.adminPermissions, adminPermissions)&&(identical(other.paymentStats, paymentStats) || other.paymentStats == paymentStats)&&(identical(other.jobStats, jobStats) || other.jobStats == jobStats)&&const DeepCollectionEquality().equals(other.connectedAccounts, connectedAccounts)&&(identical(other.aiResumeStats, aiResumeStats) || other.aiResumeStats == aiResumeStats)&&(identical(other.security, security) || other.security == security));
}


@override
int get hashCode => Object.hashAll([runtimeType,name,jobTitle,location,email,phone,nationality,gender,company,education,linkedin,profileStrength,profileImage,userType,subscriptionPlan,subscriptionStatus,totalResumes,totalApplications,savedJobs,const DeepCollectionEquality().hash(adminPermissions),paymentStats,jobStats,const DeepCollectionEquality().hash(connectedAccounts),aiResumeStats,security]);

@override
String toString() {
  return 'ProfileData(name: $name, jobTitle: $jobTitle, location: $location, email: $email, phone: $phone, nationality: $nationality, gender: $gender, company: $company, education: $education, linkedin: $linkedin, profileStrength: $profileStrength, profileImage: $profileImage, userType: $userType, subscriptionPlan: $subscriptionPlan, subscriptionStatus: $subscriptionStatus, totalResumes: $totalResumes, totalApplications: $totalApplications, savedJobs: $savedJobs, adminPermissions: $adminPermissions, paymentStats: $paymentStats, jobStats: $jobStats, connectedAccounts: $connectedAccounts, aiResumeStats: $aiResumeStats, security: $security)';
}


}

/// @nodoc
abstract mixin class $ProfileDataCopyWith<$Res>  {
  factory $ProfileDataCopyWith(ProfileData value, $Res Function(ProfileData) _then) = _$ProfileDataCopyWithImpl;
@useResult
$Res call({
 String name, String jobTitle, String location, String email, String phone, String nationality, String gender, String company, String education, String linkedin, int profileStrength, String? profileImage, String? userType, String? subscriptionPlan, String? subscriptionStatus, int? totalResumes, int? totalApplications, int? savedJobs, List<String> adminPermissions, PaymentStatsData? paymentStats, JobStatsData? jobStats, List<ConnectedAccountData> connectedAccounts, AiResumeStatsData? aiResumeStats, SecurityData? security
});


$PaymentStatsDataCopyWith<$Res>? get paymentStats;$JobStatsDataCopyWith<$Res>? get jobStats;$AiResumeStatsDataCopyWith<$Res>? get aiResumeStats;$SecurityDataCopyWith<$Res>? get security;

}
/// @nodoc
class _$ProfileDataCopyWithImpl<$Res>
    implements $ProfileDataCopyWith<$Res> {
  _$ProfileDataCopyWithImpl(this._self, this._then);

  final ProfileData _self;
  final $Res Function(ProfileData) _then;

/// Create a copy of ProfileData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? name = null,Object? jobTitle = null,Object? location = null,Object? email = null,Object? phone = null,Object? nationality = null,Object? gender = null,Object? company = null,Object? education = null,Object? linkedin = null,Object? profileStrength = null,Object? profileImage = freezed,Object? userType = freezed,Object? subscriptionPlan = freezed,Object? subscriptionStatus = freezed,Object? totalResumes = freezed,Object? totalApplications = freezed,Object? savedJobs = freezed,Object? adminPermissions = null,Object? paymentStats = freezed,Object? jobStats = freezed,Object? connectedAccounts = null,Object? aiResumeStats = freezed,Object? security = freezed,}) {
  return _then(_self.copyWith(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,jobTitle: null == jobTitle ? _self.jobTitle : jobTitle // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,nationality: null == nationality ? _self.nationality : nationality // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,education: null == education ? _self.education : education // ignore: cast_nullable_to_non_nullable
as String,linkedin: null == linkedin ? _self.linkedin : linkedin // ignore: cast_nullable_to_non_nullable
as String,profileStrength: null == profileStrength ? _self.profileStrength : profileStrength // ignore: cast_nullable_to_non_nullable
as int,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as String?,userType: freezed == userType ? _self.userType : userType // ignore: cast_nullable_to_non_nullable
as String?,subscriptionPlan: freezed == subscriptionPlan ? _self.subscriptionPlan : subscriptionPlan // ignore: cast_nullable_to_non_nullable
as String?,subscriptionStatus: freezed == subscriptionStatus ? _self.subscriptionStatus : subscriptionStatus // ignore: cast_nullable_to_non_nullable
as String?,totalResumes: freezed == totalResumes ? _self.totalResumes : totalResumes // ignore: cast_nullable_to_non_nullable
as int?,totalApplications: freezed == totalApplications ? _self.totalApplications : totalApplications // ignore: cast_nullable_to_non_nullable
as int?,savedJobs: freezed == savedJobs ? _self.savedJobs : savedJobs // ignore: cast_nullable_to_non_nullable
as int?,adminPermissions: null == adminPermissions ? _self.adminPermissions : adminPermissions // ignore: cast_nullable_to_non_nullable
as List<String>,paymentStats: freezed == paymentStats ? _self.paymentStats : paymentStats // ignore: cast_nullable_to_non_nullable
as PaymentStatsData?,jobStats: freezed == jobStats ? _self.jobStats : jobStats // ignore: cast_nullable_to_non_nullable
as JobStatsData?,connectedAccounts: null == connectedAccounts ? _self.connectedAccounts : connectedAccounts // ignore: cast_nullable_to_non_nullable
as List<ConnectedAccountData>,aiResumeStats: freezed == aiResumeStats ? _self.aiResumeStats : aiResumeStats // ignore: cast_nullable_to_non_nullable
as AiResumeStatsData?,security: freezed == security ? _self.security : security // ignore: cast_nullable_to_non_nullable
as SecurityData?,
  ));
}
/// Create a copy of ProfileData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentStatsDataCopyWith<$Res>? get paymentStats {
    if (_self.paymentStats == null) {
    return null;
  }

  return $PaymentStatsDataCopyWith<$Res>(_self.paymentStats!, (value) {
    return _then(_self.copyWith(paymentStats: value));
  });
}/// Create a copy of ProfileData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JobStatsDataCopyWith<$Res>? get jobStats {
    if (_self.jobStats == null) {
    return null;
  }

  return $JobStatsDataCopyWith<$Res>(_self.jobStats!, (value) {
    return _then(_self.copyWith(jobStats: value));
  });
}/// Create a copy of ProfileData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AiResumeStatsDataCopyWith<$Res>? get aiResumeStats {
    if (_self.aiResumeStats == null) {
    return null;
  }

  return $AiResumeStatsDataCopyWith<$Res>(_self.aiResumeStats!, (value) {
    return _then(_self.copyWith(aiResumeStats: value));
  });
}/// Create a copy of ProfileData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SecurityDataCopyWith<$Res>? get security {
    if (_self.security == null) {
    return null;
  }

  return $SecurityDataCopyWith<$Res>(_self.security!, (value) {
    return _then(_self.copyWith(security: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProfileData].
extension ProfileDataPatterns on ProfileData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileData value)  $default,){
final _that = this;
switch (_that) {
case _ProfileData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileData value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String name,  String jobTitle,  String location,  String email,  String phone,  String nationality,  String gender,  String company,  String education,  String linkedin,  int profileStrength,  String? profileImage,  String? userType,  String? subscriptionPlan,  String? subscriptionStatus,  int? totalResumes,  int? totalApplications,  int? savedJobs,  List<String> adminPermissions,  PaymentStatsData? paymentStats,  JobStatsData? jobStats,  List<ConnectedAccountData> connectedAccounts,  AiResumeStatsData? aiResumeStats,  SecurityData? security)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileData() when $default != null:
return $default(_that.name,_that.jobTitle,_that.location,_that.email,_that.phone,_that.nationality,_that.gender,_that.company,_that.education,_that.linkedin,_that.profileStrength,_that.profileImage,_that.userType,_that.subscriptionPlan,_that.subscriptionStatus,_that.totalResumes,_that.totalApplications,_that.savedJobs,_that.adminPermissions,_that.paymentStats,_that.jobStats,_that.connectedAccounts,_that.aiResumeStats,_that.security);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String name,  String jobTitle,  String location,  String email,  String phone,  String nationality,  String gender,  String company,  String education,  String linkedin,  int profileStrength,  String? profileImage,  String? userType,  String? subscriptionPlan,  String? subscriptionStatus,  int? totalResumes,  int? totalApplications,  int? savedJobs,  List<String> adminPermissions,  PaymentStatsData? paymentStats,  JobStatsData? jobStats,  List<ConnectedAccountData> connectedAccounts,  AiResumeStatsData? aiResumeStats,  SecurityData? security)  $default,) {final _that = this;
switch (_that) {
case _ProfileData():
return $default(_that.name,_that.jobTitle,_that.location,_that.email,_that.phone,_that.nationality,_that.gender,_that.company,_that.education,_that.linkedin,_that.profileStrength,_that.profileImage,_that.userType,_that.subscriptionPlan,_that.subscriptionStatus,_that.totalResumes,_that.totalApplications,_that.savedJobs,_that.adminPermissions,_that.paymentStats,_that.jobStats,_that.connectedAccounts,_that.aiResumeStats,_that.security);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String name,  String jobTitle,  String location,  String email,  String phone,  String nationality,  String gender,  String company,  String education,  String linkedin,  int profileStrength,  String? profileImage,  String? userType,  String? subscriptionPlan,  String? subscriptionStatus,  int? totalResumes,  int? totalApplications,  int? savedJobs,  List<String> adminPermissions,  PaymentStatsData? paymentStats,  JobStatsData? jobStats,  List<ConnectedAccountData> connectedAccounts,  AiResumeStatsData? aiResumeStats,  SecurityData? security)?  $default,) {final _that = this;
switch (_that) {
case _ProfileData() when $default != null:
return $default(_that.name,_that.jobTitle,_that.location,_that.email,_that.phone,_that.nationality,_that.gender,_that.company,_that.education,_that.linkedin,_that.profileStrength,_that.profileImage,_that.userType,_that.subscriptionPlan,_that.subscriptionStatus,_that.totalResumes,_that.totalApplications,_that.savedJobs,_that.adminPermissions,_that.paymentStats,_that.jobStats,_that.connectedAccounts,_that.aiResumeStats,_that.security);case _:
  return null;

}
}

}

/// @nodoc


class _ProfileData implements ProfileData {
  const _ProfileData({required this.name, required this.jobTitle, required this.location, required this.email, required this.phone, required this.nationality, required this.gender, required this.company, required this.education, required this.linkedin, required this.profileStrength, this.profileImage, this.userType, this.subscriptionPlan, this.subscriptionStatus, this.totalResumes, this.totalApplications, this.savedJobs, final  List<String> adminPermissions = const [], this.paymentStats, this.jobStats, final  List<ConnectedAccountData> connectedAccounts = const [], this.aiResumeStats, this.security}): _adminPermissions = adminPermissions,_connectedAccounts = connectedAccounts;
  

// Basic user info
@override final  String name;
@override final  String jobTitle;
@override final  String location;
@override final  String email;
@override final  String phone;
@override final  String nationality;
@override final  String gender;
@override final  String company;
@override final  String education;
@override final  String linkedin;
@override final  int profileStrength;
@override final  String? profileImage;
// Extended user data from comprehensive API
@override final  String? userType;
@override final  String? subscriptionPlan;
@override final  String? subscriptionStatus;
@override final  int? totalResumes;
@override final  int? totalApplications;
@override final  int? savedJobs;
 final  List<String> _adminPermissions;
@override@JsonKey() List<String> get adminPermissions {
  if (_adminPermissions is EqualUnmodifiableListView) return _adminPermissions;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_adminPermissions);
}

@override final  PaymentStatsData? paymentStats;
@override final  JobStatsData? jobStats;
 final  List<ConnectedAccountData> _connectedAccounts;
@override@JsonKey() List<ConnectedAccountData> get connectedAccounts {
  if (_connectedAccounts is EqualUnmodifiableListView) return _connectedAccounts;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(_connectedAccounts);
}

@override final  AiResumeStatsData? aiResumeStats;
@override final  SecurityData? security;

/// Create a copy of ProfileData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileDataCopyWith<_ProfileData> get copyWith => __$ProfileDataCopyWithImpl<_ProfileData>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileData&&(identical(other.name, name) || other.name == name)&&(identical(other.jobTitle, jobTitle) || other.jobTitle == jobTitle)&&(identical(other.location, location) || other.location == location)&&(identical(other.email, email) || other.email == email)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.nationality, nationality) || other.nationality == nationality)&&(identical(other.gender, gender) || other.gender == gender)&&(identical(other.company, company) || other.company == company)&&(identical(other.education, education) || other.education == education)&&(identical(other.linkedin, linkedin) || other.linkedin == linkedin)&&(identical(other.profileStrength, profileStrength) || other.profileStrength == profileStrength)&&(identical(other.profileImage, profileImage) || other.profileImage == profileImage)&&(identical(other.userType, userType) || other.userType == userType)&&(identical(other.subscriptionPlan, subscriptionPlan) || other.subscriptionPlan == subscriptionPlan)&&(identical(other.subscriptionStatus, subscriptionStatus) || other.subscriptionStatus == subscriptionStatus)&&(identical(other.totalResumes, totalResumes) || other.totalResumes == totalResumes)&&(identical(other.totalApplications, totalApplications) || other.totalApplications == totalApplications)&&(identical(other.savedJobs, savedJobs) || other.savedJobs == savedJobs)&&const DeepCollectionEquality().equals(other._adminPermissions, _adminPermissions)&&(identical(other.paymentStats, paymentStats) || other.paymentStats == paymentStats)&&(identical(other.jobStats, jobStats) || other.jobStats == jobStats)&&const DeepCollectionEquality().equals(other._connectedAccounts, _connectedAccounts)&&(identical(other.aiResumeStats, aiResumeStats) || other.aiResumeStats == aiResumeStats)&&(identical(other.security, security) || other.security == security));
}


@override
int get hashCode => Object.hashAll([runtimeType,name,jobTitle,location,email,phone,nationality,gender,company,education,linkedin,profileStrength,profileImage,userType,subscriptionPlan,subscriptionStatus,totalResumes,totalApplications,savedJobs,const DeepCollectionEquality().hash(_adminPermissions),paymentStats,jobStats,const DeepCollectionEquality().hash(_connectedAccounts),aiResumeStats,security]);

@override
String toString() {
  return 'ProfileData(name: $name, jobTitle: $jobTitle, location: $location, email: $email, phone: $phone, nationality: $nationality, gender: $gender, company: $company, education: $education, linkedin: $linkedin, profileStrength: $profileStrength, profileImage: $profileImage, userType: $userType, subscriptionPlan: $subscriptionPlan, subscriptionStatus: $subscriptionStatus, totalResumes: $totalResumes, totalApplications: $totalApplications, savedJobs: $savedJobs, adminPermissions: $adminPermissions, paymentStats: $paymentStats, jobStats: $jobStats, connectedAccounts: $connectedAccounts, aiResumeStats: $aiResumeStats, security: $security)';
}


}

/// @nodoc
abstract mixin class _$ProfileDataCopyWith<$Res> implements $ProfileDataCopyWith<$Res> {
  factory _$ProfileDataCopyWith(_ProfileData value, $Res Function(_ProfileData) _then) = __$ProfileDataCopyWithImpl;
@override @useResult
$Res call({
 String name, String jobTitle, String location, String email, String phone, String nationality, String gender, String company, String education, String linkedin, int profileStrength, String? profileImage, String? userType, String? subscriptionPlan, String? subscriptionStatus, int? totalResumes, int? totalApplications, int? savedJobs, List<String> adminPermissions, PaymentStatsData? paymentStats, JobStatsData? jobStats, List<ConnectedAccountData> connectedAccounts, AiResumeStatsData? aiResumeStats, SecurityData? security
});


@override $PaymentStatsDataCopyWith<$Res>? get paymentStats;@override $JobStatsDataCopyWith<$Res>? get jobStats;@override $AiResumeStatsDataCopyWith<$Res>? get aiResumeStats;@override $SecurityDataCopyWith<$Res>? get security;

}
/// @nodoc
class __$ProfileDataCopyWithImpl<$Res>
    implements _$ProfileDataCopyWith<$Res> {
  __$ProfileDataCopyWithImpl(this._self, this._then);

  final _ProfileData _self;
  final $Res Function(_ProfileData) _then;

/// Create a copy of ProfileData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? name = null,Object? jobTitle = null,Object? location = null,Object? email = null,Object? phone = null,Object? nationality = null,Object? gender = null,Object? company = null,Object? education = null,Object? linkedin = null,Object? profileStrength = null,Object? profileImage = freezed,Object? userType = freezed,Object? subscriptionPlan = freezed,Object? subscriptionStatus = freezed,Object? totalResumes = freezed,Object? totalApplications = freezed,Object? savedJobs = freezed,Object? adminPermissions = null,Object? paymentStats = freezed,Object? jobStats = freezed,Object? connectedAccounts = null,Object? aiResumeStats = freezed,Object? security = freezed,}) {
  return _then(_ProfileData(
name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,jobTitle: null == jobTitle ? _self.jobTitle : jobTitle // ignore: cast_nullable_to_non_nullable
as String,location: null == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String,email: null == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String,phone: null == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String,nationality: null == nationality ? _self.nationality : nationality // ignore: cast_nullable_to_non_nullable
as String,gender: null == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String,company: null == company ? _self.company : company // ignore: cast_nullable_to_non_nullable
as String,education: null == education ? _self.education : education // ignore: cast_nullable_to_non_nullable
as String,linkedin: null == linkedin ? _self.linkedin : linkedin // ignore: cast_nullable_to_non_nullable
as String,profileStrength: null == profileStrength ? _self.profileStrength : profileStrength // ignore: cast_nullable_to_non_nullable
as int,profileImage: freezed == profileImage ? _self.profileImage : profileImage // ignore: cast_nullable_to_non_nullable
as String?,userType: freezed == userType ? _self.userType : userType // ignore: cast_nullable_to_non_nullable
as String?,subscriptionPlan: freezed == subscriptionPlan ? _self.subscriptionPlan : subscriptionPlan // ignore: cast_nullable_to_non_nullable
as String?,subscriptionStatus: freezed == subscriptionStatus ? _self.subscriptionStatus : subscriptionStatus // ignore: cast_nullable_to_non_nullable
as String?,totalResumes: freezed == totalResumes ? _self.totalResumes : totalResumes // ignore: cast_nullable_to_non_nullable
as int?,totalApplications: freezed == totalApplications ? _self.totalApplications : totalApplications // ignore: cast_nullable_to_non_nullable
as int?,savedJobs: freezed == savedJobs ? _self.savedJobs : savedJobs // ignore: cast_nullable_to_non_nullable
as int?,adminPermissions: null == adminPermissions ? _self._adminPermissions : adminPermissions // ignore: cast_nullable_to_non_nullable
as List<String>,paymentStats: freezed == paymentStats ? _self.paymentStats : paymentStats // ignore: cast_nullable_to_non_nullable
as PaymentStatsData?,jobStats: freezed == jobStats ? _self.jobStats : jobStats // ignore: cast_nullable_to_non_nullable
as JobStatsData?,connectedAccounts: null == connectedAccounts ? _self._connectedAccounts : connectedAccounts // ignore: cast_nullable_to_non_nullable
as List<ConnectedAccountData>,aiResumeStats: freezed == aiResumeStats ? _self.aiResumeStats : aiResumeStats // ignore: cast_nullable_to_non_nullable
as AiResumeStatsData?,security: freezed == security ? _self.security : security // ignore: cast_nullable_to_non_nullable
as SecurityData?,
  ));
}

/// Create a copy of ProfileData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$PaymentStatsDataCopyWith<$Res>? get paymentStats {
    if (_self.paymentStats == null) {
    return null;
  }

  return $PaymentStatsDataCopyWith<$Res>(_self.paymentStats!, (value) {
    return _then(_self.copyWith(paymentStats: value));
  });
}/// Create a copy of ProfileData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$JobStatsDataCopyWith<$Res>? get jobStats {
    if (_self.jobStats == null) {
    return null;
  }

  return $JobStatsDataCopyWith<$Res>(_self.jobStats!, (value) {
    return _then(_self.copyWith(jobStats: value));
  });
}/// Create a copy of ProfileData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$AiResumeStatsDataCopyWith<$Res>? get aiResumeStats {
    if (_self.aiResumeStats == null) {
    return null;
  }

  return $AiResumeStatsDataCopyWith<$Res>(_self.aiResumeStats!, (value) {
    return _then(_self.copyWith(aiResumeStats: value));
  });
}/// Create a copy of ProfileData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SecurityDataCopyWith<$Res>? get security {
    if (_self.security == null) {
    return null;
  }

  return $SecurityDataCopyWith<$Res>(_self.security!, (value) {
    return _then(_self.copyWith(security: value));
  });
}
}

// dart format on
