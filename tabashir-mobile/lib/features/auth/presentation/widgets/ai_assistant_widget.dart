import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme.dart';

class AIAssistantWidget extends StatelessWidget {
  // Whether to use AppTheme (for signup) or custom styling (for login)

  const AIAssistantWidget({
    required this.message,
    super.key,
    this.useAppTheme = true, // Default to using AppTheme for consistency
  });
  final String message;
  final bool useAppTheme;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (useAppTheme) {
      // Use AppTheme styling (for signup)
      return Container(
        padding: EdgeInsets.all(AppTheme.spacingMd.w),
        decoration: BoxDecoration(
          color: AppTheme.primaryColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.auto_awesome,
              size: 24.sp,
              color: AppTheme.warningColor,
            ),
            SizedBox(width: AppTheme.spacingMd.w),
            Expanded(
              child: Text(
                message,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.primaryColor,
                  fontSize: 13.sp,
                ),
              ),
            ),
          ],
        ),
      );
    } else {
      // Use login screen styling with AppTheme color
      return Container(
        padding: EdgeInsets.all(AppTheme.spacingMd.w),
        decoration: BoxDecoration(
          color: AppTheme.warningColor.withOpacity(0.1),
          borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.auto_awesome,
              size: 24.sp,
              color: AppTheme.warningColor,
            ),
            SizedBox(width: AppTheme.spacingMd.w),
            Expanded(
              child: Text(
                message,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: AppTheme.warningColor,
                  fontSize: 14.sp,
                ),
              ),
            ),
          ],
        ),
      );
    }
  }
}
