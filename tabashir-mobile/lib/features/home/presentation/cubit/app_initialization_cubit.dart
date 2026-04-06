import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/core/network/models/user/user_profile_response.dart';
import 'package:tabashir/core/session/cubit/session_cubit.dart';
import 'package:tabashir/features/home/data/models/app_initialization_state.dart';
import 'package:tabashir/features/profile/domain/repositories/profile_repository.dart';
import 'package:tabashir/features/profile/presentation/cubit/profile_cubit.dart';
import 'package:tabashir/features/home/presentation/cubit/home_cubit.dart';
import 'package:tabashir/features/resume/presentation/cubit/resume_vault_cubit.dart';
import 'package:tabashir/core/utils/app_logger.dart';

@lazySingleton
class AppInitializationCubit extends Cubit<AppInitializationState> {
  AppInitializationCubit(
    this._profileRepository,
  ) : super(const AppInitializationState());

  final ProfileRepository _profileRepository;

  /// Initialize the entire app by loading all required data
  /// Call this once after login
  Future<void> initialize() async {
    if (state.isInitialized && state.errorMessage == null) {
      AppLogger.debug('[APP_INIT] Already initialized successfully, skipping', tag: 'Home');
      return;
    }

    AppLogger.debug('[APP_INIT] Starting app initialization...', tag: 'Home');
    if (!isClosed) {
      emit(state.copyWith(isLoading: true, errorMessage: null));
    }

    try {
      // 1. Load user profile
      AppLogger.debug('[APP_INIT] 1/2 Loading user profile...', tag: 'Home');
      final userProfile = await _profileRepository.getUserProfile();
      AppLogger.debug('[APP_INIT] ✅ User profile loaded', tag: 'Home');

      // 2. Initialize other cubits with shared data
      AppLogger.debug('[APP_INIT] 2/2 Initializing cubits with shared data...', tag: 'Home');
      await _initializeCubits(userProfile);
      AppLogger.debug('[APP_INIT] ✅ Cubits initialized', tag: 'Home');

      // Emit success state with all data
      if (!isClosed) {
        emit(
          state.copyWith(
            isLoading: false,
            isInitialized: true,
            userProfile: userProfile,
          ),
        );
      }

      AppLogger.debug('[APP_INIT] ✅✅ App initialization complete', tag: 'Home');
    } catch (e) {
      // If authentication failed and logged the user out, we shouldn't show an error.
      // We just let the UI redirect to the login screen.
      final sessionCubit = getIt<SessionCubit>();
      final isUnauthenticated = sessionCubit.state.maybeMap(
        unauthenticated: (_) => true,
        orElse: () => false,
      );

      if (isUnauthenticated) {
        AppLogger.error('[APP_INIT] Authentication failed during initialization. User is logged out. Continuing gracefully.', tag: 'Home');
        if (!isClosed) {
          emit(
            state.copyWith(
              isInitialized:
                  false, // Don't mark as initialized if we didn't actually load data
              isLoading: false,
            ),
          );
        }
        return;
      }

      AppLogger.error('[APP_INIT] ❌ Initialization failed: $e', tag: 'Home', error: e);
      if (!isClosed) {
        emit(
          state.copyWith(
            isLoading: false,
            errorMessage: 'Failed to initialize app: $e',
          ),
        );
      }
    }
  }

  /// Initialize other cubits with shared data to prevent duplicate API calls
  Future<void> _initializeCubits(
    UserProfileResponse userProfile,
  ) async {
    try {
      // Initialize ProfileCubit with user profile data
      final profileCubit = getIt<ProfileCubit>();
      await profileCubit.initializeWithProfileData(userProfile);

      // Initialize ResumeVaultCubit
      final resumeCubit = getIt<ResumeVaultCubit>();
      await resumeCubit.loadResumes();

      // Initialize HomeCubit
      final homeCubit = getIt<HomeCubit>();
      homeCubit.initializeWithData(
        userProfile: userProfile,
      );

      AppLogger.debug('[APP_INIT] ✅ All cubits initialized with shared data', tag: 'Home');
    } catch (e) {
      AppLogger.error('[APP_INIT] ⚠️ Error initializing cubits: $e', tag: 'Home', error: e);
      // Don't fail the whole initialization if cubit init fails
    }
  }

  /// Reset initialization (for logout/session change)
  void reset() {
    AppLogger.debug('[APP_INIT] Resetting app initialization and sub-cubits...', tag: 'Home');

    // Reset sub-cubits that hold session data
    try {
      getIt<HomeCubit>().reset();
      getIt<ResumeVaultCubit>().reset();
      getIt<ProfileCubit>().reset();
    } catch (e) {
      AppLogger.error('[APP_INIT] ⚠️ Error resetting sub-cubits: $e', tag: 'Home', error: e);
    }

    if (!isClosed) {
      emit(const AppInitializationState());
    }
  }
}
