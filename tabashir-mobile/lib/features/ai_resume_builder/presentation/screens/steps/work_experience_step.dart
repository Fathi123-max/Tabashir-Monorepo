import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/features/ai_resume_builder/presentation/cubit/ai_resume_builder_cubit.dart';
import 'package:tabashir/features/ai_resume_builder/presentation/widgets/shared/form_fields.dart';

import '../../../../../core/network/models/ai_resume/resume_models.dart';

class WorkExperienceStep extends StatelessWidget {
  const WorkExperienceStep({super.key});

  @override
  Widget build(
    BuildContext context,
  ) => BlocBuilder<AiResumeBuilderCubit, AiResumeBuilderState>(
    builder: (context, state) {
      final workExperience = state.resumeData.workExperience;

      return SingleChildScrollView(
        padding: EdgeInsets.all(AppTheme.spacingMd.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Work Experience'.tr(),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppTheme.spacingXs.h),
            Text(
              'Add your work experience. Start with your most recent position.'
                  .tr(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.textMutedLight,
              ),
            ),
            SizedBox(height: AppTheme.spacingXl.h),
            if (workExperience.isEmpty)
              _buildEmptyState(context)
            else
              ...workExperience.asMap().entries.map((entry) {
                final index = entry.key;
                final experience = entry.value;
                return _buildExperienceCard(
                  context,
                  index,
                  experience,
                );
              }),
            SizedBox(height: AppTheme.spacingLg.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _showAddExperienceDialog(context),
                icon: const Icon(Icons.add),
                label: Text('Add Experience'.tr()),
              ),
            ),
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
            Icons.work_outline,
            size: 64.sp,
            color: theme.iconTheme.color?.withOpacity(0.3),
          ),
          SizedBox(height: AppTheme.spacingMd.h),
          Text(
            'No work experience added yet'.tr(),
            style: theme.textTheme.titleMedium?.copyWith(
              color: AppTheme.textMutedLight,
            ),
          ),
          SizedBox(height: AppTheme.spacingXs.h),
          Text(
            'Add your first work experience'.tr(),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textMutedLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExperienceCard(
    BuildContext context,
    int index,
    WorkExperience experience,
  ) {
    final theme = Theme.of(context);
    final startDate = experience.startDate != null
        ? '${experience.startDate!.day}/${experience.startDate!.month}/${experience.startDate!.year}'
        : 'Not set'.tr();
    final endDate = experience.isPresent
        ? 'Present'.tr()
        : experience.endDate != null
        ? '${experience.endDate!.day}/${experience.endDate!.month}/${experience.endDate!.year}'
        : 'Not set'.tr();

    return Container(
      margin: EdgeInsets.only(bottom: AppTheme.spacingMd.h),
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      experience.position ?? 'Position Not Set'.tr(),
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      experience.organization ?? 'Organization Not Set'.tr(),
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: AppTheme.textMutedLight,
                      ),
                    ),
                    SizedBox(height: AppTheme.spacingXs.h),
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_outlined,
                          size: 16.sp,
                          color: AppTheme.textMutedLight,
                        ),
                        SizedBox(width: AppTheme.spacingXs.w),
                        Text(
                          experience.city ?? 'Location not specified'.tr(),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.textMutedLight,
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: AppTheme.spacingXs.h),
                    Row(
                      children: [
                        Icon(
                          Icons.calendar_today_outlined,
                          size: 16.sp,
                          color: AppTheme.textMutedLight,
                        ),
                        SizedBox(width: AppTheme.spacingXs.w),
                        Text(
                          '$startDate - $endDate'.tr(),
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.textMutedLight,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              PopupMenuButton<String>(
                onSelected: (value) {
                  if (value == 'edit'.tr()) {
                    _showEditExperienceDialog(context, index, experience);
                  } else if (value == 'delete'.tr()) {
                    _showDeleteConfirmation(context, index);
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'edit',
                    child: Text('Edit'.tr()),
                  ),
                  PopupMenuItem(
                    value: 'delete',
                    child: Text('Delete'.tr()),
                  ),
                ],
              ),
            ],
          ),
          if (experience.keyTasks != null &&
              experience.keyTasks!.isNotEmpty) ...[
            SizedBox(height: AppTheme.spacingMd.h),
            Divider(
              color: theme.brightness == Brightness.light
                  ? AppTheme.borderLight
                  : AppTheme.borderDark,
            ),
            SizedBox(height: AppTheme.spacingSm.h),
            Text(
              'Key Responsibilities:'.tr(),
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: AppTheme.spacingXs.h),
            Text(
              experience.keyTasks!,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ],
      ),
    );
  }

  void _showAddExperienceDialog(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final cubit = context.read<AiResumeBuilderCubit>();

    showDialog(
      context: context,
      builder: (context) => BlocProvider.value(
        value: cubit,
        child: _ExperienceDialog(
          formKey: formKey,
          title: 'Add Work Experience'.tr(),
          onSave: (exp) {
            cubit.addWorkExperience(exp);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  void _showEditExperienceDialog(
    BuildContext context,
    int index,
    WorkExperience experience,
  ) {
    final formKey = GlobalKey<FormState>();
    final cubit = context.read<AiResumeBuilderCubit>();

    showDialog(
      context: context,
      builder: (context) => BlocProvider.value(
        value: cubit,
        child: _ExperienceDialog(
          formKey: formKey,
          title: 'Edit Work Experience'.tr(),
          initialExperience: experience,
          onSave: (exp) {
            cubit.updateWorkExperience(index, exp);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  void _showDeleteConfirmation(BuildContext context, int index) {
    final cubit = context.read<AiResumeBuilderCubit>();

    showDialog(
      context: context,
      builder: (context) => BlocProvider.value(
        value: cubit,
        child: AlertDialog(
          title: Text('Delete Work Experience'.tr()),
          content: Text(
            'Are you sure you want to delete this work experience?'.tr(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'.tr()),
            ),
            ElevatedButton(
              onPressed: () {
                cubit.removeWorkExperience(index);
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.errorColor,
              ),
              child: Text('Delete'.tr()),
            ),
          ],
        ),
      ),
    );
  }
}

class _ExperienceDialog extends StatefulWidget {
  const _ExperienceDialog({
    required this.formKey,
    required this.title,
    required this.onSave,
    this.initialExperience,
  });
  final GlobalKey<FormState> formKey;
  final String title;
  final WorkExperience? initialExperience;
  final Function(WorkExperience) onSave;

  @override
  State<_ExperienceDialog> createState() => _ExperienceDialogState();
}

class _ExperienceDialogState extends State<_ExperienceDialog> {
  late TextEditingController positionController;
  late TextEditingController organizationController;
  late TextEditingController cityController;
  late TextEditingController tasksController;
  late TextEditingController startDateController;
  late TextEditingController endDateController;
  late bool isPresent;

  @override
  void initState() {
    super.initState();
    positionController = TextEditingController(
      text: widget.initialExperience?.position ?? '',
    );
    organizationController = TextEditingController(
      text: widget.initialExperience?.organization ?? '',
    );
    cityController = TextEditingController(
      text: widget.initialExperience?.city ?? '',
    );
    tasksController = TextEditingController(
      text: widget.initialExperience?.keyTasks ?? '',
    );
    startDateController = TextEditingController(
      text: widget.initialExperience?.startDate != null
          ? '${widget.initialExperience!.startDate!.day}/${widget.initialExperience!.startDate!.month}/${widget.initialExperience!.startDate!.year}'
          : '',
    );
    endDateController = TextEditingController(
      text: widget.initialExperience?.endDate != null
          ? '${widget.initialExperience!.endDate!.day}/${widget.initialExperience!.endDate!.month}/${widget.initialExperience!.endDate!.year}'
          : '',
    );
    isPresent = widget.initialExperience?.isPresent ?? false;
  }

  @override
  void dispose() {
    positionController.dispose();
    organizationController.dispose();
    cityController.dispose();
    tasksController.dispose();
    startDateController.dispose();
    endDateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge.r),
      ),
      child: Container(
        constraints: BoxConstraints(maxHeight: 0.8.sh),
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
                    Icons.work_outline,
                    color: AppTheme.primaryColor,
                    size: 24.sp,
                  ),
                ),
                SizedBox(width: AppTheme.spacingMd.w),
                Expanded(
                  child: Text(
                    widget.title,
                    style: theme.textTheme.headlineSmall?.copyWith(
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
                  key: widget.formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Position/Role Section
                      _buildSectionHeader(
                        theme,
                        Icons.person_outline,
                        'Position/Role',
                      ),
                      SizedBox(height: AppTheme.spacingMd.h),
                      AppTextField(
                        label: 'Job Title *'.tr(),
                        hint: 'e.g., Software Engineer, Product Manager'.tr(),
                        controller: positionController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Position is required'.tr();
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: AppTheme.spacingLg.h),
                      // Organization Section
                      _buildSectionHeader(
                        theme,
                        Icons.business_outlined,
                        'Organization'.tr(),
                      ),
                      SizedBox(height: AppTheme.spacingMd.h),
                      AppTextField(
                        label: 'Company Name *'.tr(),
                        hint: 'e.g., Google, Microsoft, Startup Inc.'.tr(),
                        controller: organizationController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Organization is required'.tr();
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: AppTheme.spacingMd.h),
                      AppTextField(
                        label: 'City'.tr(),
                        hint: 'e.g., San Francisco, London'.tr(),
                        controller: cityController,
                      ),
                      SizedBox(height: AppTheme.spacingLg.h),
                      // Responsibilities Section
                      _buildSectionHeader(
                        theme,
                        Icons.list_alt_outlined,
                        'Key Responsibilities'.tr(),
                      ),
                      SizedBox(height: AppTheme.spacingMd.h),
                      AppTextField(
                        label: 'Key Tasks & Achievements'.tr(),
                        hint:
                            'Describe your main responsibilities and achievements'
                                .tr(),
                        controller: tasksController,
                        maxLines: 4,
                      ),
                      SizedBox(height: AppTheme.spacingLg.h),
                      // Employment Period Section
                      _buildSectionHeader(
                        theme,
                        Icons.calendar_today_outlined,
                        'Employment Period'.tr(),
                      ),
                      SizedBox(height: AppTheme.spacingMd.h),
                      Row(
                        children: [
                          Expanded(
                            child: AppDateField(
                              label: 'Start Date *'.tr(),
                              hint: 'Select start date'.tr(),
                              onChanged: (date) {
                                startDateController.text =
                                    '${date.day}/${date.month}/${date.year}';
                              },
                              validator: (value) {
                                if (startDateController.text.isEmpty) {
                                  return 'Start date is required'.tr();
                                }
                                return null;
                              },
                            ),
                          ),
                          SizedBox(width: AppTheme.spacingMd.w),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'End Date'.tr(),
                                  style: theme.textTheme.labelLarge?.copyWith(
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: AppTheme.spacingXs.h),
                                CheckboxListTile(
                                  value: isPresent,
                                  onChanged: (value) {
                                    setState(() {
                                      isPresent = value ?? false;
                                      if (isPresent) endDateController.clear();
                                    });
                                  },
                                  title: Text('Present'.tr()),
                                  dense: true,
                                  controlAffinity:
                                      ListTileControlAffinity.leading,
                                  contentPadding: EdgeInsets.zero,
                                ),
                                if (!isPresent)
                                  AppDateField(
                                    hint: 'Select end date'.tr(),
                                    onChanged: (date) {
                                      endDateController.text =
                                          '${date.day}/${date.month}/${date.year}';
                                    },
                                    validator: (value) {
                                      if (!isPresent &&
                                          endDateController.text.isEmpty) {
                                        return 'End date is required if not present'
                                            .tr();
                                      }
                                      return null;
                                    },
                                  ),
                              ],
                            ),
                          ),
                        ],
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
                      style: Theme.of(context).textTheme.bodyMedium?.copyWith(
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
                      if (widget.formKey.currentState!.validate()) {
                        widget.onSave(
                          WorkExperience(
                            position: positionController.text,
                            organization: organizationController.text,
                            city: cityController.text.isEmpty
                                ? null
                                : cityController.text,
                            keyTasks: tasksController.text.isEmpty
                                ? null
                                : tasksController.text,
                            startDate: _parseDate(startDateController.text),
                            endDate: isPresent
                                ? null
                                : _parseDate(endDateController.text),
                            isPresent: isPresent,
                          ),
                        );
                      }
                    },
                    child: Text('Save'.tr()),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionHeader(ThemeData theme, IconData icon, String title) =>
      Row(
        children: [
          Icon(
            icon,
            size: 20.sp,
            color: AppTheme.primaryColor,
          ),
          SizedBox(width: AppTheme.spacingSm.w),
          Text(
            title,
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: AppTheme.primaryColor,
            ),
          ),
        ],
      );

  DateTime? _parseDate(String dateStr) {
    if (dateStr.isEmpty) return null;
    final parts = dateStr.split('/');
    if (parts.length == 3) {
      return DateTime(
        int.parse(parts[2]),
        int.parse(parts[1]),
        int.parse(parts[0]),
      );
    }
    return null;
  }
}
