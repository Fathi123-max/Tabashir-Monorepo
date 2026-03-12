// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_profile_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_UserProfileResponse _$UserProfileResponseFromJson(
  Map<String, dynamic> json,
) => _UserProfileResponse(
  user: UserData.fromJson(json['user'] as Map<String, dynamic>),
  candidateProfile: json['candidateProfile'] == null
      ? null
      : CandidateProfileData.fromJson(
          json['candidateProfile'] as Map<String, dynamic>,
        ),
  recruiterProfile: json['recruiterProfile'] == null
      ? null
      : RecruiterProfileData.fromJson(
          json['recruiterProfile'] as Map<String, dynamic>,
        ),
  ownerProfile: json['ownerProfile'] == null
      ? null
      : OwnerProfileData.fromJson(json['ownerProfile'] as Map<String, dynamic>),
  counts: json['counts'] == null
      ? null
      : ProfileCounts.fromJson(json['counts'] as Map<String, dynamic>),
  subscription: json['subscription'] == null
      ? null
      : SubscriptionData.fromJson(json['subscription'] as Map<String, dynamic>),
  adminPermissions:
      (json['adminPermissions'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList() ??
      const [],
  paymentStats: json['paymentStats'] == null
      ? null
      : PaymentStatsData.fromJson(json['paymentStats'] as Map<String, dynamic>),
  jobStats: json['jobStats'] == null
      ? null
      : JobStatsData.fromJson(json['jobStats'] as Map<String, dynamic>),
  connectedAccounts:
      (json['connectedAccounts'] as List<dynamic>?)
          ?.map((e) => ConnectedAccountData.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  aiResumeStats: json['aiResumeStats'] == null
      ? null
      : AiResumeStatsData.fromJson(
          json['aiResumeStats'] as Map<String, dynamic>,
        ),
  security: json['security'] == null
      ? null
      : SecurityData.fromJson(json['security'] as Map<String, dynamic>),
);

Map<String, dynamic> _$UserProfileResponseToJson(
  _UserProfileResponse instance,
) => <String, dynamic>{
  'user': instance.user,
  'candidateProfile': instance.candidateProfile,
  'recruiterProfile': instance.recruiterProfile,
  'ownerProfile': instance.ownerProfile,
  'counts': instance.counts,
  'subscription': instance.subscription,
  'adminPermissions': instance.adminPermissions,
  'paymentStats': instance.paymentStats,
  'jobStats': instance.jobStats,
  'connectedAccounts': instance.connectedAccounts,
  'aiResumeStats': instance.aiResumeStats,
  'security': instance.security,
};

_UserData _$UserDataFromJson(Map<String, dynamic> json) => _UserData(
  id: json['id'] as String,
  name: json['name'] as String?,
  email: json['email'] as String?,
  emailVerified: json['emailVerified'] == null
      ? null
      : DateTime.parse(json['emailVerified'] as String),
  image: json['image'] as String?,
  userType: json['userType'] as String?,
  adminRole: json['adminRole'] as String?,
  jobCount: (json['jobCount'] as num?)?.toInt(),
  aiJobApplyCount: (json['aiJobApplyCount'] as num?)?.toInt(),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
  updatedAt: json['updatedAt'] == null
      ? null
      : DateTime.parse(json['updatedAt'] as String),
  referralCode: json['referralCode'] as String?,
  referredBy: json['referredBy'] as String?,
);

Map<String, dynamic> _$UserDataToJson(_UserData instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'email': instance.email,
  'emailVerified': instance.emailVerified?.toIso8601String(),
  'image': instance.image,
  'userType': instance.userType,
  'adminRole': instance.adminRole,
  'jobCount': instance.jobCount,
  'aiJobApplyCount': instance.aiJobApplyCount,
  'createdAt': instance.createdAt?.toIso8601String(),
  'updatedAt': instance.updatedAt?.toIso8601String(),
  'referralCode': instance.referralCode,
  'referredBy': instance.referredBy,
};

_ApplicationStatusCounts _$ApplicationStatusCountsFromJson(
  Map<String, dynamic> json,
) => _ApplicationStatusCounts(
  inReview: (json['inReview'] as num).toInt(),
  interview: (json['interview'] as num).toInt(),
  offer: (json['offer'] as num).toInt(),
  rejected: (json['rejected'] as num).toInt(),
);

Map<String, dynamic> _$ApplicationStatusCountsToJson(
  _ApplicationStatusCounts instance,
) => <String, dynamic>{
  'inReview': instance.inReview,
  'interview': instance.interview,
  'offer': instance.offer,
  'rejected': instance.rejected,
};

_ProfileCounts _$ProfileCountsFromJson(Map<String, dynamic> json) =>
    _ProfileCounts(
      totalResumes: (json['totalResumes'] as num).toInt(),
      totalApplications: (json['totalApplications'] as num).toInt(),
      savedJobs: (json['savedJobs'] as num).toInt(),
      applicationsByStatus: json['applicationsByStatus'] == null
          ? null
          : ApplicationStatusCounts.fromJson(
              json['applicationsByStatus'] as Map<String, dynamic>,
            ),
    );

Map<String, dynamic> _$ProfileCountsToJson(_ProfileCounts instance) =>
    <String, dynamic>{
      'totalResumes': instance.totalResumes,
      'totalApplications': instance.totalApplications,
      'savedJobs': instance.savedJobs,
      'applicationsByStatus': instance.applicationsByStatus,
    };

_CandidateProfileData _$CandidateProfileDataFromJson(
  Map<String, dynamic> json,
) => _CandidateProfileData(
  id: json['id'] as String,
  phone: json['phone'] as String?,
  nationality: json['nationality'] as String?,
  gender: json['gender'] as String?,
  languages: (json['languages'] as List<dynamic>?)
      ?.map((e) => e as String)
      .toList(),
  age: (json['age'] as num?)?.toInt(),
  profilePicture: json['profilePicture'] as String?,
  jobType: json['jobType'] as String?,
  skills: (json['skills'] as List<dynamic>?)?.map((e) => e as String).toList(),
  experience: json['experience'] as String?,
  education: json['education'] as String?,
  degree: json['degree'] as String?,
  location: json['location'] as String?,
  linkedin: json['linkedin'] as String?,
  onboardingCompleted: json['onboardingCompleted'] as bool?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$CandidateProfileDataToJson(
  _CandidateProfileData instance,
) => <String, dynamic>{
  'id': instance.id,
  'phone': instance.phone,
  'nationality': instance.nationality,
  'gender': instance.gender,
  'languages': instance.languages,
  'age': instance.age,
  'profilePicture': instance.profilePicture,
  'jobType': instance.jobType,
  'skills': instance.skills,
  'experience': instance.experience,
  'education': instance.education,
  'degree': instance.degree,
  'location': instance.location,
  'linkedin': instance.linkedin,
  'onboardingCompleted': instance.onboardingCompleted,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};

_OwnerProfileData _$OwnerProfileDataFromJson(Map<String, dynamic> json) =>
    _OwnerProfileData(
      id: json['id'] as String,
      phone: json['phone'] as String?,
      createdAt: json['createdAt'] as String?,
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$OwnerProfileDataToJson(_OwnerProfileData instance) =>
    <String, dynamic>{
      'id': instance.id,
      'phone': instance.phone,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
    };

_RecruiterProfileData _$RecruiterProfileDataFromJson(
  Map<String, dynamic> json,
) => _RecruiterProfileData(
  id: json['id'] as String,
  companyName: json['companyName'] as String?,
  contactPersonName: json['contactPersonName'] as String?,
  phone: json['phone'] as String?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$RecruiterProfileDataToJson(
  _RecruiterProfileData instance,
) => <String, dynamic>{
  'id': instance.id,
  'companyName': instance.companyName,
  'contactPersonName': instance.contactPersonName,
  'phone': instance.phone,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};

_SubscriptionData _$SubscriptionDataFromJson(Map<String, dynamic> json) =>
    _SubscriptionData(
      plan: json['plan'] as String?,
      status: json['status'] as String?,
      startDate: json['startDate'] == null
          ? null
          : DateTime.parse(json['startDate'] as String),
      endDate: json['endDate'] == null
          ? null
          : DateTime.parse(json['endDate'] as String),
      autoRenew: json['autoRenew'] as bool?,
    );

Map<String, dynamic> _$SubscriptionDataToJson(_SubscriptionData instance) =>
    <String, dynamic>{
      'plan': instance.plan,
      'status': instance.status,
      'startDate': instance.startDate?.toIso8601String(),
      'endDate': instance.endDate?.toIso8601String(),
      'autoRenew': instance.autoRenew,
    };

_PaymentStatsData _$PaymentStatsDataFromJson(Map<String, dynamic> json) =>
    _PaymentStatsData(
      totalPayments: (json['totalPayments'] as num).toInt(),
      totalAmountSpent: (json['totalAmountSpent'] as num).toDouble(),
      currency: json['currency'] as String?,
    );

Map<String, dynamic> _$PaymentStatsDataToJson(_PaymentStatsData instance) =>
    <String, dynamic>{
      'totalPayments': instance.totalPayments,
      'totalAmountSpent': instance.totalAmountSpent,
      'currency': instance.currency,
    };

_JobStatsData _$JobStatsDataFromJson(Map<String, dynamic> json) =>
    _JobStatsData(
      totalJobs: (json['totalJobs'] as num).toInt(),
      activeJobs: (json['activeJobs'] as num).toInt(),
      applicationsReceived: (json['applicationsReceived'] as num).toInt(),
    );

Map<String, dynamic> _$JobStatsDataToJson(_JobStatsData instance) =>
    <String, dynamic>{
      'totalJobs': instance.totalJobs,
      'activeJobs': instance.activeJobs,
      'applicationsReceived': instance.applicationsReceived,
    };

_ConnectedAccountData _$ConnectedAccountDataFromJson(
  Map<String, dynamic> json,
) => _ConnectedAccountData(
  provider: json['provider'] as String,
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$ConnectedAccountDataToJson(
  _ConnectedAccountData instance,
) => <String, dynamic>{
  'provider': instance.provider,
  'createdAt': instance.createdAt?.toIso8601String(),
};

_AiResumeStatsData _$AiResumeStatsDataFromJson(Map<String, dynamic> json) =>
    _AiResumeStatsData(
      total: (json['total'] as num).toInt(),
      draft: (json['draft'] as num).toInt(),
      inProgress: (json['inProgress'] as num).toInt(),
      completed: (json['completed'] as num).toInt(),
    );

Map<String, dynamic> _$AiResumeStatsDataToJson(_AiResumeStatsData instance) =>
    <String, dynamic>{
      'total': instance.total,
      'draft': instance.draft,
      'inProgress': instance.inProgress,
      'completed': instance.completed,
    };

_SecurityData _$SecurityDataFromJson(Map<String, dynamic> json) =>
    _SecurityData(
      activeSessions: (json['activeSessions'] as num).toInt(),
      hasResetToken: json['hasResetToken'] as bool,
      resetTokenExpiry: json['resetTokenExpiry'] == null
          ? null
          : DateTime.parse(json['resetTokenExpiry'] as String),
    );

Map<String, dynamic> _$SecurityDataToJson(_SecurityData instance) =>
    <String, dynamic>{
      'activeSessions': instance.activeSessions,
      'hasResetToken': instance.hasResetToken,
      'resetTokenExpiry': instance.resetTokenExpiry?.toIso8601String(),
    };
