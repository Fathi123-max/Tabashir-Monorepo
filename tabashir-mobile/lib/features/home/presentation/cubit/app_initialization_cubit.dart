import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/core/network/models/user/user_profile_response.dart';
import 'package:tabashir/core/network/models/home_dashboard_response.dart';
import 'package:tabashir/core/network/models/resume_response/resume_item.dart';
import 'package:tabashir/features/home/data/models/app_initialization_state.dart';
import 'package:tabashir/features/profile/domain/repositories/profile_repository.dart';
import 'package:tabashir/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:tabashir/features/home/services/home_api_service.dart';
import 'package:tabashir/features/resume/presentation/cubit/resume_vault_cubit.dart';
import 'package:tabashir/features/resume/domain/repositories/resume_vault_repository.dart';

@lazySingleton
class AppInitializationCubit extends Cubit<AppInitializationState> {
  AppInitializationCubit(
    this._profileRepository,
    this._homeApiService,
    this._resumeRepository,
  ) : super(const AppInitializationState());

  final ProfileRepository _profileRepository;
  final HomeApiService _homeApiService;
  final ResumeVaultRepository _resumeRepository;

  /// Initialize the entire app by loading all required data
  /// Call this once after login
  Future<void> initialize() async {
    if (state.isInitialized) {
      print('[APP_INIT] Already initialized, skipping');
      return;
    }

    print('[APP_INIT] Starting app initialization...');
    emit(state.copyWith(isLoading: true, errorMessage: null));

    try {
      // 1. Load user profile
      print('[APP_INIT] 1/4 Loading user profile...');
      final userProfile = await _profileRepository.getUserProfile();
      print('[APP_INIT] ✅ User profile loaded');

      // 2. Load resumes
      print('[APP_INIT] 2/4 Loading resumes...');
      final resumes = await _resumeRepository.getUserResumes();
      print('[APP_INIT] ✅ Loaded ${resumes.length} resumes');

      // 3. Load home dashboard data
      print('[APP_INIT] 3/4 Loading home dashboard...');
      final homeDashboard = await _homeApiService.getHomeDashboardData();
      print('[APP_INIT] ✅ Home dashboard loaded');

      // 4. Initialize other cubits with shared data
      print('[APP_INIT] 4/4 Initializing cubits with shared data...');
      await _initializeCubits(userProfile, resumes);
      print('[APP_INIT] ✅ Cubits initialized');

      // Emit success state with all data
      emit(
        state.copyWith(
          isLoading: false,
          isInitialized: true,
          userProfile: userProfile,
          resumes: resumes,
          homeDashboard: homeDashboard,
        ),
      );

      print('[APP_INIT] ✅✅ App initialization complete');
    } catch (e) {
      print('[APP_INIT] ❌ Initialization failed: $e');
      emit(
        state.copyWith(
          isLoading: false,
          errorMessage: 'Failed to initialize app: $e',
        ),
      );
    }
  }

  /// Initialize other cubits with shared data to prevent duplicate API calls
  Future<void> _initializeCubits(
    UserProfileResponse userProfile,
    List<ResumeItem> resumes,
  ) async {
    try {
      // Initialize ProfileCubit with user profile data
      final profileCubit = getIt<ProfileCubit>();
      await profileCubit.initializeWithProfileData(userProfile);

      // Initialize ResumeVaultCubit with resumes data
      final resumeCubit = getIt<ResumeVaultCubit>();
      await resumeCubit.initializeWithResumes(resumes);

      print('[APP_INIT] ✅ All cubits initialized with shared data');
    } catch (e) {
      print('[APP_INIT] ⚠️ Error initializing cubits: $e');
      // Don't fail the whole initialization if cubit init fails
    }
  }

  /// Reset initialization (for logout)
  void reset() {
    emit(const AppInitializationState());
  }
}
