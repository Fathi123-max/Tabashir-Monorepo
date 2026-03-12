import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme.dart';

class ResumeImportOptionCard extends StatelessWidget {
  const ResumeImportOptionCard({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
    super.key,
  });
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
      child: Container(
        padding: EdgeInsets.all(AppTheme.spacingMd.w),
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
          boxShadow: [
            BoxShadow(
              color: theme.shadowColor.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 2),
            ),
          ],
          border: Border.all(
            color: theme.brightness == Brightness.light
                ? AppTheme.borderLight
                : AppTheme.borderDark,
          ),
        ),
        child: Row(
          children: [
            // Icon Container
            Container(
              width: 48.w,
              height: 48.w,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
              ),
              child: Icon(
                icon,
                color: theme.colorScheme.primary,
                size: 24.sp,
              ),
            ),

            SizedBox(width: AppTheme.spacingMd.w),

            // Text Content
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.bodyLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: AppTheme.spacingXs.h),
                  Text(
                    subtitle,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.brightness == Brightness.light
                          ? AppTheme.textMutedLight
                          : AppTheme.textMutedDark,
                    ),
                  ),
                ],
              ),
            ),

            SizedBox(width: AppTheme.spacingSm.w),

            // Arrow Icon
            Icon(
              Icons.arrow_forward_ios,
              color: theme.brightness == Brightness.light
                  ? AppTheme.textMutedLight
                  : AppTheme.textMutedDark,
              size: 16.sp,
            ),
          ],
        ),
      ),
    );
  }
}
