import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tabashir/core/network/models/resume_response/resume_item.dart';
import 'package:tabashir/features/profile/presentation/cubit/profile_cubit.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/services/auth_session_service.dart';
import '../../../../core/theme/app_theme.dart';
import '../cubit/resume_import_cubit.dart';
import '../widgets/resume_import_option_card.dart';

class ResumeImportScreen extends StatelessWidget {
  const ResumeImportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: BlocConsumer<ResumeImportCubit, ResumeImportState>(
          listener: (context, state) {
            state.when(
              initial: () {},
              loading: () {},
              success: (resume, parsedData) {
                if (resume != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: const Text('Resume imported successfully!'),
                      backgroundColor: AppTheme.primaryColor,
                    ),
                  );
                }
              },
              error: (message) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(message),
                    backgroundColor: AppTheme.errorColor,
                  ),
                );
              },
              skipped: () {
                _completeOnboardingAndNavigate(context);
              },
            );
          },
          builder: (context, state) => Stack(
            children: [
              FutureBuilder<bool>(
                future: () async {
                  await Future<void>.delayed(
                    const Duration(milliseconds: 100),
                  );
                  final isAuthenticated =
                      await AuthSessionService.instance.isAuthenticated;
                  return isAuthenticated;
                }(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularProgressIndicator(),
                          SizedBox(height: 16),
                          Text('Checking authentication status...'),
                        ],
                      ),
                    );
                  }

                  if (snapshot.hasData && !snapshot.data!) {
                    return FutureBuilder<String?>(
                      future: AuthSessionService.instance.accessToken,
                      builder: (context, tokenSnapshot) {
                        if (tokenSnapshot.hasData &&
                            tokenSnapshot.data != null) {
                          return _buildMainContent(context, state);
                        } else {
                          return _buildAuthenticationRequiredView(context);
                        }
                      },
                    );
                  }

                  return _buildMainContent(context, state);
                },
              ),
              if (state.maybeWhen(
                loading: () => true,
                orElse: () => false,
              ))
                ColoredBox(
                  color: Colors.black.withOpacity(0.3),
                  child: const Center(
                    child: CircularProgressIndicator(),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildMainContent(
    BuildContext context,
    ResumeImportState state,
  ) => SingleChildScrollView(
    padding: EdgeInsets.symmetric(
      horizontal: AppTheme.spacingMd.w,
      vertical: AppTheme.spacingXl.h,
    ),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(context),
        SizedBox(height: AppTheme.spacingMd.h),
        state.maybeWhen(
          success: (resume, parsedData) {
            if (resume != null) {
              return _buildUploadedResumeView(
                context,
                resume,
                parsedData,
              );
            }
            return _buildImportOptions(context);
          },
          orElse: () => _buildImportOptions(context),
        ),
        SizedBox(height: AppTheme.spacingXl.h),
        _buildFooter(context),
      ],
    ),
  );

  Widget _buildUploadedResumeView(
    BuildContext context,
    ResumeItem resume,
    Map<String, dynamic>? parsedData,
  ) {
    final theme = Theme.of(context);
    final fileName = resume.name;

    return Hero(
      tag: 'resume-review-card',
      child: Container(
        width: double.infinity,
        padding: EdgeInsets.all(AppTheme.spacingLg.w),
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(AppTheme.radiusLarge.r),
          border: Border.all(
            color: AppTheme.primaryColor.withOpacity(0.3),
          ),
          boxShadow: [
            BoxShadow(
              color: AppTheme.primaryColor.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(AppTheme.spacingMd.w),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.check_circle,
                color: AppTheme.primaryColor,
                size: 48.sp,
              ),
            ),
            SizedBox(height: AppTheme.spacingMd.h),
            Material(
              type: MaterialType.transparency,
              child: Text(
                'Resume Uploaded!',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
            SizedBox(height: AppTheme.spacingSm.h),
            Material(
              type: MaterialType.transparency,
              child: Text(
                fileName,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.textTheme.bodyMedium?.color?.withOpacity(0.7),
                ),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: AppTheme.spacingMd.h),
            if (parsedData != null && parsedData.isNotEmpty)
              _buildParsedDataPreview(parsedData: parsedData),
            if (parsedData != null && parsedData.isNotEmpty)
              SizedBox(height: AppTheme.spacingMd.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () async {
                  if (parsedData == null || parsedData.isEmpty) {
                    _completeOnboardingAndNavigate(context);
                    return;
                  }

                  context.push(RouteNames.resumeReview, extra: parsedData);
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: AppTheme.spacingMd.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      AppTheme.radiusMedium.r,
                    ),
                  ),
                ),
                child: const Text('Continue'),
              ),
            ),
            SizedBox(height: AppTheme.spacingSm.h),
            TextButton(
              onPressed: () {
                context.read<ResumeImportCubit>().pickResumeFile();
              },
              child: const Text('Upload a different file'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Let's get your profile ready".tr(),
          style: theme.textTheme.displayLarge,
        ),
        SizedBox(height: AppTheme.spacingSm.h),
        Text(
          "Upload your resume — I'll extract your skills, experience, and matches."
              .tr(),
          style: theme.textTheme.bodyLarge?.copyWith(
            color: theme.brightness == Brightness.light
                ? AppTheme.textMutedLight
                : AppTheme.textMutedDark,
          ),
        ),
      ],
    );
  }

  Widget _buildImportOptions(BuildContext context) => Container(
    width: double.infinity,
    padding: EdgeInsets.all(AppTheme.spacingMd.w),
    decoration: BoxDecoration(
      color: Theme.of(context).cardTheme.color,
      borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
      border: Border.all(
        color: AppTheme.primaryColor.withOpacity(0.2),
      ),
      boxShadow: [
        BoxShadow(
          color: AppTheme.primaryColor.withOpacity(0.05),
          blurRadius: 8,
          offset: const Offset(0, 2),
        ),
      ],
    ),
    child: Column(
      children: [
        ResumeImportOptionCard(
          icon: Icons.upload_file_outlined,
          title: 'Upload File'.tr(),
          subtitle: 'Upload your resume from your device (PDF, DOCX).'.tr(),
          onTap: () {
            context.read<ResumeImportCubit>().pickResumeFile();
          },
        ),
        SizedBox(height: AppTheme.spacingSm.h),
      ],
    ),
  );

  Widget _buildAuthenticationRequiredView(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppTheme.spacingMd.w,
        vertical: AppTheme.spacingXl.h,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.lock_outline,
            size: 64.sp,
            color: theme.colorScheme.primary,
          ),
          SizedBox(height: AppTheme.spacingLg.h),
          Text(
            'Authentication Required',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppTheme.spacingMd.h),
          Text(
            'Please complete the sign up or login process to import your resume.',
            style: theme.textTheme.bodyLarge?.copyWith(
              color: theme.brightness == Brightness.light
                  ? AppTheme.textMutedLight
                  : AppTheme.textMutedDark,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppTheme.spacingXl.h),
          ElevatedButton(
            onPressed: () {
              context.go(RouteNames.login);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(
                horizontal: AppTheme.spacingMd.w,
                vertical: AppTheme.spacingMd.h,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
              ),
            ),
            child: Text(
              'Continue to Login',
              style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w600),
            ),
          ),
          SizedBox(height: AppTheme.spacingMd.h),
          TextButton(
            onPressed: () {
              _completeOnboardingAndNavigate(context);
            },
            child: Text(
              'Skip for now',
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.primary,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    final theme = Theme.of(context);
    return Column(
      children: [
        TextButton(
          onPressed: () {
            context.read<ResumeImportCubit>().skipForNow();
          },
          child: Text(
            'Skip for now'.tr(),
            style: theme.textTheme.labelMedium?.copyWith(
              color: theme.brightness == Brightness.light
                  ? AppTheme.textMutedLight
                  : AppTheme.textMutedDark,
            ),
          ),
        ),
        SizedBox(height: AppTheme.spacingMd.h),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: AppTheme.spacingMd.w),
          child: Text(
            'We never share your data. Your resume is used only to find better matches.'
                .tr(),
            textAlign: TextAlign.center,
            style: theme.textTheme.bodySmall,
          ),
        ),
      ],
    );
  }

  Future<void> _completeOnboardingAndNavigate(BuildContext context) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setBool('has_completed_onboarding', true);
    } catch (e) {}
    if (context.mounted) {
      context.go('/');
    }
  }

  Widget _buildParsedDataPreview({required Map<String, dynamic> parsedData}) {
    final personalFields = <Widget?>[
      _buildParsedField(
        'Full name',
        parsedData['fullName'] as String? ?? parsedData['name'] as String?,
      ),
      _buildParsedField('Email', parsedData['email'] as String?),
      _buildParsedField('Phone', parsedData['phone'] as String?),
      _buildParsedField('Address', parsedData['address'] as String?),
      _buildParsedField('Nationality', parsedData['nationality'] as String?),
      _buildParsedField('Summary', parsedData['summary'] as String?),
    ].whereType<Widget>().toList();

    final skills = (parsedData['skills'] as List?)
        ?.cast<String>()
        .where((skill) => skill.trim().isNotEmpty)
        .toList();
    final experience = (parsedData['experience'] as List?)
        ?.cast<Map<String, dynamic>>()
        .where((exp) => exp.isNotEmpty)
        .toList();
    final education = (parsedData['education'] as List?)
        ?.cast<Map<String, dynamic>>()
        .where((edu) => edu.isNotEmpty)
        .toList();

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppTheme.spacingMd.w),
      decoration: BoxDecoration(
        color: AppTheme.surfaceLight,
        borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
        border: Border.all(color: AppTheme.borderLight),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Preview extracted details',
            style: TextStyle(fontWeight: FontWeight.w600, fontSize: 16.sp),
          ),
          SizedBox(height: AppTheme.spacingSm.h),
          if (personalFields.isNotEmpty) ...[
            ...personalFields,
            SizedBox(height: AppTheme.spacingSm.h),
          ],
          if (skills != null && skills.isNotEmpty) ...[
            Text(
              'Skills',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
            ),
            SizedBox(height: AppTheme.spacingXs.h),
            Wrap(
              spacing: AppTheme.spacingXs.w,
              runSpacing: AppTheme.spacingXs.h,
              children: skills
                  .map(
                    (skill) => Chip(
                      label: Text(skill),
                      backgroundColor: AppTheme.primaryColor.withOpacity(0.08),
                      side: BorderSide.none,
                    ),
                  )
                  .toList(),
            ),
            SizedBox(height: AppTheme.spacingSm.h),
          ],
          if (experience != null && experience.isNotEmpty) ...[
            Text(
              'Experience',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
            ),
            SizedBox(height: AppTheme.spacingXs.h),
            ...experience.map(
              (exp) => Padding(
                padding: EdgeInsets.only(bottom: AppTheme.spacingSm.h),
                child: _buildExperiencePreview(exp),
              ),
            ),
          ],
          if (education != null && education.isNotEmpty) ...[
            Text(
              'Education',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
            ),
            SizedBox(height: AppTheme.spacingXs.h),
            ...education.map(
              (edu) => Padding(
                padding: EdgeInsets.only(bottom: AppTheme.spacingXs.h),
                child: Text(
                  '${edu['degree'] ?? ''} at ${edu['institution'] ?? ''}',
                  style: TextStyle(fontSize: 14.sp),
                ),
              ),
            ),
            SizedBox(height: AppTheme.spacingSm.h),
          ],
          if (parsedData['projects'] != null &&
              (parsedData['projects'] as List).isNotEmpty) ...[
            Text(
              'Projects',
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 14.sp),
            ),
            SizedBox(height: AppTheme.spacingXs.h),
            ...(parsedData['projects'] as List).map(
              (proj) => Padding(
                padding: EdgeInsets.only(bottom: AppTheme.spacingSm.h),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      (proj['title'] ?? '') as String,
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 13.sp,
                      ),
                    ),
                    if (proj['description']?.toString().isNotEmpty ?? false)
                      Text(
                        (proj['description'] ?? '') as String,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: AppTheme.textMutedLight,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                  ],
                ),
              ),
            ),
            SizedBox(height: AppTheme.spacingSm.h),
          ],
        ],
      ),
    );
  }

  Widget _buildExperiencePreview(Map<String, dynamic> experience) {
    final company = (experience['company'] as String?)?.trim();
    final position = (experience['position'] as String?)?.trim();
    final start = (experience['startDate'] as String?)?.trim();
    final end = (experience['endDate'] as String?)?.trim();
    final description = (experience['description'] as String?)?.trim();
    if ([
      company,
      position,
      start,
      end,
      description,
    ].every((element) => element?.isEmpty ?? true)) {
      return const SizedBox.shrink();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (position != null && position.isNotEmpty)
          Text(
            position,
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 14.sp),
          ),
        if (company != null && company.isNotEmpty)
          Text(
            company,
            style: TextStyle(color: AppTheme.textMutedLight, fontSize: 13.sp),
          ),
        if (start != null && start.isNotEmpty)
          Text(
            end != null && end.isNotEmpty ? '$start – $end' : start,
            style: TextStyle(color: AppTheme.textMutedLight, fontSize: 12.sp),
          ),
        if (description != null && description.isNotEmpty) ...[
          SizedBox(height: AppTheme.spacingXs.h),
          Text(
            description,
            style: TextStyle(fontSize: 13.sp),
            maxLines: 3,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ],
    );
  }

  Widget? _buildParsedField(String label, String? value) {
    final text = value?.trim();
    if (text == null || text.isEmpty) return null;
    return Padding(
      padding: EdgeInsets.only(bottom: AppTheme.spacingXs.h),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            width: 90.w,
            child: Text(
              label,
              style: TextStyle(fontWeight: FontWeight.w600, fontSize: 13.sp),
            ),
          ),
          Expanded(
            child: Text(text, style: TextStyle(fontSize: 13.sp)),
          ),
        ],
      ),
    );
  }
}
