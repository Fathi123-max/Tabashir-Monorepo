import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/router/route_names.dart';

/// Bottom sheet for creating a new resume
class CreateResumeBottomSheet extends StatelessWidget {
  const CreateResumeBottomSheet({super.key});

  static Future<void> show(BuildContext context) =>
      showModalBottomSheet<Widget>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (context) => const CreateResumeBottomSheet(),
      );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.r),
        ),
      ),
      padding: EdgeInsets.all(24.w),
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
              borderRadius: BorderRadius.circular(2.r),
            ),
          ),
          SizedBox(height: 24.h),
          Text(
            'Add New Resume',
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 24.h),
          ListTile(
            leading: Icon(
              Icons.auto_awesome,
              color: AppTheme.primaryColor,
            ),
            title: const Text('Create with AI'),
            subtitle: const Text('Generate resume with AI assistance'),
            onTap: () {
              Navigator.pop(context);
              context.push(RouteNames.aiResumeBuilder);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.edit_document,
              color: AppTheme.primaryColor,
            ),
            title: const Text('Use Resume Builder'),
            subtitle: const Text('Build resume from scratch'),
            onTap: () {
              Navigator.pop(context);
              context.push(RouteNames.resumeBuilder);
            },
          ),
          ListTile(
            leading: Icon(
              Icons.upload_file,
              color: AppTheme.primaryColor,
            ),
            title: const Text('Upload from Device'),
            subtitle: const Text('Upload PDF or DOCX files'),
            onTap: () {
              Navigator.pop(context);
              _showUploadInfo(context);
            },
          ),
        ],
      ),
    );
  }

  void _showUploadInfo(BuildContext context) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Please navigate to Resume Vault to upload files'),
        backgroundColor: AppTheme.primaryColor,
      ),
    );
  }
}
