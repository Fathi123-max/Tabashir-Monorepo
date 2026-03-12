import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import '../../data/models/resume_models.dart';

class AiResumeBuilderHeader extends StatelessWidget {
  const AiResumeBuilderHeader({
    required this.currentStep,
    required this.resumeScore,
    required this.onStepTap,
    super.key,
  });
  final int currentStep;
  final int resumeScore;
  final Function(int) onStepTap;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.all(AppTheme.spacingMd.w),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  'Tabashir'.tr(),
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingMd.w,
                  vertical: AppTheme.spacingXs.h,
                ),
                decoration: BoxDecoration(
                  color: AppTheme.primaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(AppTheme.radiusFull.r),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      '🇺🇸',
                      style: theme.textTheme.bodyMedium,
                    ),
                    SizedBox(width: AppTheme.spacingXs.w),
                    Text(
                      '$resumeScore%',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
              TextButton(
                onPressed: () {},
                child: Text(
                  'Tips'.tr(),
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: AppTheme.primaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: AppTheme.spacingMd.h),
          _buildStepNavigator(context),
        ],
      ),
    );
  }

  Widget _buildStepNavigator(BuildContext context) {
    final theme = Theme.of(context);
    final steps = [
      'Personal Details'.tr(),
      'Professional Summary'.tr(),
      'Work Experience'.tr(),
      'Education'.tr(),
      'Skills'.tr(),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: List.generate(steps.length, (index) {
        final isActive = index == currentStep;
        final isCompleted = index < currentStep;
        // All steps are accessible at the same level
        const isEnabled = true;

        return Expanded(
          child: GestureDetector(
            onTap: isEnabled ? () => onStepTap(index) : null,
            child: Container(
              padding: EdgeInsets.symmetric(vertical: AppTheme.spacingSm.h),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Step indicator - always at same height
                  Container(
                    width: 32.w,
                    height: 32.w,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isActive
                          ? AppTheme.primaryColor
                          : isCompleted
                          ? AppTheme.successColor
                          : AppTheme.primaryColor.withOpacity(0.1),
                      border: Border.all(
                        color: isActive || isCompleted
                            ? Colors.transparent
                            : AppTheme.primaryColor.withOpacity(0.3),
                        width: 2,
                      ),
                    ),
                    child: Center(
                      child: isCompleted
                          ? Icon(
                              Icons.check,
                              color: Colors.white,
                              size: 18.sp,
                            )
                          : Text(
                              '${index + 1}',
                              style: theme.textTheme.labelMedium?.copyWith(
                                color: isActive || isCompleted
                                    ? Colors.white
                                    : AppTheme.primaryColor,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                    ),
                  ),
                  SizedBox(height: AppTheme.spacingXs.h),
                  // Text label - aligned and same height
                  Text(
                    steps[index],
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: isActive
                          ? AppTheme.primaryColor
                          : AppTheme.textMutedLight,
                      fontWeight: isActive ? FontWeight.w600 : FontWeight.w500,
                      height: 1.2,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      }),
    );
  }
}
