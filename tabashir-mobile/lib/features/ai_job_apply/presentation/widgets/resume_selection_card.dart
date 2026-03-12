import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/features/ai_job_apply/data/models/resume_selection_model.dart';

/// Reusable card widget for resume selection
class ResumeSelectionCard extends StatelessWidget {
  /// Creates a resume selection card
  const ResumeSelectionCard({
    required this.resume,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  /// The resume data model
  final ResumeSelectionModel resume;

  /// Whether this card is currently selected
  final bool isSelected;

  /// Callback when card is tapped
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: isSelected
                ? AppTheme.primaryColor
                : AppTheme.white.withOpacity(0.3),
            width: 1.5,
          ),
          borderRadius: BorderRadius.circular(12.r),
          color: isSelected ? AppTheme.white : AppTheme.white.withOpacity(0.1),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Row(
          children: [
            // Radio button
            Padding(
              padding: EdgeInsets.only(left: 15.w),
              child: Radio<String>(
                value: resume.id,
                groupValue: isSelected ? resume.id : null,
                onChanged: (_) => onTap(),
                activeColor: AppTheme.primaryColor,
                splashRadius: 20,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ),
            // Resume info
            Expanded(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 15.h,
                  horizontal: 12.w,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      resume.title,
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.zinc900,
                      ),
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      resume.description,
                      style: TextStyle(
                        fontSize: 12.sp,
                        color: AppTheme.zinc500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Check icon for selected state
            if (isSelected)
              Padding(
                padding: EdgeInsets.only(right: 15.w),
                child: Icon(
                  Icons.check_circle,
                  color: AppTheme.primaryColor,
                  size: 24.sp,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
