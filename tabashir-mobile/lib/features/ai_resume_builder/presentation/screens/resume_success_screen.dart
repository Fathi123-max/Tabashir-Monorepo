import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:share_plus/share_plus.dart';
import 'package:tabashir/core/network/models/resume_response/resume_item.dart';
import 'package:tabashir/core/router/route_names.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:url_launcher/url_launcher.dart';

class ResumeSuccessScreen extends StatelessWidget {
  final ResumeItem resume;

  const ResumeSuccessScreen({
    super.key,
    required this.resume,
  });

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
              // Success Icon/Animation Placeholder
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
              // Action Buttons
              _buildActionButton(
                context,
                icon: Icons.picture_as_pdf_rounded,
                label: 'Download PDF'.tr(),
                onTap:
                    (resume.formatedUrl != null &&
                        resume.formatedUrl!.isNotEmpty)
                    ? () => _downloadPdf(context)
                    : null,
                isPrimary: true,
              ),
              SizedBox(height: 16.h),
              _buildActionButton(
                context,
                icon: Icons.description_rounded,
                label: 'Share Word File'.tr(),
                onTap:
                    (resume.originalUrl != null &&
                        resume.originalUrl!.isNotEmpty)
                    ? () => _shareWordFile(context)
                    : null,
                isPrimary: false,
              ),
              SizedBox(height: 16.h),
              _buildActionButton(
                context,
                icon: Icons.inventory_2_outlined,
                label: 'Go to Vault'.tr(),
                onTap: () => context.go(RouteNames.resumeVault),
                isPrimary: false,
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

  Future<void> _downloadPdf(BuildContext context) async {
    final url = resume.formatedUrl;
    if (url == null || url.isEmpty) {
      _showError(context, 'PDF download link is not available.'.tr());
      return;
    }

    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      _showError(context, 'Could not open download link.'.tr());
    }
  }

  Future<void> _shareWordFile(BuildContext context) async {
    final url = resume.originalUrl;
    if (url == null || url.isEmpty) {
      _showError(context, 'Word file link is not available.'.tr());
      return;
    }

    // Since we don't have the file locally yet, we can share the link
    // or download it first. For now, sharing the link is the simplest.
    await Share.share(
      '${'Check out my professional resume:'.tr()} $url',
      subject: 'My Resume'.tr(),
    );
  }

  void _showError(BuildContext context, String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.errorColor,
      ),
    );
  }
}
