import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/router/route_names.dart';
import '../../domain/repositories/resume_vault_repository.dart';
import '../../../../core/network/models/resume_response/resume_item.dart';
import '../cubit/resume_vault_cubit.dart';

/// Widget for displaying resume options bottom sheet
class ResumeVaultOptionsSheet extends StatelessWidget {
  const ResumeVaultOptionsSheet({
    required this.resume,
    required this.index,
    required this.cubit,
    super.key,
  });

  final ResumeItem resume;
  final int index;
  final ResumeVaultCubit cubit;

  static Future<void> show(
    BuildContext context,
    ResumeItem resume,
    int index,
    ResumeVaultCubit cubit,
  ) => showModalBottomSheet<Widget>(
    context: context,
    backgroundColor: Theme.of(context).cardTheme.color,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(
        top: Radius.circular(AppTheme.radiusLarge.r),
      ),
    ),
    builder: (context) => ResumeVaultOptionsSheet(
      resume: resume,
      index: index,
      cubit: cubit,
    ),
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
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
            resume.name,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: AppTheme.spacingLg.h),
          ..._buildOptionTiles(context),
        ],
      ),
    );
  }

  List<Widget> _buildOptionTiles(BuildContext context) => [
    if (!resume.isDefault)
      ListTile(
        leading: const Icon(Icons.check_circle_outline),
        title: const Text('Set as Default'),
        onTap: () {
          Navigator.pop(context);
          cubit.setDefaultResume(resume.id);
        },
      ),
    ListTile(
      leading: const Icon(Icons.visibility),
      title: const Text('View'),
      onTap: () {
        Navigator.pop(context);
        _viewResume(context);
      },
    ),
    // Hidden: Make a Copy option removed
    // Hidden: Rename option removed
    ListTile(
      leading: const Icon(Icons.share),
      title: const Text('Share'),
      onTap: () {
        Navigator.pop(context);
        _shareResume(context);
      },
    ),
    ListTile(
      leading: Icon(
        Icons.delete,
        color: AppTheme.errorColor,
      ),
      title: Text(
        'Delete',
        style: TextStyle(color: AppTheme.errorColor),
      ),
      onTap: () {
        Navigator.pop(context);
        _confirmDelete(context);
      },
    ),
  ];

  void _viewResume(BuildContext context) {
    // Map repository ResumeItem to core ResumeItem for preview
    final coreResume = ResumeItem(
      id: resume.id,
      filename: resume.name,
      originalUrl: resume.filePath,
      formatedUrl: null,
      isAiResume: false,
      createdAt: DateTime.now(), // Not used in preview
      updatedAt: DateTime.now(), // Not used in preview
    );

    context.push(
      RouteNames.resumePreview,
      extra: coreResume,
    );
  }

  void _confirmDelete(BuildContext context) {
    final theme = Theme.of(context);

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: theme.cardTheme.color,
        title: const Text('Delete Resume'),
        content: Text(
          'Are you sure you want to delete "${resume.name}"? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
              cubit.deleteResume(resume.id);
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Resume deleted successfully'),
                  backgroundColor: AppTheme.successColor,
                ),
              );
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.errorColor,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  void _showRenameDialog(BuildContext context) {
    final controller = TextEditingController(text: resume.name);
    final formKey = GlobalKey<FormState>();

    showDialog<void>(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Theme.of(context).cardTheme.color,
        title: const Text('Rename Resume'),
        content: Form(
          key: formKey,
          child: TextFormField(
            controller: controller,
            decoration: const InputDecoration(
              hintText: 'Enter resume name',
            ),
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Name cannot be empty';
              }
              return null;
            },
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              if (formKey.currentState?.validate() ?? false) {
                Navigator.pop(context);
                cubit.renameResume(
                  resume.id,
                  controller.text.trim(),
                );
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: const Text('Resume renamed successfully'),
                    backgroundColor: AppTheme.successColor,
                  ),
                );
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  Future<void> _shareResume(BuildContext context) async {
    try {
      final scaffoldMessenger = ScaffoldMessenger.of(context);

      // Download the file first
      final dir = await getTemporaryDirectory();
      final fileName = '${resume.name}.pdf';
      final filePath = '${dir.path}/$fileName';

      final dio = Dio();
      // For local files, we might not need to download if it's already a local path
      // But if it's a URL, we download it.
      // Since we are in the vault, it's likely a local path, but let's handle both.

      if (resume.filePath.startsWith('http')) {
        await dio.download(
          resume.filePath,
          filePath,
        );
      } else {
        // It's a local file, just copy it to temp for sharing if needed,
        // or just share directly if path is accessible.
        // For safety, let's copy to temp.
        final sourceFile = File(resume.filePath);
        if (await sourceFile.exists()) {
          await sourceFile.copy(filePath);
        } else {
          throw Exception('File not found at ${resume.filePath}');
        }
      }

      // Share the file
      final file = XFile(filePath, mimeType: 'application/pdf');
      await Share.shareXFiles(
        [file],
        subject: 'Resume: ${resume.name}',
        text: 'Check out my resume',
      );

      scaffoldMessenger.showSnackBar(
        SnackBar(
          content: const Text('Resume ready to share'),
          backgroundColor: AppTheme.successColor,
        ),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to share resume: $e'),
          backgroundColor: AppTheme.errorColor,
        ),
      );
    }
  }
}
