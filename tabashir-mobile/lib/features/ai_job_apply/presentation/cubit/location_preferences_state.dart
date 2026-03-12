part of 'location_preferences_cubit.dart';

/// State for location preferences selection
@freezed
sealed class LocationPreferencesState with _$LocationPreferencesState {
  /// Creates the initial state
  const factory LocationPreferencesState({
    /// List of available locations to select from
    @Default([]) List<LocationPreferenceModel> availableLocations,

    /// Currently selected locations
    @Default([]) List<LocationPreferenceModel> selectedLocations,

    /// Current dropdown selection
    @Default('') String dropdownSelection,

    /// AI suggestion for additional location
    LocationPreferenceModel? aiSuggestion,

    /// Submitting state
    @Default(false) bool isSubmitting,

    /// Error state
    @Default(false) bool hasError,

    /// Error message
    @Default('') String errorMessage,
  }) = _LocationPreferencesState;
}
