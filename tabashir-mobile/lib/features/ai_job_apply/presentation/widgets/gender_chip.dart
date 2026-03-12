import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/features/ai_job_apply/data/models/personal_details_model.dart';

/// Reusable chip widget for gender selection
class GenderChip extends StatelessWidget {
  /// Creates a gender chip
  const GenderChip({
    required this.gender,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  /// The gender selection
  final Gender gender;

  /// Whether this chip is currently selected
  final bool isSelected;

  /// Callback when chip is tapped
  final VoidCallback onTap;

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
        color: isSelected ? AppTheme.white : AppTheme.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: isSelected
              ? AppTheme.primaryColor
              : AppTheme.white.withOpacity(0.3),
        ),
      ),
      child: Center(
        child: Text(
          _getDisplayName(gender),
          style: TextStyle(
            color: isSelected ? AppTheme.primaryColor : AppTheme.white,
            fontSize: 14.sp,
            fontWeight: FontWeight.w500,
            height: 1.2,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    ),
  );

  String _getDisplayName(Gender gender) {
    switch (gender) {
      case Gender.male:
        return 'Male';
      case Gender.female:
        return 'Female';
      case Gender.preferNotToSay:
        return 'Prefer not to say';
    }
  }
}
