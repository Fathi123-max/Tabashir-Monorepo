part of 'personal_details_cubit.dart';

/// State for personal details form
@freezed
sealed class PersonalDetailsState with _$PersonalDetailsState {
  /// Creates the initial state
  const factory PersonalDetailsState({
    /// Selected nationality
    @Default('usa') String nationality,

    /// Selected gender
    Gender? gender,

    /// Whether visa sponsorship is required
    @Default(false) bool requiresVisaSponsorship,

    /// Submitting state
    @Default(false) bool isSubmitting,

    /// Error state
    @Default(false) bool hasError,

    /// Error message
    @Default('') String errorMessage,
  }) = _PersonalDetailsState;
}
