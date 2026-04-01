import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tabashir/core/network/models/applied_jobs_response.dart';

part 'home_repository.freezed.dart';
part 'home_repository.g.dart';

@freezed
sealed class DashboardData with _$DashboardData {
  const factory DashboardData({
    required String userId,
    required String userName,
    required String userEmail,
    String? userAvatar,
    @Default([]) List<QuickAction> quickActions,
    @Default([]) List<RecentActivity> recentActivities,
    @Default([]) List<JobRecommendation> jobRecommendations,
    @Default(0) int totalApplications,
    @Default(0) int savedJobs,
    @Default(0) int profileViews,
  }) = _DashboardData;

  factory DashboardData.fromJson(Map<String, dynamic> json) =>
      _$DashboardDataFromJson(json);
}

@freezed
sealed class QuickAction with _$QuickAction {
  const factory QuickAction({
    required String id,
    required String title,
    required String icon,
    required String route,
  }) = _QuickAction;

  factory QuickAction.fromJson(Map<String, dynamic> json) =>
      _$QuickActionFromJson(json);
}

@freezed
sealed class RecentActivity with _$RecentActivity {
  const factory RecentActivity({
    required String id,
    required String title,
    required String description,
    required DateTime timestamp,
    required String type, // 'application', 'profile', 'job'
  }) = _RecentActivity;

  factory RecentActivity.fromJson(Map<String, dynamic> json) =>
      _$RecentActivityFromJson(json);
}

@freezed
sealed class JobRecommendation with _$JobRecommendation {
  const factory JobRecommendation({
    required String id,
    required String title,
    required String company,
    required String location,
    @Default(0) int matchPercentage,
  }) = _JobRecommendation;

  factory JobRecommendation.fromJson(Map<String, dynamic> json) =>
      _$JobRecommendationFromJson(json);
}

@freezed
sealed class CityJobCount with _$CityJobCount {
  const factory CityJobCount({
    required String city,
    required int count,
  }) = _CityJobCount;

  factory CityJobCount.fromJson(Map<String, dynamic> json) =>
      _$CityJobCountFromJson(json);
}

/// Repository interface for home dashboard operations
/// Defines the contract for home screen data operations
abstract class HomeRepository {
  /// Get dashboard data for a user
  /// Returns [DashboardData]
  Future<DashboardData> getDashboardData({
    required String userId,
  });

  /// Get quick actions
  /// Returns list of [QuickAction]
  Future<List<QuickAction>> getQuickActions({
    required String userId,
  });

  /// Get recent activities
  /// Returns list of [RecentActivity]
  Future<List<RecentActivity>> getRecentActivities({
    required String userId,
    int limit = 10,
  });

  /// Get job recommendations
  /// Returns list of [JobRecommendation]
  Future<List<JobRecommendation>> getJobRecommendations({
    required String userId,
    int limit = 5,
  });

  /// Save activity
  /// Returns void when operation is complete
  Future<void> saveActivity({
    required String userId,
    required RecentActivity activity,
  });

  /// Clear all activities for a user
  /// Returns void when operation is complete
  Future<void> clearActivities({
    required String userId,
  });

  /// Update user stats
  /// Returns void when operation is complete
  Future<void> updateUserStats({
    required String userId,
    int? totalApplications,
    int? savedJobs,
    int? profileViews,
  });

  /// Search jobs
  /// Returns list of job data
  Future<List<Map<String, dynamic>>> searchJobs({
    required String query,
    String? location,
    String? category,
    int page = 1,
    int limit = 20,
  });

  /// Get the AI client profile
  Future<Map<String, dynamic>> getClientProfile();

  /// Get applied jobs count
  Future<int> getAppliedJobsCount({required String email});

  /// Get AI matched jobs
  Future<List<JobRecommendation>> getMatchedJobs({
    required String email,
    int limit = 10,
  });

  /// Get job counts grouped by city
  Future<List<CityJobCount>> getJobsCountByCity();

  /// Get latest jobs
  Future<List<Map<String, dynamic>>> getLatestJobs({
    int page = 1,
    int limit = 10,
  });

  /// Get user's applied jobs
  Future<List<AppliedJob>> getAppliedJobs({required String email});
}
