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
  });
  final IconData icon;
  final String title;
  final String description;
  final String price;
  final String buttonText;
  final bool isEnabled;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Opacity(
      opacity: isEnabled ? 1.0 : 0.7,
      child: Container(
        padding: EdgeInsets.all(AppTheme.spacingMd.w),
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
          border: Border.all(
            color: theme.dividerTheme.color ?? AppTheme.borderLight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.04),
              blurRadius: 12,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Icon in a circular container
            Container(
              width: 64.w,
              height: 64.w,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    AppTheme.primaryColor.withOpacity(0.1),
                    AppTheme.primaryColor.withOpacity(0.05),
                  ],
                ),
                borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
              ),
              child: Icon(
                icon,
                size: 32.sp,
                color: AppTheme.primaryColor,
              ),
            ),
            SizedBox(height: AppTheme.spacingMd.h),

            // Content
            Text(
              title,
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
                fontSize: 18.sp,
              ),
            ),
            SizedBox(height: AppTheme.spacingXs.h),
            Text(
              description,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
                height: 1.5,
              ),
            ),
            SizedBox(height: AppTheme.spacingMd.h),

            // Price
            Text(
              price,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
                color: AppTheme.primaryColor,
              ),
            ),
            SizedBox(height: AppTheme.spacingMd.h),

            // Action Button
            SizedBox(
              width: double.infinity,
              height: 48.h,
              child: isEnabled
                  ? ElevatedButton(
                      onPressed: onPressed,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppTheme.primaryColor,
                        foregroundColor: Colors.white,
                        elevation: 2,
                        shadowColor: Colors.black.withOpacity(0.2),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppTheme.radiusDefault.r,
                          ),
                        ),
                        padding: EdgeInsets.symmetric(
                          vertical: AppTheme.spacingSm.h,
                        ),
                      ),
                      child: Text(
                        buttonText,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    )
                  : OutlinedButton(
                      onPressed: null,
                      style: OutlinedButton.styleFrom(
                        side: BorderSide(
                          color: theme.colorScheme.outline.withOpacity(0.5),
                          width: 2,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            AppTheme.radiusDefault.r,
                          ),
                        ),
                        disabledForegroundColor:
                            theme.colorScheme.onSurfaceVariant,
                      ),
                      child: Text(
                        buttonText,
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
