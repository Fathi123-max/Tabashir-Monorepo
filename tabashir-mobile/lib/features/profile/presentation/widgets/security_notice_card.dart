import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme.dart';

/// Widget for displaying a security notice card
class SecurityNoticeCard extends StatelessWidget {
  const SecurityNoticeCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Container(
      padding: EdgeInsets.all(AppTheme.spacingMd.w),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.1),
        borderRadius: BorderRadius.circular(
          AppTheme.radiusDefault.r,
        ),
        border: Border.all(
          color: AppTheme.primaryColor.withOpacity(0.3),
        ),
      ),
      child: Row(
        children: [
          Icon(
            Icons.security,
            color: AppTheme.primaryColor,
            size: 24.sp,
          ),
          SizedBox(width: AppTheme.spacingMd.w),
          Expanded(
            child: Text(
              'Your password should be at least 8 characters long and include a mix of uppercase, lowercase letters, and numbers.',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
