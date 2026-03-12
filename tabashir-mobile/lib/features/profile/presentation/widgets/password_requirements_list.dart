import 'package:flutter/material.dart';
import '../cubit/change_password_cubit.dart';
import 'password_requirement_item.dart';

/// Widget for displaying password requirements
class PasswordRequirementsList extends StatelessWidget {
  const PasswordRequirementsList({
    required this.newPassword,
    required this.confirmPassword,
    required this.cubit,
    super.key,
  });

  final String newPassword;
  final String confirmPassword;
  final ChangePasswordCubit cubit;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final passwordMatchError = cubit.validatePasswordMatch(
      newPassword,
      confirmPassword,
    );

    return Column(
      children: [
        PasswordRequirementItem(
          requirement: 'At least 8 characters',
          isMet: newPassword.length >= 8,
          theme: theme,
        ),
        PasswordRequirementItem(
          requirement: 'Contains uppercase letter',
          isMet: newPassword.contains(RegExp('[A-Z]')),
          theme: theme,
        ),
        PasswordRequirementItem(
          requirement: 'Contains lowercase letter',
          isMet: newPassword.contains(RegExp('[a-z]')),
          theme: theme,
        ),
        PasswordRequirementItem(
          requirement: 'Contains a number',
          isMet: newPassword.contains(RegExp('[0-9]')),
          theme: theme,
        ),
        PasswordRequirementItem(
          requirement: 'Passwords match',
          isMet: passwordMatchError == null,
          theme: theme,
        ),
      ],
    );
  }
}
