import 'package:tabashir/features/onboarding/models/onboarding_page_model.dart';

/// Repository interface for Onboarding feature
abstract class OnboardingRepository {
  /// Get all onboarding pages
  Future<List<OnboardingPageModel>> getOnboardingPages();

  /// Check if onboarding is completed
  Future<bool> isOnboardingCompleted();

  /// Mark onboarding as completed
  Future<void> completeOnboarding();

  /// Reset onboarding state
  Future<void> resetOnboarding();

  /// Get current page index
  Future<int> getCurrentPageIndex();

  /// Update current page index
  Future<void> setCurrentPageIndex(int index);
}
