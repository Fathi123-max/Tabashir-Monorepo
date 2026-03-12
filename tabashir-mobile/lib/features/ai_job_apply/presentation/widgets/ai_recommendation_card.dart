import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabashir/core/theme/app_theme.dart';

/// Reusable card widget displaying AI recommendation
class AIRecommendationCard extends StatelessWidget {
  /// Creates an AI recommendation card
  const AIRecommendationCard({
    required this.resumeTitle,
    required this.matchPercentage,
    super.key,
  });

  /// Recommended resume title
  final String resumeTitle;

  /// Match percentage (0-100)
  final int matchPercentage;

  @override
  Widget build(BuildContext context) => Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12.r),
      gradient: LinearGradient(
        begin: Alignment.topLeft,
        end: Alignment.bottomRight,
        colors: [
          AppTheme.blue900, // #042052
          AppTheme.primaryColor, // #0D57E1
        ],
        stops: const [0.0, 1.0],
      ),
      boxShadow: [
        BoxShadow(
          color: AppTheme.primaryColor.withValues(alpha: 0.3),
          blurRadius: 12,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Padding(
      padding: EdgeInsets.all(16.w),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // AI icon
          Padding(
            padding: EdgeInsets.only(top: 4.h),
            child: Icon(
              Icons.auto_awesome,
              color: AppTheme.white,
              size: 32.sp,
            ),
          ),
          SizedBox(width: 16.w),
          // Recommendation text
          Expanded(
            child: Text(
              "I recommend your '$resumeTitle' resume — it matches $matchPercentage% of target roles.",
              style: Theme.of(context).textTheme.labelMedium?.copyWith(
                color: AppTheme.white,
                height: 1.5,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
