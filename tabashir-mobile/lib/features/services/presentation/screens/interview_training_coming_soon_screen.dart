import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabashir/core/theme/app_theme.dart';

import 'package:tabashir/features/services/presentation/cubit/interview_training_cubit.dart';
import 'package:tabashir/features/services/presentation/widgets/interview_training_info_banner.dart';
import 'package:tabashir/features/services/presentation/widgets/coming_soon_card.dart';
import 'package:tabashir/features/services/presentation/widgets/waitlist_form.dart';

class InterviewTrainingComingSoonScreen extends StatelessWidget {
  const InterviewTrainingComingSoonScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocProvider(
      create: (context) => InterviewTrainingCubit(),
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Scrollable Content
              Expanded(
                child: ListView(
                  padding: EdgeInsets.only(
                    bottom: AppTheme.spacingLg.h,
                    top: AppTheme.spacingMd.h,
                  ),
                  children: [
                    // Header
                    Padding(
                      padding: EdgeInsets.fromLTRB(
                        AppTheme.spacingMd.w,
                        0,
                        AppTheme.spacingMd.w,
                        AppTheme.spacingXs.h,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'AI Interview Training'.tr(),
                            style: theme.textTheme.displayMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: 28.sp,
                            ),
                          ),
                          SizedBox(height: AppTheme.spacingSm.h),
                          Text(
                            'Practice with real-time feedback — launching soon!'
                                .tr(),
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: AppTheme.spacingLg.h),

                    // Info Banner
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppTheme.spacingMd.w,
                      ),
                      child: const InterviewTrainingInfoBanner(),
                    ),
                    SizedBox(height: AppTheme.spacingLg.h),

                    // Main Card
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppTheme.spacingMd.w,
                      ),
                      child: const ComingSoonCard(),
                    ),
                    SizedBox(height: AppTheme.spacingLg.h),

                    // Waitlist Form
                    Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: AppTheme.spacingMd.w,
                      ),
                      child: const WaitlistForm(),
                    ),
                    SizedBox(height: AppTheme.spacingLg.h),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
