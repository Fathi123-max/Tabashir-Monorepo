import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tabashir/features/ai_job_apply/data/models/personal_details_model.dart';

part 'personal_details_cubit.freezed.dart';
part 'personal_details_state.dart';

/// Cubit for managing personal details state
class PersonalDetailsCubit extends Cubit<PersonalDetailsState> {
  /// Creates the personal details cubit
  PersonalDetailsCubit() : super(const PersonalDetailsState()) {
    _initializeDefault();
  }

  /// Initializes default personal details
  void _initializeDefault() {
    emit(
      const PersonalDetailsState(
        gender: Gender.preferNotToSay,
      ),
    );
  }

  /// Updates nationality
  void updateNationality(String nationality) {
    emit(state.copyWith(nationality: nationality));
  }

  /// Updates gender selection
  void updateGender(Gender gender) {
    emit(state.copyWith(gender: gender));
  }

  /// Toggles visa sponsorship requirement
  void toggleVisaSponsorship() {
    emit(
      state.copyWith(
        requiresVisaSponsorship: !state.requiresVisaSponsorship,
      ),
    );
  }

  /// Continues to review applications
  Future<void> continueToReview() async {
    emit(state.copyWith(isSubmitting: true));

    try {
      // TODO: Implement actual review logic
      // This would proceed to the review applications screen

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

  /// Clears the error state
  void clearError() {
    emit(state.copyWith(hasError: false, errorMessage: ''));
  }
}
