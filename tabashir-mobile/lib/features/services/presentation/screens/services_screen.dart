import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/theme/app_theme.dart';
import '../cubit/services_cubit.dart';
import '../widgets/info_banner.dart';
import '../widgets/service_card.dart';
import '../widgets/trust_indicators.dart';

/// Services screen that displays AI career services including:
/// - AI Resume Optimization
/// - AI LinkedIn Enhancement
/// - AI Job Apply Service
/// - Interview Prep AI
class ServicesScreen extends StatelessWidget {
  const ServicesScreen({super.key});

  void _showComingSoonDialog(BuildContext context) {
    final theme = Theme.of(context);

    showDialog<void>(
      context: context,
      builder: (_) => AlertDialog(
        backgroundColor: theme.cardTheme.color,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
        ),
        title: Row(
          children: [
            Icon(
              Icons.lightbulb_outline,
              color: AppTheme.primaryColor,
              size: 24.sp,
            ),
            SizedBox(width: AppTheme.spacingSm.w),
            Text(
              'Coming Soon'.tr(),
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        content: Text(
          'LinkedIn Enhancement feature is coming soon. '.tr() +
              'Stay tuned for updates!'.tr(),
          style: theme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text(
              'OK'.tr(),
              style: TextStyle(
                color: AppTheme.primaryColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => ServicesCubit()..initialize(),
      child: BlocBuilder<ServicesCubit, ServicesState>(
        builder: (context, state) => Scaffold(
          backgroundColor: theme.scaffoldBackgroundColor,
          body: SafeArea(
            child: Column(
              children: [
                // Main scrollable content
                Expanded(
                  child: ListView(
                    padding: EdgeInsets.only(
                      bottom: kBottomNavigationBarHeight + AppTheme.spacingLg.h,
                    ),
                    children: [
                      // Header
                      Padding(
                        padding: EdgeInsets.fromLTRB(
                          AppTheme.spacingMd.w,
                          AppTheme.spacingLg.h,
                          AppTheme.spacingMd.w,
                          AppTheme.spacingXs.h,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'AI Career Services'.tr(),
                              style: theme.textTheme.displayMedium?.copyWith(
                                fontSize: 30.sp,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(height: AppTheme.spacingXs.h),
                            Text(
                              'Boost your job search with smart tools.'.tr(),
                              style: theme.textTheme.bodyMedium?.copyWith(
                                color: theme.colorScheme.onSurfaceVariant,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Info Banner
                      Padding(
                        padding: EdgeInsets.all(AppTheme.spacingMd.w),
                        child: const InfoBanner(),
                      ),

                      // Service Cards
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppTheme.spacingMd.w,
                        ),
                        child: Column(
                          children: [
                            ServiceCard(
                              icon: Icons.description_outlined,
                              title: 'AI Resume Optimization'.tr(),
                              description:
                                  'Get your resume scored and optimized by AI to '
                                      .tr() +
                                  'pass ATS and impress recruiters.'.tr(),
                              price: 'Free trial • AED 29'.tr(),
                              buttonText: 'Get Started'.tr(),
                              isEnabled: true,
                              onPressed: () {
                                context.pushNamed('ai-resume-screen');
                              },
                            ),
                            SizedBox(height: AppTheme.spacingMd.h),

                            ServiceCard(
                              icon: Icons.link,
                              title: 'AI LinkedIn Enhancement'.tr(),
                              description:
                                  'Optimize your LinkedIn profile to attract more '
                                      .tr() +
                                  'recruiters and opportunities.'.tr(),
                              price: 'AED 19'.tr(),
                              buttonText: 'Enhance Now'.tr(),
                              isEnabled: true,
                              onPressed: () {
                                _showComingSoonDialog(context);
                              },
                            ),
                            SizedBox(height: AppTheme.spacingMd.h),

                            ServiceCard(
                              icon: Icons.flash_on,
                              title: 'AI Job Apply Service'.tr(),
                              description:
                                  'Let our AI find and apply to the best jobs for '
                                      .tr() +
                                  'you automatically.'.tr(),
                              price: 'AED 49'.tr(),
                              buttonText: 'Auto Apply'.tr(),
                              isEnabled: true,
                              onPressed: () {
                                context.pushNamed('subscriptions-screen');
                              },
                            ),
                            SizedBox(height: AppTheme.spacingMd.h),

                            ServiceCard(
                              icon: Icons.mic,
                              title: 'Interview Prep AI'.tr(),
                              description:
                                  'Practice with an AI interviewer and get instant '
                                      .tr() +
                                  'feedback to ace your next interview.'.tr(),
                              price: 'Coming Soon'.tr(),
                              buttonText: 'Notify Me'.tr(),
                              isEnabled: true,
                              onPressed: () {
                                context.pushNamed(
                                  'interview-training-screen',
                                );
                              },
                            ),
                          ],
                        ),
                      ),

                      // Trust Indicators
                      Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppTheme.spacingMd.w,
                          vertical: AppTheme.spacingLg.h,
                        ),
                        child: const TrustIndicators(),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
