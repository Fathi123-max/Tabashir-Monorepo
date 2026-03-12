import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabashir/core/theme/app_theme.dart';

class NavItem extends StatelessWidget {
  const NavItem({
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
    final color = isSelected
        ? theme.bottomNavigationBarTheme.selectedItemColor ??
              AppTheme.primaryColor
        : theme.bottomNavigationBarTheme.unselectedItemColor;

    return InkWell(
      onTap: () {},
      borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: AppTheme.spacingSm.w,
          vertical: AppTheme.spacingXs.h,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              color: color,
              size: 24.sp,
            ),
            SizedBox(height: 4.h),
            Text(
              label,
              style:
                  (isSelected
                          ? theme.bottomNavigationBarTheme.selectedLabelStyle
                          : theme.bottomNavigationBarTheme.unselectedLabelStyle)
                      ?.copyWith(color: color),
            ),
          ],
        ),
      ),
    );
  }
}
