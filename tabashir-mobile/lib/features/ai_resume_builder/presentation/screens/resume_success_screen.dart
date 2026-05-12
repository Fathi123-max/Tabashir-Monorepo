import 'dart:io';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:path_provider/path_provider.dart';
import 'package:dio/dio.dart';
import 'package:open_filex/open_filex.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/core/network/_clients/auth_dio_client.dart';
import 'package:tabashir/core/services/auth_session_service.dart';
import 'package:tabashir/core/network/models/resume_response/resume_item.dart';
import 'package:tabashir/core/router/route_names.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/core/utils/app_logger.dart';

class ResumeSuccessScreen extends StatelessWidget {
  const ResumeSuccessScreen({
    required this.resume,
    super.key,
  });
  final ResumeItem resume;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 120.w,
                height: 120.w,
                decoration: BoxDecoration(
                  color: AppTheme.successColor.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle_rounded,
                  color: AppTheme.successColor,
                  size: 80.w,
                ),
              ),
              SizedBox(height: 32.h),
              Text(
                'Resume Generated Successfully!'.tr(),
                style: theme.textTheme.headlineSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 16.h),
              Text(
                'Your professional CV has been created and saved to your vault.'
                    .tr(),
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: theme.textTheme.bodySmall?.color,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 48.h),
              _buildActionButton(
                context,
                icon: Icons.picture_as_pdf_rounded,
                label: 'Download & View PDF'.tr(),
                onTap: () => _downloadAndOpen(context, 'pdf'),
                isPrimary: true,
              ),
              SizedBox(height: 16.h),
              _buildActionButton(
                context,
                icon: Icons.share_rounded,
                label: 'Share Resume'.tr(),
                onTap: () => _downloadAndShare(context),
              ),
              SizedBox(height: 16.h),
              _buildActionButton(
                context,
                icon: Icons.inventory_2_outlined,
                label: 'Go to Vault'.tr(),
                onTap: () => context.go(RouteNames.resumeVault),
              ),
              SizedBox(height: 32.h),
              TextButton(
                onPressed: () => context.go(RouteNames.home),
                child: Text('Back to Home'.tr()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildActionButton(
    BuildContext context, {
    required IconData icon,
    required String label,
    required VoidCallback? onTap,
    bool isPrimary = false,
  }) {
    if (isPrimary) {
      return SizedBox(
        width: double.infinity,
        height: 56.h,
        child: ElevatedButton.icon(
          onPressed: onTap,
          icon: Icon(icon),
          label: Text(label),
        ),
      );
    }

    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: OutlinedButton.icon(
        onPressed: onTap,
        icon: Icon(icon),
        label: Text(label),
      ),
    );
  }

  Future<void> _downloadAndOpen(BuildContext context, String format) async {
    try {
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      final url = resume.originalUrl;
      if (url == null || url.isEmpty) throw Exception('URL not available');

      final downloadUrl =
          url.contains('?')
              ? '$url&output_format=$format'
              : '$url?output_format=$format';

      final dir = await getApplicationDocumentsDirectory();
      final fileName =
          'Generated_Resume_${DateTime.now().millisecondsSinceEpoch}.${format == 'docx' ? 'docx' : 'pdf'}';
      final filePath = '${dir.path}/$fileName';

      final token = await AuthSessionService.instance.accessToken;
      final dio = getIt<AuthDioClient>().dio;

      scaffoldMessenger.showSnackBar(
        SnackBar(content: Text('Downloading ${format.toUpperCase()}...')),
      );

      await dio.download(
        downloadUrl,
        filePath,
        options: Options(
          headers: {
            if (token != null) 'Authorization': 'Bearer $token',
          },
        ),
      );

      final result = await OpenFilex.open(filePath);
      if (result.type != ResultType.done) {
        throw Exception(result.message);
      }
    } catch (e) {
      AppLogger.error('Download failed: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Failed to download: $e'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
      }
    }
  }

  Future<void> _downloadAndShare(BuildContext context) async {
    try {
      final scaffoldMessenger = ScaffoldMessenger.of(context);
      final url = resume.originalUrl;
      if (url == null || url.isEmpty) throw Exception('URL not available');

      // Default to PDF for sharing unless it's known to be DOCX
      final format = resume.filename.toLowerCase().endsWith('.docx') ? 'docx' : 'pdf';
      final downloadUrl =
          url.contains('?')
              ? '$url&output_format=$format'
              : '$url?output_format=$format';

      final tempDir = await getTemporaryDirectory();
      final ext = format == 'docx' ? '.docx' : '.pdf';
      final filePath =
          '${tempDir.path}/share_${DateTime.now().millisecondsSinceEpoch}$ext';

      final token = await AuthSessionService.instance.accessToken;
      final dio = getIt<AuthDioClient>().dio;

      scaffoldMessenger.showSnackBar(
        const SnackBar(content: Text('Preparing file for sharing...')),
      );

      await dio.download(
        downloadUrl,
        filePath,
        options: Options(
          headers: {
            if (token != null) 'Authorization': 'Bearer $token',
          },
        ),
      );

      await Share.shareXFiles([XFile(filePath)], text: 'My Resume');
    } catch (e) {
      AppLogger.error('Share failed: $e');
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error: $e'),
            backgroundColor: AppTheme.errorColor,
          ),
        );
      }
    }
  }
}
