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
      print('[APP_INIT] Already initialized successfully, skipping');
      return;
    }

    print('[APP_INIT] Starting app initialization...');
    if (!isClosed) {
      emit(state.copyWith(isLoading: true, errorMessage: null));
    }

    try {
      // 1. Load user profile
      print('[APP_INIT] 1/2 Loading user profile...');
      final userProfile = await _profileRepository.getUserProfile();
      print('[APP_INIT] ✅ User profile loaded');

      // 2. Initialize other cubits with shared data
      print('[APP_INIT] 2/2 Initializing cubits with shared data...');
      await _initializeCubits(userProfile);
      print('[APP_INIT] ✅ Cubits initialized');

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

      print('[APP_INIT] ✅✅ App initialization complete');
    } catch (e) {
      // If authentication failed and logged the user out, we shouldn't show an error.
      // We just let the UI redirect to the login screen.
      final sessionCubit = getIt<SessionCubit>();
      final isUnauthenticated = sessionCubit.state.maybeMap(
        unauthenticated: (_) => true,
        orElse: () => false,
      );

      if (isUnauthenticated) {
        print(
          '[APP_INIT] Authentication failed during initialization. User is logged out. Continuing gracefully.',
        );
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

      print('[APP_INIT] ❌ Initialization failed: $e');
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

      print('[APP_INIT] ✅ All cubits initialized with shared data');
    } catch (e) {
      print('[APP_INIT] ⚠️ Error initializing cubits: $e');
      // Don't fail the whole initialization if cubit init fails
    }
  }

  /// Reset initialization (for logout/session change)
  void reset() {
    print('[APP_INIT] Resetting app initialization and sub-cubits...');

    // Reset sub-cubits that hold session data
    try {
      getIt<HomeCubit>().reset();
      getIt<ResumeVaultCubit>().reset();
      getIt<ProfileCubit>().reset();
    } catch (e) {
      print('[APP_INIT] ⚠️ Error resetting sub-cubits: $e');
    }

    if (!isClosed) {
      emit(const AppInitializationState());
    }
  }
}
