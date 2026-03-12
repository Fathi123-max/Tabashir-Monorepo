import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tabashir/core/theme/app_theme.dart';

class SavedJobsHeader extends StatelessWidget {
  const SavedJobsHeader({
    required this.savedJobsCount,
    super.key,
  });

  final int savedJobsCount;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(AppTheme.spacingMd.w),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor.withOpacity(0.8),
      ),
      child: Row(
        children: [
          // // Back Button
          // Container(
          //   width: 40.w,
          //   height: 40.w,
          //   decoration: const BoxDecoration(
          //     shape: BoxShape.circle,
          //   ),
          //   child: IconButton(
          //     onPressed: () {
          //       context.pop();
          //     },
          //     icon: Icon(
          //       Icons.arrow_back,
          //       size: 24.sp,
          //       color: theme.iconTheme.color,
          //     ),
          //     padding: EdgeInsets.zero,
          //   ),
          // ),
          // SizedBox(width: AppTheme.spacingMd.w),

          // Title
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Saved Jobs',
                  style: theme.textTheme.displayMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (savedJobsCount > 0)
                  Text(
                    '$savedJobsCount ${savedJobsCount == 1 ? 'job' : 'jobs'} saved',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
