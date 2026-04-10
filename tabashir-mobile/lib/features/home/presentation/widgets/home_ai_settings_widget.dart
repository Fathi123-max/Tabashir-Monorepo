import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/features/home/presentation/cubit/home_cubit.dart';
import 'package:tabashir/features/home/presentation/cubit/home_state.dart';

/// Displays AI job apply remaining count from the clients table
/// Shows jobs_to_apply_number with upgrade CTA when low
class HomeAISettingsWidget extends StatelessWidget {
  const HomeAISettingsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final remainingApplies = state.jobsToApplyNumber ?? 0;
        final jobMatching = state.jobMatching ?? 0;
        final isPro = jobMatching == 1;

        // Don't show if no data loaded
        if (remainingApplies == 0 && !isPro) {
          // Show upgrade prompt for free users with 0 remaining
          return _buildUpgradeCard(context, remainingApplies);
        }

        final theme = Theme.of(context);
        final isLowBalance = remainingApplies <= 5;
        final isVeryLowBalance = remainingApplies <= 3;

        return Container(
          margin: EdgeInsets.symmetric(
            horizontal: AppTheme.spacingMd.w,
            vertical: AppTheme.spacingSm.h,
          ),
          padding: EdgeInsets.all(AppTheme.spacingMd.w),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isPro
                  ? [
                      AppTheme.primaryBlue.withOpacity(0.1),
                      AppTheme.primaryBlue.withOpacity(0.05),
                    ]
                  : [
                      AppTheme.zinc100!.withOpacity(0.5),
                      AppTheme.zinc50!.withOpacity(0.8),
                    ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(AppTheme.radiusLarge.r),
            border: Border.all(
              color: isPro
                  ? AppTheme.primaryBlue.withOpacity(0.3)
                  : isLowBalance
                      ? Colors.orange.withOpacity(0.3)
                      : AppTheme.zinc200!.withOpacity(0.5),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: isPro
                    ? AppTheme.primaryBlue.withOpacity(0.15)
                    : Colors.black.withOpacity(0.05),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              Row(
                children: [
                  Container(
                    padding: EdgeInsets.all(AppTheme.spacingSm.w),
                    decoration: BoxDecoration(
                      gradient: isPro ? AppTheme.primaryGradient : null,
                      color: isPro
                          ? null
                          : isLowBalance
                              ? Colors.orange.withOpacity(0.2)
                              : AppTheme.zinc200,
                      borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
                    ),
                    child: Icon(
                      isPro ? Iconsax.star : Iconsax.document_copy,
                      size: 20.sp,
                      color: isPro ? Colors.white : (isLowBalance ? Colors.orange : AppTheme.zinc700),
                    ),
                  ),
                  SizedBox(width: AppTheme.spacingSm.w),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              isPro ? 'AI Job Apply: Pro Plan' : 'AI Job Apply',
                              style: theme.textTheme.titleMedium?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: isPro
                                    ? AppTheme.primaryBlue
                                    : isLowBalance
                                        ? Colors.orange
                                        : AppTheme.zinc900,
                              ),
                            ),
                            if (isPro) ...[
                              SizedBox(width: 4.w),
                              Icon(
                                Iconsax.check,
                                size: 16.sp,
                                color: AppTheme.primaryBlue,
                              ),
                            ],
                          ],
                        ),
                        if (!isPro && isLowBalance)
                          Text(
                            isVeryLowBalance
                                ? 'Only $remainingApplies left!'
                                : 'Running low on applies',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: isVeryLowBalance ? Colors.red : Colors.orange,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppTheme.spacingMd.h),
              // Remaining Applies Display
              _buildRemainingDisplay(context, remainingApplies, isPro),
              // Upgrade CTA for low balance
              if (!isPro && isLowBalance) ...[
                SizedBox(height: AppTheme.spacingMd.h),
                _buildUpgradeButton(context),
              ],
            ],
          ),
        );
      },
    );
  }

  Widget _buildRemainingDisplay(
    BuildContext context,
    int remainingApplies,
    bool isPro,
  ) {
    final theme = Theme.of(context);
    final percentage = remainingApplies.toDouble() / (isPro ? 200 : 10).toDouble();
    final clampedPercentage = percentage.clamp(0.0, 1.0);

    return Column(
      children: [
        // Progress bar
        ClipRRect(
          borderRadius: BorderRadius.circular(4.r),
          child: LinearProgressIndicator(
            value: clampedPercentage,
            minHeight: 8.h,
            backgroundColor: AppTheme.zinc200,
            valueColor: AlwaysStoppedAnimation<Color>(
              isPro
                  ? AppTheme.primaryBlue
                  : remainingApplies <= 3
                      ? Colors.red
                      : remainingApplies <= 5
                          ? Colors.orange
                          : AppTheme.successColor,
            ),
          ),
        ),
        SizedBox(height: AppTheme.spacingSm.h),
        // Count display
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$remainingApplies applies remaining',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.zinc900,
                  ),
                ),
                Text(
                  isPro ? 'Unlimited plan' : 'Free plan (10 applies)',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: AppTheme.zinc500,
                  ),
                ),
              ],
            ),
            // Icon badge
            Container(
              padding: EdgeInsets.all(AppTheme.spacingMd.w),
              decoration: BoxDecoration(
                color: (isPro
                        ? AppTheme.primaryBlue
                        : remainingApplies <= 3
                            ? Colors.red
                            : remainingApplies <= 5
                                ? Colors.orange
                                : AppTheme.successColor)
                    .withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
              ),
              child: Icon(
                remainingApplies <= 0
                    ? Iconsax.lock
                    : remainingApplies <= 3
                        ? Iconsax.warning_2
                        : Iconsax.tick_circle,
                size: 32.sp,
                color: isPro
                    ? AppTheme.primaryBlue
                    : remainingApplies <= 3
                        ? Colors.red
                        : remainingApplies <= 5
                            ? Colors.orange
                            : AppTheme.successColor,
              ),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildUpgradeCard(BuildContext context, int remainingApplies) {
    final theme = Theme.of(context);

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: AppTheme.spacingMd.w,
        vertical: AppTheme.spacingSm.h,
      ),
      padding: EdgeInsets.all(AppTheme.spacingMd.w),
      decoration: BoxDecoration(
        color: AppTheme.zinc50,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge.r),
        border: Border.all(
          color: AppTheme.zinc200!,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Iconsax.lock_1,
            size: 48.sp,
            color: AppTheme.zinc400,
          ),
          SizedBox(height: AppTheme.spacingMd.h),
          Text(
            'No AI Applies Remaining',
            style: theme.textTheme.titleMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: AppTheme.zinc700,
            ),
          ),
          SizedBox(height: AppTheme.spacingXs.h),
          Text(
            'Upgrade to continue using AI job apply',
            style: theme.textTheme.bodySmall?.copyWith(
              color: AppTheme.zinc500,
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppTheme.spacingMd.h),
          _buildUpgradeButton(context),
        ],
      ),
    );
  }

  Widget _buildUpgradeButton(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          // Navigate to services page
          context.pushNamed('services-screen');
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: AppTheme.primaryBlue,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(
            horizontal: AppTheme.spacingLg.w,
            vertical: AppTheme.spacingMd.h,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
          ),
          elevation: 2,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Iconsax.star,
              size: 20.sp,
              color: Colors.white,
            ),
            SizedBox(width: AppTheme.spacingSm.w),
            Text(
              'Upgrade to Pro - AED 200',
              style: theme.textTheme.labelLarge?.copyWith(
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
