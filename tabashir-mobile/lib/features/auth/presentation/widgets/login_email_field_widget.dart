import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme.dart';

class LoginEmailFieldWidget extends StatelessWidget {
  const LoginEmailFieldWidget({required this.controller, super.key});
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.emailAddress,
      style: theme.textTheme.bodyLarge?.copyWith(fontSize: 16.sp),
      decoration: InputDecoration(
        hintText: 'Email',
        filled: true,
        fillColor: theme.inputDecorationTheme.fillColor,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
          borderSide: BorderSide(
            color: theme.dividerTheme.color ?? AppTheme.borderLight,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
          borderSide: BorderSide(
            color: theme.dividerTheme.color ?? AppTheme.borderLight,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
          borderSide: BorderSide(
            color: theme.colorScheme.primary,
            width: 2,
          ),
        ),
        contentPadding: EdgeInsets.all(AppTheme.spacingMd.w),
        hintStyle: theme.textTheme.bodyLarge?.copyWith(
          color: theme.hintColor,
        ),
      ),
    );
  }
}
