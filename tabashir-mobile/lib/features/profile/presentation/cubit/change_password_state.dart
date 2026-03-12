part of 'change_password_cubit.dart';

enum ChangePasswordStatus { initial, loading, success, failure }

@freezed
sealed class ChangePasswordState with _$ChangePasswordState {
  const factory ChangePasswordState({
    @Default(ChangePasswordStatus.initial) ChangePasswordStatus status,
    String? message,
    String? errorMessage,
  }) = _ChangePasswordState;

  factory ChangePasswordState.initial() => const ChangePasswordState();
}

// Trigger for build_runner
