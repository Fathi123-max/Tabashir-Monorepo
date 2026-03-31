import 'package:freezed_annotation/freezed_annotation.dart';

part 'user_profile_response.freezed.dart';
part 'user_profile_response.g.dart';

/// Comprehensive user profile response from mobile API
@freezed
sealed class UserProfileResponse with _$UserProfileResponse {
  const factory UserProfileResponse({
    required UserData user,
    CandidateProfileData? candidateProfile,
    RecruiterProfileData? recruiterProfile,
    OwnerProfileData? ownerProfile,
    ProfileCounts? counts,
    SubscriptionData? subscription,
    @Default([]) List<String> adminPermissions,
    PaymentStatsData? paymentStats,
    JobStatsData? jobStats,
    @Default([]) List<ConnectedAccountData> connectedAccounts,
    AiResumeStatsData? aiResumeStats,
    SecurityData? security,
  }) = _UserProfileResponse;

  factory UserProfileResponse.fromJson(Map<String, dynamic> json) =>
      _$UserProfileResponseFromJson(json);
}

/// Resume info for candidate profile
@freezed
sealed class ResumeInfo with _$ResumeInfo {
  const factory ResumeInfo({
    String? fileName,
    String? fileUrl,
  }) = _ResumeInfo;

  factory ResumeInfo.fromJson(Map<String, dynamic> json) =>
      _$ResumeInfoFromJson(json);
}


/// Core user data
@freezed
sealed class UserData with _$UserData {
  const factory UserData({
    required String id,
    String? name,
    String? email,
    DateTime? emailVerified,
    String? image,
    String? userType,
    String? adminRole,
    int? jobCount,
    int? aiJobApplyCount,
    DateTime? createdAt,
    DateTime? updatedAt,
    String? referralCode,
    String? referredBy,
  }) = _UserData;

  factory UserData.fromJson(Map<String, dynamic> json) =>
      _$UserDataFromJson(json);
}

/// Application status counts
@freezed
sealed class ApplicationStatusCounts with _$ApplicationStatusCounts {
  const factory ApplicationStatusCounts({
    required int inReview,
    required int interview,
    required int offer,
    required int rejected,
  }) = _ApplicationStatusCounts;

  factory ApplicationStatusCounts.fromJson(Map<String, dynamic> json) =>
      _$ApplicationStatusCountsFromJson(json);
}

/// Profile counts data
@freezed
sealed class ProfileCounts with _$ProfileCounts {
  const factory ProfileCounts({
    required int totalResumes,
    required int totalApplications,
    required int savedJobs,
    ApplicationStatusCounts? applicationsByStatus,
  }) = _ProfileCounts;

  factory ProfileCounts.fromJson(Map<String, dynamic> json) =>
      _$ProfileCountsFromJson(json);
}

/// Candidate profile data
@freezed
sealed class CandidateProfileData with _$CandidateProfileData {
  const factory CandidateProfileData({
    String? id,
    String? phone,
    String? nationality,
    String? gender,
    List<String>? languages,
    int? age,
    String? profilePicture,
    String? jobType,
    List<String>? skills,
    String? experience,
    String? education,
    String? degree,
    String? location,
    String? linkedin,
    bool? onboardingCompleted,
    ResumeInfo? latestResume,
    String? createdAt,
    String? updatedAt,
  }) = _CandidateProfileData;

  factory CandidateProfileData.fromJson(Map<String, dynamic> json) =>
      _$CandidateProfileDataFromJson(json);
}


/// Owner profile data
@freezed
sealed class OwnerProfileData with _$OwnerProfileData {
  const factory OwnerProfileData({
    String? id,
    String? phone,
    String? createdAt,
    String? updatedAt,
  }) = _OwnerProfileData;

  factory OwnerProfileData.fromJson(Map<String, dynamic> json) =>
      _$OwnerProfileDataFromJson(json);
}

/// Recruiter profile data
@freezed
sealed class RecruiterProfileData with _$RecruiterProfileData {
  const factory RecruiterProfileData({
    String? id,
    String? companyName,
    String? contactPersonName,
    String? phone,
    String? createdAt,
    String? updatedAt,
  }) = _RecruiterProfileData;

  factory RecruiterProfileData.fromJson(Map<String, dynamic> json) =>
      _$RecruiterProfileDataFromJson(json);
}

/// Subscription data
@freezed
sealed class SubscriptionData with _$SubscriptionData {
  const factory SubscriptionData({
    String? plan,
    String? status,
    DateTime? startDate,
    DateTime? endDate,
    bool? autoRenew,
  }) = _SubscriptionData;

  factory SubscriptionData.fromJson(Map<String, dynamic> json) =>
      _$SubscriptionDataFromJson(json);
}

/// Payment statistics data
@freezed
sealed class PaymentStatsData with _$PaymentStatsData {
  const factory PaymentStatsData({
    required int totalPayments,
    required double totalAmountSpent,
    String? currency,
  }) = _PaymentStatsData;

  factory PaymentStatsData.fromJson(Map<String, dynamic> json) =>
      _$PaymentStatsDataFromJson(json);
}

/// Job statistics data
@freezed
sealed class JobStatsData with _$JobStatsData {
  const factory JobStatsData({
    required int totalJobs,
    required int activeJobs,
    required int applicationsReceived,
  }) = _JobStatsData;

  factory JobStatsData.fromJson(Map<String, dynamic> json) =>
      _$JobStatsDataFromJson(json);
}

/// Connected account data (social logins)
@freezed
sealed class ConnectedAccountData with _$ConnectedAccountData {
  const factory ConnectedAccountData({
    required String provider,
    DateTime? createdAt,
  }) = _ConnectedAccountData;

  factory ConnectedAccountData.fromJson(Map<String, dynamic> json) =>
      _$ConnectedAccountDataFromJson(json);
}

/// AI resume statistics data
@freezed
sealed class AiResumeStatsData with _$AiResumeStatsData {
  const factory AiResumeStatsData({
    required int total,
    required int draft,
    required int inProgress,
    required int completed,
  }) = _AiResumeStatsData;

  factory AiResumeStatsData.fromJson(Map<String, dynamic> json) =>
      _$AiResumeStatsDataFromJson(json);
}

/// Security information data
@freezed
sealed class SecurityData with _$SecurityData {
  const factory SecurityData({
    required int activeSessions,
    required bool hasResetToken,
    DateTime? resetTokenExpiry,
  }) = _SecurityData;

  factory SecurityData.fromJson(Map<String, dynamic> json) =>
      _$SecurityDataFromJson(json);
}
