import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/features/ai_resume_builder/presentation/cubit/ai_resume_builder_cubit.dart';
import 'package:tabashir/features/ai_resume_builder/presentation/widgets/shared/form_fields.dart';

import '../../../data/models/resume_models.dart';

class EducationStep extends StatelessWidget {
  const EducationStep({super.key});

  @override
  Widget build(
    BuildContext context,
  ) => BlocBuilder<AiResumeBuilderCubit, AiResumeBuilderState>(
    builder: (context, state) {
      final education = state.resumeData.education;

      return SingleChildScrollView(
        padding: EdgeInsets.all(AppTheme.spacingMd.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Education'.tr(),
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: AppTheme.spacingXs.h),
            Text(
              'Add your educational background. Include your degrees and certifications.'
                  .tr(),
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: AppTheme.textMutedLight,
              ),
            ),
            SizedBox(height: AppTheme.spacingXl.h),
            if (education.isEmpty)
              _buildEmptyState(context)
            else
              ...education.asMap().entries.map((entry) {
                final index = entry.key;
                final edu = entry.value;
                return _buildEducationCard(context, index, edu);
              }),
            SizedBox(height: AppTheme.spacingLg.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton.icon(
                onPressed: () => _showAddEducationDialog(context),
                icon: const Icon(Icons.add),
                label: Text('Add Education'.tr()),
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
            Icons.school_outlined,
            size: 64.sp,
            color: theme.iconTheme.color?.withOpacity(0.3),
          ),
          SizedBox(height: AppTheme.spacingMd.h),
          Text(
            'No education added yet'.tr(),
            style: theme.textTheme.titleMedium?.copyWith(
              color: AppTheme.textMutedLight,
            ),
          ),
          SizedBox(height: AppTheme.spacingXs.h),
          Text(
            'Add your first education'.tr(),
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textMutedLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEducationCard(
    BuildContext context,
    int index,
    Education edu,
  ) {
    final theme = Theme.of(context);
    final startDate = edu.startDate != null
        ? '${edu.startDate!.day}/${edu.startDate!.month}/${edu.startDate!.year}'
        : 'Not set'.tr();
    final endDate = edu.endDate != null
        ? '${edu.endDate!.day}/${edu.endDate!.month}/${edu.endDate!.year}'
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
                      edu.degree ?? 'Degree Not Set'.tr(),
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    Text(
                      edu.school ?? 'School Not Set'.tr(),
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
                          edu.city ?? 'Location not specified'.tr(),
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
                    _showEditEducationDialog(context, index, edu);
                  } else if (value == 'delete'.tr()) {
                    _showDeleteConfirmation(context, index);
                  }
                },
                itemBuilder: (context) => [
                  PopupMenuItem(
                    value: 'edit'.tr(),
                    child: Text('Edit'.tr()),
                  ),
                  PopupMenuItem(
                    value: 'delete'.tr(),
                    child: Text('Delete'.tr()),
                  ),
                ],
              ),
            ],
          ),
          if (edu.description != null && edu.description!.isNotEmpty) ...[
            SizedBox(height: AppTheme.spacingMd.h),
            Divider(
              color: theme.brightness == Brightness.light
                  ? AppTheme.borderLight
                  : AppTheme.borderDark,
            ),
            SizedBox(height: AppTheme.spacingSm.h),
            Text(
              'Description:'.tr(),
              style: theme.textTheme.labelMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            SizedBox(height: AppTheme.spacingXs.h),
            Text(
              edu.description!,
              style: theme.textTheme.bodyMedium,
            ),
          ],
        ],
      ),
    );
  }

  void _showAddEducationDialog(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final cubit = context.read<AiResumeBuilderCubit>();

    showDialog(
      context: context,
      builder: (context) => BlocProvider.value(
        value: cubit,
        child: _EducationDialog(
          formKey: formKey,
          title: 'Add Education'.tr(),
          onSave: (edu) {
            cubit.addEducation(edu);
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  void _showEditEducationDialog(
    BuildContext context,
    int index,
    Education edu,
  ) {
    final formKey = GlobalKey<FormState>();
    final cubit = context.read<AiResumeBuilderCubit>();

    showDialog(
      context: context,
      builder: (context) => BlocProvider.value(
        value: cubit,
        child: _EducationDialog(
          formKey: formKey,
          title: 'Edit Education'.tr(),
          initialEducation: edu,
          onSave: (updatedEdu) {
            cubit.updateEducation(
              index,
              updatedEdu,
            );
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
          title: Text('Delete Education'.tr()),
          content: Text(
            'Are you sure you want to delete this education entry?'.tr(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text('Cancel'.tr()),
            ),
            ElevatedButton(
              onPressed: () {
                cubit.removeEducation(index);
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

class _EducationDialog extends StatefulWidget {
  const _EducationDialog({
    required this.formKey,
    required this.title,
    required this.onSave,
    this.initialEducation,
  });
  final GlobalKey<FormState> formKey;
  final String title;
  final Education? initialEducation;
  final Function(Education) onSave;

  @override
  State<_EducationDialog> createState() => _EducationDialogState();
}

class _EducationDialogState extends State<_EducationDialog> {
  late TextEditingController schoolController;
  late TextEditingController degreeController;
  late TextEditingController cityController;
  late TextEditingController descriptionController;
  late TextEditingController startDateController;
  late TextEditingController endDateController;

  @override
  void initState() {
    super.initState();
    schoolController = TextEditingController(
      text: widget.initialEducation?.school ?? '',
    );
    degreeController = TextEditingController(
      text: widget.initialEducation?.degree ?? '',
    );
    cityController = TextEditingController(
      text: widget.initialEducation?.city ?? '',
    );
    descriptionController = TextEditingController(
      text: widget.initialEducation?.description ?? '',
    );
    startDateController = TextEditingController(
      text: widget.initialEducation?.startDate != null
          ? '${widget.initialEducation!.startDate!.day}/${widget.initialEducation!.startDate!.month}/${widget.initialEducation!.startDate!.year}'
          : '',
    );
    endDateController = TextEditingController(
      text: widget.initialEducation?.endDate != null
          ? '${widget.initialEducation!.endDate!.day}/${widget.initialEducation!.endDate!.month}/${widget.initialEducation!.endDate!.year}'
          : '',
    );
  }

  @override
  void dispose() {
    schoolController.dispose();
    degreeController.dispose();
    cityController.dispose();
    descriptionController.dispose();
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
                    color: Colors.orange.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(
                      AppTheme.radiusDefault.r,
                    ),
                  ),
                  child: Icon(
                    Icons.school_outlined,
                    color: Colors.orange,
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
                      // Institution Section
                      _buildSectionHeader(
                        theme,
                        Icons.account_balance_outlined,
                        'Institution'.tr(),
                      ),
                      SizedBox(height: AppTheme.spacingMd.h),
                      AppTextField(
                        label: 'School/University *',
                        hint: 'e.g., Harvard University, MIT'.tr(),
                        controller: schoolController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'School is required'.tr();
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: AppTheme.spacingLg.h),
                      // Degree Section
                      _buildSectionHeader(
                        theme,
                        Icons.school_outlined,
                        'Degree'.tr(),
                      ),
                      SizedBox(height: AppTheme.spacingMd.h),
                      AppTextField(
                        label: 'Degree *'.tr(),
                        hint: 'e.g., Bachelor of Science in Computer Science'
                            .tr(),
                        controller: degreeController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Degree is required'.tr();
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: AppTheme.spacingMd.h),
                      AppTextField(
                        label: 'City'.tr(),
                        hint: 'e.g., Cambridge, MA'.tr(),
                        controller: cityController,
                      ),
                      SizedBox(height: AppTheme.spacingLg.h),
                      // Dates Section
                      _buildSectionHeader(
                        theme,
                        Icons.calendar_today_outlined,
                        'Attendance Period'.tr(),
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
                            child: AppDateField(
                              label: 'End Date'.tr(),
                              hint: 'Select end date'.tr(),
                              onChanged: (date) {
                                endDateController.text =
                                    '${date.day}/${date.month}/${date.year}';
                              },
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: AppTheme.spacingLg.h),
                      // Description Section
                      _buildSectionHeader(
                        theme,
                        Icons.description_outlined,
                        'Additional Information'.tr(),
                      ),
                      SizedBox(height: AppTheme.spacingMd.h),
                      AppTextField(
                        label: 'Description (Optional)'.tr(),
                        hint:
                            'Additional details about your education, GPA, honors, etc.'
                                .tr(),
                        controller: descriptionController,
                        maxLines: 3,
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
                          Education(
                            school: schoolController.text,
                            degree: degreeController.text,
                            city: cityController.text.isEmpty
                                ? null
                                : cityController.text,
                            startDate: _parseDate(startDateController.text),
                            endDate: _parseDate(endDateController.text),
                            description: descriptionController.text.isEmpty
                                ? null
                                : descriptionController.text,
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
            color: Colors.orange,
          ),
          SizedBox(width: AppTheme.spacingSm.w),
          Text(
            title,
            style: theme.textTheme.labelLarge?.copyWith(
              fontWeight: FontWeight.w600,
              color: Colors.orange,
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
