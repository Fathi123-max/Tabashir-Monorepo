import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tabashir/core/network/models/user/user_profile_response.dart';
import 'package:tabashir/core/network/models/home_dashboard_response.dart';
import 'package:tabashir/core/network/models/resume_response/resume_item.dart';

part 'app_initialization_state.freezed.dart';

@freezed
sealed class AppInitializationState with _$AppInitializationState {
  const factory AppInitializationState({
    @Default(false) bool isInitialized,
    @Default(false) bool isLoading,
    String? errorMessage,
    UserProfileResponse? userProfile,
    List<ResumeItem>? resumes,
    HomeDashboardResponse? homeDashboard,
  }) = _AppInitializationState;
}
