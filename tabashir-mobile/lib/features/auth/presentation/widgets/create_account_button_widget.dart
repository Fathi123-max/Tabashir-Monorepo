import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme.dart';

class CreateAccountButtonWidget extends StatelessWidget {
  const CreateAccountButtonWidget({
    super.key,
    this.onPressed,
    this.isEnabled = false,
    this.isLoading = false,
  });
  final VoidCallback? onPressed;
  final bool isEnabled;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 56.h,
      child: Container(
        decoration: BoxDecoration(
          gradient: isEnabled ? AppTheme.primaryGradient : null,
          borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
          boxShadow: isEnabled
              ? [
                  BoxShadow(
                    color: AppTheme.primaryColor.withOpacity(0.2),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: isEnabled
                ? Colors.transparent
                : theme.disabledColor,
            foregroundColor: Colors.white,
            elevation: 0,
            shadowColor: Colors.transparent,
            disabledBackgroundColor: theme.disabledColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
            ),
          ),
          child: isLoading
              ? SizedBox(
                  height: 20.h,
                  width: 20.h,
                  child: const CircularProgressIndicator(
                    strokeWidth: 2,
                    valueColor: AlwaysStoppedAnimation<Color>(
                      Colors.white,
                    ),
                  ),
                )
              : Text(
                  'Create Account',
                  style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
        ),
      ),
    );
  }
}
