import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tabashir/core/network/models/applied_jobs_response.dart';
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

    // Data from recommendations API (used in UI)
    Map<String, dynamic>? recommendationsData,

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
    @Default([]) List<JobRecommendation> allMatchedJobsList,
    @Default([]) List<AppliedJob> appliedJobsList,
    
    // Pagination for Matched Jobs
    @Default(1) int matchedJobsPage,
    @Default(0) int matchedJobsTotal,
    @Default(20) int matchedJobsLimit,
    @Default(true) bool matchedJobsHasMore,
    @Default(false) bool isLoadingMoreMatched,
    
    // Pagination for Applied Jobs
    @Default(1) int appliedJobsPage,
    @Default(0) int appliedJobsTotal,
    @Default(20) int appliedJobsLimit,
    @Default(true) bool appliedJobsHasMore,
    @Default(false) bool isLoadingMoreApplied,
  }) = _HomeState;
}
