import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/features/ai_job_apply/data/models/location_preference_model.dart';

/// Reusable chip widget for location selection
class LocationChip extends StatelessWidget {
  /// Creates a location chip
  const LocationChip({
    required this.location,
    required this.isSelected,
    required this.onTap,
    super.key,
  });

  /// The location data model
  final LocationPreferenceModel location;

  /// Whether this chip is currently selected
  final bool isSelected;

  /// Callback when chip is tapped
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
      height: 40.h,
      padding: EdgeInsets.symmetric(
        horizontal: 16.w,
        vertical: 8.h,
      ),
      decoration: BoxDecoration(
        color: isSelected ? AppTheme.white : Colors.transparent,
        borderRadius: BorderRadius.circular(20.r),
        border: Border.all(
          color: isSelected
              ? Colors.transparent
              : AppTheme.white.withOpacity(0.5),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (isSelected) ...[
            Icon(
              Icons.check,
              size: 16.sp,
              color: AppTheme.primaryColor,
            ),
            SizedBox(width: 8.w),
          ],
          Flexible(
            child: Text(
              location.name,
              style: TextStyle(
                color: isSelected ? AppTheme.primaryColor : AppTheme.white,
                fontSize: 14.sp,
                fontWeight: FontWeight.w500,
                height: 1.2,
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    ),
  );
}
