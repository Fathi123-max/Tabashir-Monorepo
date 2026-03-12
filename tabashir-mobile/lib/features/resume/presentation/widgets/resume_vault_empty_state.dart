import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../core/theme/app_theme.dart';

/// Widget for displaying empty state when no resumes exist
class ResumeVaultEmptyState extends StatelessWidget {
  const ResumeVaultEmptyState({
    required this.onAddResume,
    super.key,
  });

  final VoidCallback onAddResume;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppTheme.spacingXl.w),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.folder_open,
              size: 80.sp,
              color: theme.brightness == Brightness.light
                  ? AppTheme.textMutedLight
                  : AppTheme.textMutedDark,
            ),
            SizedBox(height: AppTheme.spacingLg.h),
            Text(
              'No Resumes Yet',
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppTheme.spacingMd.h),
            Text(
              'Add your first resume to get started with job applications',
              style: theme.textTheme.bodyLarge?.copyWith(
                color: theme.brightness == Brightness.light
                    ? AppTheme.textMutedLight
                    : AppTheme.textMutedDark,
              ),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: AppTheme.spacingXl.h),
            ElevatedButton.icon(
              onPressed: onAddResume,
              icon: const Icon(Icons.add_circle),
              label: const Text('Add Your First Resume'),
              style: AppTheme.primaryButtonStyle,
            ),
          ],
        ),
      ),
    );
  }
}
