import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabashir/core/network/models/resume_response/resume_item.dart';
import 'package:tabashir/features/resume/domain/repositories/resume_vault_repository.dart';
import '../../../../core/theme/app_theme.dart';

class ResumeCard extends StatelessWidget {
  const ResumeCard({
    required this.resume,
    this.onTap,
    this.onMorePressed,
    super.key,
  });
  final ResumeItem resume;
  final VoidCallback? onTap;
  final VoidCallback? onMorePressed;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
      child: Container(
        padding: EdgeInsets.all(AppTheme.spacingMd.w),
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 8,
              offset: const Offset(0, 1),
            ),
          ],
          border: Border.all(
            color: resume.isDefault
                ? AppTheme.primaryColor
                : theme.brightness == Brightness.light
                ? AppTheme.borderLight
                : AppTheme.borderDark,
            width: resume.isDefault ? 2 : 1,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Row
            Row(
              children: [
                // File Icon
                Container(
                  width: 48.w,
                  height: 48.w,
                  decoration: BoxDecoration(
                    color: resume.isDefault
                        ? AppTheme.primaryColor.withOpacity(0.1)
                        : theme.colorScheme.primaryContainer,
                    borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
                  ),
                  child: Icon(
                    _getFileIcon(resume.fileType),
                    color: resume.isDefault
                        ? AppTheme.primaryColor
                        : theme.colorScheme.primary,
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: AppTheme.spacingMd.w),
                // Title and Subtitle
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              resume.title.isNotEmpty
                                  ? resume.title
                                  : 'Untitled Resume',
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (resume.isDefault) ...[
                            SizedBox(width: AppTheme.spacingXs.w),
                            Container(
                              padding: EdgeInsets.symmetric(
                                horizontal: AppTheme.spacingSm.w,
                                vertical: 2.h,
                              ),
                              decoration: BoxDecoration(
                                color: AppTheme.primaryColor.withOpacity(0.1),
                                borderRadius: BorderRadius.circular(
                                  AppTheme.radiusSmall.r,
                                ),
                              ),
                              child: Text(
                                'Default',
                                style: theme.textTheme.labelSmall?.copyWith(
                                  color: AppTheme.primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                          ],
                        ],
                      ),
                      SizedBox(height: AppTheme.spacingXs.h),
                      Text(
                        _getFileInfo(resume),
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: theme.brightness == Brightness.light
                              ? AppTheme.textMutedLight
                              : AppTheme.textMutedDark,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
                // More Button
                IconButton(
                  onPressed: onMorePressed,
                  icon: Icon(
                    Icons.more_vert,
                    color: theme.brightness == Brightness.light
                        ? AppTheme.textMutedLight
                        : AppTheme.textMutedDark,
                    size: 20.sp,
                  ),
                  padding: EdgeInsets.zero,
                  constraints: const BoxConstraints(),
                ),
              ],
            ),
            SizedBox(height: AppTheme.spacingMd.h),
            // Divider
            Divider(
              color: theme.brightness == Brightness.light
                  ? AppTheme.borderLight
                  : AppTheme.borderDark,
              thickness: 1,
              height: 1,
            ),
            SizedBox(height: AppTheme.spacingMd.h),
            // Footer Info
            Row(
              children: [
                Icon(
                  Icons.insert_drive_file,
                  size: 16.sp,
                  color: theme.brightness == Brightness.light
                      ? AppTheme.textMutedLight
                      : AppTheme.textMutedDark,
                ),
                SizedBox(width: AppTheme.spacingXs.w),
                // Show file size only if greater than 0
                if (resume.fileSize > 0) ...[
                  Text(
                    '${resume.fileType} • ${_formatFileSize(resume.fileSize)}',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.brightness == Brightness.light
                          ? AppTheme.textMutedLight
                          : AppTheme.textMutedDark,
                    ),
                  ),
                ] else ...[
                  Text(
                    resume.fileType,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.brightness == Brightness.light
                          ? AppTheme.textMutedLight
                          : AppTheme.textMutedDark,
                    ),
                  ),
                ],
                const Spacer(),
                Icon(
                  Icons.access_time,
                  size: 16.sp,
                  color: theme.brightness == Brightness.light
                      ? AppTheme.textMutedLight
                      : AppTheme.textMutedDark,
                ),
                SizedBox(width: AppTheme.spacingXs.w),
                Text(
                  resume.lastModified,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.brightness == Brightness.light
                        ? AppTheme.textMutedLight
                        : AppTheme.textMutedDark,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  IconData _getFileIcon(String fileType) {
    switch (fileType.toUpperCase()) {
      case 'PDF':
        return Icons.picture_as_pdf;
      case 'DOC':
      case 'DOCX':
        return Icons.description;
      default:
        return Icons.insert_drive_file;
    }
  }

  String _formatFileSize(int bytes) {
    if (bytes < 1024) {
      return '$bytes B';
    } else if (bytes < 1024 * 1024) {
      return '${(bytes / 1024).toStringAsFixed(1)} KB';
    } else {
      return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
    }
  }

  String _getFileInfo(ResumeItem resume) {
    // Show file path or useful info in subtitle
    if (resume.filePath.isNotEmpty) {
      // Extract filename from path
      final uri = Uri.tryParse(resume.filePath);
      final fileName = uri?.pathSegments.last ?? 'Resume file';
      return fileName;
    }
    // Fallback to file type
    return '${resume.fileType} file';
  }
}
