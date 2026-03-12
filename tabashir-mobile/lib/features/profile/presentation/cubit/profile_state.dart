part of 'profile_cubit.dart';

enum ProfileStatus { initial, loading, success, failure }

@freezed
sealed class ProfileState with _$ProfileState {
  const factory ProfileState({
    @Default(ProfileStatus.initial) ProfileStatus status,
    ProfileData? profile,
    UserProfileResponse? userProfileResponse, // Raw API response with candidateProfile
    String? errorMessage,
    @Default(false) bool requiresReauth,
  }) = _ProfileState;

  factory ProfileState.initial() => const ProfileState();
}

@freezed
sealed class ProfileData with _$ProfileData {
  const factory ProfileData({
    // Basic user info
    required String name,
    required String jobTitle,
    required String location,
    required String email,
    required String phone,
    required String nationality,
    required String gender,
    required String company,
    required String education,
    required String linkedin,
    required int profileStrength,
    String? profileImage,

    // Extended user data from comprehensive API
    String? userType,
    String? subscriptionPlan,
    String? subscriptionStatus,
    int? totalResumes,
    int? totalApplications,
    int? savedJobs,
    @Default([]) List<String> adminPermissions,
    PaymentStatsData? paymentStats,
    JobStatsData? jobStats,
    @Default([]) List<ConnectedAccountData> connectedAccounts,
    AiResumeStatsData? aiResumeStats,
    SecurityData? security,
  }) = _ProfileData;
}

// Trigger for build_runner
