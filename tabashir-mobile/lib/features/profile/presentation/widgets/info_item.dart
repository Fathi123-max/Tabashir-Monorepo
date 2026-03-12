import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme.dart';

class InfoItem extends StatelessWidget {
  const InfoItem({
    required this.icon,
    required this.text,
    super.key,
    this.onEdit,
    this.trailing,
  });
  final IconData icon;
  final String text;
  final VoidCallback? onEdit;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
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
            color: Theme.of(context).colorScheme.primary,
          ),
          SizedBox(width: AppTheme.spacingMd.w),
          Expanded(
            child: Text(
              text,
              style: theme.textTheme.bodyLarge,
            ),
          ),
          if (trailing != null)
            trailing!
          else if (onEdit != null)
            TextButton(
              onPressed: onEdit,
              style: TextButton.styleFrom(
                padding: EdgeInsets.zero,
                minimumSize: Size.zero,
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Edit',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.primaryColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
