import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:reactive_forms/reactive_forms.dart';

part 'change_password_cubit.freezed.dart';
part 'change_password_state.dart';

class ChangePasswordCubit extends Cubit<ChangePasswordState> {
  ChangePasswordCubit() : super(ChangePasswordState.initial());

  FormGroup getChangePasswordForm() => FormGroup({
    'currentPassword': FormControl<String>(
      validators: [Validators.required],
    ),
    'newPassword': FormControl<String>(
      validators: [
        Validators.required,
        Validators.minLength(8),
      ],
    ),
    'confirmPassword': FormControl<String>(
      validators: [Validators.required],
    ),
  });

  Future<void> changePassword(FormGroup form) async {
    emit(state.copyWith(status: ChangePasswordStatus.loading));

    try {
      // Simulate API call to change password
      await Future<void>.delayed(const Duration(milliseconds: 1000));

      final currentPassword = form.control('currentPassword').value as String;
      final newPassword = form.control('newPassword').value as String;

      // In a real app, this would validate against the backend
      if (currentPassword.isEmpty || newPassword.isEmpty) {
        throw Exception('Password change failed');
      }

      emit(
        state.copyWith(
          status: ChangePasswordStatus.success,
          message: 'Password changed successfully',
        ),
      );
    } catch (e) {
      emit(
        state.copyWith(
          status: ChangePasswordStatus.failure,
          errorMessage: e.toString(),
        ),
      );
    }
  }

  bool validatePasswordStrength(String password) {
    if (password.isEmpty) return false;
    if (password.length < 8) return false;
    if (!password.contains(RegExp('[A-Z]'))) return false;
    if (!password.contains(RegExp('[a-z]'))) return false;
    if (!password.contains(RegExp('[0-9]'))) return false;
    return true;
  }

  String? validatePasswordMatch(String newPassword, String confirmPassword) {
    if (newPassword != confirmPassword) {
      return 'Passwords do not match';
    }
    return null;
  }
}
