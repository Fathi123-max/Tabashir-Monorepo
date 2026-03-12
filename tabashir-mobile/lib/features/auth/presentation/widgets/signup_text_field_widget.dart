import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme.dart';

class SignupTextFieldWidget extends StatelessWidget {
  const SignupTextFieldWidget({
    required this.controller,
    required this.hintText,
    super.key,
    this.keyboardType,
    this.obscureText = false,
    this.suffixIcon,
    this.validator,
  });
  final TextEditingController controller;
  final String hintText;
  final TextInputType? keyboardType;
  final bool obscureText;
  final Widget? suffixIcon;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: theme.textTheme.bodyLarge,
      decoration: InputDecoration(
        hintText: hintText,
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
            color: AppTheme.primaryColor,
            width: 2,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
          borderSide: BorderSide(
            color: AppTheme.errorColor,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
          borderSide: BorderSide(
            color: AppTheme.errorColor,
            width: 2,
          ),
        ),
        contentPadding: EdgeInsets.all(AppTheme.spacingMd.w),
        suffixIcon: suffixIcon,
      ),
      validator: validator,
    );
  }
}
