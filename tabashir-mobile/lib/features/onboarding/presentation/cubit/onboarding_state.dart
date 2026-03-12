part of 'onboarding_cubit.dart';

@freezed
sealed class OnboardingState with _$OnboardingState {
  const factory OnboardingState({
    @Default(OnboardingStatus.initial) OnboardingStatus status,
    @Default('') String errorMessage,
    @Default([]) List<OnboardingPageModel> pages,
    @Default(0) int currentPageIndex,
    @Default(false) bool isCompleted,
  }) = _OnboardingState;

  factory OnboardingState.fromJson(Map<String, dynamic> json) =>
      _$OnboardingStateFromJson(json);
}

enum OnboardingStatus {
  initial,
  loading,
  loaded,
  error,
}
