import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconsax/iconsax.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import '../cubit/resume_review_cubit.dart';
import '../cubit/resume_review_state.dart';

class ResumeReviewScreen extends StatelessWidget {
  const ResumeReviewScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: const Text('Review Resume'),
        centerTitle: true,
      ),
      body: BlocConsumer<ResumeReviewCubit, ResumeReviewState>(
        listener: (context, state) {
          if (state.status == ResumeReviewStatus.success) {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text('Resume saved successfully!')),
            );
            Navigator.of(context).popUntil((route) => route.isFirst);
          } else if (state.status == ResumeReviewStatus.failure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage ?? 'An error occurred'),
                backgroundColor: AppTheme.errorColor,
              ),
            );
          }
        },
        builder: (context, state) {
          return Stack(
            children: [
              CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: EdgeInsets.all(AppTheme.spacingMd.w),
                    sliver: SliverList(
                      delegate: SliverChildListDelegate([
                        _buildHeroCard(context, state),
                        SizedBox(height: AppTheme.spacingLg.h),
                        _PersonalInfoSection(data: state.data),
                        SizedBox(height: AppTheme.spacingLg.h),
                        _SummarySection(summary: state.data['summary'] as String?),
                        SizedBox(height: AppTheme.spacingLg.h),
                        _ExperienceSection(
                          experience: (state.data['experience'] as List?)
                              ?.cast<Map<String, dynamic>>() ??
                              [],
                        ),
                        SizedBox(height: AppTheme.spacingLg.h),
                        _EducationSection(
                          education: (state.data['education'] as List?)
                              ?.cast<Map<String, dynamic>>() ??
                              [],
                        ),
                        SizedBox(height: AppTheme.spacingLg.h),
                        _SkillsSection(
                          skills: (state.data['skills'] as List?)?.cast<String>() ?? [],
                        ),
                        SizedBox(height: 100.h), // Space for footer
                      ]),
                    ),
                  ),
                ],
              ),
              _buildFooter(context, state),
              if (state.status == ResumeReviewStatus.syncing)
                const ColoredBox(
                  color: Colors.black26,
                  child: Center(child: CircularProgressIndicator()),
                ),
            ],
          );
        },
      ),
    );
  }

  Widget _buildHeroCard(BuildContext context, ResumeReviewState state) {
    final theme = Theme.of(context);
    final name = state.data['fullName'] as String? ?? state.data['name'] as String? ?? 'No Name';

    return Hero(
      tag: 'resume-review-card',
      child: Container(
        padding: EdgeInsets.all(AppTheme.spacingLg.w),
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(AppTheme.radiusLarge.r),
          border: Border.all(color: AppTheme.primaryColor.withOpacity(0.1)),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              padding: EdgeInsets.all(AppTheme.spacingMd.w),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Iconsax.document_text5,
                color: AppTheme.primaryColor,
                size: 32.sp,
              ),
            ),
            SizedBox(height: AppTheme.spacingMd.h),
            Material(
              type: MaterialType.transparency,
              child: Text(
                name,
                style: theme.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: AppTheme.spacingSm.h),
            const Material(
              type: MaterialType.transparency,
              child: Text(
                'AI has extracted these details. Please verify before saving.',
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context, ResumeReviewState state) {
    final hasName = (state.data['fullName'] as String? ?? state.data['name'] as String? ?? '').isNotEmpty;
    final hasEmail = (state.data['email'] as String? ?? '').isNotEmpty;
    final isValid = hasName && hasEmail;

    return Align(
      alignment: Alignment.bottomCenter,
      child: Container(
        padding: EdgeInsets.all(AppTheme.spacingMd.w),
        decoration: BoxDecoration(
          color: Theme.of(context).scaffoldBackgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, -4),
            ),
          ],
        ),
        child: SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: isValid ? () => context.read<ResumeReviewCubit>().confirmAndSave() : null,
            style: AppTheme.primaryButtonStyle.copyWith(
              padding: WidgetStatePropertyAll(EdgeInsets.symmetric(vertical: 16.h)),
            ),
            child: const Text('Confirm & Save'),
          ),
        ),
      ),
    );
  }

  Widget _buildInfoField(
    BuildContext context,
    String label,
    String? value, {
    bool isRequired = false,
    required Function(String) onEdit,
  }) {
    final theme = Theme.of(context);
    final isEmpty = value == null || value.isEmpty;
    final showError = isRequired && isEmpty;

    return Padding(
      padding: EdgeInsets.only(bottom: AppTheme.spacingMd.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(label, style: theme.textTheme.labelMedium),
              if (isRequired)
                Text(' *', style: TextStyle(color: AppTheme.errorColor)),
              const Spacer(),
              if (!isEmpty)
                Icon(
                  Iconsax.magicpen,
                  size: 14,
                  color: AppTheme.accentColor,
                ),            ],
          ),
          SizedBox(height: AppTheme.spacingXs.h),
          InkWell(
            onTap: () {
              _showEditTextField(context, label, value ?? '', onEdit);
            },
            borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
            child: Container(
              width: double.infinity,
              padding: EdgeInsets.symmetric(
                horizontal: AppTheme.spacingMd.w,
                vertical: AppTheme.spacingSm.h,
              ),
              decoration: BoxDecoration(
                color:
                    showError
                        ? AppTheme.errorColor.withOpacity(0.05)
                        : theme.cardTheme.color,
                borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
                border: Border.all(
                  color: showError ? AppTheme.errorColor : AppTheme.borderLight,
                ),
              ),
              child: Text(
                isEmpty ? 'Not found' : value!,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color:
                      isEmpty
                          ? AppTheme.textMutedLight
                          : theme.textTheme.bodyMedium?.color,
                  fontStyle: isEmpty ? FontStyle.italic : null,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void _showEditTextField(
    BuildContext context,
    String label,
    String initialValue,
    Function(String) onSave,
  ) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => _EditItemSheet(
            title: 'Edit $label',
            initialData: {'value': initialValue},
            fields: [
              {
                'key': 'value',
                'label': label,
                'maxLines': label == 'Summary' ? 5 : 1,
              },
            ],
            onSave: (data) => onSave(data['value'] as String),
          ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  final String title;
  final VoidCallback? onAdd;

  const _SectionHeader({required this.title, this.onAdd});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
            color: AppTheme.primaryColor,
          ),
        ),
        if (onAdd != null)
          IconButton(
            onPressed: onAdd,
            icon: Icon(Iconsax.add_circle, color: AppTheme.primaryColor),
          ),
      ],
    );
  }
}

class _PersonalInfoSection extends StatelessWidget {
  final Map<String, dynamic> data;

  const _PersonalInfoSection({required this.data});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<ResumeReviewCubit>();
    final parent = context.findAncestorWidgetOfExactType<ResumeReviewScreen>()!;
    final name = data['fullName'] as String? ?? data['name'] as String?;
    final email = data['email'] as String?;
    final phone = data['phone'] as String?;
    final location = data['location'] as String? ?? data['address'] as String?;
    final linkedin = data['linkedin'] as String?;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeader(title: 'Personal Info'),
        SizedBox(height: AppTheme.spacingSm.h),
        parent._buildInfoField(
          context,
          'Full Name',
          name,
          isRequired: true,
          onEdit: (val) => cubit.updatePersonalInfo(name: val),
        ),
        parent._buildInfoField(
          context,
          'Email',
          email,
          isRequired: true,
          onEdit: (val) => cubit.updatePersonalInfo(email: val),
        ),
        parent._buildInfoField(
          context,
          'Phone',
          phone,
          onEdit: (val) => cubit.updatePersonalInfo(phone: val),
        ),
        parent._buildInfoField(
          context,
          'Location',
          location,
          onEdit: (val) => cubit.updatePersonalInfo(location: val),
        ),
        parent._buildInfoField(
          context,
          'LinkedIn',
          linkedin,
          onEdit: (val) => cubit.updatePersonalInfo(linkedin: val),
        ),
      ],
    );
  }
}

class _SummarySection extends StatelessWidget {
  final String? summary;

  const _SummarySection({this.summary});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.read<ResumeReviewCubit>();
    final isEmpty = summary == null || summary!.isEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const _SectionHeader(title: 'Summary'),
        SizedBox(height: AppTheme.spacingSm.h),
        InkWell(
          onTap: () {
            (context.findAncestorWidgetOfExactType<ResumeReviewScreen>()!)
                ._showEditTextField(
                  context,
                  'Summary',
                  summary ?? '',
                  (val) => cubit.updateSummary(val),
                );
          },
          borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
          child: Container(
            width: double.infinity,
            padding: EdgeInsets.all(AppTheme.spacingMd.w),
            decoration: BoxDecoration(
              color: theme.cardTheme.color,
              borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
              border: Border.all(color: AppTheme.borderLight),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    isEmpty ? 'No summary extracted' : summary!,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: isEmpty ? AppTheme.textMutedLight : null,
                      fontStyle: isEmpty ? FontStyle.italic : null,
                    ),
                  ),
                ),
                if (!isEmpty)
                  Icon(
                    Iconsax.magicpen,
                    size: 14,
                    color: AppTheme.accentColor,
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _ExperienceSection extends StatelessWidget {
  final List<Map<String, dynamic>> experience;

  const _ExperienceSection({required this.experience});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.read<ResumeReviewCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          title: 'Experience',
          onAdd: () {
            _showEditExperienceSheet(context, {}, -1);
          },
        ),
        if (experience.isEmpty)
          Padding(
            padding: EdgeInsets.all(AppTheme.spacingMd.w),
            child: Text(
              'No experience extracted',
              style: theme.textTheme.bodySmall,
            ),
          )
        else
          ...experience.asMap().entries.map((entry) {
            final index = entry.key;
            final exp = entry.value;
            return _ReviewItemTile(
              title: exp['position'] ?? 'Unknown Position',
              subtitle: exp['company'] ?? 'Unknown Company',
              date: '${exp['startDate'] ?? ''} - ${exp['endDate'] ?? 'Present'}',
              onEdit: () {
                _showEditExperienceSheet(context, exp, index);
              },
              onDelete: () {
                cubit.removeExperience(index);
              },
            );
          }),
      ],
    );
  }

  void _showEditExperienceSheet(
    BuildContext context,
    Map<String, dynamic> exp,
    int index,
  ) {
    final cubit = context.read<ResumeReviewCubit>();
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder:
          (context) => _EditItemSheet(
            title: index == -1 ? 'Add Experience' : 'Edit Experience',
            initialData: exp,
            fields: const [
              {'key': 'position', 'label': 'Position'},
              {'key': 'company', 'label': 'Company'},
              {'key': 'startDate', 'label': 'Start Date'},
              {'key': 'endDate', 'label': 'End Date'},
              {'key': 'description', 'label': 'Description', 'maxLines': 4},
            ],
            onSave: (newData) {
              if (index == -1) {
                cubit.addExperience(newData);
              } else {
                cubit.removeExperience(index);
                cubit.addExperience(newData);
              }
            },
          ),
    );
  }
}

class _EducationSection extends StatelessWidget {
  final List<Map<String, dynamic>> education;

  const _EducationSection({required this.education});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(title: 'Education', onAdd: () {}),
        if (education.isEmpty)
          Padding(
            padding: EdgeInsets.all(AppTheme.spacingMd.w),
            child: Text('No education extracted', style: theme.textTheme.bodySmall),
          )
        else
          ...education.asMap().entries.map((entry) {
            final index = entry.key;
            final edu = entry.value;
            return _ReviewItemTile(
              title: edu['degree'] ?? 'Unknown Degree',
              subtitle: edu['institution'] ?? 'Unknown Institution',
              date: '${edu['startDate'] ?? ''} - ${edu['endDate'] ?? ''}',
              onEdit: () {
                _showEditEducationSheet(context, edu, index);
              },
            );
          }),
      ],
    );
  }

  void _showEditEducationSheet(BuildContext context, Map<String, dynamic> edu, int index) {
    showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => _EditItemSheet(
        title: 'Edit Education',
        initialData: edu,
        fields: const [
          {'key': 'degree', 'label': 'Degree'},
          {'key': 'institution', 'label': 'Institution'},
          {'key': 'startDate', 'label': 'Start Date'},
          {'key': 'endDate', 'label': 'End Date'},
          {'key': 'fieldOfStudy', 'label': 'Field of Study'},
        ],
        onSave: (newData) {
          // TODO: Update in cubit
        },
      ),
    );
  }
}

class _SkillsSection extends StatelessWidget {
  final List<String> skills;

  const _SkillsSection({required this.skills});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.read<ResumeReviewCubit>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _SectionHeader(
          title: 'Skills',
          onAdd: () {
            _showAddSkillDialog(context);
          },
        ),
        if (skills.isEmpty)
          Padding(
            padding: EdgeInsets.all(AppTheme.spacingMd.w),
            child: Text('No skills extracted', style: theme.textTheme.bodySmall),
          )
        else
          Wrap(
            spacing: AppTheme.spacingSm.w,
            runSpacing: AppTheme.spacingSm.h,
            children:
                skills
                    .map(
                      (skill) => Chip(
                        label: Text(skill),
                        onDeleted: () {
                          final newSkills = List<String>.from(skills);
                          newSkills.remove(skill);
                          cubit.updateSkills(newSkills);
                        },
                      ),
                    )
                    .toList(),
          ),
      ],
    );
  }

  void _showAddSkillDialog(BuildContext context) {
    final cubit = context.read<ResumeReviewCubit>();
    final controller = TextEditingController();
    showDialog<void>(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Add Skill'),
            content: TextField(
              controller: controller,
              decoration: const InputDecoration(hintText: 'Enter skill name'),
              autofocus: true,
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  if (controller.text.trim().isNotEmpty) {
                    final newSkills = List<String>.from(skills);
                    newSkills.add(controller.text.trim());
                    cubit.updateSkills(newSkills);
                  }
                  Navigator.pop(context);
                },
                child: const Text('Add'),
              ),
            ],
          ),
    );
  }
}

class _ReviewItemTile extends StatelessWidget {
  final String title;
  final String subtitle;
  final String date;
  final VoidCallback onEdit;
  final VoidCallback? onDelete;

  const _ReviewItemTile({
    required this.title,
    required this.subtitle,
    required this.date,
    required this.onEdit,
    this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: EdgeInsets.only(bottom: AppTheme.spacingSm.h),
      child: ListTile(
        title: Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(subtitle),
            Text(date, style: theme.textTheme.bodySmall),
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (onDelete != null)
              IconButton(
                onPressed: onDelete,
                icon: Icon(Iconsax.trash, size: 18, color: AppTheme.errorColor),
              ),
            Icon(
              Iconsax.magicpen,
              size: 16,
              color: AppTheme.accentColor,
            ),
          ],
        ),
        onTap: onEdit,
      ),
    );
  }
}

class _EditItemSheet extends StatefulWidget {
  final String title;
  final Map<String, dynamic> initialData;
  final List<Map<String, dynamic>> fields;
  final Function(Map<String, dynamic>) onSave;

  const _EditItemSheet({
    required this.title,
    required this.initialData,
    required this.fields,
    required this.onSave,
  });

  @override
  State<_EditItemSheet> createState() => _EditItemSheetState();
}

class _EditItemSheetState extends State<_EditItemSheet> {
  late Map<String, dynamic> _formData;

  @override
  void initState() {
    super.initState();
    _formData = Map<String, dynamic>.from(widget.initialData);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppTheme.radiusLarge.r)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40.w,
            height: 4.h,
            margin: EdgeInsets.symmetric(vertical: AppTheme.spacingMd.h),
            decoration: BoxDecoration(
              color: AppTheme.borderLight,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: AppTheme.spacingLg.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(widget.title, style: theme.textTheme.titleLarge),
                IconButton(
                  onPressed: () => Navigator.pop(context),
                  icon: const Icon(Icons.close),
                ),
              ],
            ),
          ),
          Flexible(
            child: SingleChildScrollView(
              padding: EdgeInsets.all(AppTheme.spacingLg.w),
              child: Column(
                children: [
                  ...widget.fields.map((field) {
                    final key = field['key'] as String;
                    final label = field['label'] as String;
                    final maxLines = field['maxLines'] as int? ?? 1;

                    return Padding(
                      padding: EdgeInsets.only(bottom: AppTheme.spacingMd.h),
                      child: TextFormField(
                        initialValue: _formData[key]?.toString(),
                        maxLines: maxLines,
                        decoration: InputDecoration(
                          labelText: label,
                          alignLabelWithHint: maxLines > 1,
                        ),
                        onChanged: (value) => _formData[key] = value,
                      ),
                    );
                  }),
                  SizedBox(height: AppTheme.spacingLg.h),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        widget.onSave(_formData);
                        Navigator.pop(context);
                      },
                      child: const Text('Save Changes'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
