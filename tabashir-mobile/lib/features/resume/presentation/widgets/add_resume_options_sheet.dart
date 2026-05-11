import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_theme.dart';
import '../cubit/resume_vault_cubit.dart';
import 'package:tabashir/core/utils/app_logger.dart';

/// Widget for displaying add resume options bottom sheet
class AddResumeOptionsSheet extends StatelessWidget {
  const AddResumeOptionsSheet({super.key});

  static Future<void> show(BuildContext context) {
    final cubit = context.read<ResumeVaultCubit>();
    return showModalBottomSheet<Widget>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => BlocProvider.value(
        value: cubit,
        child: const AddResumeOptionsSheet(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<ResumeVaultCubit, ResumeVaultState>(
      builder: (context, state) => Container(
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppTheme.radiusLarge.r),
          ),
        ),
        padding: EdgeInsets.all(AppTheme.spacingLg.w),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 40.w,
              height: 4.h,
              decoration: BoxDecoration(
                color: theme.brightness == Brightness.light
                    ? AppTheme.textMutedLight
                    : AppTheme.textMutedDark,
                borderRadius: BorderRadius.circular(AppTheme.radiusFull.r),
              ),
            ),
            SizedBox(height: AppTheme.spacingLg.h),
            Text(
              'Add New Resume'.tr(),
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppTheme.spacingLg.h),
            ListTile(
              leading: Icon(
                state.isUploading ? Icons.hourglass_top : Icons.document_scanner_outlined,
                color: state.isUploading ? AppTheme.primaryColor : null,
              ),
              title: Text(
                state.isUploading
                    ? 'Reformatting resume...'.tr()
                    : 'Reformat to ATS'.tr(),
              ),
              subtitle: Text(
                state.isUploading
                    ? 'Please wait while we reformat your resume'.tr()
                    : 'Upload existing resume to optimize for ATS'.tr(),
              ),
              onTap: state.isUploading
                  ? null
                  : () async {
                      await _uploadFromDevice(context, isReformat: true);
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
            ),
            ListTile(
              leading: const Icon(Icons.create_outlined),
              title: Text('Build from Scratch'.tr()),
              subtitle: Text('Generate a new resume with AI assistance'.tr()),
              onTap: state.isUploading
                  ? null
                  : () {
                      Navigator.pop(context);
                      context.push(RouteNames.aiResumeBuilder);
                    },
            ),
            // ListTile(
            //   leading: const Icon(Icons.edit_document),
            //   title: Text('Use Resume Builder'.tr()),
            //   subtitle: Text('Build resume from scratch'.tr()),
            //   onTap: state.isUploading
            //       ? null
            //       : () {
            //           Navigator.pop(context);
            //           context.push(RouteNames.resumeBuilder);
            //         },
            // ),

            // ListTile(
            //   leading: const Icon(Icons.cloud_upload),
            //   title: Text('Import from Cloud'.tr()),
            //   subtitle: Text('Import from Google Drive, Dropbox'.tr()),
            //   onTap: state.isUploading
            //       ? null
            //       : () {
            //           Navigator.pop(context);
            //           _importFromCloud(context);
            //         },
            // ),
          ],
        ),
      ),
    );
  }

  Future<void> _uploadFromDevice(BuildContext context, {bool isReformat = false}) async {
    AppLogger.debug('🟢 [ADD_RESUME_SHEET] _uploadFromDevice() called (isReformat: $isReformat)', tag: 'Resume');
    try {
      final cubit = context.read<ResumeVaultCubit>();

      // If reformatting, ask for desired output format first
      String? outputFormat;
      if (isReformat) {
        outputFormat = await showDialog<String>(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('Select Output Format'.tr()),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  ListTile(
                    leading: const Icon(Icons.picture_as_pdf, color: Colors.red),
                    title: const Text('PDF Document'),
                    onTap: () => Navigator.pop(context, 'pdf'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.description, color: Colors.blue),
                    title: const Text('Word Document (DOCX)'),
                    onTap: () => Navigator.pop(context, 'docx'),
                  ),
                ],
              ),
              actions: [
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: Text('Cancel'.tr()),
                ),
              ],
            );
          },
        );

        if (outputFormat == null) return; // User cancelled
      }

      AppLogger.debug('🟢 [ADD_RESUME_SHEET] Opening file picker...', tag: 'Resume');
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'docx'],
      );
      
      if (result == null || result.files.isEmpty) return;

      final file = result.files.single;
      if (file.path == null) return;

      final fileName = file.name;
      final filePath = file.path!;
      final fileSize = file.size;
      final fileExtension = file.extension?.toLowerCase() ?? '';

      if (fileSize > 10 * 1024 * 1024) {
        AppLogger.debug('🟢 [ADD_RESUME_SHEET] File too large');
        return;
      }

      if (isReformat) {
        await cubit.reformatResume(
          fileName: fileName,
          filePath: filePath,
          fileType: fileExtension,
          fileSize: fileSize,
          outputFormat: outputFormat,
        );
      } else {
        await cubit.uploadResume(
          fileName: fileName,
          filePath: filePath,
          fileType: fileExtension,
          fileSize: fileSize,
        );
      }
    } catch (e, stackTrace) {
      AppLogger.error('🟢 [ADD_RESUME_SHEET] ❌ Exception: $e', tag: 'Resume', error: e);
    }
  }

  void _importFromCloud(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Cloud import feature coming soon!'.tr()),
        backgroundColor: AppTheme.warningColor,
      ),
    );
  }
}
