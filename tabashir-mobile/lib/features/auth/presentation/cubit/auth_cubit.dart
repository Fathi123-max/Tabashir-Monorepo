import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/core/network/models/auth/auth_response.dart';
import 'package:tabashir/core/network/models/auth/email_verification_response.dart';
import 'package:tabashir/core/services/auth_session_service.dart';
import 'package:tabashir/features/auth/domain/repositories/auth_repository.dart';
import 'package:tabashir/features/profile/presentation/cubit/profile_cubit.dart';

part 'auth_state.dart';
part 'auth_cubit.freezed.dart';
part 'auth_cubit.g.dart';

@injectable
class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this._repository, this._profileCubit) : super(const AuthState());

  final AuthRepository _repository;
  final ProfileCubit _profileCubit;

  /// Login user with email and password
  Future<void> login({
    required String email,
    required String password,
  }) async {
    emit(
      state.copyWith(
        status: AuthStatus.loading,
        email: email,
        password: password,
      ),
    );

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
      print('[AUTH_CUBIT] Login response received:');
      print(
        '[AUTH_CUBIT] - accessToken: ${tokenToStore != null ? "present (${tokenToStore.length} chars)" : "NULL"}',
      );
      print(
        '[AUTH_CUBIT] - refreshToken: ${refreshTokenToStore != null ? "present (${refreshTokenToStore.length} chars)" : "NULL"}',
      );
      print('[AUTH_CUBIT] - user: ${response.user?.email}');

      if (tokenToStore != null) {
        await AuthSessionService.instance.setLoggedIn(
          token: tokenToStore,
          refreshToken: refreshTokenToStore,
        );
        // Load profile data after successful login
        await _profileCubit.loadProfileData();
      } else {
        print('[AUTH_CUBIT] WARNING: No access token in response!');
      }

      emit(
        state.copyWith(
          status: AuthStatus.loginSuccess,
          isEmailVerified: true, // Assume email is verified after login
        ),
      );
    } on Exception catch (e) {
      // Extract the error message from the exception
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      emit(
        state.copyWith(
          status: AuthStatus.error,
          errorMessage: errorMessage,
        ),
      );
    } catch (e) {
      // Catch any other unexpected errors
      emit(
        state.copyWith(
          status: AuthStatus.error,
          errorMessage: 'An unexpected error occurred. Please try again.',
        ),
      );
    }
  }

  /// Register new user
  Future<void> register({
    required String email,
    required String password,
    required String name,
    String userType = 'CANDIDATE',
  }) async {
    emit(
      state.copyWith(
        status: AuthStatus.loading,
        email: email,
        password: password,
        name: name,
        userType: userType,
      ),
    );

    try {
      final response = await _repository.register(
        email: email,
        password: password,
        name: name,
        userType: userType,
      );

      // Debug: Print the full response to see the structure
      print('DEBUG: Register response: $response');
      print('DEBUG: Token in response.token: ${response.token}');

      // Store the token in AuthSessionService
      // API returns token in 'accessToken' field
      final tokenToStore = response.accessToken ?? response.token;
      final refreshTokenToStore = response.refreshToken;

      if (tokenToStore != null) {
        print('DEBUG: Storing token: $tokenToStore');
        await AuthSessionService.instance.setLoggedIn(
          token: tokenToStore,
          refreshToken: refreshTokenToStore,
        );
        // Load profile data after successful registration
        await _profileCubit.loadProfileData();
      } else {
        print('DEBUG: WARNING - No token found in response!');
        // If no token was returned from registration, try to log the user in
        // to obtain the necessary tokens
        print('DEBUG: Attempting to login after registration...');
        await _attemptLoginAfterRegistration(email, password);
      }

      emit(
        state.copyWith(
          status: AuthStatus.registerSuccess,
          isEmailVerified: false,
        ),
      );
    } on Exception catch (e) {
      // Extract the error message from the exception
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      emit(
        state.copyWith(
          status: AuthStatus.error,
          errorMessage: errorMessage,
        ),
      );
    } catch (e) {
      // Catch any other unexpected errors
      emit(
        state.copyWith(
          status: AuthStatus.error,
          errorMessage: 'An unexpected error occurred. Please try again.',
        ),
      );
    }
  }

  /// Send verification email
  Future<void> sendVerificationEmail({required String email}) async {
    emit(
      state.copyWith(
        status: AuthStatus.loading,
        email: email,
      ),
    );

    try {
      final response = await _repository.sendVerificationEmail(email: email);

      emit(
        state.copyWith(
          status: AuthStatus.emailSent,
        ),
      );
    } on Exception catch (e) {
      // Extract the error message from the exception
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      emit(
        state.copyWith(
          status: AuthStatus.error,
          errorMessage: errorMessage,
        ),
      );
    } catch (e) {
      // Catch any other unexpected errors
      emit(
        state.copyWith(
          status: AuthStatus.error,
          errorMessage: 'An unexpected error occurred. Please try again.',
        ),
      );
    }
  }

  /// Verify email with code
  Future<void> verifyEmail({
    required String email,
    required String code,
  }) async {
    emit(
      state.copyWith(
        status: AuthStatus.loading,
        email: email,
        verificationCode: code,
      ),
    );

    try {
      final response = await _repository.verifyEmail(
        email: email,
        code: code,
      );

      emit(
        state.copyWith(
          status: AuthStatus.emailVerified,
          isEmailVerified: true,
        ),
      );
    } on Exception catch (e) {
      // Extract the error message from the exception
      final errorMessage = e.toString().replaceFirst('Exception: ', '');
      emit(
        state.copyWith(
          status: AuthStatus.error,
          errorMessage: errorMessage,
        ),
      );
    } catch (e) {
      // Catch any other unexpected errors
      emit(
        state.copyWith(
          status: AuthStatus.error,
          errorMessage: 'An unexpected error occurred. Please try again.',
        ),
      );
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
        print(
          'DEBUG: Successfully obtained token after registration via login: $tokenToStore',
        );
        await AuthSessionService.instance.setLoggedIn(
          token: tokenToStore,
          refreshToken: refreshTokenToStore,
        );
        // Load profile data after successful login
        await _profileCubit.loadProfileData();
      } else {
        print('DEBUG: WARNING - No token obtained even after login attempt!');
      }
    } catch (e) {
      print('DEBUG: Login after registration failed: $e');
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
