import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tabashir/core/network/models/user/user_profile_response.dart';
import 'package:tabashir/features/home/domain/repositories/home_repository.dart';

part 'home_state.freezed.dart';

@freezed
sealed class HomeState with _$HomeState {
  const factory HomeState({
    @Default(false) bool isLoading,
    @Default(false) bool error,
    @Default('') String errorMessage,
    @Default([]) List<Map<String, dynamic>> jobs,
    @Default(0) int matches,
    @Default(0) int companiesViewed,
    @Default('') String matchDistribution,
    @Default(0) int inReview,
    @Default(0) int interview,
    @Default(0) int offer,
    @Default(0) int rejected,
    @Default(0) int pending,
    @Default(0) int unreadNotificationCount,
    UserData? user,

    // New fields for enhanced data
    Map<String, dynamic>? trendingData,
    Map<String, dynamic>? marketInsights,
    Map<String, dynamic>? analyticsData,
    Map<String, dynamic>? recommendationsData,
    Map<String, dynamic>? dashboardData,

    // Metrics from dashboard API
    @Default(0) int profileCompletionPercentage,
    @Default(0) int applicationSuccessRate,
    @Default('N/A') String avgMarketSalary,
    @Default(0) int totalApplications,

    // AI Enhanced Native Fields
    Map<String, dynamic>? clientProfile,
    @Default([]) List<CityJobCount> cityJobCounts,
    @Default([]) List<Map<String, dynamic>> latestJobsList,
    @Default([]) List<JobRecommendation> matchedJobsList,
  }) = _HomeState;
}
