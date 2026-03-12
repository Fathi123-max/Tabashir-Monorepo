import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/features/ai_job_apply/data/models/location_preference_model.dart';

/// Reusable widget displaying AI location suggestion
class AILocationSuggestion extends StatelessWidget {
  /// Creates an AI location suggestion widget
  const AILocationSuggestion({
    required this.suggestion,
    required this.onTap,
    super.key,
  });

  /// The AI suggestion model
  final LocationPreferenceModel suggestion;

  /// Callback when suggestion is tapped
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: onTap,
    child: Container(
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
            // Spark icon
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
                    : 'Consider adding ${suggestion.name} — it has great opportunities.',
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
    ),
  );
}
