import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme.dart';

/// Widget for displaying error state when loading fails
class ResumeVaultErrorState extends StatelessWidget {
  const ResumeVaultErrorState({
    required this.onRetry,
    super.key,
  });

  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppTheme.spacingXl.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: 80,
              color: AppTheme.errorColor,
            ),
            SizedBox(height: AppTheme.spacingLg.h),
            Text(
              'Oops! Something went wrong'.tr(),
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppTheme.spacingMd.h),
            Text(
              "We couldn't load your resumes. Please try again.".tr(),
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.brightness == Brightness.light
                    ? AppTheme.textMutedLight
                    : AppTheme.textMutedDark,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppTheme.spacingXl.h),
            ElevatedButton(
              onPressed: onRetry,
              style: AppTheme.primaryButtonStyle,
              child: Text('Retry'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}
