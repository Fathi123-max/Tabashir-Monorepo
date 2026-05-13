import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/network/models/ai_resume/resume_models.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../cubit/ai_resume_builder_cubit.dart';
import '../../widgets/shared/form_fields.dart';

class ResumeProjectsStep extends StatelessWidget {
  const ResumeProjectsStep({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AiResumeBuilderCubit, AiResumeBuilderState>(
      builder: (context, state) {
        final projects = state.resumeData.projects;
        final theme = Theme.of(context);

        return SingleChildScrollView(
          padding: EdgeInsets.all(AppTheme.spacingMd.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'ResumeProjects'.tr(),
                style: theme.textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: AppTheme.spacingXs.h),
              Text(
                'Add relevant projects you have worked on.'.tr(),
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textMutedLight,
                ),
              ),
              SizedBox(height: AppTheme.spacingXl.h),
              if (projects.isEmpty)
                _buildEmptyState(context, theme)
              else
                ...projects.asMap().entries.map((entry) {
                  final index = entry.key;
                  final project = entry.value;
                  return _buildResumeProjectCard(
                    context,
                    theme,
                    project,
                    index,
                    projects,
                  );
                }),
              SizedBox(height: AppTheme.spacingLg.h),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () => _showAddResumeProjectDialog(context),
                  icon: const Icon(Icons.add),
                  label: Text('Add ResumeProject'.tr()),
                  style: OutlinedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                      vertical: AppTheme.spacingMd.h,
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppTheme.spacingXxl.h),
            ],
          ),
        );
      },
    );
  }

  Widget _buildEmptyState(BuildContext context, ThemeData theme) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(AppTheme.spacingXl.w),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge.r),
        border: Border.all(
          color: theme.brightness == Brightness.light
              ? AppTheme.borderLight
              : AppTheme.borderDark,
          style: BorderStyle.solid,
        ),
      ),
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.all(AppTheme.spacingLg.w),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.code,
              size: 48.sp,
              color: AppTheme.primaryColor,
            ),
          ),
          SizedBox(height: AppTheme.spacingLg.h),
          Text(
            'No projects added yet'.tr(),
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: AppTheme.spacingSm.h),
          Text(
            'Add projects to showcase your skills in action.'.tr(),
            textAlign: TextAlign.center,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppTheme.textMutedLight,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildResumeProjectCard(
    BuildContext context,
    ThemeData theme,
    ResumeProject project,
    int index,
    List<ResumeProject> projects,
  ) {
    return Card(
      margin: EdgeInsets.only(bottom: AppTheme.spacingMd.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
        side: BorderSide(
          color: theme.brightness == Brightness.light
              ? AppTheme.borderLight
              : AppTheme.borderDark,
        ),
      ),
      child: Padding(
        padding: EdgeInsets.all(AppTheme.spacingMd.w),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.all(AppTheme.spacingSm.w),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
              ),
              child: Icon(
                Icons.code,
                color: AppTheme.primaryColor,
                size: 24.sp,
              ),
            ),
            SizedBox(width: AppTheme.spacingMd.w),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    project.name ?? '',
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  if (project.position?.isNotEmpty == true) ...[
                    SizedBox(height: AppTheme.spacingXs.h),
                    Text(
                      project.position!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                  SizedBox(height: AppTheme.spacingXs.h),
                  Row(
                    children: [
                      Icon(
                        Icons.calendar_today_outlined,
                        size: 14.sp,
                        color: AppTheme.textMutedLight,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        _formatDateRange(project.startDate, project.endDate),
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: AppTheme.textMutedLight,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            PopupMenuButton(
              icon: const Icon(Icons.more_vert),
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'edit',
                  child: Row(
                    children: [
                      const Icon(Icons.edit_outlined, size: 20),
                      SizedBox(width: AppTheme.spacingSm.w),
                      Text('Edit'.tr()),
                    ],
                  ),
                ),
                PopupMenuItem(
                  value: 'delete',
                  child: Row(
                    children: [
                      Icon(
                        Icons.delete_outline,
                        size: 20,
                        color: AppTheme.errorColor,
                      ),
                      SizedBox(width: AppTheme.spacingSm.w),
                      Text(
                        'Delete'.tr(),
                        style: TextStyle(color: AppTheme.errorColor),
                      ),
                    ],
                  ),
                ),
              ],
              onSelected: (value) {
                if (value == 'edit') {
                  _showAddResumeProjectDialog(
                    context,
                    project: project,
                    index: index,
                  );
                } else if (value == 'delete') {
                  _deleteResumeProject(context, projects, index);
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  String _formatDateRange(DateTime? start, DateTime? end) {
    if (start == null) return '';
    final startStr = '${start.month}/${start.year}';
    if (end == null) return '$startStr - Present';
    return '$startStr - ${end.month}/${end.year}';
  }

  void _showAddResumeProjectDialog(
    BuildContext context, {
    ResumeProject? project,
    int? index,
  }) {
    final formKey = GlobalKey<FormState>();
    final cubit = context.read<AiResumeBuilderCubit>();

    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => BlocProvider.value(
        value: cubit,
        child: _ResumeProjectDialog(
          formKey: formKey,
          title: project == null
              ? 'Add ResumeProject'.tr()
              : 'Edit ResumeProject'.tr(),
          initialResumeProject: project,
          onSave: (newResumeProject) {
            if (project == null) {
              // Add
              final updated = [
                ...cubit.state.resumeData.projects,
                newResumeProject,
              ];
              cubit.updateResumeProjects(updated);
            } else {
              // Edit
              final updated = [...cubit.state.resumeData.projects];
              updated[index!] = newResumeProject;
              cubit.updateResumeProjects(updated);
            }
            Navigator.pop(context);
          },
        ),
      ),
    );
  }

  void _deleteResumeProject(
    BuildContext context,
    List<ResumeProject> projects,
    int index,
  ) {
    final cubit = context.read<AiResumeBuilderCubit>();
    final updated = [...projects];
    updated.removeAt(index);
    cubit.updateResumeProjects(updated);
  }
}

class _ResumeProjectDialog extends StatefulWidget {
  const _ResumeProjectDialog({
    required this.formKey,
    required this.title,
    required this.onSave,
    this.initialResumeProject,
  });

  final GlobalKey<FormState> formKey;
  final String title;
  final ResumeProject? initialResumeProject;
  final Function(ResumeProject) onSave;

  @override
  State<_ResumeProjectDialog> createState() => _ResumeProjectDialogState();
}

class _ResumeProjectDialogState extends State<_ResumeProjectDialog> {
  late TextEditingController nameController;
  late TextEditingController positionController;
  late TextEditingController cityController;
  late TextEditingController descriptionController;
  late TextEditingController startDateController;
  late TextEditingController endDateController;
  bool isPresent = false;

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
      text: widget.initialResumeProject?.name ?? '',
    );
    positionController = TextEditingController(
      text: widget.initialResumeProject?.position ?? '',
    );
    cityController = TextEditingController(
      text: widget.initialResumeProject?.city ?? '',
    );
    descriptionController = TextEditingController(
      text: widget.initialResumeProject?.description ?? '',
    );
    startDateController = TextEditingController(
      text: widget.initialResumeProject?.startDate != null
          ? '${widget.initialResumeProject!.startDate!.day}/${widget.initialResumeProject!.startDate!.month}/${widget.initialResumeProject!.startDate!.year}'
          : '',
    );
    isPresent =
        widget.initialResumeProject?.endDate == null &&
        widget.initialResumeProject?.startDate != null;
    endDateController = TextEditingController(
      text: widget.initialResumeProject?.endDate != null
          ? '${widget.initialResumeProject!.endDate!.day}/${widget.initialResumeProject!.endDate!.month}/${widget.initialResumeProject!.endDate!.year}'
          : '',
    );
  }

  @override
  void dispose() {
    nameController.dispose();
    positionController.dispose();
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
                    color: AppTheme.primaryColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(
                      AppTheme.radiusDefault.r,
                    ),
                  ),
                  child: Icon(
                    Icons.code,
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
                      SizedBox(height: AppTheme.spacingMd.h),
                      AppTextField(
                        label: 'ResumeProject Name *'.tr(),
                        hint: 'e.g., E-Commerce App'.tr(),
                        controller: nameController,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'ResumeProject name is required'.tr();
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: AppTheme.spacingLg.h),
                      AppTextField(
                        label: 'Position/Role'.tr(),
                        hint: 'e.g., Lead Developer'.tr(),
                        controller: positionController,
                      ),
                      SizedBox(height: AppTheme.spacingMd.h),
                      AppTextField(
                        label: 'Location/City'.tr(),
                        hint: 'e.g., Remote, San Francisco'.tr(),
                        controller: cityController,
                      ),
                      SizedBox(height: AppTheme.spacingLg.h),
                      AppTextField(
                        label: 'Key Tasks & Details'.tr(),
                        hint: 'Describe your contributions...'.tr(),
                        controller: descriptionController,
                        maxLines: 4,
                      ),
                      SizedBox(height: AppTheme.spacingLg.h),
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
                          ResumeProject(
                            name: nameController.text,
                            position: positionController.text.isEmpty
                                ? null
                                : positionController.text,
                            city: cityController.text.isEmpty
                                ? null
                                : cityController.text,
                            description: descriptionController.text.isEmpty
                                ? null
                                : descriptionController.text,
                            startDate: _parseDate(startDateController.text),
                            endDate: isPresent
                                ? null
                                : _parseDate(endDateController.text),
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
