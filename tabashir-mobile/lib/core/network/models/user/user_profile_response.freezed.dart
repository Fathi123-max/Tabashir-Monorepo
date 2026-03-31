// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'user_profile_response.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$UserProfileResponse {

 UserData get user; CandidateProfileData? get candidateProfile; RecruiterProfileData? get recruiterProfile; OwnerProfileData? get ownerProfile; ProfileCounts? get counts; SubscriptionData? get subscription; List<String> get adminPermissions; PaymentStatsData? get paymentStats; JobStatsData? get jobStats; List<ConnectedAccountData> get connectedAccounts; AiResumeStatsData? get aiResumeStats; SecurityData? get security;
/// Create a copy of UserProfileResponse
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserProfileResponseCopyWith<UserProfileResponse> get copyWith => _$UserProfileResponseCopyWithImpl<UserProfileResponse>(this as UserProfileResponse, _$identity);

  /// Serializes this UserProfileResponse to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserProfileResponse&&(identical(other.user, user) || other.user == user)&&(identical(other.candidateProfile, candidateProfile) || other.candidateProfile == candidateProfile)&&(identical(other.recruiterProfile, recruiterProfile) || other.recruiterProfile == recruiterProfile)&&(identical(other.ownerProfile, ownerProfile) || other.ownerProfile == ownerProfile)&&(identical(other.counts, counts) || other.counts == counts)&&(identical(other.subscription, subscription) || other.subscription == subscription)&&const DeepCollectionEquality().equals(other.adminPermissions, adminPermissions)&&(identical(other.paymentStats, paymentStats) || other.paymentStats == paymentStats)&&(identical(other.jobStats, jobStats) || other.jobStats == jobStats)&&const DeepCollectionEquality().equals(other.connectedAccounts, connectedAccounts)&&(identical(other.aiResumeStats, aiResumeStats) || other.aiResumeStats == aiResumeStats)&&(identical(other.security, security) || other.security == security));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user,candidateProfile,recruiterProfile,ownerProfile,counts,subscription,const DeepCollectionEquality().hash(adminPermissions),paymentStats,jobStats,const DeepCollectionEquality().hash(connectedAccounts),aiResumeStats,security);

@override
String toString() {
  return 'UserProfileResponse(user: $user, candidateProfile: $candidateProfile, recruiterProfile: $recruiterProfile, ownerProfile: $ownerProfile, counts: $counts, subscription: $subscription, adminPermissions: $adminPermissions, paymentStats: $paymentStats, jobStats: $jobStats, connectedAccounts: $connectedAccounts, aiResumeStats: $aiResumeStats, security: $security)';
}


}

/// @nodoc
abstract mixin class $UserProfileResponseCopyWith<$Res>  {
  factory $UserProfileResponseCopyWith(UserProfileResponse value, $Res Function(UserProfileResponse) _then) = _$UserProfileResponseCopyWithImpl;
@useResult
$Res call({
 UserData user, CandidateProfileData? candidateProfile, RecruiterProfileData? recruiterProfile, OwnerProfileData? ownerProfile, ProfileCounts? counts, SubscriptionData? subscription, List<String> adminPermissions, PaymentStatsData? paymentStats, JobStatsData? jobStats, List<ConnectedAccountData> connectedAccounts, AiResumeStatsData? aiResumeStats, SecurityData? security
});


$UserDataCopyWith<$Res> get user;$CandidateProfileDataCopyWith<$Res>? get candidateProfile;$RecruiterProfileDataCopyWith<$Res>? get recruiterProfile;$OwnerProfileDataCopyWith<$Res>? get ownerProfile;$ProfileCountsCopyWith<$Res>? get counts;$SubscriptionDataCopyWith<$Res>? get subscription;$PaymentStatsDataCopyWith<$Res>? get paymentStats;$JobStatsDataCopyWith<$Res>? get jobStats;$AiResumeStatsDataCopyWith<$Res>? get aiResumeStats;$SecurityDataCopyWith<$Res>? get security;

}
/// @nodoc
class _$UserProfileResponseCopyWithImpl<$Res>
    implements $UserProfileResponseCopyWith<$Res> {
  _$UserProfileResponseCopyWithImpl(this._self, this._then);

  final UserProfileResponse _self;
  final $Res Function(UserProfileResponse) _then;

/// Create a copy of UserProfileResponse
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? user = null,Object? candidateProfile = freezed,Object? recruiterProfile = freezed,Object? ownerProfile = freezed,Object? counts = freezed,Object? subscription = freezed,Object? adminPermissions = null,Object? paymentStats = freezed,Object? jobStats = freezed,Object? connectedAccounts = null,Object? aiResumeStats = freezed,Object? security = freezed,}) {
  return _then(_self.copyWith(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserData,candidateProfile: freezed == candidateProfile ? _self.candidateProfile : candidateProfile // ignore: cast_nullable_to_non_nullable
as CandidateProfileData?,recruiterProfile: freezed == recruiterProfile ? _self.recruiterProfile : recruiterProfile // ignore: cast_nullable_to_non_nullable
as RecruiterProfileData?,ownerProfile: freezed == ownerProfile ? _self.ownerProfile : ownerProfile // ignore: cast_nullable_to_non_nullable
as OwnerProfileData?,counts: freezed == counts ? _self.counts : counts // ignore: cast_nullable_to_non_nullable
as ProfileCounts?,subscription: freezed == subscription ? _self.subscription : subscription // ignore: cast_nullable_to_non_nullable
as SubscriptionData?,adminPermissions: null == adminPermissions ? _self.adminPermissions : adminPermissions // ignore: cast_nullable_to_non_nullable
as List<String>,paymentStats: freezed == paymentStats ? _self.paymentStats : paymentStats // ignore: cast_nullable_to_non_nullable
as PaymentStatsData?,jobStats: freezed == jobStats ? _self.jobStats : jobStats // ignore: cast_nullable_to_non_nullable
as JobStatsData?,connectedAccounts: null == connectedAccounts ? _self.connectedAccounts : connectedAccounts // ignore: cast_nullable_to_non_nullable
as List<ConnectedAccountData>,aiResumeStats: freezed == aiResumeStats ? _self.aiResumeStats : aiResumeStats // ignore: cast_nullable_to_non_nullable
as AiResumeStatsData?,security: freezed == security ? _self.security : security // ignore: cast_nullable_to_non_nullable
as SecurityData?,
  ));
}
/// Create a copy of UserProfileResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserDataCopyWith<$Res> get user {
  
  return $UserDataCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of UserProfileResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CandidateProfileDataCopyWith<$Res>? get candidateProfile {
    if (_self.candidateProfile == null) {
    return null;
  }

  return $CandidateProfileDataCopyWith<$Res>(_self.candidateProfile!, (value) {
    return _then(_self.copyWith(candidateProfile: value));
  });
}/// Create a copy of UserProfileResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecruiterProfileDataCopyWith<$Res>? get recruiterProfile {
    if (_self.recruiterProfile == null) {
    return null;
  }

  return $RecruiterProfileDataCopyWith<$Res>(_self.recruiterProfile!, (value) {
    return _then(_self.copyWith(recruiterProfile: value));
  });
}/// Create a copy of UserProfileResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OwnerProfileDataCopyWith<$Res>? get ownerProfile {
    if (_self.ownerProfile == null) {
    return null;
  }

  return $OwnerProfileDataCopyWith<$Res>(_self.ownerProfile!, (value) {
    return _then(_self.copyWith(ownerProfile: value));
  });
}/// Create a copy of UserProfileResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileCountsCopyWith<$Res>? get counts {
    if (_self.counts == null) {
    return null;
  }

  return $ProfileCountsCopyWith<$Res>(_self.counts!, (value) {
    return _then(_self.copyWith(counts: value));
  });
}/// Create a copy of UserProfileResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubscriptionDataCopyWith<$Res>? get subscription {
    if (_self.subscription == null) {
    return null;
  }

  return $SubscriptionDataCopyWith<$Res>(_self.subscription!, (value) {
    return _then(_self.copyWith(subscription: value));
  });
}/// Create a copy of UserProfileResponse
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
}/// Create a copy of UserProfileResponse
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
}/// Create a copy of UserProfileResponse
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
}/// Create a copy of UserProfileResponse
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


/// Adds pattern-matching-related methods to [UserProfileResponse].
extension UserProfileResponsePatterns on UserProfileResponse {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserProfileResponse value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserProfileResponse() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserProfileResponse value)  $default,){
final _that = this;
switch (_that) {
case _UserProfileResponse():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserProfileResponse value)?  $default,){
final _that = this;
switch (_that) {
case _UserProfileResponse() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( UserData user,  CandidateProfileData? candidateProfile,  RecruiterProfileData? recruiterProfile,  OwnerProfileData? ownerProfile,  ProfileCounts? counts,  SubscriptionData? subscription,  List<String> adminPermissions,  PaymentStatsData? paymentStats,  JobStatsData? jobStats,  List<ConnectedAccountData> connectedAccounts,  AiResumeStatsData? aiResumeStats,  SecurityData? security)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserProfileResponse() when $default != null:
return $default(_that.user,_that.candidateProfile,_that.recruiterProfile,_that.ownerProfile,_that.counts,_that.subscription,_that.adminPermissions,_that.paymentStats,_that.jobStats,_that.connectedAccounts,_that.aiResumeStats,_that.security);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( UserData user,  CandidateProfileData? candidateProfile,  RecruiterProfileData? recruiterProfile,  OwnerProfileData? ownerProfile,  ProfileCounts? counts,  SubscriptionData? subscription,  List<String> adminPermissions,  PaymentStatsData? paymentStats,  JobStatsData? jobStats,  List<ConnectedAccountData> connectedAccounts,  AiResumeStatsData? aiResumeStats,  SecurityData? security)  $default,) {final _that = this;
switch (_that) {
case _UserProfileResponse():
return $default(_that.user,_that.candidateProfile,_that.recruiterProfile,_that.ownerProfile,_that.counts,_that.subscription,_that.adminPermissions,_that.paymentStats,_that.jobStats,_that.connectedAccounts,_that.aiResumeStats,_that.security);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( UserData user,  CandidateProfileData? candidateProfile,  RecruiterProfileData? recruiterProfile,  OwnerProfileData? ownerProfile,  ProfileCounts? counts,  SubscriptionData? subscription,  List<String> adminPermissions,  PaymentStatsData? paymentStats,  JobStatsData? jobStats,  List<ConnectedAccountData> connectedAccounts,  AiResumeStatsData? aiResumeStats,  SecurityData? security)?  $default,) {final _that = this;
switch (_that) {
case _UserProfileResponse() when $default != null:
return $default(_that.user,_that.candidateProfile,_that.recruiterProfile,_that.ownerProfile,_that.counts,_that.subscription,_that.adminPermissions,_that.paymentStats,_that.jobStats,_that.connectedAccounts,_that.aiResumeStats,_that.security);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserProfileResponse implements UserProfileResponse {
  const _UserProfileResponse({required this.user, this.candidateProfile, this.recruiterProfile, this.ownerProfile, this.counts, this.subscription, final  List<String> adminPermissions = const [], this.paymentStats, this.jobStats, final  List<ConnectedAccountData> connectedAccounts = const [], this.aiResumeStats, this.security}): _adminPermissions = adminPermissions,_connectedAccounts = connectedAccounts;
  factory _UserProfileResponse.fromJson(Map<String, dynamic> json) => _$UserProfileResponseFromJson(json);

@override final  UserData user;
@override final  CandidateProfileData? candidateProfile;
@override final  RecruiterProfileData? recruiterProfile;
@override final  OwnerProfileData? ownerProfile;
@override final  ProfileCounts? counts;
@override final  SubscriptionData? subscription;
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

/// Create a copy of UserProfileResponse
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserProfileResponseCopyWith<_UserProfileResponse> get copyWith => __$UserProfileResponseCopyWithImpl<_UserProfileResponse>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserProfileResponseToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserProfileResponse&&(identical(other.user, user) || other.user == user)&&(identical(other.candidateProfile, candidateProfile) || other.candidateProfile == candidateProfile)&&(identical(other.recruiterProfile, recruiterProfile) || other.recruiterProfile == recruiterProfile)&&(identical(other.ownerProfile, ownerProfile) || other.ownerProfile == ownerProfile)&&(identical(other.counts, counts) || other.counts == counts)&&(identical(other.subscription, subscription) || other.subscription == subscription)&&const DeepCollectionEquality().equals(other._adminPermissions, _adminPermissions)&&(identical(other.paymentStats, paymentStats) || other.paymentStats == paymentStats)&&(identical(other.jobStats, jobStats) || other.jobStats == jobStats)&&const DeepCollectionEquality().equals(other._connectedAccounts, _connectedAccounts)&&(identical(other.aiResumeStats, aiResumeStats) || other.aiResumeStats == aiResumeStats)&&(identical(other.security, security) || other.security == security));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,user,candidateProfile,recruiterProfile,ownerProfile,counts,subscription,const DeepCollectionEquality().hash(_adminPermissions),paymentStats,jobStats,const DeepCollectionEquality().hash(_connectedAccounts),aiResumeStats,security);

@override
String toString() {
  return 'UserProfileResponse(user: $user, candidateProfile: $candidateProfile, recruiterProfile: $recruiterProfile, ownerProfile: $ownerProfile, counts: $counts, subscription: $subscription, adminPermissions: $adminPermissions, paymentStats: $paymentStats, jobStats: $jobStats, connectedAccounts: $connectedAccounts, aiResumeStats: $aiResumeStats, security: $security)';
}


}

/// @nodoc
abstract mixin class _$UserProfileResponseCopyWith<$Res> implements $UserProfileResponseCopyWith<$Res> {
  factory _$UserProfileResponseCopyWith(_UserProfileResponse value, $Res Function(_UserProfileResponse) _then) = __$UserProfileResponseCopyWithImpl;
@override @useResult
$Res call({
 UserData user, CandidateProfileData? candidateProfile, RecruiterProfileData? recruiterProfile, OwnerProfileData? ownerProfile, ProfileCounts? counts, SubscriptionData? subscription, List<String> adminPermissions, PaymentStatsData? paymentStats, JobStatsData? jobStats, List<ConnectedAccountData> connectedAccounts, AiResumeStatsData? aiResumeStats, SecurityData? security
});


@override $UserDataCopyWith<$Res> get user;@override $CandidateProfileDataCopyWith<$Res>? get candidateProfile;@override $RecruiterProfileDataCopyWith<$Res>? get recruiterProfile;@override $OwnerProfileDataCopyWith<$Res>? get ownerProfile;@override $ProfileCountsCopyWith<$Res>? get counts;@override $SubscriptionDataCopyWith<$Res>? get subscription;@override $PaymentStatsDataCopyWith<$Res>? get paymentStats;@override $JobStatsDataCopyWith<$Res>? get jobStats;@override $AiResumeStatsDataCopyWith<$Res>? get aiResumeStats;@override $SecurityDataCopyWith<$Res>? get security;

}
/// @nodoc
class __$UserProfileResponseCopyWithImpl<$Res>
    implements _$UserProfileResponseCopyWith<$Res> {
  __$UserProfileResponseCopyWithImpl(this._self, this._then);

  final _UserProfileResponse _self;
  final $Res Function(_UserProfileResponse) _then;

/// Create a copy of UserProfileResponse
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? user = null,Object? candidateProfile = freezed,Object? recruiterProfile = freezed,Object? ownerProfile = freezed,Object? counts = freezed,Object? subscription = freezed,Object? adminPermissions = null,Object? paymentStats = freezed,Object? jobStats = freezed,Object? connectedAccounts = null,Object? aiResumeStats = freezed,Object? security = freezed,}) {
  return _then(_UserProfileResponse(
user: null == user ? _self.user : user // ignore: cast_nullable_to_non_nullable
as UserData,candidateProfile: freezed == candidateProfile ? _self.candidateProfile : candidateProfile // ignore: cast_nullable_to_non_nullable
as CandidateProfileData?,recruiterProfile: freezed == recruiterProfile ? _self.recruiterProfile : recruiterProfile // ignore: cast_nullable_to_non_nullable
as RecruiterProfileData?,ownerProfile: freezed == ownerProfile ? _self.ownerProfile : ownerProfile // ignore: cast_nullable_to_non_nullable
as OwnerProfileData?,counts: freezed == counts ? _self.counts : counts // ignore: cast_nullable_to_non_nullable
as ProfileCounts?,subscription: freezed == subscription ? _self.subscription : subscription // ignore: cast_nullable_to_non_nullable
as SubscriptionData?,adminPermissions: null == adminPermissions ? _self._adminPermissions : adminPermissions // ignore: cast_nullable_to_non_nullable
as List<String>,paymentStats: freezed == paymentStats ? _self.paymentStats : paymentStats // ignore: cast_nullable_to_non_nullable
as PaymentStatsData?,jobStats: freezed == jobStats ? _self.jobStats : jobStats // ignore: cast_nullable_to_non_nullable
as JobStatsData?,connectedAccounts: null == connectedAccounts ? _self._connectedAccounts : connectedAccounts // ignore: cast_nullable_to_non_nullable
as List<ConnectedAccountData>,aiResumeStats: freezed == aiResumeStats ? _self.aiResumeStats : aiResumeStats // ignore: cast_nullable_to_non_nullable
as AiResumeStatsData?,security: freezed == security ? _self.security : security // ignore: cast_nullable_to_non_nullable
as SecurityData?,
  ));
}

/// Create a copy of UserProfileResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$UserDataCopyWith<$Res> get user {
  
  return $UserDataCopyWith<$Res>(_self.user, (value) {
    return _then(_self.copyWith(user: value));
  });
}/// Create a copy of UserProfileResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CandidateProfileDataCopyWith<$Res>? get candidateProfile {
    if (_self.candidateProfile == null) {
    return null;
  }

  return $CandidateProfileDataCopyWith<$Res>(_self.candidateProfile!, (value) {
    return _then(_self.copyWith(candidateProfile: value));
  });
}/// Create a copy of UserProfileResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RecruiterProfileDataCopyWith<$Res>? get recruiterProfile {
    if (_self.recruiterProfile == null) {
    return null;
  }

  return $RecruiterProfileDataCopyWith<$Res>(_self.recruiterProfile!, (value) {
    return _then(_self.copyWith(recruiterProfile: value));
  });
}/// Create a copy of UserProfileResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$OwnerProfileDataCopyWith<$Res>? get ownerProfile {
    if (_self.ownerProfile == null) {
    return null;
  }

  return $OwnerProfileDataCopyWith<$Res>(_self.ownerProfile!, (value) {
    return _then(_self.copyWith(ownerProfile: value));
  });
}/// Create a copy of UserProfileResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ProfileCountsCopyWith<$Res>? get counts {
    if (_self.counts == null) {
    return null;
  }

  return $ProfileCountsCopyWith<$Res>(_self.counts!, (value) {
    return _then(_self.copyWith(counts: value));
  });
}/// Create a copy of UserProfileResponse
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$SubscriptionDataCopyWith<$Res>? get subscription {
    if (_self.subscription == null) {
    return null;
  }

  return $SubscriptionDataCopyWith<$Res>(_self.subscription!, (value) {
    return _then(_self.copyWith(subscription: value));
  });
}/// Create a copy of UserProfileResponse
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
}/// Create a copy of UserProfileResponse
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
}/// Create a copy of UserProfileResponse
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
}/// Create a copy of UserProfileResponse
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


/// @nodoc
mixin _$ResumeInfo {

 String? get fileName; String? get fileUrl;
/// Create a copy of ResumeInfo
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ResumeInfoCopyWith<ResumeInfo> get copyWith => _$ResumeInfoCopyWithImpl<ResumeInfo>(this as ResumeInfo, _$identity);

  /// Serializes this ResumeInfo to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ResumeInfo&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fileName,fileUrl);

@override
String toString() {
  return 'ResumeInfo(fileName: $fileName, fileUrl: $fileUrl)';
}


}

/// @nodoc
abstract mixin class $ResumeInfoCopyWith<$Res>  {
  factory $ResumeInfoCopyWith(ResumeInfo value, $Res Function(ResumeInfo) _then) = _$ResumeInfoCopyWithImpl;
@useResult
$Res call({
 String? fileName, String? fileUrl
});




}
/// @nodoc
class _$ResumeInfoCopyWithImpl<$Res>
    implements $ResumeInfoCopyWith<$Res> {
  _$ResumeInfoCopyWithImpl(this._self, this._then);

  final ResumeInfo _self;
  final $Res Function(ResumeInfo) _then;

/// Create a copy of ResumeInfo
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? fileName = freezed,Object? fileUrl = freezed,}) {
  return _then(_self.copyWith(
fileName: freezed == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String?,fileUrl: freezed == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [ResumeInfo].
extension ResumeInfoPatterns on ResumeInfo {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ResumeInfo value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ResumeInfo() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ResumeInfo value)  $default,){
final _that = this;
switch (_that) {
case _ResumeInfo():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ResumeInfo value)?  $default,){
final _that = this;
switch (_that) {
case _ResumeInfo() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? fileName,  String? fileUrl)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ResumeInfo() when $default != null:
return $default(_that.fileName,_that.fileUrl);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? fileName,  String? fileUrl)  $default,) {final _that = this;
switch (_that) {
case _ResumeInfo():
return $default(_that.fileName,_that.fileUrl);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? fileName,  String? fileUrl)?  $default,) {final _that = this;
switch (_that) {
case _ResumeInfo() when $default != null:
return $default(_that.fileName,_that.fileUrl);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ResumeInfo implements ResumeInfo {
  const _ResumeInfo({this.fileName, this.fileUrl});
  factory _ResumeInfo.fromJson(Map<String, dynamic> json) => _$ResumeInfoFromJson(json);

@override final  String? fileName;
@override final  String? fileUrl;

/// Create a copy of ResumeInfo
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ResumeInfoCopyWith<_ResumeInfo> get copyWith => __$ResumeInfoCopyWithImpl<_ResumeInfo>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ResumeInfoToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ResumeInfo&&(identical(other.fileName, fileName) || other.fileName == fileName)&&(identical(other.fileUrl, fileUrl) || other.fileUrl == fileUrl));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,fileName,fileUrl);

@override
String toString() {
  return 'ResumeInfo(fileName: $fileName, fileUrl: $fileUrl)';
}


}

/// @nodoc
abstract mixin class _$ResumeInfoCopyWith<$Res> implements $ResumeInfoCopyWith<$Res> {
  factory _$ResumeInfoCopyWith(_ResumeInfo value, $Res Function(_ResumeInfo) _then) = __$ResumeInfoCopyWithImpl;
@override @useResult
$Res call({
 String? fileName, String? fileUrl
});




}
/// @nodoc
class __$ResumeInfoCopyWithImpl<$Res>
    implements _$ResumeInfoCopyWith<$Res> {
  __$ResumeInfoCopyWithImpl(this._self, this._then);

  final _ResumeInfo _self;
  final $Res Function(_ResumeInfo) _then;

/// Create a copy of ResumeInfo
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? fileName = freezed,Object? fileUrl = freezed,}) {
  return _then(_ResumeInfo(
fileName: freezed == fileName ? _self.fileName : fileName // ignore: cast_nullable_to_non_nullable
as String?,fileUrl: freezed == fileUrl ? _self.fileUrl : fileUrl // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$UserData {

 String get id; String? get name; String? get email; DateTime? get emailVerified; String? get image; String? get userType; String? get adminRole; int? get jobCount; int? get aiJobApplyCount; DateTime? get createdAt; DateTime? get updatedAt; String? get referralCode; String? get referredBy;
/// Create a copy of UserData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$UserDataCopyWith<UserData> get copyWith => _$UserDataCopyWithImpl<UserData>(this as UserData, _$identity);

  /// Serializes this UserData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is UserData&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.emailVerified, emailVerified) || other.emailVerified == emailVerified)&&(identical(other.image, image) || other.image == image)&&(identical(other.userType, userType) || other.userType == userType)&&(identical(other.adminRole, adminRole) || other.adminRole == adminRole)&&(identical(other.jobCount, jobCount) || other.jobCount == jobCount)&&(identical(other.aiJobApplyCount, aiJobApplyCount) || other.aiJobApplyCount == aiJobApplyCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.referralCode, referralCode) || other.referralCode == referralCode)&&(identical(other.referredBy, referredBy) || other.referredBy == referredBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,email,emailVerified,image,userType,adminRole,jobCount,aiJobApplyCount,createdAt,updatedAt,referralCode,referredBy);

@override
String toString() {
  return 'UserData(id: $id, name: $name, email: $email, emailVerified: $emailVerified, image: $image, userType: $userType, adminRole: $adminRole, jobCount: $jobCount, aiJobApplyCount: $aiJobApplyCount, createdAt: $createdAt, updatedAt: $updatedAt, referralCode: $referralCode, referredBy: $referredBy)';
}


}

/// @nodoc
abstract mixin class $UserDataCopyWith<$Res>  {
  factory $UserDataCopyWith(UserData value, $Res Function(UserData) _then) = _$UserDataCopyWithImpl;
@useResult
$Res call({
 String id, String? name, String? email, DateTime? emailVerified, String? image, String? userType, String? adminRole, int? jobCount, int? aiJobApplyCount, DateTime? createdAt, DateTime? updatedAt, String? referralCode, String? referredBy
});




}
/// @nodoc
class _$UserDataCopyWithImpl<$Res>
    implements $UserDataCopyWith<$Res> {
  _$UserDataCopyWithImpl(this._self, this._then);

  final UserData _self;
  final $Res Function(UserData) _then;

/// Create a copy of UserData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = freezed,Object? email = freezed,Object? emailVerified = freezed,Object? image = freezed,Object? userType = freezed,Object? adminRole = freezed,Object? jobCount = freezed,Object? aiJobApplyCount = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? referralCode = freezed,Object? referredBy = freezed,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,emailVerified: freezed == emailVerified ? _self.emailVerified : emailVerified // ignore: cast_nullable_to_non_nullable
as DateTime?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,userType: freezed == userType ? _self.userType : userType // ignore: cast_nullable_to_non_nullable
as String?,adminRole: freezed == adminRole ? _self.adminRole : adminRole // ignore: cast_nullable_to_non_nullable
as String?,jobCount: freezed == jobCount ? _self.jobCount : jobCount // ignore: cast_nullable_to_non_nullable
as int?,aiJobApplyCount: freezed == aiJobApplyCount ? _self.aiJobApplyCount : aiJobApplyCount // ignore: cast_nullable_to_non_nullable
as int?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,referralCode: freezed == referralCode ? _self.referralCode : referralCode // ignore: cast_nullable_to_non_nullable
as String?,referredBy: freezed == referredBy ? _self.referredBy : referredBy // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [UserData].
extension UserDataPatterns on UserData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _UserData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _UserData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _UserData value)  $default,){
final _that = this;
switch (_that) {
case _UserData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _UserData value)?  $default,){
final _that = this;
switch (_that) {
case _UserData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String? name,  String? email,  DateTime? emailVerified,  String? image,  String? userType,  String? adminRole,  int? jobCount,  int? aiJobApplyCount,  DateTime? createdAt,  DateTime? updatedAt,  String? referralCode,  String? referredBy)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _UserData() when $default != null:
return $default(_that.id,_that.name,_that.email,_that.emailVerified,_that.image,_that.userType,_that.adminRole,_that.jobCount,_that.aiJobApplyCount,_that.createdAt,_that.updatedAt,_that.referralCode,_that.referredBy);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String? name,  String? email,  DateTime? emailVerified,  String? image,  String? userType,  String? adminRole,  int? jobCount,  int? aiJobApplyCount,  DateTime? createdAt,  DateTime? updatedAt,  String? referralCode,  String? referredBy)  $default,) {final _that = this;
switch (_that) {
case _UserData():
return $default(_that.id,_that.name,_that.email,_that.emailVerified,_that.image,_that.userType,_that.adminRole,_that.jobCount,_that.aiJobApplyCount,_that.createdAt,_that.updatedAt,_that.referralCode,_that.referredBy);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String? name,  String? email,  DateTime? emailVerified,  String? image,  String? userType,  String? adminRole,  int? jobCount,  int? aiJobApplyCount,  DateTime? createdAt,  DateTime? updatedAt,  String? referralCode,  String? referredBy)?  $default,) {final _that = this;
switch (_that) {
case _UserData() when $default != null:
return $default(_that.id,_that.name,_that.email,_that.emailVerified,_that.image,_that.userType,_that.adminRole,_that.jobCount,_that.aiJobApplyCount,_that.createdAt,_that.updatedAt,_that.referralCode,_that.referredBy);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _UserData implements UserData {
  const _UserData({required this.id, this.name, this.email, this.emailVerified, this.image, this.userType, this.adminRole, this.jobCount, this.aiJobApplyCount, this.createdAt, this.updatedAt, this.referralCode, this.referredBy});
  factory _UserData.fromJson(Map<String, dynamic> json) => _$UserDataFromJson(json);

@override final  String id;
@override final  String? name;
@override final  String? email;
@override final  DateTime? emailVerified;
@override final  String? image;
@override final  String? userType;
@override final  String? adminRole;
@override final  int? jobCount;
@override final  int? aiJobApplyCount;
@override final  DateTime? createdAt;
@override final  DateTime? updatedAt;
@override final  String? referralCode;
@override final  String? referredBy;

/// Create a copy of UserData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$UserDataCopyWith<_UserData> get copyWith => __$UserDataCopyWithImpl<_UserData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$UserDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _UserData&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.email, email) || other.email == email)&&(identical(other.emailVerified, emailVerified) || other.emailVerified == emailVerified)&&(identical(other.image, image) || other.image == image)&&(identical(other.userType, userType) || other.userType == userType)&&(identical(other.adminRole, adminRole) || other.adminRole == adminRole)&&(identical(other.jobCount, jobCount) || other.jobCount == jobCount)&&(identical(other.aiJobApplyCount, aiJobApplyCount) || other.aiJobApplyCount == aiJobApplyCount)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt)&&(identical(other.referralCode, referralCode) || other.referralCode == referralCode)&&(identical(other.referredBy, referredBy) || other.referredBy == referredBy));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,email,emailVerified,image,userType,adminRole,jobCount,aiJobApplyCount,createdAt,updatedAt,referralCode,referredBy);

@override
String toString() {
  return 'UserData(id: $id, name: $name, email: $email, emailVerified: $emailVerified, image: $image, userType: $userType, adminRole: $adminRole, jobCount: $jobCount, aiJobApplyCount: $aiJobApplyCount, createdAt: $createdAt, updatedAt: $updatedAt, referralCode: $referralCode, referredBy: $referredBy)';
}


}

/// @nodoc
abstract mixin class _$UserDataCopyWith<$Res> implements $UserDataCopyWith<$Res> {
  factory _$UserDataCopyWith(_UserData value, $Res Function(_UserData) _then) = __$UserDataCopyWithImpl;
@override @useResult
$Res call({
 String id, String? name, String? email, DateTime? emailVerified, String? image, String? userType, String? adminRole, int? jobCount, int? aiJobApplyCount, DateTime? createdAt, DateTime? updatedAt, String? referralCode, String? referredBy
});




}
/// @nodoc
class __$UserDataCopyWithImpl<$Res>
    implements _$UserDataCopyWith<$Res> {
  __$UserDataCopyWithImpl(this._self, this._then);

  final _UserData _self;
  final $Res Function(_UserData) _then;

/// Create a copy of UserData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = freezed,Object? email = freezed,Object? emailVerified = freezed,Object? image = freezed,Object? userType = freezed,Object? adminRole = freezed,Object? jobCount = freezed,Object? aiJobApplyCount = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,Object? referralCode = freezed,Object? referredBy = freezed,}) {
  return _then(_UserData(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: freezed == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String?,email: freezed == email ? _self.email : email // ignore: cast_nullable_to_non_nullable
as String?,emailVerified: freezed == emailVerified ? _self.emailVerified : emailVerified // ignore: cast_nullable_to_non_nullable
as DateTime?,image: freezed == image ? _self.image : image // ignore: cast_nullable_to_non_nullable
as String?,userType: freezed == userType ? _self.userType : userType // ignore: cast_nullable_to_non_nullable
as String?,adminRole: freezed == adminRole ? _self.adminRole : adminRole // ignore: cast_nullable_to_non_nullable
as String?,jobCount: freezed == jobCount ? _self.jobCount : jobCount // ignore: cast_nullable_to_non_nullable
as int?,aiJobApplyCount: freezed == aiJobApplyCount ? _self.aiJobApplyCount : aiJobApplyCount // ignore: cast_nullable_to_non_nullable
as int?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as DateTime?,referralCode: freezed == referralCode ? _self.referralCode : referralCode // ignore: cast_nullable_to_non_nullable
as String?,referredBy: freezed == referredBy ? _self.referredBy : referredBy // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$ApplicationStatusCounts {

 int get inReview; int get interview; int get offer; int get rejected;
/// Create a copy of ApplicationStatusCounts
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ApplicationStatusCountsCopyWith<ApplicationStatusCounts> get copyWith => _$ApplicationStatusCountsCopyWithImpl<ApplicationStatusCounts>(this as ApplicationStatusCounts, _$identity);

  /// Serializes this ApplicationStatusCounts to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ApplicationStatusCounts&&(identical(other.inReview, inReview) || other.inReview == inReview)&&(identical(other.interview, interview) || other.interview == interview)&&(identical(other.offer, offer) || other.offer == offer)&&(identical(other.rejected, rejected) || other.rejected == rejected));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,inReview,interview,offer,rejected);

@override
String toString() {
  return 'ApplicationStatusCounts(inReview: $inReview, interview: $interview, offer: $offer, rejected: $rejected)';
}


}

/// @nodoc
abstract mixin class $ApplicationStatusCountsCopyWith<$Res>  {
  factory $ApplicationStatusCountsCopyWith(ApplicationStatusCounts value, $Res Function(ApplicationStatusCounts) _then) = _$ApplicationStatusCountsCopyWithImpl;
@useResult
$Res call({
 int inReview, int interview, int offer, int rejected
});




}
/// @nodoc
class _$ApplicationStatusCountsCopyWithImpl<$Res>
    implements $ApplicationStatusCountsCopyWith<$Res> {
  _$ApplicationStatusCountsCopyWithImpl(this._self, this._then);

  final ApplicationStatusCounts _self;
  final $Res Function(ApplicationStatusCounts) _then;

/// Create a copy of ApplicationStatusCounts
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? inReview = null,Object? interview = null,Object? offer = null,Object? rejected = null,}) {
  return _then(_self.copyWith(
inReview: null == inReview ? _self.inReview : inReview // ignore: cast_nullable_to_non_nullable
as int,interview: null == interview ? _self.interview : interview // ignore: cast_nullable_to_non_nullable
as int,offer: null == offer ? _self.offer : offer // ignore: cast_nullable_to_non_nullable
as int,rejected: null == rejected ? _self.rejected : rejected // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [ApplicationStatusCounts].
extension ApplicationStatusCountsPatterns on ApplicationStatusCounts {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ApplicationStatusCounts value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ApplicationStatusCounts() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ApplicationStatusCounts value)  $default,){
final _that = this;
switch (_that) {
case _ApplicationStatusCounts():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ApplicationStatusCounts value)?  $default,){
final _that = this;
switch (_that) {
case _ApplicationStatusCounts() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int inReview,  int interview,  int offer,  int rejected)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ApplicationStatusCounts() when $default != null:
return $default(_that.inReview,_that.interview,_that.offer,_that.rejected);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int inReview,  int interview,  int offer,  int rejected)  $default,) {final _that = this;
switch (_that) {
case _ApplicationStatusCounts():
return $default(_that.inReview,_that.interview,_that.offer,_that.rejected);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int inReview,  int interview,  int offer,  int rejected)?  $default,) {final _that = this;
switch (_that) {
case _ApplicationStatusCounts() when $default != null:
return $default(_that.inReview,_that.interview,_that.offer,_that.rejected);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ApplicationStatusCounts implements ApplicationStatusCounts {
  const _ApplicationStatusCounts({required this.inReview, required this.interview, required this.offer, required this.rejected});
  factory _ApplicationStatusCounts.fromJson(Map<String, dynamic> json) => _$ApplicationStatusCountsFromJson(json);

@override final  int inReview;
@override final  int interview;
@override final  int offer;
@override final  int rejected;

/// Create a copy of ApplicationStatusCounts
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ApplicationStatusCountsCopyWith<_ApplicationStatusCounts> get copyWith => __$ApplicationStatusCountsCopyWithImpl<_ApplicationStatusCounts>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ApplicationStatusCountsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ApplicationStatusCounts&&(identical(other.inReview, inReview) || other.inReview == inReview)&&(identical(other.interview, interview) || other.interview == interview)&&(identical(other.offer, offer) || other.offer == offer)&&(identical(other.rejected, rejected) || other.rejected == rejected));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,inReview,interview,offer,rejected);

@override
String toString() {
  return 'ApplicationStatusCounts(inReview: $inReview, interview: $interview, offer: $offer, rejected: $rejected)';
}


}

/// @nodoc
abstract mixin class _$ApplicationStatusCountsCopyWith<$Res> implements $ApplicationStatusCountsCopyWith<$Res> {
  factory _$ApplicationStatusCountsCopyWith(_ApplicationStatusCounts value, $Res Function(_ApplicationStatusCounts) _then) = __$ApplicationStatusCountsCopyWithImpl;
@override @useResult
$Res call({
 int inReview, int interview, int offer, int rejected
});




}
/// @nodoc
class __$ApplicationStatusCountsCopyWithImpl<$Res>
    implements _$ApplicationStatusCountsCopyWith<$Res> {
  __$ApplicationStatusCountsCopyWithImpl(this._self, this._then);

  final _ApplicationStatusCounts _self;
  final $Res Function(_ApplicationStatusCounts) _then;

/// Create a copy of ApplicationStatusCounts
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? inReview = null,Object? interview = null,Object? offer = null,Object? rejected = null,}) {
  return _then(_ApplicationStatusCounts(
inReview: null == inReview ? _self.inReview : inReview // ignore: cast_nullable_to_non_nullable
as int,interview: null == interview ? _self.interview : interview // ignore: cast_nullable_to_non_nullable
as int,offer: null == offer ? _self.offer : offer // ignore: cast_nullable_to_non_nullable
as int,rejected: null == rejected ? _self.rejected : rejected // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ProfileCounts {

 int get totalResumes; int get totalApplications; int get savedJobs; ApplicationStatusCounts? get applicationsByStatus;
/// Create a copy of ProfileCounts
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ProfileCountsCopyWith<ProfileCounts> get copyWith => _$ProfileCountsCopyWithImpl<ProfileCounts>(this as ProfileCounts, _$identity);

  /// Serializes this ProfileCounts to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ProfileCounts&&(identical(other.totalResumes, totalResumes) || other.totalResumes == totalResumes)&&(identical(other.totalApplications, totalApplications) || other.totalApplications == totalApplications)&&(identical(other.savedJobs, savedJobs) || other.savedJobs == savedJobs)&&(identical(other.applicationsByStatus, applicationsByStatus) || other.applicationsByStatus == applicationsByStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalResumes,totalApplications,savedJobs,applicationsByStatus);

@override
String toString() {
  return 'ProfileCounts(totalResumes: $totalResumes, totalApplications: $totalApplications, savedJobs: $savedJobs, applicationsByStatus: $applicationsByStatus)';
}


}

/// @nodoc
abstract mixin class $ProfileCountsCopyWith<$Res>  {
  factory $ProfileCountsCopyWith(ProfileCounts value, $Res Function(ProfileCounts) _then) = _$ProfileCountsCopyWithImpl;
@useResult
$Res call({
 int totalResumes, int totalApplications, int savedJobs, ApplicationStatusCounts? applicationsByStatus
});


$ApplicationStatusCountsCopyWith<$Res>? get applicationsByStatus;

}
/// @nodoc
class _$ProfileCountsCopyWithImpl<$Res>
    implements $ProfileCountsCopyWith<$Res> {
  _$ProfileCountsCopyWithImpl(this._self, this._then);

  final ProfileCounts _self;
  final $Res Function(ProfileCounts) _then;

/// Create a copy of ProfileCounts
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalResumes = null,Object? totalApplications = null,Object? savedJobs = null,Object? applicationsByStatus = freezed,}) {
  return _then(_self.copyWith(
totalResumes: null == totalResumes ? _self.totalResumes : totalResumes // ignore: cast_nullable_to_non_nullable
as int,totalApplications: null == totalApplications ? _self.totalApplications : totalApplications // ignore: cast_nullable_to_non_nullable
as int,savedJobs: null == savedJobs ? _self.savedJobs : savedJobs // ignore: cast_nullable_to_non_nullable
as int,applicationsByStatus: freezed == applicationsByStatus ? _self.applicationsByStatus : applicationsByStatus // ignore: cast_nullable_to_non_nullable
as ApplicationStatusCounts?,
  ));
}
/// Create a copy of ProfileCounts
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApplicationStatusCountsCopyWith<$Res>? get applicationsByStatus {
    if (_self.applicationsByStatus == null) {
    return null;
  }

  return $ApplicationStatusCountsCopyWith<$Res>(_self.applicationsByStatus!, (value) {
    return _then(_self.copyWith(applicationsByStatus: value));
  });
}
}


/// Adds pattern-matching-related methods to [ProfileCounts].
extension ProfileCountsPatterns on ProfileCounts {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ProfileCounts value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ProfileCounts() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ProfileCounts value)  $default,){
final _that = this;
switch (_that) {
case _ProfileCounts():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ProfileCounts value)?  $default,){
final _that = this;
switch (_that) {
case _ProfileCounts() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalResumes,  int totalApplications,  int savedJobs,  ApplicationStatusCounts? applicationsByStatus)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ProfileCounts() when $default != null:
return $default(_that.totalResumes,_that.totalApplications,_that.savedJobs,_that.applicationsByStatus);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalResumes,  int totalApplications,  int savedJobs,  ApplicationStatusCounts? applicationsByStatus)  $default,) {final _that = this;
switch (_that) {
case _ProfileCounts():
return $default(_that.totalResumes,_that.totalApplications,_that.savedJobs,_that.applicationsByStatus);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalResumes,  int totalApplications,  int savedJobs,  ApplicationStatusCounts? applicationsByStatus)?  $default,) {final _that = this;
switch (_that) {
case _ProfileCounts() when $default != null:
return $default(_that.totalResumes,_that.totalApplications,_that.savedJobs,_that.applicationsByStatus);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ProfileCounts implements ProfileCounts {
  const _ProfileCounts({required this.totalResumes, required this.totalApplications, required this.savedJobs, this.applicationsByStatus});
  factory _ProfileCounts.fromJson(Map<String, dynamic> json) => _$ProfileCountsFromJson(json);

@override final  int totalResumes;
@override final  int totalApplications;
@override final  int savedJobs;
@override final  ApplicationStatusCounts? applicationsByStatus;

/// Create a copy of ProfileCounts
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ProfileCountsCopyWith<_ProfileCounts> get copyWith => __$ProfileCountsCopyWithImpl<_ProfileCounts>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ProfileCountsToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ProfileCounts&&(identical(other.totalResumes, totalResumes) || other.totalResumes == totalResumes)&&(identical(other.totalApplications, totalApplications) || other.totalApplications == totalApplications)&&(identical(other.savedJobs, savedJobs) || other.savedJobs == savedJobs)&&(identical(other.applicationsByStatus, applicationsByStatus) || other.applicationsByStatus == applicationsByStatus));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalResumes,totalApplications,savedJobs,applicationsByStatus);

@override
String toString() {
  return 'ProfileCounts(totalResumes: $totalResumes, totalApplications: $totalApplications, savedJobs: $savedJobs, applicationsByStatus: $applicationsByStatus)';
}


}

/// @nodoc
abstract mixin class _$ProfileCountsCopyWith<$Res> implements $ProfileCountsCopyWith<$Res> {
  factory _$ProfileCountsCopyWith(_ProfileCounts value, $Res Function(_ProfileCounts) _then) = __$ProfileCountsCopyWithImpl;
@override @useResult
$Res call({
 int totalResumes, int totalApplications, int savedJobs, ApplicationStatusCounts? applicationsByStatus
});


@override $ApplicationStatusCountsCopyWith<$Res>? get applicationsByStatus;

}
/// @nodoc
class __$ProfileCountsCopyWithImpl<$Res>
    implements _$ProfileCountsCopyWith<$Res> {
  __$ProfileCountsCopyWithImpl(this._self, this._then);

  final _ProfileCounts _self;
  final $Res Function(_ProfileCounts) _then;

/// Create a copy of ProfileCounts
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalResumes = null,Object? totalApplications = null,Object? savedJobs = null,Object? applicationsByStatus = freezed,}) {
  return _then(_ProfileCounts(
totalResumes: null == totalResumes ? _self.totalResumes : totalResumes // ignore: cast_nullable_to_non_nullable
as int,totalApplications: null == totalApplications ? _self.totalApplications : totalApplications // ignore: cast_nullable_to_non_nullable
as int,savedJobs: null == savedJobs ? _self.savedJobs : savedJobs // ignore: cast_nullable_to_non_nullable
as int,applicationsByStatus: freezed == applicationsByStatus ? _self.applicationsByStatus : applicationsByStatus // ignore: cast_nullable_to_non_nullable
as ApplicationStatusCounts?,
  ));
}

/// Create a copy of ProfileCounts
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ApplicationStatusCountsCopyWith<$Res>? get applicationsByStatus {
    if (_self.applicationsByStatus == null) {
    return null;
  }

  return $ApplicationStatusCountsCopyWith<$Res>(_self.applicationsByStatus!, (value) {
    return _then(_self.copyWith(applicationsByStatus: value));
  });
}
}


/// @nodoc
mixin _$CandidateProfileData {

 String? get id; String? get phone; String? get nationality; String? get gender; List<String>? get languages; int? get age; String? get profilePicture; String? get jobType; List<String>? get skills; String? get experience; String? get education; String? get degree; String? get location; String? get linkedin; bool? get onboardingCompleted; ResumeInfo? get latestResume; String? get createdAt; String? get updatedAt;
/// Create a copy of CandidateProfileData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CandidateProfileDataCopyWith<CandidateProfileData> get copyWith => _$CandidateProfileDataCopyWithImpl<CandidateProfileData>(this as CandidateProfileData, _$identity);

  /// Serializes this CandidateProfileData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CandidateProfileData&&(identical(other.id, id) || other.id == id)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.nationality, nationality) || other.nationality == nationality)&&(identical(other.gender, gender) || other.gender == gender)&&const DeepCollectionEquality().equals(other.languages, languages)&&(identical(other.age, age) || other.age == age)&&(identical(other.profilePicture, profilePicture) || other.profilePicture == profilePicture)&&(identical(other.jobType, jobType) || other.jobType == jobType)&&const DeepCollectionEquality().equals(other.skills, skills)&&(identical(other.experience, experience) || other.experience == experience)&&(identical(other.education, education) || other.education == education)&&(identical(other.degree, degree) || other.degree == degree)&&(identical(other.location, location) || other.location == location)&&(identical(other.linkedin, linkedin) || other.linkedin == linkedin)&&(identical(other.onboardingCompleted, onboardingCompleted) || other.onboardingCompleted == onboardingCompleted)&&(identical(other.latestResume, latestResume) || other.latestResume == latestResume)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,phone,nationality,gender,const DeepCollectionEquality().hash(languages),age,profilePicture,jobType,const DeepCollectionEquality().hash(skills),experience,education,degree,location,linkedin,onboardingCompleted,latestResume,createdAt,updatedAt);

@override
String toString() {
  return 'CandidateProfileData(id: $id, phone: $phone, nationality: $nationality, gender: $gender, languages: $languages, age: $age, profilePicture: $profilePicture, jobType: $jobType, skills: $skills, experience: $experience, education: $education, degree: $degree, location: $location, linkedin: $linkedin, onboardingCompleted: $onboardingCompleted, latestResume: $latestResume, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $CandidateProfileDataCopyWith<$Res>  {
  factory $CandidateProfileDataCopyWith(CandidateProfileData value, $Res Function(CandidateProfileData) _then) = _$CandidateProfileDataCopyWithImpl;
@useResult
$Res call({
 String? id, String? phone, String? nationality, String? gender, List<String>? languages, int? age, String? profilePicture, String? jobType, List<String>? skills, String? experience, String? education, String? degree, String? location, String? linkedin, bool? onboardingCompleted, ResumeInfo? latestResume, String? createdAt, String? updatedAt
});


$ResumeInfoCopyWith<$Res>? get latestResume;

}
/// @nodoc
class _$CandidateProfileDataCopyWithImpl<$Res>
    implements $CandidateProfileDataCopyWith<$Res> {
  _$CandidateProfileDataCopyWithImpl(this._self, this._then);

  final CandidateProfileData _self;
  final $Res Function(CandidateProfileData) _then;

/// Create a copy of CandidateProfileData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? phone = freezed,Object? nationality = freezed,Object? gender = freezed,Object? languages = freezed,Object? age = freezed,Object? profilePicture = freezed,Object? jobType = freezed,Object? skills = freezed,Object? experience = freezed,Object? education = freezed,Object? degree = freezed,Object? location = freezed,Object? linkedin = freezed,Object? onboardingCompleted = freezed,Object? latestResume = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,nationality: freezed == nationality ? _self.nationality : nationality // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,languages: freezed == languages ? _self.languages : languages // ignore: cast_nullable_to_non_nullable
as List<String>?,age: freezed == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int?,profilePicture: freezed == profilePicture ? _self.profilePicture : profilePicture // ignore: cast_nullable_to_non_nullable
as String?,jobType: freezed == jobType ? _self.jobType : jobType // ignore: cast_nullable_to_non_nullable
as String?,skills: freezed == skills ? _self.skills : skills // ignore: cast_nullable_to_non_nullable
as List<String>?,experience: freezed == experience ? _self.experience : experience // ignore: cast_nullable_to_non_nullable
as String?,education: freezed == education ? _self.education : education // ignore: cast_nullable_to_non_nullable
as String?,degree: freezed == degree ? _self.degree : degree // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,linkedin: freezed == linkedin ? _self.linkedin : linkedin // ignore: cast_nullable_to_non_nullable
as String?,onboardingCompleted: freezed == onboardingCompleted ? _self.onboardingCompleted : onboardingCompleted // ignore: cast_nullable_to_non_nullable
as bool?,latestResume: freezed == latestResume ? _self.latestResume : latestResume // ignore: cast_nullable_to_non_nullable
as ResumeInfo?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}
/// Create a copy of CandidateProfileData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResumeInfoCopyWith<$Res>? get latestResume {
    if (_self.latestResume == null) {
    return null;
  }

  return $ResumeInfoCopyWith<$Res>(_self.latestResume!, (value) {
    return _then(_self.copyWith(latestResume: value));
  });
}
}


/// Adds pattern-matching-related methods to [CandidateProfileData].
extension CandidateProfileDataPatterns on CandidateProfileData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _CandidateProfileData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _CandidateProfileData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _CandidateProfileData value)  $default,){
final _that = this;
switch (_that) {
case _CandidateProfileData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _CandidateProfileData value)?  $default,){
final _that = this;
switch (_that) {
case _CandidateProfileData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? phone,  String? nationality,  String? gender,  List<String>? languages,  int? age,  String? profilePicture,  String? jobType,  List<String>? skills,  String? experience,  String? education,  String? degree,  String? location,  String? linkedin,  bool? onboardingCompleted,  ResumeInfo? latestResume,  String? createdAt,  String? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _CandidateProfileData() when $default != null:
return $default(_that.id,_that.phone,_that.nationality,_that.gender,_that.languages,_that.age,_that.profilePicture,_that.jobType,_that.skills,_that.experience,_that.education,_that.degree,_that.location,_that.linkedin,_that.onboardingCompleted,_that.latestResume,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? phone,  String? nationality,  String? gender,  List<String>? languages,  int? age,  String? profilePicture,  String? jobType,  List<String>? skills,  String? experience,  String? education,  String? degree,  String? location,  String? linkedin,  bool? onboardingCompleted,  ResumeInfo? latestResume,  String? createdAt,  String? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _CandidateProfileData():
return $default(_that.id,_that.phone,_that.nationality,_that.gender,_that.languages,_that.age,_that.profilePicture,_that.jobType,_that.skills,_that.experience,_that.education,_that.degree,_that.location,_that.linkedin,_that.onboardingCompleted,_that.latestResume,_that.createdAt,_that.updatedAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? phone,  String? nationality,  String? gender,  List<String>? languages,  int? age,  String? profilePicture,  String? jobType,  List<String>? skills,  String? experience,  String? education,  String? degree,  String? location,  String? linkedin,  bool? onboardingCompleted,  ResumeInfo? latestResume,  String? createdAt,  String? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _CandidateProfileData() when $default != null:
return $default(_that.id,_that.phone,_that.nationality,_that.gender,_that.languages,_that.age,_that.profilePicture,_that.jobType,_that.skills,_that.experience,_that.education,_that.degree,_that.location,_that.linkedin,_that.onboardingCompleted,_that.latestResume,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _CandidateProfileData implements CandidateProfileData {
  const _CandidateProfileData({this.id, this.phone, this.nationality, this.gender, final  List<String>? languages, this.age, this.profilePicture, this.jobType, final  List<String>? skills, this.experience, this.education, this.degree, this.location, this.linkedin, this.onboardingCompleted, this.latestResume, this.createdAt, this.updatedAt}): _languages = languages,_skills = skills;
  factory _CandidateProfileData.fromJson(Map<String, dynamic> json) => _$CandidateProfileDataFromJson(json);

@override final  String? id;
@override final  String? phone;
@override final  String? nationality;
@override final  String? gender;
 final  List<String>? _languages;
@override List<String>? get languages {
  final value = _languages;
  if (value == null) return null;
  if (_languages is EqualUnmodifiableListView) return _languages;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  int? age;
@override final  String? profilePicture;
@override final  String? jobType;
 final  List<String>? _skills;
@override List<String>? get skills {
  final value = _skills;
  if (value == null) return null;
  if (_skills is EqualUnmodifiableListView) return _skills;
  // ignore: implicit_dynamic_type
  return EqualUnmodifiableListView(value);
}

@override final  String? experience;
@override final  String? education;
@override final  String? degree;
@override final  String? location;
@override final  String? linkedin;
@override final  bool? onboardingCompleted;
@override final  ResumeInfo? latestResume;
@override final  String? createdAt;
@override final  String? updatedAt;

/// Create a copy of CandidateProfileData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CandidateProfileDataCopyWith<_CandidateProfileData> get copyWith => __$CandidateProfileDataCopyWithImpl<_CandidateProfileData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$CandidateProfileDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _CandidateProfileData&&(identical(other.id, id) || other.id == id)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.nationality, nationality) || other.nationality == nationality)&&(identical(other.gender, gender) || other.gender == gender)&&const DeepCollectionEquality().equals(other._languages, _languages)&&(identical(other.age, age) || other.age == age)&&(identical(other.profilePicture, profilePicture) || other.profilePicture == profilePicture)&&(identical(other.jobType, jobType) || other.jobType == jobType)&&const DeepCollectionEquality().equals(other._skills, _skills)&&(identical(other.experience, experience) || other.experience == experience)&&(identical(other.education, education) || other.education == education)&&(identical(other.degree, degree) || other.degree == degree)&&(identical(other.location, location) || other.location == location)&&(identical(other.linkedin, linkedin) || other.linkedin == linkedin)&&(identical(other.onboardingCompleted, onboardingCompleted) || other.onboardingCompleted == onboardingCompleted)&&(identical(other.latestResume, latestResume) || other.latestResume == latestResume)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,phone,nationality,gender,const DeepCollectionEquality().hash(_languages),age,profilePicture,jobType,const DeepCollectionEquality().hash(_skills),experience,education,degree,location,linkedin,onboardingCompleted,latestResume,createdAt,updatedAt);

@override
String toString() {
  return 'CandidateProfileData(id: $id, phone: $phone, nationality: $nationality, gender: $gender, languages: $languages, age: $age, profilePicture: $profilePicture, jobType: $jobType, skills: $skills, experience: $experience, education: $education, degree: $degree, location: $location, linkedin: $linkedin, onboardingCompleted: $onboardingCompleted, latestResume: $latestResume, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$CandidateProfileDataCopyWith<$Res> implements $CandidateProfileDataCopyWith<$Res> {
  factory _$CandidateProfileDataCopyWith(_CandidateProfileData value, $Res Function(_CandidateProfileData) _then) = __$CandidateProfileDataCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? phone, String? nationality, String? gender, List<String>? languages, int? age, String? profilePicture, String? jobType, List<String>? skills, String? experience, String? education, String? degree, String? location, String? linkedin, bool? onboardingCompleted, ResumeInfo? latestResume, String? createdAt, String? updatedAt
});


@override $ResumeInfoCopyWith<$Res>? get latestResume;

}
/// @nodoc
class __$CandidateProfileDataCopyWithImpl<$Res>
    implements _$CandidateProfileDataCopyWith<$Res> {
  __$CandidateProfileDataCopyWithImpl(this._self, this._then);

  final _CandidateProfileData _self;
  final $Res Function(_CandidateProfileData) _then;

/// Create a copy of CandidateProfileData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? phone = freezed,Object? nationality = freezed,Object? gender = freezed,Object? languages = freezed,Object? age = freezed,Object? profilePicture = freezed,Object? jobType = freezed,Object? skills = freezed,Object? experience = freezed,Object? education = freezed,Object? degree = freezed,Object? location = freezed,Object? linkedin = freezed,Object? onboardingCompleted = freezed,Object? latestResume = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_CandidateProfileData(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,nationality: freezed == nationality ? _self.nationality : nationality // ignore: cast_nullable_to_non_nullable
as String?,gender: freezed == gender ? _self.gender : gender // ignore: cast_nullable_to_non_nullable
as String?,languages: freezed == languages ? _self._languages : languages // ignore: cast_nullable_to_non_nullable
as List<String>?,age: freezed == age ? _self.age : age // ignore: cast_nullable_to_non_nullable
as int?,profilePicture: freezed == profilePicture ? _self.profilePicture : profilePicture // ignore: cast_nullable_to_non_nullable
as String?,jobType: freezed == jobType ? _self.jobType : jobType // ignore: cast_nullable_to_non_nullable
as String?,skills: freezed == skills ? _self._skills : skills // ignore: cast_nullable_to_non_nullable
as List<String>?,experience: freezed == experience ? _self.experience : experience // ignore: cast_nullable_to_non_nullable
as String?,education: freezed == education ? _self.education : education // ignore: cast_nullable_to_non_nullable
as String?,degree: freezed == degree ? _self.degree : degree // ignore: cast_nullable_to_non_nullable
as String?,location: freezed == location ? _self.location : location // ignore: cast_nullable_to_non_nullable
as String?,linkedin: freezed == linkedin ? _self.linkedin : linkedin // ignore: cast_nullable_to_non_nullable
as String?,onboardingCompleted: freezed == onboardingCompleted ? _self.onboardingCompleted : onboardingCompleted // ignore: cast_nullable_to_non_nullable
as bool?,latestResume: freezed == latestResume ? _self.latestResume : latestResume // ignore: cast_nullable_to_non_nullable
as ResumeInfo?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

/// Create a copy of CandidateProfileData
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$ResumeInfoCopyWith<$Res>? get latestResume {
    if (_self.latestResume == null) {
    return null;
  }

  return $ResumeInfoCopyWith<$Res>(_self.latestResume!, (value) {
    return _then(_self.copyWith(latestResume: value));
  });
}
}


/// @nodoc
mixin _$OwnerProfileData {

 String? get id; String? get phone; String? get createdAt; String? get updatedAt;
/// Create a copy of OwnerProfileData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$OwnerProfileDataCopyWith<OwnerProfileData> get copyWith => _$OwnerProfileDataCopyWithImpl<OwnerProfileData>(this as OwnerProfileData, _$identity);

  /// Serializes this OwnerProfileData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is OwnerProfileData&&(identical(other.id, id) || other.id == id)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,phone,createdAt,updatedAt);

@override
String toString() {
  return 'OwnerProfileData(id: $id, phone: $phone, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $OwnerProfileDataCopyWith<$Res>  {
  factory $OwnerProfileDataCopyWith(OwnerProfileData value, $Res Function(OwnerProfileData) _then) = _$OwnerProfileDataCopyWithImpl;
@useResult
$Res call({
 String? id, String? phone, String? createdAt, String? updatedAt
});




}
/// @nodoc
class _$OwnerProfileDataCopyWithImpl<$Res>
    implements $OwnerProfileDataCopyWith<$Res> {
  _$OwnerProfileDataCopyWithImpl(this._self, this._then);

  final OwnerProfileData _self;
  final $Res Function(OwnerProfileData) _then;

/// Create a copy of OwnerProfileData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? phone = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [OwnerProfileData].
extension OwnerProfileDataPatterns on OwnerProfileData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _OwnerProfileData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _OwnerProfileData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _OwnerProfileData value)  $default,){
final _that = this;
switch (_that) {
case _OwnerProfileData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _OwnerProfileData value)?  $default,){
final _that = this;
switch (_that) {
case _OwnerProfileData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? phone,  String? createdAt,  String? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _OwnerProfileData() when $default != null:
return $default(_that.id,_that.phone,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? phone,  String? createdAt,  String? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _OwnerProfileData():
return $default(_that.id,_that.phone,_that.createdAt,_that.updatedAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? phone,  String? createdAt,  String? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _OwnerProfileData() when $default != null:
return $default(_that.id,_that.phone,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _OwnerProfileData implements OwnerProfileData {
  const _OwnerProfileData({this.id, this.phone, this.createdAt, this.updatedAt});
  factory _OwnerProfileData.fromJson(Map<String, dynamic> json) => _$OwnerProfileDataFromJson(json);

@override final  String? id;
@override final  String? phone;
@override final  String? createdAt;
@override final  String? updatedAt;

/// Create a copy of OwnerProfileData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$OwnerProfileDataCopyWith<_OwnerProfileData> get copyWith => __$OwnerProfileDataCopyWithImpl<_OwnerProfileData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$OwnerProfileDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _OwnerProfileData&&(identical(other.id, id) || other.id == id)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,phone,createdAt,updatedAt);

@override
String toString() {
  return 'OwnerProfileData(id: $id, phone: $phone, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$OwnerProfileDataCopyWith<$Res> implements $OwnerProfileDataCopyWith<$Res> {
  factory _$OwnerProfileDataCopyWith(_OwnerProfileData value, $Res Function(_OwnerProfileData) _then) = __$OwnerProfileDataCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? phone, String? createdAt, String? updatedAt
});




}
/// @nodoc
class __$OwnerProfileDataCopyWithImpl<$Res>
    implements _$OwnerProfileDataCopyWith<$Res> {
  __$OwnerProfileDataCopyWithImpl(this._self, this._then);

  final _OwnerProfileData _self;
  final $Res Function(_OwnerProfileData) _then;

/// Create a copy of OwnerProfileData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? phone = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_OwnerProfileData(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$RecruiterProfileData {

 String? get id; String? get companyName; String? get contactPersonName; String? get phone; String? get createdAt; String? get updatedAt;
/// Create a copy of RecruiterProfileData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RecruiterProfileDataCopyWith<RecruiterProfileData> get copyWith => _$RecruiterProfileDataCopyWithImpl<RecruiterProfileData>(this as RecruiterProfileData, _$identity);

  /// Serializes this RecruiterProfileData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RecruiterProfileData&&(identical(other.id, id) || other.id == id)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.contactPersonName, contactPersonName) || other.contactPersonName == contactPersonName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,companyName,contactPersonName,phone,createdAt,updatedAt);

@override
String toString() {
  return 'RecruiterProfileData(id: $id, companyName: $companyName, contactPersonName: $contactPersonName, phone: $phone, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class $RecruiterProfileDataCopyWith<$Res>  {
  factory $RecruiterProfileDataCopyWith(RecruiterProfileData value, $Res Function(RecruiterProfileData) _then) = _$RecruiterProfileDataCopyWithImpl;
@useResult
$Res call({
 String? id, String? companyName, String? contactPersonName, String? phone, String? createdAt, String? updatedAt
});




}
/// @nodoc
class _$RecruiterProfileDataCopyWithImpl<$Res>
    implements $RecruiterProfileDataCopyWith<$Res> {
  _$RecruiterProfileDataCopyWithImpl(this._self, this._then);

  final RecruiterProfileData _self;
  final $Res Function(RecruiterProfileData) _then;

/// Create a copy of RecruiterProfileData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = freezed,Object? companyName = freezed,Object? contactPersonName = freezed,Object? phone = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_self.copyWith(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,companyName: freezed == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String?,contactPersonName: freezed == contactPersonName ? _self.contactPersonName : contactPersonName // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [RecruiterProfileData].
extension RecruiterProfileDataPatterns on RecruiterProfileData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RecruiterProfileData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RecruiterProfileData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RecruiterProfileData value)  $default,){
final _that = this;
switch (_that) {
case _RecruiterProfileData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RecruiterProfileData value)?  $default,){
final _that = this;
switch (_that) {
case _RecruiterProfileData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? id,  String? companyName,  String? contactPersonName,  String? phone,  String? createdAt,  String? updatedAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RecruiterProfileData() when $default != null:
return $default(_that.id,_that.companyName,_that.contactPersonName,_that.phone,_that.createdAt,_that.updatedAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? id,  String? companyName,  String? contactPersonName,  String? phone,  String? createdAt,  String? updatedAt)  $default,) {final _that = this;
switch (_that) {
case _RecruiterProfileData():
return $default(_that.id,_that.companyName,_that.contactPersonName,_that.phone,_that.createdAt,_that.updatedAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? id,  String? companyName,  String? contactPersonName,  String? phone,  String? createdAt,  String? updatedAt)?  $default,) {final _that = this;
switch (_that) {
case _RecruiterProfileData() when $default != null:
return $default(_that.id,_that.companyName,_that.contactPersonName,_that.phone,_that.createdAt,_that.updatedAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _RecruiterProfileData implements RecruiterProfileData {
  const _RecruiterProfileData({this.id, this.companyName, this.contactPersonName, this.phone, this.createdAt, this.updatedAt});
  factory _RecruiterProfileData.fromJson(Map<String, dynamic> json) => _$RecruiterProfileDataFromJson(json);

@override final  String? id;
@override final  String? companyName;
@override final  String? contactPersonName;
@override final  String? phone;
@override final  String? createdAt;
@override final  String? updatedAt;

/// Create a copy of RecruiterProfileData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RecruiterProfileDataCopyWith<_RecruiterProfileData> get copyWith => __$RecruiterProfileDataCopyWithImpl<_RecruiterProfileData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$RecruiterProfileDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RecruiterProfileData&&(identical(other.id, id) || other.id == id)&&(identical(other.companyName, companyName) || other.companyName == companyName)&&(identical(other.contactPersonName, contactPersonName) || other.contactPersonName == contactPersonName)&&(identical(other.phone, phone) || other.phone == phone)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt)&&(identical(other.updatedAt, updatedAt) || other.updatedAt == updatedAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,companyName,contactPersonName,phone,createdAt,updatedAt);

@override
String toString() {
  return 'RecruiterProfileData(id: $id, companyName: $companyName, contactPersonName: $contactPersonName, phone: $phone, createdAt: $createdAt, updatedAt: $updatedAt)';
}


}

/// @nodoc
abstract mixin class _$RecruiterProfileDataCopyWith<$Res> implements $RecruiterProfileDataCopyWith<$Res> {
  factory _$RecruiterProfileDataCopyWith(_RecruiterProfileData value, $Res Function(_RecruiterProfileData) _then) = __$RecruiterProfileDataCopyWithImpl;
@override @useResult
$Res call({
 String? id, String? companyName, String? contactPersonName, String? phone, String? createdAt, String? updatedAt
});




}
/// @nodoc
class __$RecruiterProfileDataCopyWithImpl<$Res>
    implements _$RecruiterProfileDataCopyWith<$Res> {
  __$RecruiterProfileDataCopyWithImpl(this._self, this._then);

  final _RecruiterProfileData _self;
  final $Res Function(_RecruiterProfileData) _then;

/// Create a copy of RecruiterProfileData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = freezed,Object? companyName = freezed,Object? contactPersonName = freezed,Object? phone = freezed,Object? createdAt = freezed,Object? updatedAt = freezed,}) {
  return _then(_RecruiterProfileData(
id: freezed == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String?,companyName: freezed == companyName ? _self.companyName : companyName // ignore: cast_nullable_to_non_nullable
as String?,contactPersonName: freezed == contactPersonName ? _self.contactPersonName : contactPersonName // ignore: cast_nullable_to_non_nullable
as String?,phone: freezed == phone ? _self.phone : phone // ignore: cast_nullable_to_non_nullable
as String?,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as String?,updatedAt: freezed == updatedAt ? _self.updatedAt : updatedAt // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$SubscriptionData {

 String? get plan; String? get status; DateTime? get startDate; DateTime? get endDate; bool? get autoRenew;
/// Create a copy of SubscriptionData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SubscriptionDataCopyWith<SubscriptionData> get copyWith => _$SubscriptionDataCopyWithImpl<SubscriptionData>(this as SubscriptionData, _$identity);

  /// Serializes this SubscriptionData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SubscriptionData&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.status, status) || other.status == status)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.autoRenew, autoRenew) || other.autoRenew == autoRenew));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,plan,status,startDate,endDate,autoRenew);

@override
String toString() {
  return 'SubscriptionData(plan: $plan, status: $status, startDate: $startDate, endDate: $endDate, autoRenew: $autoRenew)';
}


}

/// @nodoc
abstract mixin class $SubscriptionDataCopyWith<$Res>  {
  factory $SubscriptionDataCopyWith(SubscriptionData value, $Res Function(SubscriptionData) _then) = _$SubscriptionDataCopyWithImpl;
@useResult
$Res call({
 String? plan, String? status, DateTime? startDate, DateTime? endDate, bool? autoRenew
});




}
/// @nodoc
class _$SubscriptionDataCopyWithImpl<$Res>
    implements $SubscriptionDataCopyWith<$Res> {
  _$SubscriptionDataCopyWithImpl(this._self, this._then);

  final SubscriptionData _self;
  final $Res Function(SubscriptionData) _then;

/// Create a copy of SubscriptionData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? plan = freezed,Object? status = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? autoRenew = freezed,}) {
  return _then(_self.copyWith(
plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,autoRenew: freezed == autoRenew ? _self.autoRenew : autoRenew // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}

}


/// Adds pattern-matching-related methods to [SubscriptionData].
extension SubscriptionDataPatterns on SubscriptionData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SubscriptionData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SubscriptionData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SubscriptionData value)  $default,){
final _that = this;
switch (_that) {
case _SubscriptionData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SubscriptionData value)?  $default,){
final _that = this;
switch (_that) {
case _SubscriptionData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? plan,  String? status,  DateTime? startDate,  DateTime? endDate,  bool? autoRenew)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SubscriptionData() when $default != null:
return $default(_that.plan,_that.status,_that.startDate,_that.endDate,_that.autoRenew);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? plan,  String? status,  DateTime? startDate,  DateTime? endDate,  bool? autoRenew)  $default,) {final _that = this;
switch (_that) {
case _SubscriptionData():
return $default(_that.plan,_that.status,_that.startDate,_that.endDate,_that.autoRenew);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? plan,  String? status,  DateTime? startDate,  DateTime? endDate,  bool? autoRenew)?  $default,) {final _that = this;
switch (_that) {
case _SubscriptionData() when $default != null:
return $default(_that.plan,_that.status,_that.startDate,_that.endDate,_that.autoRenew);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SubscriptionData implements SubscriptionData {
  const _SubscriptionData({this.plan, this.status, this.startDate, this.endDate, this.autoRenew});
  factory _SubscriptionData.fromJson(Map<String, dynamic> json) => _$SubscriptionDataFromJson(json);

@override final  String? plan;
@override final  String? status;
@override final  DateTime? startDate;
@override final  DateTime? endDate;
@override final  bool? autoRenew;

/// Create a copy of SubscriptionData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SubscriptionDataCopyWith<_SubscriptionData> get copyWith => __$SubscriptionDataCopyWithImpl<_SubscriptionData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SubscriptionDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SubscriptionData&&(identical(other.plan, plan) || other.plan == plan)&&(identical(other.status, status) || other.status == status)&&(identical(other.startDate, startDate) || other.startDate == startDate)&&(identical(other.endDate, endDate) || other.endDate == endDate)&&(identical(other.autoRenew, autoRenew) || other.autoRenew == autoRenew));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,plan,status,startDate,endDate,autoRenew);

@override
String toString() {
  return 'SubscriptionData(plan: $plan, status: $status, startDate: $startDate, endDate: $endDate, autoRenew: $autoRenew)';
}


}

/// @nodoc
abstract mixin class _$SubscriptionDataCopyWith<$Res> implements $SubscriptionDataCopyWith<$Res> {
  factory _$SubscriptionDataCopyWith(_SubscriptionData value, $Res Function(_SubscriptionData) _then) = __$SubscriptionDataCopyWithImpl;
@override @useResult
$Res call({
 String? plan, String? status, DateTime? startDate, DateTime? endDate, bool? autoRenew
});




}
/// @nodoc
class __$SubscriptionDataCopyWithImpl<$Res>
    implements _$SubscriptionDataCopyWith<$Res> {
  __$SubscriptionDataCopyWithImpl(this._self, this._then);

  final _SubscriptionData _self;
  final $Res Function(_SubscriptionData) _then;

/// Create a copy of SubscriptionData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? plan = freezed,Object? status = freezed,Object? startDate = freezed,Object? endDate = freezed,Object? autoRenew = freezed,}) {
  return _then(_SubscriptionData(
plan: freezed == plan ? _self.plan : plan // ignore: cast_nullable_to_non_nullable
as String?,status: freezed == status ? _self.status : status // ignore: cast_nullable_to_non_nullable
as String?,startDate: freezed == startDate ? _self.startDate : startDate // ignore: cast_nullable_to_non_nullable
as DateTime?,endDate: freezed == endDate ? _self.endDate : endDate // ignore: cast_nullable_to_non_nullable
as DateTime?,autoRenew: freezed == autoRenew ? _self.autoRenew : autoRenew // ignore: cast_nullable_to_non_nullable
as bool?,
  ));
}


}


/// @nodoc
mixin _$PaymentStatsData {

 int get totalPayments; double get totalAmountSpent; String? get currency;
/// Create a copy of PaymentStatsData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$PaymentStatsDataCopyWith<PaymentStatsData> get copyWith => _$PaymentStatsDataCopyWithImpl<PaymentStatsData>(this as PaymentStatsData, _$identity);

  /// Serializes this PaymentStatsData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is PaymentStatsData&&(identical(other.totalPayments, totalPayments) || other.totalPayments == totalPayments)&&(identical(other.totalAmountSpent, totalAmountSpent) || other.totalAmountSpent == totalAmountSpent)&&(identical(other.currency, currency) || other.currency == currency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalPayments,totalAmountSpent,currency);

@override
String toString() {
  return 'PaymentStatsData(totalPayments: $totalPayments, totalAmountSpent: $totalAmountSpent, currency: $currency)';
}


}

/// @nodoc
abstract mixin class $PaymentStatsDataCopyWith<$Res>  {
  factory $PaymentStatsDataCopyWith(PaymentStatsData value, $Res Function(PaymentStatsData) _then) = _$PaymentStatsDataCopyWithImpl;
@useResult
$Res call({
 int totalPayments, double totalAmountSpent, String? currency
});




}
/// @nodoc
class _$PaymentStatsDataCopyWithImpl<$Res>
    implements $PaymentStatsDataCopyWith<$Res> {
  _$PaymentStatsDataCopyWithImpl(this._self, this._then);

  final PaymentStatsData _self;
  final $Res Function(PaymentStatsData) _then;

/// Create a copy of PaymentStatsData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalPayments = null,Object? totalAmountSpent = null,Object? currency = freezed,}) {
  return _then(_self.copyWith(
totalPayments: null == totalPayments ? _self.totalPayments : totalPayments // ignore: cast_nullable_to_non_nullable
as int,totalAmountSpent: null == totalAmountSpent ? _self.totalAmountSpent : totalAmountSpent // ignore: cast_nullable_to_non_nullable
as double,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}

}


/// Adds pattern-matching-related methods to [PaymentStatsData].
extension PaymentStatsDataPatterns on PaymentStatsData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _PaymentStatsData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _PaymentStatsData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _PaymentStatsData value)  $default,){
final _that = this;
switch (_that) {
case _PaymentStatsData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _PaymentStatsData value)?  $default,){
final _that = this;
switch (_that) {
case _PaymentStatsData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalPayments,  double totalAmountSpent,  String? currency)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _PaymentStatsData() when $default != null:
return $default(_that.totalPayments,_that.totalAmountSpent,_that.currency);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalPayments,  double totalAmountSpent,  String? currency)  $default,) {final _that = this;
switch (_that) {
case _PaymentStatsData():
return $default(_that.totalPayments,_that.totalAmountSpent,_that.currency);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalPayments,  double totalAmountSpent,  String? currency)?  $default,) {final _that = this;
switch (_that) {
case _PaymentStatsData() when $default != null:
return $default(_that.totalPayments,_that.totalAmountSpent,_that.currency);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _PaymentStatsData implements PaymentStatsData {
  const _PaymentStatsData({required this.totalPayments, required this.totalAmountSpent, this.currency});
  factory _PaymentStatsData.fromJson(Map<String, dynamic> json) => _$PaymentStatsDataFromJson(json);

@override final  int totalPayments;
@override final  double totalAmountSpent;
@override final  String? currency;

/// Create a copy of PaymentStatsData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$PaymentStatsDataCopyWith<_PaymentStatsData> get copyWith => __$PaymentStatsDataCopyWithImpl<_PaymentStatsData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$PaymentStatsDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _PaymentStatsData&&(identical(other.totalPayments, totalPayments) || other.totalPayments == totalPayments)&&(identical(other.totalAmountSpent, totalAmountSpent) || other.totalAmountSpent == totalAmountSpent)&&(identical(other.currency, currency) || other.currency == currency));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalPayments,totalAmountSpent,currency);

@override
String toString() {
  return 'PaymentStatsData(totalPayments: $totalPayments, totalAmountSpent: $totalAmountSpent, currency: $currency)';
}


}

/// @nodoc
abstract mixin class _$PaymentStatsDataCopyWith<$Res> implements $PaymentStatsDataCopyWith<$Res> {
  factory _$PaymentStatsDataCopyWith(_PaymentStatsData value, $Res Function(_PaymentStatsData) _then) = __$PaymentStatsDataCopyWithImpl;
@override @useResult
$Res call({
 int totalPayments, double totalAmountSpent, String? currency
});




}
/// @nodoc
class __$PaymentStatsDataCopyWithImpl<$Res>
    implements _$PaymentStatsDataCopyWith<$Res> {
  __$PaymentStatsDataCopyWithImpl(this._self, this._then);

  final _PaymentStatsData _self;
  final $Res Function(_PaymentStatsData) _then;

/// Create a copy of PaymentStatsData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalPayments = null,Object? totalAmountSpent = null,Object? currency = freezed,}) {
  return _then(_PaymentStatsData(
totalPayments: null == totalPayments ? _self.totalPayments : totalPayments // ignore: cast_nullable_to_non_nullable
as int,totalAmountSpent: null == totalAmountSpent ? _self.totalAmountSpent : totalAmountSpent // ignore: cast_nullable_to_non_nullable
as double,currency: freezed == currency ? _self.currency : currency // ignore: cast_nullable_to_non_nullable
as String?,
  ));
}


}


/// @nodoc
mixin _$JobStatsData {

 int get totalJobs; int get activeJobs; int get applicationsReceived;
/// Create a copy of JobStatsData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$JobStatsDataCopyWith<JobStatsData> get copyWith => _$JobStatsDataCopyWithImpl<JobStatsData>(this as JobStatsData, _$identity);

  /// Serializes this JobStatsData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is JobStatsData&&(identical(other.totalJobs, totalJobs) || other.totalJobs == totalJobs)&&(identical(other.activeJobs, activeJobs) || other.activeJobs == activeJobs)&&(identical(other.applicationsReceived, applicationsReceived) || other.applicationsReceived == applicationsReceived));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalJobs,activeJobs,applicationsReceived);

@override
String toString() {
  return 'JobStatsData(totalJobs: $totalJobs, activeJobs: $activeJobs, applicationsReceived: $applicationsReceived)';
}


}

/// @nodoc
abstract mixin class $JobStatsDataCopyWith<$Res>  {
  factory $JobStatsDataCopyWith(JobStatsData value, $Res Function(JobStatsData) _then) = _$JobStatsDataCopyWithImpl;
@useResult
$Res call({
 int totalJobs, int activeJobs, int applicationsReceived
});




}
/// @nodoc
class _$JobStatsDataCopyWithImpl<$Res>
    implements $JobStatsDataCopyWith<$Res> {
  _$JobStatsDataCopyWithImpl(this._self, this._then);

  final JobStatsData _self;
  final $Res Function(JobStatsData) _then;

/// Create a copy of JobStatsData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? totalJobs = null,Object? activeJobs = null,Object? applicationsReceived = null,}) {
  return _then(_self.copyWith(
totalJobs: null == totalJobs ? _self.totalJobs : totalJobs // ignore: cast_nullable_to_non_nullable
as int,activeJobs: null == activeJobs ? _self.activeJobs : activeJobs // ignore: cast_nullable_to_non_nullable
as int,applicationsReceived: null == applicationsReceived ? _self.applicationsReceived : applicationsReceived // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [JobStatsData].
extension JobStatsDataPatterns on JobStatsData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _JobStatsData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _JobStatsData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _JobStatsData value)  $default,){
final _that = this;
switch (_that) {
case _JobStatsData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _JobStatsData value)?  $default,){
final _that = this;
switch (_that) {
case _JobStatsData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int totalJobs,  int activeJobs,  int applicationsReceived)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _JobStatsData() when $default != null:
return $default(_that.totalJobs,_that.activeJobs,_that.applicationsReceived);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int totalJobs,  int activeJobs,  int applicationsReceived)  $default,) {final _that = this;
switch (_that) {
case _JobStatsData():
return $default(_that.totalJobs,_that.activeJobs,_that.applicationsReceived);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int totalJobs,  int activeJobs,  int applicationsReceived)?  $default,) {final _that = this;
switch (_that) {
case _JobStatsData() when $default != null:
return $default(_that.totalJobs,_that.activeJobs,_that.applicationsReceived);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _JobStatsData implements JobStatsData {
  const _JobStatsData({required this.totalJobs, required this.activeJobs, required this.applicationsReceived});
  factory _JobStatsData.fromJson(Map<String, dynamic> json) => _$JobStatsDataFromJson(json);

@override final  int totalJobs;
@override final  int activeJobs;
@override final  int applicationsReceived;

/// Create a copy of JobStatsData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$JobStatsDataCopyWith<_JobStatsData> get copyWith => __$JobStatsDataCopyWithImpl<_JobStatsData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$JobStatsDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _JobStatsData&&(identical(other.totalJobs, totalJobs) || other.totalJobs == totalJobs)&&(identical(other.activeJobs, activeJobs) || other.activeJobs == activeJobs)&&(identical(other.applicationsReceived, applicationsReceived) || other.applicationsReceived == applicationsReceived));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,totalJobs,activeJobs,applicationsReceived);

@override
String toString() {
  return 'JobStatsData(totalJobs: $totalJobs, activeJobs: $activeJobs, applicationsReceived: $applicationsReceived)';
}


}

/// @nodoc
abstract mixin class _$JobStatsDataCopyWith<$Res> implements $JobStatsDataCopyWith<$Res> {
  factory _$JobStatsDataCopyWith(_JobStatsData value, $Res Function(_JobStatsData) _then) = __$JobStatsDataCopyWithImpl;
@override @useResult
$Res call({
 int totalJobs, int activeJobs, int applicationsReceived
});




}
/// @nodoc
class __$JobStatsDataCopyWithImpl<$Res>
    implements _$JobStatsDataCopyWith<$Res> {
  __$JobStatsDataCopyWithImpl(this._self, this._then);

  final _JobStatsData _self;
  final $Res Function(_JobStatsData) _then;

/// Create a copy of JobStatsData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? totalJobs = null,Object? activeJobs = null,Object? applicationsReceived = null,}) {
  return _then(_JobStatsData(
totalJobs: null == totalJobs ? _self.totalJobs : totalJobs // ignore: cast_nullable_to_non_nullable
as int,activeJobs: null == activeJobs ? _self.activeJobs : activeJobs // ignore: cast_nullable_to_non_nullable
as int,applicationsReceived: null == applicationsReceived ? _self.applicationsReceived : applicationsReceived // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$ConnectedAccountData {

 String get provider; DateTime? get createdAt;
/// Create a copy of ConnectedAccountData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ConnectedAccountDataCopyWith<ConnectedAccountData> get copyWith => _$ConnectedAccountDataCopyWithImpl<ConnectedAccountData>(this as ConnectedAccountData, _$identity);

  /// Serializes this ConnectedAccountData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ConnectedAccountData&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,provider,createdAt);

@override
String toString() {
  return 'ConnectedAccountData(provider: $provider, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class $ConnectedAccountDataCopyWith<$Res>  {
  factory $ConnectedAccountDataCopyWith(ConnectedAccountData value, $Res Function(ConnectedAccountData) _then) = _$ConnectedAccountDataCopyWithImpl;
@useResult
$Res call({
 String provider, DateTime? createdAt
});




}
/// @nodoc
class _$ConnectedAccountDataCopyWithImpl<$Res>
    implements $ConnectedAccountDataCopyWith<$Res> {
  _$ConnectedAccountDataCopyWithImpl(this._self, this._then);

  final ConnectedAccountData _self;
  final $Res Function(ConnectedAccountData) _then;

/// Create a copy of ConnectedAccountData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? provider = null,Object? createdAt = freezed,}) {
  return _then(_self.copyWith(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [ConnectedAccountData].
extension ConnectedAccountDataPatterns on ConnectedAccountData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ConnectedAccountData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ConnectedAccountData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ConnectedAccountData value)  $default,){
final _that = this;
switch (_that) {
case _ConnectedAccountData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ConnectedAccountData value)?  $default,){
final _that = this;
switch (_that) {
case _ConnectedAccountData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String provider,  DateTime? createdAt)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ConnectedAccountData() when $default != null:
return $default(_that.provider,_that.createdAt);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String provider,  DateTime? createdAt)  $default,) {final _that = this;
switch (_that) {
case _ConnectedAccountData():
return $default(_that.provider,_that.createdAt);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String provider,  DateTime? createdAt)?  $default,) {final _that = this;
switch (_that) {
case _ConnectedAccountData() when $default != null:
return $default(_that.provider,_that.createdAt);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _ConnectedAccountData implements ConnectedAccountData {
  const _ConnectedAccountData({required this.provider, this.createdAt});
  factory _ConnectedAccountData.fromJson(Map<String, dynamic> json) => _$ConnectedAccountDataFromJson(json);

@override final  String provider;
@override final  DateTime? createdAt;

/// Create a copy of ConnectedAccountData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ConnectedAccountDataCopyWith<_ConnectedAccountData> get copyWith => __$ConnectedAccountDataCopyWithImpl<_ConnectedAccountData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$ConnectedAccountDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ConnectedAccountData&&(identical(other.provider, provider) || other.provider == provider)&&(identical(other.createdAt, createdAt) || other.createdAt == createdAt));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,provider,createdAt);

@override
String toString() {
  return 'ConnectedAccountData(provider: $provider, createdAt: $createdAt)';
}


}

/// @nodoc
abstract mixin class _$ConnectedAccountDataCopyWith<$Res> implements $ConnectedAccountDataCopyWith<$Res> {
  factory _$ConnectedAccountDataCopyWith(_ConnectedAccountData value, $Res Function(_ConnectedAccountData) _then) = __$ConnectedAccountDataCopyWithImpl;
@override @useResult
$Res call({
 String provider, DateTime? createdAt
});




}
/// @nodoc
class __$ConnectedAccountDataCopyWithImpl<$Res>
    implements _$ConnectedAccountDataCopyWith<$Res> {
  __$ConnectedAccountDataCopyWithImpl(this._self, this._then);

  final _ConnectedAccountData _self;
  final $Res Function(_ConnectedAccountData) _then;

/// Create a copy of ConnectedAccountData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? provider = null,Object? createdAt = freezed,}) {
  return _then(_ConnectedAccountData(
provider: null == provider ? _self.provider : provider // ignore: cast_nullable_to_non_nullable
as String,createdAt: freezed == createdAt ? _self.createdAt : createdAt // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}


/// @nodoc
mixin _$AiResumeStatsData {

 int get total; int get draft; int get inProgress; int get completed;
/// Create a copy of AiResumeStatsData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$AiResumeStatsDataCopyWith<AiResumeStatsData> get copyWith => _$AiResumeStatsDataCopyWithImpl<AiResumeStatsData>(this as AiResumeStatsData, _$identity);

  /// Serializes this AiResumeStatsData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is AiResumeStatsData&&(identical(other.total, total) || other.total == total)&&(identical(other.draft, draft) || other.draft == draft)&&(identical(other.inProgress, inProgress) || other.inProgress == inProgress)&&(identical(other.completed, completed) || other.completed == completed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,total,draft,inProgress,completed);

@override
String toString() {
  return 'AiResumeStatsData(total: $total, draft: $draft, inProgress: $inProgress, completed: $completed)';
}


}

/// @nodoc
abstract mixin class $AiResumeStatsDataCopyWith<$Res>  {
  factory $AiResumeStatsDataCopyWith(AiResumeStatsData value, $Res Function(AiResumeStatsData) _then) = _$AiResumeStatsDataCopyWithImpl;
@useResult
$Res call({
 int total, int draft, int inProgress, int completed
});




}
/// @nodoc
class _$AiResumeStatsDataCopyWithImpl<$Res>
    implements $AiResumeStatsDataCopyWith<$Res> {
  _$AiResumeStatsDataCopyWithImpl(this._self, this._then);

  final AiResumeStatsData _self;
  final $Res Function(AiResumeStatsData) _then;

/// Create a copy of AiResumeStatsData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? total = null,Object? draft = null,Object? inProgress = null,Object? completed = null,}) {
  return _then(_self.copyWith(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,draft: null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as int,inProgress: null == inProgress ? _self.inProgress : inProgress // ignore: cast_nullable_to_non_nullable
as int,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as int,
  ));
}

}


/// Adds pattern-matching-related methods to [AiResumeStatsData].
extension AiResumeStatsDataPatterns on AiResumeStatsData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _AiResumeStatsData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _AiResumeStatsData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _AiResumeStatsData value)  $default,){
final _that = this;
switch (_that) {
case _AiResumeStatsData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _AiResumeStatsData value)?  $default,){
final _that = this;
switch (_that) {
case _AiResumeStatsData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int total,  int draft,  int inProgress,  int completed)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _AiResumeStatsData() when $default != null:
return $default(_that.total,_that.draft,_that.inProgress,_that.completed);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int total,  int draft,  int inProgress,  int completed)  $default,) {final _that = this;
switch (_that) {
case _AiResumeStatsData():
return $default(_that.total,_that.draft,_that.inProgress,_that.completed);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int total,  int draft,  int inProgress,  int completed)?  $default,) {final _that = this;
switch (_that) {
case _AiResumeStatsData() when $default != null:
return $default(_that.total,_that.draft,_that.inProgress,_that.completed);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _AiResumeStatsData implements AiResumeStatsData {
  const _AiResumeStatsData({required this.total, required this.draft, required this.inProgress, required this.completed});
  factory _AiResumeStatsData.fromJson(Map<String, dynamic> json) => _$AiResumeStatsDataFromJson(json);

@override final  int total;
@override final  int draft;
@override final  int inProgress;
@override final  int completed;

/// Create a copy of AiResumeStatsData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$AiResumeStatsDataCopyWith<_AiResumeStatsData> get copyWith => __$AiResumeStatsDataCopyWithImpl<_AiResumeStatsData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$AiResumeStatsDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _AiResumeStatsData&&(identical(other.total, total) || other.total == total)&&(identical(other.draft, draft) || other.draft == draft)&&(identical(other.inProgress, inProgress) || other.inProgress == inProgress)&&(identical(other.completed, completed) || other.completed == completed));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,total,draft,inProgress,completed);

@override
String toString() {
  return 'AiResumeStatsData(total: $total, draft: $draft, inProgress: $inProgress, completed: $completed)';
}


}

/// @nodoc
abstract mixin class _$AiResumeStatsDataCopyWith<$Res> implements $AiResumeStatsDataCopyWith<$Res> {
  factory _$AiResumeStatsDataCopyWith(_AiResumeStatsData value, $Res Function(_AiResumeStatsData) _then) = __$AiResumeStatsDataCopyWithImpl;
@override @useResult
$Res call({
 int total, int draft, int inProgress, int completed
});




}
/// @nodoc
class __$AiResumeStatsDataCopyWithImpl<$Res>
    implements _$AiResumeStatsDataCopyWith<$Res> {
  __$AiResumeStatsDataCopyWithImpl(this._self, this._then);

  final _AiResumeStatsData _self;
  final $Res Function(_AiResumeStatsData) _then;

/// Create a copy of AiResumeStatsData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? total = null,Object? draft = null,Object? inProgress = null,Object? completed = null,}) {
  return _then(_AiResumeStatsData(
total: null == total ? _self.total : total // ignore: cast_nullable_to_non_nullable
as int,draft: null == draft ? _self.draft : draft // ignore: cast_nullable_to_non_nullable
as int,inProgress: null == inProgress ? _self.inProgress : inProgress // ignore: cast_nullable_to_non_nullable
as int,completed: null == completed ? _self.completed : completed // ignore: cast_nullable_to_non_nullable
as int,
  ));
}


}


/// @nodoc
mixin _$SecurityData {

 int get activeSessions; bool get hasResetToken; DateTime? get resetTokenExpiry;
/// Create a copy of SecurityData
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$SecurityDataCopyWith<SecurityData> get copyWith => _$SecurityDataCopyWithImpl<SecurityData>(this as SecurityData, _$identity);

  /// Serializes this SecurityData to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is SecurityData&&(identical(other.activeSessions, activeSessions) || other.activeSessions == activeSessions)&&(identical(other.hasResetToken, hasResetToken) || other.hasResetToken == hasResetToken)&&(identical(other.resetTokenExpiry, resetTokenExpiry) || other.resetTokenExpiry == resetTokenExpiry));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,activeSessions,hasResetToken,resetTokenExpiry);

@override
String toString() {
  return 'SecurityData(activeSessions: $activeSessions, hasResetToken: $hasResetToken, resetTokenExpiry: $resetTokenExpiry)';
}


}

/// @nodoc
abstract mixin class $SecurityDataCopyWith<$Res>  {
  factory $SecurityDataCopyWith(SecurityData value, $Res Function(SecurityData) _then) = _$SecurityDataCopyWithImpl;
@useResult
$Res call({
 int activeSessions, bool hasResetToken, DateTime? resetTokenExpiry
});




}
/// @nodoc
class _$SecurityDataCopyWithImpl<$Res>
    implements $SecurityDataCopyWith<$Res> {
  _$SecurityDataCopyWithImpl(this._self, this._then);

  final SecurityData _self;
  final $Res Function(SecurityData) _then;

/// Create a copy of SecurityData
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? activeSessions = null,Object? hasResetToken = null,Object? resetTokenExpiry = freezed,}) {
  return _then(_self.copyWith(
activeSessions: null == activeSessions ? _self.activeSessions : activeSessions // ignore: cast_nullable_to_non_nullable
as int,hasResetToken: null == hasResetToken ? _self.hasResetToken : hasResetToken // ignore: cast_nullable_to_non_nullable
as bool,resetTokenExpiry: freezed == resetTokenExpiry ? _self.resetTokenExpiry : resetTokenExpiry // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}

}


/// Adds pattern-matching-related methods to [SecurityData].
extension SecurityDataPatterns on SecurityData {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _SecurityData value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _SecurityData() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _SecurityData value)  $default,){
final _that = this;
switch (_that) {
case _SecurityData():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _SecurityData value)?  $default,){
final _that = this;
switch (_that) {
case _SecurityData() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int activeSessions,  bool hasResetToken,  DateTime? resetTokenExpiry)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _SecurityData() when $default != null:
return $default(_that.activeSessions,_that.hasResetToken,_that.resetTokenExpiry);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int activeSessions,  bool hasResetToken,  DateTime? resetTokenExpiry)  $default,) {final _that = this;
switch (_that) {
case _SecurityData():
return $default(_that.activeSessions,_that.hasResetToken,_that.resetTokenExpiry);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int activeSessions,  bool hasResetToken,  DateTime? resetTokenExpiry)?  $default,) {final _that = this;
switch (_that) {
case _SecurityData() when $default != null:
return $default(_that.activeSessions,_that.hasResetToken,_that.resetTokenExpiry);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _SecurityData implements SecurityData {
  const _SecurityData({required this.activeSessions, required this.hasResetToken, this.resetTokenExpiry});
  factory _SecurityData.fromJson(Map<String, dynamic> json) => _$SecurityDataFromJson(json);

@override final  int activeSessions;
@override final  bool hasResetToken;
@override final  DateTime? resetTokenExpiry;

/// Create a copy of SecurityData
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$SecurityDataCopyWith<_SecurityData> get copyWith => __$SecurityDataCopyWithImpl<_SecurityData>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$SecurityDataToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _SecurityData&&(identical(other.activeSessions, activeSessions) || other.activeSessions == activeSessions)&&(identical(other.hasResetToken, hasResetToken) || other.hasResetToken == hasResetToken)&&(identical(other.resetTokenExpiry, resetTokenExpiry) || other.resetTokenExpiry == resetTokenExpiry));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,activeSessions,hasResetToken,resetTokenExpiry);

@override
String toString() {
  return 'SecurityData(activeSessions: $activeSessions, hasResetToken: $hasResetToken, resetTokenExpiry: $resetTokenExpiry)';
}


}

/// @nodoc
abstract mixin class _$SecurityDataCopyWith<$Res> implements $SecurityDataCopyWith<$Res> {
  factory _$SecurityDataCopyWith(_SecurityData value, $Res Function(_SecurityData) _then) = __$SecurityDataCopyWithImpl;
@override @useResult
$Res call({
 int activeSessions, bool hasResetToken, DateTime? resetTokenExpiry
});




}
/// @nodoc
class __$SecurityDataCopyWithImpl<$Res>
    implements _$SecurityDataCopyWith<$Res> {
  __$SecurityDataCopyWithImpl(this._self, this._then);

  final _SecurityData _self;
  final $Res Function(_SecurityData) _then;

/// Create a copy of SecurityData
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? activeSessions = null,Object? hasResetToken = null,Object? resetTokenExpiry = freezed,}) {
  return _then(_SecurityData(
activeSessions: null == activeSessions ? _self.activeSessions : activeSessions // ignore: cast_nullable_to_non_nullable
as int,hasResetToken: null == hasResetToken ? _self.hasResetToken : hasResetToken // ignore: cast_nullable_to_non_nullable
as bool,resetTokenExpiry: freezed == resetTokenExpiry ? _self.resetTokenExpiry : resetTokenExpiry // ignore: cast_nullable_to_non_nullable
as DateTime?,
  ));
}


}

// dart format on
