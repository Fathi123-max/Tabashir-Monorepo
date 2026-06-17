import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../core/constants/app_constants.dart';
import '../../core/services/user_preferences_service.dart';
import '../../core/theme/app_theme.dart';

/// Interactive modal bottom sheet prompting the user for AI data sharing consent
class AiConsentBottomSheet extends StatefulWidget {
  const AiConsentBottomSheet({super.key});

  /// Static helper to ensure that AI consent is granted before performing actions
  /// Checks local preferences and displays the bottom sheet if not already consented
  static Future<bool> ensureConsent(BuildContext context) async {
    final consented = await UserPreferencesService.getAiConsent();
    if (consented) return true;

    if (!context.mounted) return false;
    final result = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => const AiConsentBottomSheet(),
    );
    return result ?? false;
  }

  @override
  State<AiConsentBottomSheet> createState() => _AiConsentBottomSheetState();
}

class _AiConsentBottomSheetState extends State<AiConsentBottomSheet> {
  bool _hasAccepted = false;

  Future<void> _openPrivacyPolicy() async {
    final url = Uri.parse(AppConstants.privacyPolicyUrl);
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      padding: EdgeInsets.symmetric(horizontal: 24.w, vertical: 20.h),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.surfaceDark : Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(24.r)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.15),
            blurRadius: 10,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40.w,
                height: 4.h,
                margin: EdgeInsets.only(bottom: 20.h),
                decoration: BoxDecoration(
                  color: isDark ? Colors.white24 : Colors.black12,
                  borderRadius: BorderRadius.circular(2.r),
                ),
              ),
            ),
            Row(
              children: [
                Icon(
                  Icons.auto_awesome,
                  color: AppTheme.primaryColor,
                  size: 28.sp,
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    'AI Data Privacy Consent'.tr(),
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      fontSize: 20.sp,
                      color: isDark ? Colors.white : AppTheme.primaryColor,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 16.h),
            Text(
              'Tabashir uses secure AI models (powered by OpenAI and DeepSeek) to analyze, structure, and optimize your resume data and match you with target job listings. Before sharing your details, please review and consent to how your data is handled:'
                  .tr(),
              style: theme.textTheme.bodyMedium?.copyWith(
                height: 1.4,
                color: isDark ? Colors.white70 : Colors.black87,
              ),
            ),
            SizedBox(height: 16.h),
            _buildDisclosureItem(
              context,
              Icons.description_outlined,
              'What Data is Shared'.tr(),
              'Your uploaded resume text, work history, education, skills, target positions, and preferred cities.'
                  .tr(),
            ),
            SizedBox(height: 12.h),
            _buildDisclosureItem(
              context,
              Icons.business_outlined,
              'Who it is Shared With'.tr(),
              'Our secure servers and vetted third-party AI processing partners (OpenAI and DeepSeek).'
                  .tr(),
            ),
            SizedBox(height: 12.h),
            _buildDisclosureItem(
              context,
              Icons.security_outlined,
              'Your Privacy Commitment'.tr(),
              'We never sell your data. Your data is encrypted in transit and not used to train public models. You can view our full policies below.'
                  .tr(),
            ),
            SizedBox(height: 20.h),
            GestureDetector(
              onTap: _openPrivacyPolicy,
              child: Row(
                children: [
                  Icon(
                    Icons.link,
                    color: AppTheme.primaryColor,
                    size: 18.sp,
                  ),
                  SizedBox(width: 6.w),
                  Text(
                    'Read our Privacy Policy'.tr(),
                    style: TextStyle(
                      color: AppTheme.primaryColor,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20.h),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  width: 24.w,
                  height: 24.h,
                  child: Checkbox(
                    value: _hasAccepted,
                    activeColor: AppTheme.primaryColor,
                    onChanged: (val) {
                      setState(() {
                        _hasAccepted = val ?? false;
                      });
                    },
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: GestureDetector(
                    onTap: () {
                      setState(() {
                        _hasAccepted = !_hasAccepted;
                      });
                    },
                    child: Text(
                      'I consent to sharing my resume and profile details with secure AI partners (OpenAI & DeepSeek) for resume optimization and matching services.'
                          .tr(),
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontSize: 13.sp,
                        height: 1.4,
                        color: isDark ? Colors.white70 : Colors.black87,
                      ),
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 24.h),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => Navigator.pop(context, false),
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                    ),
                    child: Text('Cancel'.tr()),
                  ),
                ),
                SizedBox(width: 12.w),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _hasAccepted
                        ? () async {
                            await UserPreferencesService.saveAiConsent(
                              consented: true,
                            );
                            if (context.mounted) {
                              Navigator.pop(context, true);
                            }
                          }
                        : null,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      foregroundColor: Colors.white,
                      padding: EdgeInsets.symmetric(vertical: 14.h),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      elevation: 0,
                    ),
                    child: Text('Agree & Continue'.tr()),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDisclosureItem(
    BuildContext context,
    IconData icon,
    String title,
    String desc,
  ) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: EdgeInsets.all(8.w),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withValues(alpha: 0.08),
            shape: BoxShape.circle,
          ),
          child: Icon(
            icon,
            color: AppTheme.primaryColor,
            size: 20.sp,
          ),
        ),
        SizedBox(width: 12.w),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.sp,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                desc,
                style: TextStyle(
                  fontSize: 13.sp,
                  color: isDark ? Colors.white60 : Colors.black54,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
