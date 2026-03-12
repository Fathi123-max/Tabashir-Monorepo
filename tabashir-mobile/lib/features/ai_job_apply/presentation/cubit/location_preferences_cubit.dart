import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tabashir/features/ai_job_apply/data/models/location_preference_model.dart';

part 'location_preferences_cubit.freezed.dart';
part 'location_preferences_state.dart';

/// Cubit for managing location preferences state
class LocationPreferencesCubit extends Cubit<LocationPreferencesState> {
  /// Creates the location preferences cubit
  LocationPreferencesCubit() : super(const LocationPreferencesState()) {
    _initializeDefaultLocations();
  }

  /// Initializes default location options
  void _initializeDefaultLocations() {
    final defaultLocations = <LocationPreferenceModel>[
      const LocationPreferenceModel(
        id: 'dubai',
        name: 'Dubai',
        type: 'city',
        matchScore: 95,
      ),
      const LocationPreferenceModel(
        id: 'remote',
        name: 'Remote',
        type: 'remote',
        matchScore: 90,
      ),
      const LocationPreferenceModel(
        id: 'riyadh',
        name: 'Riyadh',
        type: 'city',
        matchScore: 85,
      ),
      const LocationPreferenceModel(
        id: 'abu_dhabi',
        name: 'Abu Dhabi',
        type: 'city',
        matchScore: 88,
      ),
      const LocationPreferenceModel(
        id: 'doha',
        name: 'Doha',
        type: 'city',
        matchScore: 82,
        growthPercentage: 22,
      ),
      const LocationPreferenceModel(
        id: 'kuwait_city',
        name: 'Kuwait City',
        type: 'city',
        matchScore: 80,
      ),
      const LocationPreferenceModel(
        id: 'muscat',
        name: 'Muscat',
        type: 'city',
        matchScore: 78,
      ),
      const LocationPreferenceModel(
        id: 'manama',
        name: 'Manama',
        type: 'city',
        matchScore: 76,
      ),
    ];

    emit(
      state.copyWith(
        availableLocations: defaultLocations,
        selectedLocations: [
          // Pre-select Dubai and Remote
          defaultLocations.firstWhere((l) => l.id == 'dubai'),
          defaultLocations.firstWhere((l) => l.id == 'remote'),
        ],
      ),
    );

    _checkLocationSuggestion();
  }

  /// Toggles a location selection
  void toggleLocation(LocationPreferenceModel location) {
    final selectedLocations = List<LocationPreferenceModel>.from(
      state.selectedLocations,
    );

    if (selectedLocations.any((l) => l.id == location.id)) {
      selectedLocations.removeWhere((l) => l.id == location.id);
    } else {
      selectedLocations.add(location);
    }

    emit(state.copyWith(selectedLocations: selectedLocations));
    _checkLocationSuggestion();
  }

  /// Adds a custom location from dropdown
  void addLocationFromDropdown(String locationId) {
    if (locationId.isEmpty) return;

    final location = state.availableLocations.firstWhere(
      (l) => l.id == locationId,
      orElse: () => throw Exception('Location not found'),
    );

    if (!state.selectedLocations.any((l) => l.id == location.id)) {
      final selectedLocations = List<LocationPreferenceModel>.from(
        state.selectedLocations,
      );
      selectedLocations.add(location);

      emit(state.copyWith(selectedLocations: selectedLocations));
      _checkLocationSuggestion();
    }
  }

  /// Removes a location from selection
  void removeLocation(String locationId) {
    final selectedLocations = List<LocationPreferenceModel>.from(
      state.selectedLocations,
    );
    selectedLocations.removeWhere((l) => l.id == locationId);

    emit(state.copyWith(selectedLocations: selectedLocations));
    _checkLocationSuggestion();
  }

  /// Updates dropdown selection
  void updateDropdownSelection(String value) {
    emit(state.copyWith(dropdownSelection: value));
  }

  /// Continues with selected locations
  Future<void> continueWithSelectedLocations() async {
    if (state.selectedLocations.isEmpty) {
      emit(
        state.copyWith(
          hasError: true,
          errorMessage: 'Please select at least one location',
        ),
      );
      return;
    }

    emit(state.copyWith(isSubmitting: true));

    try {
      // TODO: Implement actual navigation logic
      // This would proceed to the next step in AI apply flow

      emit(state.copyWith(isSubmitting: false));
    } catch (error) {
      emit(
        state.copyWith(
          isSubmitting: false,
          hasError: true,
          errorMessage: 'Failed to continue',
        ),
      );
    }
  }

  /// Checks and updates AI location suggestion
  void _checkLocationSuggestion() {
    // Example: Suggest "Doha" if it's not selected and has growth
    final hasDoha = state.selectedLocations.any((l) => l.id == 'doha');
    final dohaLocation = state.availableLocations.firstWhere(
      (l) => l.id == 'doha',
    );

    if (!hasDoha && dohaLocation.growthPercentage > 0) {
      emit(
        state.copyWith(
          aiSuggestion: LocationPreferenceModel(
            id: 'doha_suggestion',
            name: 'Doha',
            isCustom: true,
            growthPercentage: dohaLocation.growthPercentage,
            description:
                'Jobs in Doha are rising ${dohaLocation.growthPercentage}% this month — consider adding it.',
          ),
        ),
      );
    } else {
      emit(state.copyWith(aiSuggestion: null));
    }
  }

  /// Clears the error state
  void clearError() {
    emit(state.copyWith(hasError: false, errorMessage: ''));
  }
}
