import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/features/ai_job_apply/data/models/target_role_model.dart';

/// Reusable chip widget for role selection
class RoleChip extends StatelessWidget {
  /// Creates a role chip
  const RoleChip({
    required this.role,
    required this.isSelected,
    required this.onTap,
    super.key,
    this.onRemove,
  });

  /// The role data model
  final TargetRoleModel role;

  /// Whether this chip is currently selected
  final bool isSelected;

  /// Callback when chip is tapped
  final VoidCallback onTap;

  /// Callback when remove button is tapped (optional)
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      height: 44.h,
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 8.h,
      ),
      decoration: BoxDecoration(
        color: isSelected ? AppTheme.white : AppTheme.white.withOpacity(0.2),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppTheme.white.withOpacity(0.3),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Flexible(
            child: Text(
              role.title,
              style: TextStyle(
                color: isSelected ? AppTheme.primaryColor : AppTheme.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
                height: 1.2,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
          if (onRemove != null) ...[
            SizedBox(width: 8.w),
            GestureDetector(
              onTap: (onTap != null) ? onRemove : null,
              child: Icon(
                Icons.close,
                size: 20.sp,
                color: isSelected ? AppTheme.primaryColor : AppTheme.white,
              ),
            ),
          ],
        ],
      ),
    ),
  );
}
