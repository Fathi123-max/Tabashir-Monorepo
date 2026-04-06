import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/core/network/models/auth/auth_response.dart';
import 'package:tabashir/core/network/models/auth/email_verification_response.dart';
import 'package:tabashir/core/services/auth_session_service.dart';
import 'package:tabashir/core/utils/app_logger.dart';
import 'package:tabashir/features/auth/domain/repositories/auth_repository.dart';
import 'package:tabashir/features/home/presentation/cubit/app_initialization_cubit.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';
part 'auth_cubit.g.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._repository) : super(const AuthState());

  final AuthRepository _repository;

  /// Login user with email and password
  Future<void> login({
    required String email,
    required String password,
  }) async {
    if (!isClosed) {
      emit(
        state.copyWith(
          status: AuthStatus.loading,
          email: email,
          password: password,
        ),
      );
    }

    try {
      final response = await _repository.login(
        email: email,
        password: password,
      );

      // Store the token in AuthSessionService
      // API returns token in 'accessToken' field
      final tokenToStore = response.accessToken ?? response.token;
      final refreshTokenToStore = response.refreshToken;

      // Debug logging to verify refresh token is received
      AppLogger.debug('Login response received:', tag: 'Auth');
      AppLogger.debug(
        '- accessToken: ${tokenToStore != null ? "present (${tokenToStore.length} chars)" : "NULL"}',
        tag: 'Auth',
      );
      AppLogger.debug(
        '- refreshToken: ${refreshTokenToStore != null ? "present (${refreshTokenToStore.length} chars)" : "NULL"}',
        tag: 'Auth',
      );
      AppLogger.debug('- user: ${response.user?.email}', tag: 'Auth');

      if (tokenToStore != null) {
        await AuthSessionService.instance.setLoggedIn(
          token: tokenToStore,
          refreshToken: refreshTokenToStore,
        );
      } else {
        AppLogger.warning('WARNING: No access token in response!', tag: 'Auth');
      }

      // Reset application initialization state on successful login
      // This will ensure the next time the user hits the Home screen,
      // everything is re-initialized with the new token.
      getIt<AppInitializationCubit>().reset();

      if (!isClosed) {
        emit(
          state.copyWith(
            status: AuthStatus.loginSuccess,
            isEmailVerified: true, // Assume email is verified after login
          ),
        );
      }
    } on Exception catch (e) {
      // Extract the error message from the exception
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      if (!isClosed) {
        emit(
          state.copyWith(
            status: AuthStatus.error,
            errorMessage: errorMessage,
          ),
        );
      }
    } catch (e) {
      // Catch any other unexpected errors
      if (!isClosed) {
        emit(
          state.copyWith(
            status: AuthStatus.error,
            errorMessage: 'An unexpected error occurred. Please try again.',
          ),
        );
      }
    }
  }

  /// Register new user
  Future<void> register({
    required String email,
    required String password,
    required String name,
    String userType = 'CANDIDATE',
  }) async {
    if (!isClosed) {
      emit(
        state.copyWith(
          status: AuthStatus.loading,
          email: email,
          password: password,
          name: name,
          userType: userType,
        ),
      );
    }

    try {
      final response = await _repository.register(
        email: email,
        password: password,
        name: name,
        userType: userType,
      );

      // Debug: Print the full response to see the structure
      AppLogger.debug('Register response: $response', tag: 'Auth');
      AppLogger.debug('Token in response.token: ${response.token}', tag: 'Auth');

      // Store the token in AuthSessionService
      // API returns token in 'accessToken' field
      final tokenToStore = response.accessToken ?? response.token;
      final refreshTokenToStore = response.refreshToken;

      if (tokenToStore != null) {
        AppLogger.debug('Storing token: $tokenToStore', tag: 'Auth');
        await AuthSessionService.instance.setLoggedIn(
          token: tokenToStore,
          refreshToken: refreshTokenToStore,
        );
      } else {
        AppLogger.warning('WARNING - No token found in response!', tag: 'Auth');
        // If no token was returned from registration, try to log the user in
        // to obtain the necessary tokens
        AppLogger.debug('Attempting to login after registration...', tag: 'Auth');
        await _attemptLoginAfterRegistration(email, password);
      }

      // Reset application initialization state on successful registration
      getIt<AppInitializationCubit>().reset();

      if (!isClosed) {
        emit(
          state.copyWith(
            status: AuthStatus.registerSuccess,
            isEmailVerified: false,
          ),
        );
      }
    } on Exception catch (e) {
      // Extract the error message from the exception
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      if (!isClosed) {
        emit(
          state.copyWith(
            status: AuthStatus.error,
            errorMessage: errorMessage,
          ),
        );
      }
    } catch (e) {
      // Catch any other unexpected errors
      if (!isClosed) {
        emit(
          state.copyWith(
            status: AuthStatus.error,
            errorMessage: 'An unexpected error occurred. Please try again.',
          ),
        );
      }
    }
  }

  /// Send verification email
  Future<void> sendVerificationEmail({required String email}) async {
    if (!isClosed) {
      emit(
        state.copyWith(
          status: AuthStatus.loading,
          email: email,
        ),
      );
    }

    try {
      final response = await _repository.sendVerificationEmail(email: email);

      if (!isClosed) {
        emit(
          state.copyWith(
            status: AuthStatus.emailSent,
          ),
        );
      }
    } on Exception catch (e) {
      // Extract the error message from the exception
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      if (!isClosed) {
        emit(
          state.copyWith(
            status: AuthStatus.error,
            errorMessage: errorMessage,
          ),
        );
      }
    } catch (e) {
      // Catch any other unexpected errors
      if (!isClosed) {
        emit(
          state.copyWith(
            status: AuthStatus.error,
            errorMessage: 'An unexpected error occurred. Please try again.',
          ),
        );
      }
    }
  }

  /// Verify email with code
  Future<void> verifyEmail({
    required String email,
    required String code,
  }) async {
    if (!isClosed) {
      emit(
        state.copyWith(
          status: AuthStatus.loading,
          email: email,
          verificationCode: code,
        ),
      );
    }

    try {
      final response = await _repository.verifyEmail(
        email: email,
        code: code,
      );

      if (!isClosed) {
        emit(
          state.copyWith(
            status: AuthStatus.emailVerified,
            isEmailVerified: true,
          ),
        );
      }
    } on Exception catch (e) {
      // Extract the error message from the exception
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      if (!isClosed) {
        emit(
          state.copyWith(
            status: AuthStatus.error,
            errorMessage: errorMessage,
          ),
        );
      }
    } catch (e) {
      // Catch any other unexpected errors
      if (!isClosed) {
        emit(
          state.copyWith(
            status: AuthStatus.error,
            errorMessage: 'An unexpected error occurred. Please try again.',
          ),
        );
      }
    }
  }

  /// Helper method to attempt login after registration when no token is returned
  Future<void> _attemptLoginAfterRegistration(
    String email,
    String password,
  ) async {
    try {
      final loginResponse = await _repository.login(
        email: email,
        password: password,
      );

      // Extract tokens from login response
      final tokenToStore = loginResponse.accessToken ?? loginResponse.token;
      final refreshTokenToStore = loginResponse.refreshToken;

      if (tokenToStore != null) {
        AppLogger.debug(
          'Successfully obtained token after registration via login: $tokenToStore',
          tag: 'Auth',
        );
        await AuthSessionService.instance.setLoggedIn(
          token: tokenToStore,
          refreshToken: refreshTokenToStore,
        );
      } else {
        AppLogger.warning('WARNING - No token obtained even after login attempt!', tag: 'Auth');
      }
    } catch (e) {
      AppLogger.debug('Login after registration failed: $e', tag: 'Auth');
      // Don't throw the error since registration already succeeded
      // The user can try to log in manually if needed
    }
  }

  /// Clear error
  void clearError() {
    emit(
      state.copyWith(
        errorMessage: '',
        status: AuthStatus.initial,
      ),
    );
  }

  /// Reset to initial state
  void reset() {
    emit(const AuthState());
  }
}
