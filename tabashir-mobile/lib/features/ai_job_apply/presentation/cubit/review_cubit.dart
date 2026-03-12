import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabashir/core/config/animation_config.dart';
import '../../data/models/review_model.dart';
import '../../data/models/target_role_model.dart';
import '../../data/models/location_preference_model.dart';
import '../../data/models/personal_details_model.dart';
import 'review_state.dart';

/// Cubit for managing review screen state
class ReviewCubit extends Cubit<ReviewState> {
  /// Creates the review cubit
  ReviewCubit() : super(const ReviewStateInitial());

  /// Initialize review data from previous screens
  void initializeReviewData({
    int selectedResumesCount = 1,
    List<TargetRoleModel> selectedRoles = const [],
    List<LocationPreferenceModel> selectedLocations = const [],
    PersonalDetailsModel? personalDetails,
  }) {
    final reviewData = ReviewModel(
      selectedResumesCount: selectedResumesCount,
      selectedRoles: selectedRoles,
      selectedLocations: selectedLocations,
      personalDetails: personalDetails,
      matchingJobsCount: _calculateMatchingJobs(
        selectedRoles.length,
        selectedLocations.length,
      ),
      aiConfidence: _calculateAICConfidence(
        selectedRoles.length,
        selectedLocations.length,
      ),
    );

    emit(ReviewStateLoaded(reviewData));
  }

  /// Apply to all matching jobs
  Future<void> applyToJobs() async {
    if (state.reviewData == null) {
      emit(const ReviewStateError('Review data not available'));
      return;
    }

    emit(ReviewStateSubmitting(state.reviewData!));

    try {
      // Simulate API call
      await Future.delayed(AnimationConfig.aiProcessingDelay);

      emit(ReviewStateSuccess(state.reviewData!));
    } catch (e) {
      emit(
        const ReviewStateError(
          'Failed to submit applications. Please try again.',
        ),
      );
    }
  }

  /// Edit preferences (go back to previous screen)
  void editPreferences() {
    // This will be handled by the UI using go_router
  }

  /// Calculate matching jobs based on selections
  int _calculateMatchingJobs(int rolesCount, int locationsCount) {
    // Simple algorithm: more roles and locations = more matches
    // Base: 10 jobs, +5 for each additional role, +3 for each additional location
    return 10 + (rolesCount * 5) + (locationsCount * 3);
  }

  /// Calculate AI confidence percentage
  int _calculateAICConfidence(int rolesCount, int locationsCount) {
    // Confidence based on selection completeness
    // More selections = higher confidence
    var confidence = 70; // Base confidence

    if (rolesCount >= 1) confidence += 10;
    if (rolesCount >= 2) confidence += 5;
    if (rolesCount >= 3) confidence += 5;

    if (locationsCount >= 1) confidence += 5;
    if (locationsCount >= 2) confidence += 5;

    return confidence.clamp(0, 100);
  }
}
