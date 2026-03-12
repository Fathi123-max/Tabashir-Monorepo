import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/features/ai_job_apply/data/models/target_role_model.dart';

/// Reusable widget displaying AI role suggestion
class AIRoleSuggestion extends StatelessWidget {
  /// Creates an AI role suggestion widget
  const AIRoleSuggestion({
    required this.suggestion,
    required this.onAdd,
    super.key,
  });

  /// The AI suggestion model
  final TargetRoleModel suggestion;

  /// Callback when add button is tapped
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      color: AppTheme.white.withOpacity(0.1),
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(
        color: AppTheme.white.withOpacity(0.2),
      ),
    ),
    child: Padding(
      padding: EdgeInsets.all(16.w),
      child: Row(
        children: [
          // AI Icon
          Container(
            width: 40.w,
            height: 40.w,
            decoration: BoxDecoration(
              color: AppTheme.white.withOpacity(0.2),
              borderRadius: BorderRadius.circular(8.r),
            ),
            child: Icon(
              Icons.auto_awesome,
              color: AppTheme.white,
              size: 24.sp,
            ),
          ),
          SizedBox(width: 16.w),
          // Suggestion text
          Expanded(
            child: Text(
              suggestion.description.isNotEmpty
                  ? suggestion.description
                  : "Adding '${suggestion.title}' could unlock ${suggestion.potentialRoles} senior roles.",
              style: TextStyle(
                color: AppTheme.white,
                fontSize: 16.sp,
                fontWeight: FontWeight.normal,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
