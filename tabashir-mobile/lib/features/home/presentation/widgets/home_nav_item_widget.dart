import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabashir/core/theme/app_theme.dart';

class HomeNavItemWidget extends StatelessWidget {
  const HomeNavItemWidget({
    required this.icon,
    required this.label,
    required this.isSelected,
    super.key,
  });
  final IconData icon;
  final String label;
  final bool isSelected;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
      child: Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppTheme.spacingSm.w,
          vertical: AppTheme.spacingXs.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Icon with gradient for selected state
            if (isSelected)
              ShaderMask(
                shaderCallback: (bounds) =>
                    AppTheme.primaryGradient.createShader(bounds),
                child: Icon(
                  icon,
                  size: 24.sp,
                  color: Colors.white,
                ),
              )
            else
              Icon(
                icon,
                size: 24.sp,
                color: theme.bottomNavigationBarTheme.unselectedItemColor,
              ),
            SizedBox(height: 4.h),

            // Label with gradient for selected state
            if (isSelected)
              ShaderMask(
                shaderCallback: (bounds) =>
                    AppTheme.primaryGradient.createShader(bounds),
                child: Text(
                  label,
                  style: theme.bottomNavigationBarTheme.selectedLabelStyle
                      ?.copyWith(
                        color: Colors.white,
                      ),
                ),
              )
            else
              Text(
                label,
                style: theme.bottomNavigationBarTheme.unselectedLabelStyle
                    ?.copyWith(
                      color: theme.bottomNavigationBarTheme.unselectedItemColor,
                    ),
              ),

            // Indicator dot for selected state
            if (isSelected)
              Container(
                margin: EdgeInsets.only(top: 4.h),
                width: 32.w,
                height: 4.h,
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient,
                  borderRadius: BorderRadius.circular(AppTheme.radiusFull.r),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
