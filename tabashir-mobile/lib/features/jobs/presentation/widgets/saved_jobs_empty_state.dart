import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tabashir/core/router/route_names.dart';
import 'package:tabashir/core/theme/app_theme.dart';

class SavedJobsEmptyState extends StatelessWidget {
  const SavedJobsEmptyState({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(vertical: AppTheme.spacingXxl.h),
      child: Column(
        children: [
          Icon(
            Icons.bookmark_border,
            size: 64.sp,
            color: theme.colorScheme.onSurfaceVariant.withValues(alpha: 0.5),
          ),
          SizedBox(height: AppTheme.spacingMd.h),
          Text(
            'No saved jobs yet',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: AppTheme.spacingSm.h),
          Text(
            "Save jobs you're interested in to view them here",
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
          ),
          SizedBox(height: AppTheme.spacingLg.h),

          // Container(
          //   height: 44.h,
          //   decoration: BoxDecoration(
          //     gradient: AppTheme.primaryGradient,
          //     borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
          //     boxShadow: [
          //       BoxShadow(
          //         color: AppTheme.primaryColor.withOpacity(0.2),
          //         blurRadius: 12,
          //         offset: const Offset(0, 4),
          //       ),
          //     ],
          //   ),

          //   // child: ElevatedButton(
          //   //   onPressed: () {
          //   //     context.push(RouteNames.jobs);
          //   //   },
          //   //   style: ElevatedButton.styleFrom(
          //   //     backgroundColor: Colors.transparent,
          //   //     foregroundColor: Colors.white,
          //   //     elevation: 0,
          //   //     shadowColor: Colors.transparent,
          //   //     shape: RoundedRectangleBorder(
          //   //       borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
          //   //     ),
          //   //     padding: EdgeInsets.symmetric(horizontal: AppTheme.spacingLg.w),
          //   //   ),
          //   //   child: Row(
          //   //     mainAxisSize: MainAxisSize.min,
          //   //     children: [
          //   //       Icon(
          //   //         Icons.search,
          //   //         size: 18.sp,
          //   //       ),
          //   //       SizedBox(width: AppTheme.spacingSm.w),
          //   //       Text(
          //   //         'Browse Jobs',
          //   //         style: TextStyle(
          //   //           fontSize: 14.sp,
          //   //           fontWeight: FontWeight.bold,
          //   //         ),
          //   //       ),
          //   //     ],
          //   //   ),
          //   // ),
          // ),
        ],
      ),
    );
  }
}
