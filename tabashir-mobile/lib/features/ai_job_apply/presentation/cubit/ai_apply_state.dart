part of 'ai_apply_cubit.dart';

/// State for AI apply functionality
@freezed
sealed class AiApplyState with _$AiApplyState {
  /// Creates the initial state
  const factory AiApplyState({
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
  }) = _AiApplyState;
}
