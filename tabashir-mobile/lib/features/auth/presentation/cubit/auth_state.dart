part of 'auth_cubit.dart';

@freezed
sealed class AuthState with _$AuthState {
  const factory AuthState({
    @Default(AuthStatus.initial) AuthStatus status,
    @Default('') String email,
    @Default('') String password,
    @Default('') String name,
    @Default('') String errorMessage,
    @Default(false) bool isEmailVerified,
    String? verificationCode,
    @Default('') String userType,
  }) = _AuthState;

  factory AuthState.fromJson(Map<String, dynamic> json) =>
      _$AuthStateFromJson(json);
}

enum AuthStatus {
  initial,
  loading,
  loginSuccess,
  registerSuccess,
  emailSent,
  emailVerified,
  error,
}
