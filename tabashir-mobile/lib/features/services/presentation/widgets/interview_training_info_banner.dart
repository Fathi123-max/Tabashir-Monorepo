import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabashir/core/theme/app_theme.dart';

class InterviewTrainingInfoBanner extends StatelessWidget {
  const InterviewTrainingInfoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(AppTheme.spacingMd.w),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color(0xFFDEEBFF),
            Color(0xFFE0E7FF),
          ],
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
      ),
      child: Row(
        children: [
          Text(
            '✨',
            style: TextStyle(fontSize: 18.sp),
          ),
          SizedBox(width: AppTheme.spacingSm.w),
          Expanded(
            child: Text(
              '87% of users who practice interviews land offers faster.',
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
                color: const Color(0xFF1E293B),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
