import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabashir/core/theme/app_theme.dart';

class ComingSoonCard extends StatelessWidget {
  const ComingSoonCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(AppTheme.spacingLg.w),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            theme.cardTheme.color ?? Colors.white,
            theme.cardTheme.color ?? Colors.white,
          ],
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge.r),
        border: Border.all(
          color: AppTheme.primaryColor.withOpacity(0.15),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Icon with gradient background
          Container(
            width: 100.w,
            height: 100.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.primaryColor.withOpacity(0.15),
                  AppTheme.primaryColor.withOpacity(0.08),
                ],
              ),
              borderRadius: BorderRadius.circular(AppTheme.radiusLarge.r),
            ),
            child: Center(
              child: Icon(
                Icons.psychology_rounded,
                size: 56.sp,
                color: AppTheme.primaryColor,
              ),
            ),
          ),
          SizedBox(height: AppTheme.spacingLg.h),

          // Title with better styling
          Text(
            'Coming This Summer',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
              color: AppTheme.primaryColor,
            ),
          ),
          SizedBox(height: AppTheme.spacingSm.h),

          // Description
          Text(
            'Get ready for the ultimate interview practice experience',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
              fontSize: 14.sp,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppTheme.spacingLg.h),

          // Features List
          Container(
            padding: EdgeInsets.all(AppTheme.spacingMd.w),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
              border: Border.all(
                color: AppTheme.primaryColor.withOpacity(0.1),
                width: 1,
              ),
            ),
            child: const Column(
              children: [
                FeatureItem(
                  icon: Icons.record_voice_over_rounded,
                  text: 'AI-powered mock interviews',
                ),
                FeatureItem(
                  icon: Icons.analytics_rounded,
                  text: 'Real-time feedback on answers',
                ),
                FeatureItem(
                  icon: Icons.lightbulb_rounded,
                  text: 'Personalized improvement tips',
                ),
                FeatureItem(
                  icon: Icons.folder_shared_rounded,
                  text: 'Role-specific question banks',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FeatureItem extends StatelessWidget {
  const FeatureItem({
    required this.icon,
    required this.text,
    super.key,
  });
  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.only(bottom: AppTheme.spacingMd.h),
      child: Row(
        children: [
          Container(
            width: 36.w,
            height: 36.w,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
            ),
            child: Icon(
              icon,
              size: 18.sp,
              color: AppTheme.primaryColor,
            ),
          ),
          SizedBox(width: AppTheme.spacingMd.w),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w500,
                fontSize: 14.sp,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
