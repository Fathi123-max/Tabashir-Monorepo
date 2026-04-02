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

    return Container(
      height: 56.h,
      decoration: BoxDecoration(
        gradient: isEnabled ? AppTheme.primaryGradient : null,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge.r),
        boxShadow: isEnabled
            ? [
                BoxShadow(
                  color: AppTheme.primaryColor.withOpacity(0.4),
                  blurRadius: 16,
                  offset: const Offset(0, 6),
                  spreadRadius: 2,
                ),
                BoxShadow(
                  color: Colors.white.withOpacity(0.1),
                  blurRadius: 8,
                  offset: const Offset(0, -2),
                ),
              ]
            : null,
      ),
      child: Material(
        color: isEnabled ? Colors.transparent : theme.disabledColor,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge.r),
        child: InkWell(
          onTap: isEnabled ? onPressed : null,
          borderRadius: BorderRadius.circular(AppTheme.radiusLarge.r),
          child: Center(
            child: isLoading
                ? SizedBox(
                    height: 24.h,
                    width: 24.h,
                    child: CircularProgressIndicator(
                      strokeWidth: 2.5,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        isEnabled ? Colors.white : theme.colorScheme.onSurface,
                      ),
                    ),
                  )
                : Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Create Account',
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontSize: 17.sp,
                          fontWeight: FontWeight.w700,
                          color: isEnabled
                              ? Colors.white
                              : theme.colorScheme.onSurface,
                          letterSpacing: 0.5,
                        ),
                      ),
                      if (isEnabled) ...[
                        SizedBox(width: AppTheme.spacingSm.w),
                        Icon(
                          Icons.arrow_forward_rounded,
                          color: Colors.white,
                          size: 20.sp,
                        ),
                      ],
                    ],
                  ),
          ),
        ),
      ),
    );
  }
}
