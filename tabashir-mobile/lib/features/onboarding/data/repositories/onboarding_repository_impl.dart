import 'package:injectable/injectable.dart';
import 'package:tabashir/core/services/local_persistence_service.dart';
import 'package:tabashir/features/onboarding/models/onboarding_page_model.dart';
import 'package:tabashir/features/onboarding/domain/repositories/onboarding_repository.dart';

/// Implementation of OnboardingRepository
@Injectable(as: OnboardingRepository)
class OnboardingRepositoryImpl implements OnboardingRepository {
  OnboardingRepositoryImpl(this._persistenceService);

  final LocalPersistenceService _persistenceService;
  static const String _onboardingCompletedKey = 'has_completed_onboarding';
  static const String _currentPageIndexKey = 'onboarding_current_page';

  @override
  Future<List<OnboardingPageModel>> getOnboardingPages() async {
    try {
      // Return default onboarding pages
      return const [
        OnboardingPageModel(
          icon: 'assets/images/onboarding_1.svg',
          title: 'Welcome to Tabashir',
          description:
              'Your AI-powered job search companion. Find your dream job with intelligent matching.',
        ),
        OnboardingPageModel(
          icon: 'assets/images/onboarding_2.svg',
          title: 'AI Resume Builder',
          description:
              'Create professional resumes with our AI-powered resume builder. Stand out from the crowd.',
        ),
        OnboardingPageModel(
          icon: 'assets/images/onboarding_3.svg',
          title: 'Smart Job Matching',
          description:
              'Get matched with jobs that fit your skills, experience, and preferences automatically.',
        ),
        OnboardingPageModel(
          icon: 'assets/images/onboarding_4.svg',
          title: 'Track Applications',
          description:
              'Track your job applications and get notified about application status updates.',
        ),
      ];
    } catch (e) {
      throw Exception('Failed to get onboarding pages: $e');
    }
  }

  @override
  Future<bool> isOnboardingCompleted() async {
    try {
      return _persistenceService.prefs.getBool(_onboardingCompletedKey) ?? false;
    } catch (e) {
      return false;
    }
  }

  @override
  Future<void> completeOnboarding() async {
    try {
      await _persistenceService.prefs.setBool(_onboardingCompletedKey, true);
      // Reset current page index when onboarding is completed
      await _persistenceService.prefs.remove(_currentPageIndexKey);
    } catch (e) {
      throw Exception('Failed to complete onboarding: $e');
    }
  }

  @override
  Future<void> resetOnboarding() async {
    try {
      await _persistenceService.prefs.remove(_onboardingCompletedKey);
      await _persistenceService.prefs.remove(_currentPageIndexKey);
    } catch (e) {
      throw Exception('Failed to reset onboarding: $e');
    }
  }

  @override
  Future<int> getCurrentPageIndex() async {
    try {
      final value = _persistenceService.prefs.getString(_currentPageIndexKey);
      if (value == null) {
        return 0;
      }
      return int.tryParse(value) ?? 0;
    } catch (e) {
      return 0;
    }
  }

  @override
  Future<void> setCurrentPageIndex(int index) async {
    try {
      await _persistenceService.prefs.setString(
        _currentPageIndexKey,
        index.toString(),
      );
    } catch (e) {
      throw Exception('Failed to set current page index: $e');
    }
  }
}
