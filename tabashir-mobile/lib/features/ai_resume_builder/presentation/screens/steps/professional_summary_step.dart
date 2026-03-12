import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/features/ai_resume_builder/presentation/cubit/ai_resume_builder_cubit.dart';

import '../../../data/models/resume_models.dart';

class ProfessionalSummaryStep extends StatelessWidget {
  const ProfessionalSummaryStep({super.key});

  @override
  Widget build(
    BuildContext context,
  ) => BlocBuilder<AiResumeBuilderCubit, AiResumeBuilderState>(
    builder: (context, state) {
      final summary = state.resumeData.professionalSummary;
      final controller = TextEditingController(text: summary?.summary ?? '');
      const maxLength = 500;

      return SingleChildScrollView(
        padding: EdgeInsets.all(AppTheme.spacingMd.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Professional Summary'.tr(),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppTheme.spacingXs.h),
            Text(
              'Write 2–4 short, energetic sentences about your professional experience, skills, and achievements.'
                  .tr(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.textMutedLight,
              ),
            ),
            SizedBox(height: AppTheme.spacingXl.h),
            Form(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Summary *'.tr(),
                    style: Theme.of(context).textTheme.labelLarge?.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: AppTheme.spacingXs.h),
                  TextFormField(
                    controller: controller,
                    onChanged: (value) {
                      context
                          .read<AiResumeBuilderCubit>()
                          .updateProfessionalSummary(
                            ProfessionalSummary(summary: value),
                          );
                    },
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Professional summary is required'.tr();
                      }
                      return null;
                    },
                    maxLines: 8,
                    maxLength: maxLength,
                    style: Theme.of(context).textTheme.bodyLarge,
                    decoration: InputDecoration(
                      hintText:
                          'Example: Experienced software engineer with 5+ years developing scalable web applications. Proficient in React, Node.js, and cloud technologies. Led cross-functional teams to deliver high-impact projects that increased user engagement by 40%. Passionate about writing clean, maintainable code and mentoring junior developers.'
                              .tr(),
                      filled: true,
                      fillColor:
                          Theme.of(context).brightness == Brightness.light
                          ? const Color(0xFFF1F5F9)
                          : const Color(0xFF1E293B),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppTheme.radiusDefault.r,
                        ),
                        borderSide: BorderSide(
                          color:
                              Theme.of(context).brightness == Brightness.light
                              ? AppTheme.borderLight
                              : AppTheme.borderDark,
                        ),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppTheme.radiusDefault.r,
                        ),
                        borderSide: BorderSide(
                          color:
                              Theme.of(context).brightness == Brightness.light
                              ? AppTheme.borderLight
                              : AppTheme.borderDark,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppTheme.radiusDefault.r,
                        ),
                        borderSide: BorderSide(
                          color: AppTheme.primaryColor,
                          width: 2,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(
                          AppTheme.radiusDefault.r,
                        ),
                        borderSide: BorderSide(
                          color: AppTheme.errorColor,
                        ),
                      ),
                      contentPadding: EdgeInsets.all(AppTheme.spacingMd.w),
                      hintStyle: TextStyle(
                        color: Theme.of(context).brightness == Brightness.light
                            ? const Color(0xFF64748B)
                            : const Color(0xFF94A3B8),
                        fontFamily: 'Inter'.tr(),
                        height: 1.5,
                      ),
                      counterStyle: TextStyle(
                        color: Theme.of(context).brightness == Brightness.light
                            ? const Color(0xFF64748B)
                            : const Color(0xFF94A3B8),
                        fontSize: 12.sp,
                      ),
                    ),
                  ),
                  SizedBox(height: AppTheme.spacingSm.h),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Guidance:'.tr(),
                        style: Theme.of(context).textTheme.labelMedium
                            ?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                      ),
                      Text(
                        '${controller.text.length}/$maxLength',
                        style: Theme.of(context).textTheme.bodySmall?.copyWith(
                          color: controller.text.length > maxLength * 0.9
                              ? AppTheme.warningColor
                              : AppTheme.textMutedLight,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppTheme.spacingMd.h),
                  Container(
                    padding: EdgeInsets.all(AppTheme.spacingMd.w),
                    decoration: BoxDecoration(
                      color: AppTheme.accentColor.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(
                        AppTheme.radiusDefault.r,
                      ),
                      border: Border.all(
                        color: AppTheme.accentColor.withOpacity(0.2),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.lightbulb_outline,
                              color: AppTheme.accentColor,
                              size: 20.sp,
                            ),
                            SizedBox(width: AppTheme.spacingXs.w),
                            Text(
                              'Tips for a Great Summary:'.tr(),
                              style: Theme.of(context).textTheme.labelLarge
                                  ?.copyWith(
                                    color: AppTheme.accentColor,
                                    fontWeight: FontWeight.w600,
                                  ),
                            ),
                          ],
                        ),
                        SizedBox(height: AppTheme.spacingSm.h),
                        _buildTip(
                          context,
                          'Highlight your years of experience and key expertise'
                              .tr(),
                        ),
                        _buildTip(
                          context,
                          'Mention 2-3 specific technologies or skills'.tr(),
                        ),
                        _buildTip(
                          context,
                          'Include a quantifiable achievement'.tr(),
                        ),
                        _buildTip(
                          context,
                          'Show enthusiasm for your field'.tr(),
                        ),
                      ],
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

  Widget _buildTip(BuildContext context, String tip) => Padding(
    padding: EdgeInsets.only(top: AppTheme.spacingXs.h),
    child: Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Icon(
          Icons.check_circle_outline,
          size: 16.sp,
          color: AppTheme.accentColor,
        ),
        SizedBox(width: AppTheme.spacingXs.w),
        Expanded(
          child: Text(
            tip,
            style: Theme.of(context).textTheme.bodySmall?.copyWith(
              height: 1.4,
            ),
          ),
        ),
      ],
    ),
  );
}
