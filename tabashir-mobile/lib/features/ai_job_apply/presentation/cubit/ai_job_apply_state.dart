import '../../data/models/personal_details_model.dart';
import '../../data/models/resume_selection_model.dart';
import '../../data/models/target_role_model.dart';
import '../../data/models/location_preference_model.dart';
import 'package:tabashir/core/network/models/jobs_match_response.dart';

import 'package:freezed_annotation/freezed_annotation.dart';

part 'ai_job_apply_state.freezed.dart';

@freezed
sealed class AiJobApplyState with _$AiJobApplyState {
  /// Creates the initial state
  const factory AiJobApplyState({
    // ============ Resume Selection ============
    /// List of available resumes
    @Default([]) List<ResumeSelectionModel> resumes,

    /// Currently selected resume ID
    String? selectedResumeId,

    /// Loading state
    @Default(false) bool isLoading,

    /// Submitting state
    @Default(false) bool isSubmitting,

    /// Creating new resume state
    @Default(false) bool isCreatingNew,

    /// Error state
    @Default(false) bool hasError,

    /// Error message
    @Default('') String errorMessage,

    // ============ Target Roles ============
    /// List of available roles to select from
    @Default([]) List<TargetRoleModel> availableRoles,

    /// Currently selected roles
    @Default([]) List<TargetRoleModel> selectedRoles,

    /// Current custom role input
    @Default('') String customRoleTitle,

    /// AI suggestion for additional role
    TargetRoleModel? aiSuggestionRole,

    /// Submitting state
    @Default(false) bool isSubmittingRole,

    /// Error state
    @Default(false) bool hasErrorRole,

    /// Error message
    @Default('') String errorMessageRole,

    // ============ Location Preferences ============
    /// List of available locations to select from
    @Default([]) List<LocationPreferenceModel> availableLocations,

    /// Currently selected locations
    @Default([]) List<LocationPreferenceModel> selectedLocations,

    /// Current dropdown selection
    @Default('') String dropdownSelection,

    /// AI suggestion for additional location
    LocationPreferenceModel? aiSuggestionLocation,

    /// Submitting state
    @Default(false) bool isSubmittingLocation,

    /// Error state
    @Default(false) bool hasErrorLocation,

    /// Error message
    @Default('') String errorMessageLocation,

    // ============ Personal Details ============
    /// Selected nationality
    /// Can be null if not set by user
    /// When null, should be initialized from user profile or config
    String? nationality,

    /// Selected gender
    Gender? gender,

    /// Whether visa sponsorship is required
    @Default(false) bool requiresVisaSponsorship,

    /// Submitting state
    @Default(false) bool isSubmittingDetails,

    /// Error state
    @Default(false) bool hasErrorDetails,

    /// Error message
    @Default('') String errorMessageDetails,

    // ============ Final Submission ============
    /// Result of the job application submission
    JobsMatchResponse? submissionResult,

    /// Submitting application state
    @Default(false) bool isSubmittingApplication,

    /// Submission error message
    @Default('') String submissionError,
  }) = _AiJobApplyState;
}
