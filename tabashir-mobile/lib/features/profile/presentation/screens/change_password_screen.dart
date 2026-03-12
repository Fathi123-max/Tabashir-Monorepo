import 'package:easy_localization/easy_localization.dart';

import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:reactive_forms/reactive_forms.dart';

import '../../../../core/theme/app_theme.dart';
import '../cubit/change_password_cubit.dart';
import '../widgets/security_notice_card.dart';
import '../widgets/password_requirements_list.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  FormGroup? _form;
  bool _obscureCurrentPassword = true;
  bool _obscureNewPassword = true;
  bool _obscureConfirmPassword = true;
  StreamSubscription<void>? _formSubscription;

  @override
  void initState() {
    super.initState();
    _initializeForm();
  }

  Future<void> _initializeForm() async {
    await Future<void>.delayed(const Duration(milliseconds: 100));

    final cubit = context.read<ChangePasswordCubit>();
    setState(() {
      _form = cubit.getChangePasswordForm();
      _formSubscription = _form!.valueChanges.listen((_) {
        setState(() {});
      });
    });
  }

  @override
  void dispose() {
    _formSubscription?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.read<ChangePasswordCubit>();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Change Password'.tr(),
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          if (_form != null)
            Padding(
              padding: EdgeInsets.only(right: AppTheme.spacingMd.w),
              child: Center(
                child: BlocBuilder<ChangePasswordCubit, ChangePasswordState>(
                  builder: (context, state) {
                    if (state.status == ChangePasswordStatus.loading) {
                      return SizedBox(
                        height: 20.h,
                        width: 20.w,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppTheme.primaryColor,
                          ),
                        ),
                      );
                    }
                    return TextButton(
                      onPressed:
                          (_form!.valid &&
                              state.status != ChangePasswordStatus.loading)
                          ? () async {
                              await cubit.changePassword(_form!);
                              if (state.status ==
                                  ChangePasswordStatus.success) {
                                if (mounted) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        state.message ??
                                            'Password changed successfully'
                                                .tr(),
                                      ),
                                      backgroundColor: AppTheme.successColor,
                                    ),
                                  );
                                  context.pop();
                                }
                              }
                            }
                          : null,
                      child: Text(
                        'Update'.tr(),
                        style: theme.textTheme.titleMedium?.copyWith(
                          color:
                              _form!.valid &&
                                  state.status != ChangePasswordStatus.loading
                              ? AppTheme.primaryColor
                              : theme.colorScheme.onSurface.withValues(
                                  alpha: 0.4,
                                ),
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
        ],
      ),
      body: _form == null
          ? const Center(child: CircularProgressIndicator())
          : BlocConsumer<ChangePasswordCubit, ChangePasswordState>(
              listener: (context, state) {
                if (state.status == ChangePasswordStatus.failure &&
                    state.errorMessage != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(state.errorMessage!),
                      backgroundColor: AppTheme.errorColor,
                    ),
                  );
                }
              },
              builder: (context, state) => ReactiveForm(
                formGroup: _form!,
                child: SingleChildScrollView(
                  padding: EdgeInsets.all(AppTheme.spacingMd.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Security Notice Card
                      const SecurityNoticeCard(),
                      SizedBox(height: AppTheme.spacingLg.h),

                      // Current Password Field
                      ReactiveTextField<String>(
                        formControlName: 'currentPassword',
                        obscureText: _obscureCurrentPassword,
                        decoration: InputDecoration(
                          labelText: 'Current Password'.tr(),
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureCurrentPassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureCurrentPassword =
                                    !_obscureCurrentPassword;
                              });
                            },
                          ),
                          border: const OutlineInputBorder(),
                        ),
                        validationMessages: {
                          ValidationMessage.required: (_) =>
                              'Current password is required'.tr(),
                        },
                      ),
                      SizedBox(height: AppTheme.spacingMd.h),

                      // New Password Field
                      ReactiveTextField<String>(
                        formControlName: 'newPassword',
                        obscureText: _obscureNewPassword,
                        decoration: InputDecoration(
                          labelText: 'New Password'.tr(),
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureNewPassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureNewPassword = !_obscureNewPassword;
                              });
                            },
                          ),
                          border: const OutlineInputBorder(),
                        ),
                        validationMessages: {
                          ValidationMessage.required: (_) =>
                              'New password is required'.tr(),
                          ValidationMessage.minLength: (_) =>
                              'Password must be at least 8 characters'.tr(),
                        },
                      ),
                      SizedBox(height: AppTheme.spacingMd.h),

                      // Confirm Password Field
                      ReactiveTextField<String>(
                        formControlName: 'confirmPassword',
                        obscureText: _obscureConfirmPassword,
                        decoration: InputDecoration(
                          labelText: 'Confirm New Password'.tr(),
                          prefixIcon: const Icon(Icons.lock_outline),
                          suffixIcon: IconButton(
                            icon: Icon(
                              _obscureConfirmPassword
                                  ? Icons.visibility_off_outlined
                                  : Icons.visibility_outlined,
                            ),
                            onPressed: () {
                              setState(() {
                                _obscureConfirmPassword =
                                    !_obscureConfirmPassword;
                              });
                            },
                          ),
                          border: const OutlineInputBorder(),
                        ),
                        validationMessages: {
                          ValidationMessage.required: (_) =>
                              'Please confirm your password'.tr(),
                          'passwordMismatch': (_) =>
                              'Passwords do not match'.tr(),
                        },
                      ),
                      SizedBox(height: AppTheme.spacingMd.h),

                      // Password Requirements
                      ReactiveFormConsumer(
                        builder: (context, form, child) {
                          final newPassword =
                              form.control('newPassword').value as String? ??
                              '';
                          final confirmPassword =
                              form.control('confirmPassword').value
                                  as String? ??
                              '';

                          final passwordMatchError = cubit
                              .validatePasswordMatch(
                                newPassword,
                                confirmPassword,
                              );

                          // Update the confirmPassword validation if passwords don't match
                          if (passwordMatchError != null &&
                              confirmPassword.isNotEmpty) {
                            form.control('confirmPassword').setErrors({
                              'passwordMismatch': passwordMatchError,
                            });
                          } else if (confirmPassword.isNotEmpty) {
                            // Remove passwordMismatch error if passwords match
                            final currentErrors = Map<String, dynamic>.from(
                              form.control('confirmPassword').errors,
                            );
                            currentErrors.remove('passwordMismatch');
                            if (currentErrors.isEmpty) {
                              form.control('confirmPassword').setErrors({});
                            } else {
                              form
                                  .control('confirmPassword')
                                  .setErrors(currentErrors);
                            }
                          }

                          return PasswordRequirementsList(
                            newPassword: newPassword,
                            confirmPassword: confirmPassword,
                            cubit: cubit,
                          );
                        },
                      ),
                      SizedBox(height: AppTheme.spacingLg.h),

                      // Update Button
                      SizedBox(
                        width: double.infinity,
                        child: ReactiveFormConsumer(
                          builder: (context, form, child) => ElevatedButton(
                            onPressed:
                                (form.valid &&
                                    state.status !=
                                        ChangePasswordStatus.loading)
                                ? () async {
                                    await cubit.changePassword(form);
                                    if (state.status ==
                                        ChangePasswordStatus.success) {
                                      if (mounted) {
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          SnackBar(
                                            content: Text(
                                              state.message ??
                                                  'Password changed successfully'
                                                      .tr(),
                                            ),
                                            backgroundColor:
                                                AppTheme.successColor,
                                          ),
                                        );
                                        context.pop();
                                      }
                                    }
                                  }
                                : null,
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                vertical: AppTheme.spacingMd.h,
                              ),
                              backgroundColor: AppTheme.primaryColor,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  AppTheme.radiusDefault.r,
                                ),
                              ),
                            ),
                            child: state.status == ChangePasswordStatus.loading
                                ? SizedBox(
                                    height: 20.h,
                                    width: 20.w,
                                    child: const CircularProgressIndicator(
                                      strokeWidth: 2,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                : Text(
                                    'Update Password'.tr(),
                                    style: theme.textTheme.titleMedium
                                        ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.w600,
                                        ),
                                  ),
                          ),
                        ),
                      ),
                      SizedBox(height: AppTheme.spacingMd.h),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
