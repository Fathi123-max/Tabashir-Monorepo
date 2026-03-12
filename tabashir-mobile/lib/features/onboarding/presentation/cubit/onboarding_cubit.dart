import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:tabashir/features/onboarding/models/onboarding_page_model.dart';
import 'package:tabashir/features/onboarding/domain/repositories/onboarding_repository.dart';

part 'onboarding_state.dart';
part 'onboarding_cubit.freezed.dart';
part 'onboarding_cubit.g.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit(this._repository) : super(const OnboardingState());

  final OnboardingRepository _repository;

  /// Initialize onboarding
  Future<void> initOnboarding() async {
    emit(
      state.copyWith(
        status: OnboardingStatus.loading,
        errorMessage: '',
      ),
    );

    try {
      final isCompleted = await _repository.isOnboardingCompleted();
      final currentPageIndex = await _repository.getCurrentPageIndex();
      final pages = await _repository.getOnboardingPages();

      emit(
        state.copyWith(
          status: OnboardingStatus.loaded,
          isCompleted: isCompleted,
          currentPageIndex: currentPageIndex,
          pages: pages,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: OnboardingStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Navigate to next page
  Future<void> nextPage() async {
    if (state.currentPageIndex < state.pages.length - 1) {
      final nextIndex = state.currentPageIndex + 1;
      await _repository.setCurrentPageIndex(nextIndex);
      emit(state.copyWith(currentPageIndex: nextIndex));
    } else {
      await completeOnboarding();
    }
  }

  /// Navigate to previous page
  Future<void> previousPage() async {
    if (state.currentPageIndex > 0) {
      final previousIndex = state.currentPageIndex - 1;
      await _repository.setCurrentPageIndex(previousIndex);
      emit(state.copyWith(currentPageIndex: previousIndex));
    }
  }

  /// Go to specific page
  Future<void> goToPage(int index) async {
    if (index >= 0 && index < state.pages.length) {
      await _repository.setCurrentPageIndex(index);
      emit(state.copyWith(currentPageIndex: index));
    }
  }

  /// Complete onboarding
  Future<void> completeOnboarding() async {
    try {
      await _repository.completeOnboarding();
      emit(
        state.copyWith(
          isCompleted: true,
          currentPageIndex: state.pages.length - 1,
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: OnboardingStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Reset onboarding
  Future<void> resetOnboarding() async {
    try {
      await _repository.resetOnboarding();
      emit(
        const OnboardingState(),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: OnboardingStatus.error,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  /// Clear error
  void clearError() {
    emit(
      state.copyWith(
        errorMessage: '',
        status: OnboardingStatus.loaded,
      ),
    );
  }
}
