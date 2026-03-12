import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme.dart';

class LoginPasswordFieldWidget extends StatefulWidget {
  const LoginPasswordFieldWidget({
    required this.controller,
    required this.isPasswordVisible,
    required this.onTogglePasswordVisibility,
    super.key,
  });
  final TextEditingController controller;
  final bool isPasswordVisible;
  final Function(bool) onTogglePasswordVisibility;

  @override
  State<LoginPasswordFieldWidget> createState() =>
      _LoginPasswordFieldWidgetState();
}

class _LoginPasswordFieldWidgetState extends State<LoginPasswordFieldWidget> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return TextFormField(
      controller: widget.controller,
      obscureText: !widget.isPasswordVisible,
      style: theme.textTheme.bodyLarge?.copyWith(fontSize: 16.sp),
      decoration: InputDecoration(
        hintText: 'Password',
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
        suffixIcon: IconButton(
          onPressed: () {
            widget.onTogglePasswordVisibility(!widget.isPasswordVisible);
          },
          icon: Icon(
            widget.isPasswordVisible ? Icons.visibility : Icons.visibility_off,
            color: theme.iconTheme.color,
            size: 24.sp,
          ),
        ),
      ),
    );
  }
}
