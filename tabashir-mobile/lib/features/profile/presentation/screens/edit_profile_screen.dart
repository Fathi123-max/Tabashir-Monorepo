import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';
import 'package:file_picker/file_picker.dart';

import '../../../../core/constants/profile_options.dart';
import '../../../../core/theme/app_theme.dart';
import '../cubit/profile_cubit.dart';
import '../widgets/reactive_dropdown_search.dart';
import '../widgets/reactive_gender_dropdown.dart';

// FormBuilder instance for creating forms
final fb = FormBuilder();

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  FormGroup? _form;
  bool _isUpdating = false;

  @override
  void initState() {
    super.initState();
    // Load profile data
    context.read<ProfileCubit>().loadProfileData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = context.read<ProfileCubit>();

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.scaffoldBackgroundColor,
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            size: 20.sp,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: Text(
          'Edit Profile'.tr(),
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          Padding(
            padding: EdgeInsets.only(right: AppTheme.spacingMd.w),
            child: Center(
              child: BlocBuilder<ProfileCubit, ProfileState>(
                builder: (context, state) => _isUpdating
                    ? SizedBox(
                        height: 20.h,
                        width: 20.w,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            AppTheme.primaryColor,
                          ),
                        ),
                      )
                    : TextButton(
                        onPressed: (_form?.valid ?? false) && !_isUpdating
                            ? () async {
                                setState(() => _isUpdating = true);
                                try {
                                  await cubit.updateProfile(_form!);
                                  if (mounted) Navigator.of(context).pop();
                                } catch (e) {
                                  debugPrint('Profile update error: $e');
                                } finally {
                                  if (mounted) {
                                    setState(() => _isUpdating = false);
                                  }
                                }
                              }
                            : null,
                        style: TextButton.styleFrom(
                          foregroundColor: AppTheme.primaryColor,
                          padding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                            vertical: 8.h,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20.r),
                          ),
                        ),
                        child: Text(
                          'Save'.tr(),
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: (_form?.valid ?? false) && !_isUpdating
                                ? AppTheme.primaryColor
                                : theme.colorScheme.onSurface.withOpacity(0.3),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
              ),
            ),
          ),
        ],
      ),
      body: BlocBuilder<ProfileCubit, ProfileState>(
        builder: (context, state) {
          if (state.profile != null) {
            if (_form == null) {
              _form = cubit.getEditForm(state.profile!);
            } else {
              _updateFormWithProfile(_form!, state.profile!);
            }
          }

          if (state.status == ProfileStatus.loading && _form == null) {
            return const Center(child: CircularProgressIndicator());
          }

          _form ??= _createBasicForm();

          return ReactiveForm(
            formGroup: _form!,
            child: SingleChildScrollView(
              padding: EdgeInsets.only(
                left: AppTheme.spacingMd.w,
                right: AppTheme.spacingMd.w,
                top: AppTheme.spacingSm.h,
                bottom: AppTheme.spacingLg.h,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _sectionHeader('Personal Information'.tr(), theme),
                  _buildSectionCard(
                    theme,
                    children: [
                      ReactiveTextField<String>(
                        formControlName: 'name',
                        decoration: _buildInputDecoration(
                          theme,
                          'Full Name'.tr(),
                          Icons.person_outline,
                        ),
                        validationMessages: {
                          ValidationMessage.required: (_) =>
                              'Name is required'.tr(),
                        },
                      ),
                      SizedBox(height: AppTheme.spacingMd.h),
                      ReactiveTextField<String>(
                        formControlName: 'email',
                        decoration: _buildInputDecoration(
                          theme,
                          'Email'.tr(),
                          Icons.email_outlined,
                        ),
                        keyboardType: TextInputType.emailAddress,
                        validationMessages: {
                          ValidationMessage.required: (_) =>
                              'Email is required'.tr(),
                          ValidationMessage.email: (_) =>
                              'Invalid email format'.tr(),
                        },
                      ),
                      SizedBox(height: AppTheme.spacingMd.h),
                      ReactiveDropdownSearch<String>(
                        formControlName: 'nationality',
                        items: nationalityOptions,
                        itemAsString: (item) => item,
                        labelText: 'Nationality'.tr(),
                        hintText: 'Select your nationality'.tr(),
                        decoration: _buildInputDecoration(
                          theme,
                          'Nationality'.tr(),
                          Icons.public_outlined,
                        ),
                        validationMessages: {
                          ValidationMessage.required: (_) =>
                              'Nationality is required'.tr(),
                        },
                      ),
                      SizedBox(height: AppTheme.spacingMd.h),
                      ReactiveGenderDropdown(
                        formControlName: 'gender',
                        decoration: _buildInputDecoration(
                          theme,
                          'Gender'.tr(),
                          Icons.person_outline,
                        ),
                        validationMessages: {
                          ValidationMessage.required: (_) =>
                              'Gender is required'.tr(),
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: AppTheme.spacingLg.h),
                  _sectionHeader('Target Details'.tr(), theme),
                  _buildSectionCard(
                    theme,
                    children: [
                      ReactiveTextField<String>(
                        formControlName: 'location',
                        decoration: _buildInputDecoration(
                          theme,
                          'Target Locations (e.g. Dubai, London)'.tr(),
                          Icons.location_on_outlined,
                        ),
                      ),
                      SizedBox(height: AppTheme.spacingMd.h),
                      ReactiveTextField<String>(
                        formControlName: 'jobTitle',
                        decoration: _buildInputDecoration(
                          theme,
                          'Target Roles / Positions'.tr(),
                          Icons.work_outline,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: AppTheme.spacingLg.h),
                  _sectionHeader('Resume / CV'.tr(), theme),
                  _buildSectionCard(
                    theme,
                    children: [
                      ReactiveValueListenableBuilder<String>(
                        formControlName: 'cv',
                        builder: (context, control, child) {
                          final value = control.value ?? '';
                          final isLocalFile =
                              value.contains('/') || value.contains(r'\');
                          final hasFile = value.isNotEmpty;

                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                padding: EdgeInsets.all(12.w),
                                decoration: BoxDecoration(
                                  color: theme
                                      .colorScheme
                                      .surfaceContainerHighest
                                      .withValues(alpha: 0.2),
                                  borderRadius: BorderRadius.circular(12.r),
                                  border: Border.all(
                                    color: theme.colorScheme.outlineVariant
                                        .withValues(alpha: 0.3),
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Icon(
                                      hasFile
                                          ? Icons.description
                                          : Icons.upload_file,
                                      color: hasFile
                                          ? theme.colorScheme.primary
                                          : theme.colorScheme.onSurfaceVariant,
                                      size: 24.sp,
                                    ),
                                    SizedBox(width: 12.w),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            hasFile
                                                ? value.split('/').last
                                                : 'No resume uploaded'.tr(),
                                            style: theme.textTheme.bodyMedium
                                                ?.copyWith(
                                                  fontWeight: hasFile
                                                      ? FontWeight.bold
                                                      : FontWeight.normal,
                                                  color: hasFile
                                                      ? theme
                                                            .colorScheme
                                                            .onSurface
                                                      : theme
                                                            .colorScheme
                                                            .onSurfaceVariant,
                                                ),
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                          if (hasFile)
                                            Text(
                                              isLocalFile
                                                  ? 'New file selected'.tr()
                                                  : 'Current resume'.tr(),
                                              style: theme.textTheme.labelSmall
                                                  ?.copyWith(
                                                    color: isLocalFile
                                                        ? Colors.orange
                                                        : theme
                                                              .colorScheme
                                                              .primary,
                                                  ),
                                            ),
                                        ],
                                      ),
                                    ),
                                    if (hasFile)
                                      IconButton(
                                        icon: Icon(Icons.close, size: 20.sp),
                                        onPressed: () => control.value = '',
                                        visualDensity: VisualDensity.compact,
                                      ),
                                  ],
                                ),
                              ),
                              SizedBox(height: 12.h),
                              SizedBox(
                                width: double.infinity,
                                child: OutlinedButton.icon(
                                  onPressed: () =>
                                      _pickCV(control as FormControl<String>),
                                  icon: Icon(
                                    Icons.add_circle_outline,
                                    size: 18.sp,
                                  ),
                                  label: Text(
                                    hasFile
                                        ? 'Replace Resume'.tr()
                                        : 'Upload Resume'.tr(),
                                  ),
                                  style: OutlinedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                      vertical: 12.h,
                                    ),
                                    side: BorderSide(
                                      color: theme.colorScheme.primary,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12.r),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: AppTheme.spacingLg.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _sectionHeader(String title, ThemeData theme) => Padding(
    padding: EdgeInsets.only(left: 4.w, bottom: 8.h),
    child: Text(
      title.toUpperCase(),
      style: theme.textTheme.labelMedium?.copyWith(
        fontWeight: FontWeight.bold,
        color: theme.colorScheme.onSurface.withValues(alpha: 0.4),
        letterSpacing: 1.2,
      ),
    ),
  );

  Widget _buildSectionCard(ThemeData theme, {required List<Widget> children}) =>
      Container(
        padding: EdgeInsets.all(AppTheme.spacingMd.w),
        decoration: BoxDecoration(
          color: theme.cardColor,
          borderRadius: BorderRadius.circular(16.r),
          border: Border.all(
            color: theme.colorScheme.outlineVariant.withValues(alpha: 0.5),
          ),
        ),
        child: Column(
          children: children,
        ),
      );

  InputDecoration _buildInputDecoration(
    ThemeData theme,
    String label,
    IconData icon,
  ) => InputDecoration(
    labelText: label,
    prefixIcon: Icon(icon, size: 20.sp),
    filled: true,
    fillColor: theme.colorScheme.surfaceContainerHighest.withValues(
      alpha: 0.3,
    ),
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide.none,
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(
        color: theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
      ),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12.r),
      borderSide: BorderSide(
        color: theme.colorScheme.primary.withValues(alpha: 0.5),
        width: 1.5,
      ),
    ),
    contentPadding: EdgeInsets.symmetric(
      horizontal: 16.w,
      vertical: 16.h,
    ),
    labelStyle: TextStyle(
      fontSize: 14.sp,
      color: theme.colorScheme.onSurface.withValues(alpha: 0.6),
    ),
    floatingLabelStyle: TextStyle(
      fontWeight: FontWeight.bold,
      color: theme.colorScheme.primary,
    ),
  );

  /// Create a basic form with empty/default values
  FormGroup _createBasicForm() => fb.group(<String, Object>{
    'name': FormControl<String>(value: ''),
    'email': FormControl<String>(value: ''),
    'nationality': FormControl<String>(value: ''),
    'gender': FormControl<String>(value: ''),
    'location': FormControl<String>(value: ''),
    'jobTitle': FormControl<String>(value: ''),
    'cv': FormControl<String>(value: ''),
  });

  /// Clean "Not specified" values to empty strings
  String _cleanValue(String? value) {
    if (value == null || value.isEmpty || value == 'Not specified') {
      return '';
    }
    return value;
  }

  /// Update form controls with profile data
  void _updateFormWithProfile(FormGroup form, ProfileData profile) {
    form.control('name').value = _cleanValue(profile.name);
    form.control('email').value = _cleanValue(profile.email);
    form.control('nationality').value = _cleanValue(profile.nationality);
    form.control('gender').value = _cleanValue(profile.gender);
    form.control('location').value = _cleanValue(profile.location);
    form.control('jobTitle').value = _cleanValue(profile.jobTitle);

    if (form.contains('cv')) {
      form.control('cv').value = _cleanValue(profile.cvFilename);
    }
  }

  Future<void> _pickCV(FormControl<String> control) async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf', 'doc', 'docx'],
      );

      if (result != null && result.files.single.path != null) {
        control.value = result.files.single.path;
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error picking file: $e'.tr())),
        );
      }
    }
  }
}
