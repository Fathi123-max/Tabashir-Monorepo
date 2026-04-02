import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabashir/core/theme/app_theme.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({
    required this.icon,
    required this.title,
    required this.description,
    required this.price,
    required this.buttonText,
    required this.isEnabled,
    super.key,
    this.onPressed,
    this.isFeatured = false,
    this.badgeText,
  });
  final IconData icon;
  final String title;
  final String description;
  final String price;
  final String buttonText;
  final bool isEnabled;
  final VoidCallback? onPressed;
  final bool isFeatured;
  final String? badgeText;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Opacity(
      opacity: isEnabled ? 1.0 : 0.7,
      child: Container(
        padding: EdgeInsets.all(AppTheme.spacingLg.w),
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(AppTheme.radiusLarge.r),
          border: Border.all(
            color: isFeatured
                ? AppTheme.primaryColor.withOpacity(0.3)
                : theme.colorScheme.outline.withOpacity(0.1),
            width: isFeatured ? 2 : 1,
          ),
          boxShadow: [
            BoxShadow(
              color: isFeatured
                  ? AppTheme.primaryColor.withOpacity(0.15)
                  : Colors.black.withOpacity(0.06),
              blurRadius: isFeatured ? 20 : 16,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with Icon and Badge
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon in a rounded container
                Container(
                  width: 60.w,
                  height: 60.w,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: isFeatured
                          ? [
                              AppTheme.primaryColor.withOpacity(0.2),
                              AppTheme.primaryColor.withOpacity(0.1),
                            ]
                          : [
                              AppTheme.primaryColor.withOpacity(0.15),
                              AppTheme.primaryColor.withOpacity(0.08),
                            ],
                    ),
                    borderRadius: BorderRadius.circular(
                      AppTheme.radiusMedium.r,
                    ),
                  ),
                  child: Icon(
                    icon,
                    size: 30.sp,
                    color: AppTheme.primaryColor,
                  ),
                ),
                SizedBox(width: AppTheme.spacingMd.w),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: theme.textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.sp,
                          height: 1.3,
                        ),
                      ),
                      if (badgeText != null) ...[
                        SizedBox(height: AppTheme.spacingXs.h),
                        Container(
                          padding: EdgeInsets.symmetric(
                            horizontal: AppTheme.spacingSm.w,
                            vertical: AppTheme.spacingXs.h,
                          ),
                          decoration: BoxDecoration(
                            color: AppTheme.successColor.withOpacity(0.1),
                            borderRadius: BorderRadius.circular(
                              AppTheme.radiusFull.r,
                            ),
                            border: Border.all(
                              color: AppTheme.successColor.withOpacity(0.2),
                            ),
                          ),
                          child: Text(
                            badgeText!,
                            style: theme.textTheme.labelSmall?.copyWith(
                              color: AppTheme.successColor,
                              fontWeight: FontWeight.w600,
                              fontSize: 11.sp,
                            ),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: AppTheme.spacingMd.h),

            // Description
            Text(
              description,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.5,
                fontSize: 14.sp,
              ),
            ),
            SizedBox(height: AppTheme.spacingLg.h),

            // Price and Button Row
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        price,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                          fontSize: 18.sp,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 140.w,
                  child: isEnabled
                      ? ElevatedButton(
                          onPressed: onPressed,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: isFeatured
                                ? AppTheme.primaryColor
                                : AppTheme.primaryColor,
                            foregroundColor: Colors.white,
                            elevation: 0,
                            shadowColor: AppTheme.primaryColor.withOpacity(0.3),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                AppTheme.radiusMedium.r,
                              ),
                            ),
                            padding: EdgeInsets.symmetric(
                              horizontal: AppTheme.spacingMd.w,
                              vertical: AppTheme.spacingSm.h,
                            ),
                          ),
                          child: Text(
                            buttonText,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        )
                      : OutlinedButton(
                          onPressed: null,
                          style: OutlinedButton.styleFrom(
                            side: BorderSide(
                              color: theme.colorScheme.outline.withOpacity(0.5),
                              width: 1.5,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                AppTheme.radiusMedium.r,
                              ),
                            ),
                            disabledForegroundColor:
                                theme.colorScheme.onSurfaceVariant,
                          ),
                          child: Text(
                            buttonText,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
