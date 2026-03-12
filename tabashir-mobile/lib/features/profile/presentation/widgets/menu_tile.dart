import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme.dart';

class MenuTile extends StatelessWidget {
  const MenuTile({
    required this.icon,
    required this.text,
    super.key,
    this.showLogoutColor = false,
    this.onTap,
    this.trailing,
  });
  final IconData icon;
  final String text;
  final bool showLogoutColor;
  final VoidCallback? onTap;
  final Widget? trailing;

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
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            Icon(
              icon,
              size: 24.sp,
              color: showLogoutColor
                  ? AppTheme.errorColor
                  : theme.colorScheme.primary,
            ),
            SizedBox(width: AppTheme.spacingMd.w),
            Expanded(
              child: Text(
                text,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: showLogoutColor
                      ? AppTheme.errorColor
                      : theme.textTheme.bodyLarge?.color,
                ),
              ),
            ),
            if (trailing != null) ...[
              SizedBox(width: AppTheme.spacingSm.w),
              trailing!,
              SizedBox(width: AppTheme.spacingSm.w),
            ] else ...[
              Icon(
                Icons.chevron_right,
                color: theme.colorScheme.onSurfaceVariant,
                size: 24.sp,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
