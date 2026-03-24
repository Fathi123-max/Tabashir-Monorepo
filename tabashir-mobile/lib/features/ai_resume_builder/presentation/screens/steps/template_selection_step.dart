import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/features/ai_resume_builder/presentation/cubit/ai_resume_builder_cubit.dart';

class TemplateSelectionStep extends StatelessWidget {
  const TemplateSelectionStep({super.key});

  @override
  Widget build(
    BuildContext context,
  ) => BlocBuilder<AiResumeBuilderCubit, AiResumeBuilderState>(
    builder: (context, state) {
      return SingleChildScrollView(
        padding: EdgeInsets.all(AppTheme.spacingMd.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Select Template'.tr(),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppTheme.spacingXs.h),
            Text(
              'Choose the design for your professional resume.'.tr(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.textMutedLight,
              ),
            ),
            SizedBox(height: AppTheme.spacingXl.h),
            _buildTemplateCard(
              context,
              id: 'regular',
              title: 'Regular (English)'.tr(),
              description: 'A clean, modern professional template.'.tr(),
              isSelected: state.selectedTemplateId == 'regular',
              icon: Icons.description_outlined,
            ),
            SizedBox(height: AppTheme.spacingMd.h),
            _buildTemplateCard(
              context,
              id: 'arabic',
              title: 'Arabic (Professional)'.tr(),
              description: 'Tailored for Arabic speakers with RTL support.'
                  .tr(),
              isSelected: state.selectedTemplateId == 'arabic',
              icon: Icons.language_outlined,
            ),
            SizedBox(height: AppTheme.spacingXl.h),
            Container(
              padding: EdgeInsets.all(AppTheme.spacingMd.w),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.05),
                borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
                border: Border.all(
                  color: AppTheme.primaryColor.withOpacity(0.2),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    color: AppTheme.primaryColor,
                    size: 20.sp,
                  ),
                  SizedBox(width: AppTheme.spacingSm.w),
                  Expanded(
                    child: Text(
                      'You can always change your template later in the resume vault.'
                          .tr(),
                      style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: AppTheme.primaryColor,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    },
  );

  Widget _buildTemplateCard(
    BuildContext context, {
    required String id,
    required String title,
    required String description,
    required bool isSelected,
    required IconData icon,
  }) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => context.read<AiResumeBuilderCubit>().updateTemplate(id),
      child: Container(
        padding: EdgeInsets.all(AppTheme.spacingLg.w),
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
          border: Border.all(
            color: isSelected
                ? AppTheme.primaryColor
                : (theme.brightness == Brightness.light
                      ? AppTheme.borderLight
                      : AppTheme.borderDark),
            width: isSelected ? 2 : 1,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
        ),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(AppTheme.spacingMd.w),
              decoration: BoxDecoration(
                color: isSelected
                    ? AppTheme.primaryColor.withOpacity(0.1)
                    : theme.dividerColor.withOpacity(0.05),
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? AppTheme.primaryColor
                    : theme.iconTheme.color?.withOpacity(0.5),
                size: 32.sp,
              ),
            ),
            SizedBox(width: AppTheme.spacingLg.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: isSelected ? AppTheme.primaryColor : null,
                    ),
                  ),
                  SizedBox(height: AppTheme.spacingXs.h),
                  Text(
                    description,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: AppTheme.textMutedLight,
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle,
                color: AppTheme.primaryColor,
                size: 24.sp,
              ),
          ],
        ),
      ),
    );
  }
}
