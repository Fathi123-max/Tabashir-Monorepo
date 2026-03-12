import 'package:easy_localization/easy_localization.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_theme.dart';
import '../cubit/resume_vault_cubit.dart';

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
                state.isUploading ? Icons.hourglass_top : Icons.upload_file,
                color: state.isUploading ? AppTheme.primaryColor : null,
              ),
              title: Text(
                state.isUploading
                    ? 'Uploading resume...'.tr()
                    : 'Upload from Device'.tr(),
              ),
              subtitle: Text(
                state.isUploading
                    ? 'Please wait while we upload your resume'.tr()
                    : 'Upload PDF or DOCX files'.tr(),
              ),
              onTap: state.isUploading
                  ? null
                  : () async {
                      await _uploadFromDevice(context);
                      if (context.mounted) {
                        Navigator.pop(context);
                      }
                    },
            ),
            ListTile(
              leading: const Icon(Icons.auto_awesome),
              title: Text('Create with AI'.tr()),
              subtitle: Text('Generate resume with AI assistance'.tr()),
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

  Future<void> _uploadFromDevice(BuildContext context) async {
    print('🟢 [ADD_RESUME_SHEET] _uploadFromDevice() called');
    try {
      final cubit = context.read<ResumeVaultCubit>();
      print('🟢 [ADD_RESUME_SHEET] Got ResumeVaultCubit instance');

      print('🟢 [ADD_RESUME_SHEET] Opening file picker...');
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'docx'],
      );
      print(
        '🟢 [ADD_RESUME_SHEET] File picker returned: ${result != null ? 'files selected' : 'user cancelled or null'}',
      );

      if (result == null) {
        print(
          '🟢 [ADD_RESUME_SHEET] File picker returned null (user cancelled or no permission)',
        );
        return;
      }

      if (result.files.isEmpty) {
        print('🟢 [ADD_RESUME_SHEET] No files selected');
        return;
      }

      final file = result.files.single;
      print('🟢 [ADD_RESUME_SHEET] File details:');
      print('🟢 [ADD_RESUME_SHEET]   - Name: ${file.name}');
      print('🟢 [ADD_RESUME_SHEET]   - Path: ${file.path}');
      print('🟢 [ADD_RESUME_SHEET]   - Size: ${file.size} bytes');
      print('🟢 [ADD_RESUME_SHEET]   - Extension: ${file.extension}');

      if (file.path == null) {
        print('🟢 [ADD_RESUME_SHEET] File path is null - cannot upload');
        // File path is null, nothing to upload
        return;
      }

      final fileName = file.name;
      final filePath = file.path!;
      final fileSize = file.size;
      final fileExtension = file.extension?.toLowerCase() ?? '';

      print('🟢 [ADD_RESUME_SHEET] File validation:');
      print('🟢 [ADD_RESUME_SHEET]   - fileSize: $fileSize bytes');
      print('🟢 [ADD_RESUME_SHEET]   - fileExtension: $fileExtension');

      if (fileSize > 10 * 1024 * 1024) {
        print(
          '🟢 [ADD_RESUME_SHEET] File too large (${fileSize} bytes > 10MB)',
        );
        // File too large, nothing to upload
        return;
      }

      print(
        '🟢 [ADD_RESUME_SHEET] File validation passed. Calling cubit.uploadResume()...',
      );
      await cubit.uploadResume(
        fileName: fileName,
        filePath: filePath,
        fileType: fileExtension,
        fileSize: fileSize,
      );
      print('🟢 [ADD_RESUME_SHEET] ✅ cubit.uploadResume() completed');
      print(
        '🟢 [ADD_RESUME_SHEET] Upload initiated - UI will update via state changes',
      );
      // Note: onTap handler will close the sheet after this method completes
    } catch (e, stackTrace) {
      print('🟢 [ADD_RESUME_SHEET] ❌ Exception occurred: $e');
      print('🟢 [ADD_RESUME_SHEET] StackTrace: $stackTrace');
      // Errors will be handled by the cubit's error state
      // The screen's BlocListener will show error messages
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
