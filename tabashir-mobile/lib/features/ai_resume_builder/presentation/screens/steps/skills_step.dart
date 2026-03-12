import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/features/ai_resume_builder/presentation/cubit/ai_resume_builder_cubit.dart';
import 'package:tabashir/features/ai_resume_builder/presentation/widgets/shared/form_fields.dart';

import '../../../data/models/resume_models.dart';

class SkillsStep extends StatelessWidget {
  const SkillsStep({super.key});

  @override
  Widget build(
    BuildContext context,
  ) => BlocBuilder<AiResumeBuilderCubit, AiResumeBuilderState>(
    builder: (context, state) {
      final skills = state.resumeData.skills;

      return SingleChildScrollView(
        padding: EdgeInsets.all(AppTheme.spacingMd.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Skills'.tr(),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppTheme.spacingXs.h),
            Text(
              'Add your relevant skills. Include both technical and soft skills.'
                  .tr(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.textMutedLight,
              ),
            ),
            SizedBox(height: AppTheme.spacingXl.h),
            if (skills.isEmpty)
              _buildEmptyState(context)
            else
              _buildSkillsByCategory(context, skills),
            SizedBox(height: AppTheme.spacingLg.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _showAddSkillDialog(context),
                icon: const Icon(Icons.add),
                label: Text('Add Skill'.tr()),
              ),
            ),
            SizedBox(height: AppTheme.spacingXl.h),
            const Divider(height: 1),
            SizedBox(height: AppTheme.spacingLg.h),
            _buildSuggestionChips(context),
          ],
        ),
      );
    },
  );

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppTheme.spacingXl.w),
      decoration: BoxDecoration(
        color: theme.brightness == Brightness.light
            ? const Color(0xFFF1F5F9)
            : const Color(0xFF1E293B),
        borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
        border: Border.all(
          color: theme.brightness == Brightness.light
              ? AppTheme.borderLight
              : AppTheme.borderDark,
        ),
      ),
      child: Column(
        children: [
          Icon(
            Icons.stars_outlined,
            size: 64.sp,
            color: theme.iconTheme.color?.withOpacity(0.3),
          ),
          SizedBox(height: AppTheme.spacingMd.h),
          Text(
            'No skills added yet'.tr(),
            style: theme.textTheme.titleMedium?.copyWith(
              color: AppTheme.textMutedLight,
            ),
          ),
          SizedBox(height: AppTheme.spacingXs.h),
          Text(
            'Add your first skill'.tr(),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textMutedLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillsByCategory(BuildContext context, List<Skill> skills) {
    final theme = Theme.of(context);
    final technicalSkills = skills
        .where((s) => s.category == SkillCategory.technical)
        .toList();
    final softSkills = skills
        .where((s) => s.category == SkillCategory.soft)
        .toList();
    final languageSkills = skills
        .where((s) => s.category == SkillCategory.languages)
        .toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (technicalSkills.isNotEmpty) ...[
          _buildCategorySection(
            context,
            'Technical Skills'.tr(),
            technicalSkills,
            Icons.code,
            AppTheme.primaryColor,
          ),
          SizedBox(height: AppTheme.spacingLg.h),
        ],
        if (softSkills.isNotEmpty) ...[
          _buildCategorySection(
            context,
            'Soft Skills'.tr(),
            softSkills,
            Icons.psychology,
            AppTheme.accentColor,
          ),
          SizedBox(height: AppTheme.spacingLg.h),
        ],
        if (languageSkills.isNotEmpty) ...[
          _buildCategorySection(
            context,
            'Languages'.tr(),
            languageSkills,
            Icons.language,
            Colors.orange,
          ),
        ],
      ],
    );
  }

  Widget _buildCategorySection(
    BuildContext context,
    String title,
    List<Skill> skills,
    IconData icon,
    Color color,
  ) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppTheme.spacingMd.w),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
        border: Border.all(
          color: theme.brightness == Brightness.light
              ? AppTheme.borderLight
              : AppTheme.borderDark,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                color: color,
                size: 20.sp,
              ),
              SizedBox(width: AppTheme.spacingXs.w),
              Text(
                title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          SizedBox(height: AppTheme.spacingSm.h),
          Wrap(
            spacing: AppTheme.spacingSm.w,
            runSpacing: AppTheme.spacingSm.h,
            children: skills.asMap().entries.map((entry) {
              final index = skills.indexOf(entry.value);
              final skill = entry.value;
              return _buildSkillChip(
                context,
                skill,
                () => _showEditSkillDialog(context, skills, index),
                () => _deleteSkill(context, skills, index),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  Widget _buildSkillChip(
    BuildContext context,
    Skill skill,
    VoidCallback onTap,
    VoidCallback onDelete,
  ) {
    final theme = Theme.of(context);
    Color chipColor;

    switch (skill.category) {
      case SkillCategory.technical:
        chipColor = AppTheme.primaryColor;
      case SkillCategory.soft:
        chipColor = AppTheme.accentColor;
      case SkillCategory.languages:
        chipColor = Colors.orange;
      case null:
        // TODO: Handle this case.
        throw UnimplementedError();
    }

    return Chip(
      label: Text(
        skill.name ?? '',
        style: theme.textTheme.labelLarge?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.w500,
        ),
      ),
      backgroundColor: chipColor,
      deleteIcon: const Icon(
        Icons.close,
        color: Colors.white,
        size: 18,
      ),
      onDeleted: onDelete,
    );
  }

  Widget _buildSuggestionChips(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Quick Add Popular Skills'.tr(),
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        SizedBox(height: AppTheme.spacingSm.h),
        Text(
          'Tap to quickly add common skills'.tr(),
          style: theme.textTheme.bodySmall?.copyWith(
            color: AppTheme.textMutedLight,
          ),
        ),
        SizedBox(height: AppTheme.spacingMd.h),
        Wrap(
          spacing: AppTheme.spacingSm.w,
          runSpacing: AppTheme.spacingSm.h,
          children: [
            _buildSuggestionChip(
              context,
              'JavaScript'.tr(),
              SkillCategory.technical,
            ),
            _buildSuggestionChip(
              context,
              'Python'.tr(),
              SkillCategory.technical,
            ),
            _buildSuggestionChip(
              context,
              'React'.tr(),
              SkillCategory.technical,
            ),
            _buildSuggestionChip(
              context,
              'Leadership'.tr(),
              SkillCategory.soft,
            ),
            _buildSuggestionChip(
              context,
              'Communication'.tr(),
              SkillCategory.soft,
            ),
            _buildSuggestionChip(
              context,
              'Problem Solving'.tr(),
              SkillCategory.soft,
            ),
            _buildSuggestionChip(
              context,
              'English'.tr(),
              SkillCategory.languages,
            ),
            _buildSuggestionChip(
              context,
              'Spanish'.tr(),
              SkillCategory.languages,
            ),
            _buildSuggestionChip(
              context,
              'Project Management'.tr(),
              SkillCategory.soft,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildSuggestionChip(
    BuildContext context,
    String skillName,
    SkillCategory category,
  ) => ActionChip(
    label: Text(skillName),
    onPressed: () {
      context.read<AiResumeBuilderCubit>().addSkill(
        Skill(
          name: skillName,
          category: category,
          proficiency: ProficiencyLevel.intermediate,
        ),
      );
    },
  );

  void _showAddSkillDialog(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final cubit = context.read<AiResumeBuilderCubit>();
    var name = '';
    var category = SkillCategory.technical;
    var proficiency = ProficiencyLevel.intermediate;

    showDialog(
      context: context,
      builder: (context) => BlocProvider.value(
        value: cubit,
        child: Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusLarge.r),
          ),
          child: Container(
            padding: EdgeInsets.all(AppTheme.spacingLg.w),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Header with icon and title
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(AppTheme.spacingMd.w),
                      decoration: BoxDecoration(
                        color: AppTheme.primaryColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(
                          AppTheme.radiusDefault.r,
                        ),
                      ),
                      child: Icon(
                        Icons.stars_outlined,
                        color: AppTheme.primaryColor,
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(width: AppTheme.spacingMd.w),
                    Expanded(
                      child: Text(
                        'Add Skill'.tr(),
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppTheme.spacingLg.h),
                // Form fields
                Expanded(
                  child: SingleChildScrollView(
                    child: Form(
                      key: formKey,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          // Skill Name Section
                          _buildSectionHeader(
                            context,
                            Icons.label_outlined,
                            'Skill Information'.tr(),
                          ),
                          SizedBox(height: AppTheme.spacingMd.h),
                          AppTextField(
                            label: 'Skill Name *'.tr(),
                            hint:
                                'e.g., JavaScript, Leadership, Project Management'
                                    .tr(),
                            onChanged: (value) => name = value,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return 'Skill name is required'.tr();
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: AppTheme.spacingLg.h),
                          // Category Section
                          _buildSectionHeader(
                            context,
                            Icons.category_outlined,
                            'Category'.tr(),
                          ),
                          SizedBox(height: AppTheme.spacingMd.h),
                          AppDropdownField<SkillCategory>(
                            label: 'Select Category *'.tr(),
                            value: category,
                            items: [
                              DropdownMenuItem(
                                value: SkillCategory.technical,
                                child: Text('Technical'.tr()),
                              ),
                              DropdownMenuItem(
                                value: SkillCategory.soft,
                                child: Text('Soft Skills'.tr()),
                              ),
                              DropdownMenuItem(
                                value: SkillCategory.languages,
                                child: Text('Languages'.tr()),
                              ),
                            ],
                            onChanged: (value) =>
                                category = value ?? SkillCategory.technical,
                            validator: (value) {
                              if (value == null) {
                                return 'Category is required'.tr();
                              }
                              return null;
                            },
                          ),
                          SizedBox(height: AppTheme.spacingLg.h),
                          // Proficiency Section
                          _buildSectionHeader(
                            context,
                            Icons.trending_up_outlined,
                            'Proficiency Level'.tr(),
                          ),
                          SizedBox(height: AppTheme.spacingMd.h),
                          AppDropdownField<ProficiencyLevel>(
                            label: 'Your Level'.tr(),
                            value: proficiency,
                            items: [
                              DropdownMenuItem(
                                value: ProficiencyLevel.beginner,
                                child: Text('Beginner'.tr()),
                              ),
                              DropdownMenuItem(
                                value: ProficiencyLevel.intermediate,
                                child: Text('Intermediate'.tr()),
                              ),
                              DropdownMenuItem(
                                value: ProficiencyLevel.advanced,
                                child: Text('Advanced'.tr()),
                              ),
                              DropdownMenuItem(
                                value: ProficiencyLevel.expert,
                                child: Text('Expert'.tr()),
                              ),
                            ],
                            onChanged: (value) => proficiency =
                                value ?? ProficiencyLevel.intermediate,
                          ),
                          SizedBox(height: AppTheme.spacingLg.h),
                        ],
                      ),
                    ),
                  ),
                ),
                // Action buttons
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text(
                          'Cancel'.tr(),
                          style: Theme.of(context).textTheme.bodyMedium
                              ?.copyWith(
                                color: AppTheme.errorColor,
                                fontWeight: FontWeight.w600,
                              ),
                        ),
                      ),
                    ),
                    SizedBox(width: AppTheme.spacingMd.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            cubit.addSkill(
                              Skill(
                                name: name,
                                category: category,
                                proficiency: proficiency,
                              ),
                            );
                            Navigator.pop(context);
                          }
                        },
                        child: Text('Add Skill'.tr()),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionHeader(
    BuildContext context,
    IconData icon,
    String title,
  ) => Row(
    children: [
      Icon(
        icon,
        size: 20.sp,
        color: AppTheme.primaryColor,
      ),
      SizedBox(width: AppTheme.spacingSm.w),
      Text(
        title,
        style: Theme.of(context).textTheme.labelLarge?.copyWith(
          fontWeight: FontWeight.w600,
          color: AppTheme.primaryColor,
        ),
      ),
    ],
  );

  void _showEditSkillDialog(
    BuildContext context,
    List<Skill> skills,
    int index,
  ) {
    final formKey = GlobalKey<FormState>();
    final cubit = context.read<AiResumeBuilderCubit>();
    final skill = skills[index];

    showDialog(
      context: context,
      builder: (context) => BlocProvider.value(
        value: cubit,
        child: AlertDialog(
          title: Text('Edit Skill'.tr()),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                AppTextField(
                  label: 'Skill Name *'.tr(),
                  hint: 'e.g., JavaScript, Leadership'.tr(),
                  initialValue: skill.name,
                  onChanged: (value) {},
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Skill name is required'.tr();
                    }
                    return null;
                  },
                ),
                SizedBox(height: AppTheme.spacingMd.h),
                AppDropdownField<SkillCategory>(
                  label: 'Category *'.tr(),
                  value: skill.category,
                  items: [
                    DropdownMenuItem(
                      value: SkillCategory.technical,
                      child: Text('Technical'.tr()),
                    ),
                    DropdownMenuItem(
                      value: SkillCategory.soft,
                      child: Text('Soft Skills'.tr()),
                    ),
                    DropdownMenuItem(
                      value: SkillCategory.languages,
                      child: Text('Languages'.tr()),
                    ),
                  ],
                  onChanged: (value) {},
                  validator: (value) {
                    if (value == null) {
                      return 'Category is required'.tr();
                    }
                    return null;
                  },
                ),
                SizedBox(height: AppTheme.spacingMd.h),
                AppDropdownField<ProficiencyLevel>(
                  label: 'Proficiency Level'.tr(),
                  value: skill.proficiency,
                  items: [
                    DropdownMenuItem(
                      value: ProficiencyLevel.beginner,
                      child: Text('Beginner'.tr()),
                    ),
                    DropdownMenuItem(
                      value: ProficiencyLevel.intermediate,
                      child: Text('Intermediate'.tr()),
                    ),
                    DropdownMenuItem(
                      value: ProficiencyLevel.advanced,
                      child: Text('Advanced'.tr()),
                    ),
                    DropdownMenuItem(
                      value: ProficiencyLevel.expert,
                      child: Text('Expert'.tr()),
                    ),
                  ],
                  onChanged: (value) {},
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'.tr()),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Update'.tr()),
            ),
          ],
        ),
      ),
    );
  }

  void _deleteSkill(BuildContext context, List<Skill> skills, int index) {
    context.read<AiResumeBuilderCubit>().removeSkill(index);
  }
}
