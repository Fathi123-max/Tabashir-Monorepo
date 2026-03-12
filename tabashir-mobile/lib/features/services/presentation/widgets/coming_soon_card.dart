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
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
        border: Border.all(
          color: AppTheme.primaryColor.withOpacity(0.1),
          width: 1.5,
        ),
        boxShadow: [
          BoxShadow(
            color: AppTheme.primaryColor.withOpacity(0.08),
            blurRadius: 20,
            offset: const Offset(0, 8),
            spreadRadius: 2,
          ),
        ],
      ),
      child: Column(
        children: [
          // Icon with gradient background
          Container(
            width: 120.w,
            height: 120.w,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  AppTheme.primaryColor.withOpacity(0.1),
                  AppTheme.primaryColor.withOpacity(0.05),
                ],
              ),
              borderRadius: BorderRadius.circular(AppTheme.radiusLarge.r),
            ),
            child: Center(
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Icon(
                    Icons.psychology_outlined,
                    size: 64.sp,
                    color: AppTheme.primaryColor,
                  ),
                ],
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
          SizedBox(height: AppTheme.spacingMd.h),

          // Description
          Text(
            'Get ready for the ultimate interview practice experience',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppTheme.spacingLg.h),

          // Features List
          Container(
            padding: EdgeInsets.all(AppTheme.spacingMd.w),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.03),
              borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
            ),
            child: const Column(
              children: [
                FeatureItem(
                  icon: Icons.record_voice_over,
                  text: 'AI-powered mock interviews',
                ),
                FeatureItem(
                  icon: Icons.analytics_outlined,
                  text: 'Real-time feedback on answers',
                ),
                FeatureItem(
                  icon: Icons.tips_and_updates,
                  text: 'Personalized improvement tips',
                ),
                FeatureItem(
                  icon: Icons.folder_shared,
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
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
            ),
            child: Icon(
              icon,
              size: 20.sp,
              color: AppTheme.primaryColor,
            ),
          ),
          SizedBox(width: AppTheme.spacingMd.w),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.colorScheme.onSurface,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
