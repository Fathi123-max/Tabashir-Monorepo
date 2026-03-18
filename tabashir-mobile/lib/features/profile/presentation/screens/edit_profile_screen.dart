import 'dart:async';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:reactive_forms/reactive_forms.dart';

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
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
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
                                print(
                                  '\n\n########## [EDIT_PROFILE] APPBAR SAVE BUTTON CLICKED ##########',
                                );
                                print(
                                  '[EDIT_PROFILE] Form valid: ${_form?.valid}',
                                );
                                if (_form != null) {
                                  print(
                                    '[EDIT_PROFILE] Form values: ${_form!.value}',
                                  );
                                  print(
                                    '[EDIT_PROFILE] Form errors: ${_form!.errors}',
                                  );
                                }

                                setState(() {
                                  _isUpdating = true;
                                });
                                try {
                                  await cubit.updateProfile(_form!);
                                  print(
                                    '[EDIT_PROFILE] ✅ AppBar: Profile update completed successfully',
                                  );
                                  print(
                                    '[EDIT_PROFILE] Current cubit state: ${cubit.state.profile?.name}',
                                  );

                                  // Navigate back after successful save
                                  print(
                                    '[EDIT_PROFILE] Navigating back to profile screen...',
                                  );
                                  if (mounted) {
                                    Navigator.of(context).pop();
                                  }
                                } catch (e) {
                                  print(
                                    '[EDIT_PROFILE] ❌ AppBar: Profile update error: $e',
                                  );
                                  print(
                                    '[EDIT_PROFILE] Stack trace: ${StackTrace.current}',
                                  );
                                } finally {
                                  if (mounted) {
                                    setState(() {
                                      _isUpdating = false;
                                    });
                                  }
                                  print(
                                    '########## [EDIT_PROFILE] APPBAR SAVE FLOW COMPLETE ##########\n\n',
                                  );
                                }
                              }
                            : null,
                        child: Text(
                          'Save'.tr(),
                          style: theme.textTheme.titleMedium?.copyWith(
                            color: (_form?.valid ?? false) && !_isUpdating
                                ? AppTheme.primaryColor
                                : theme.colorScheme.onSurface.withValues(
                                    alpha: 0.4,
                                  ),
                            fontWeight: FontWeight.w600,
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
          // Create or update form when profile data is available
          if (state.profile != null) {
            if (_form == null) {
              // Create new form
              print('[EDIT_PROFILE] Creating new form with profile data');
              _form = cubit.getEditForm(state.profile!);
              print('[EDIT_PROFILE] Form created. Valid: ${_form!.valid}');
            } else {
              // Update existing form with profile data
              print('[EDIT_PROFILE] Updating existing form with profile data');
              _updateFormWithProfile(_form!, state.profile!);
              print('[EDIT_PROFILE] Form updated. Valid: ${_form!.valid}');
              if (!_form!.valid) {
                print(
                  '[EDIT_PROFILE] Form is INVALID! Errors: ${_form!.errors}',
                );
              }
            }
          }

          // Show loading while initial load
          if (state.status == ProfileStatus.loading && _form == null) {
            return const Center(child: CircularProgressIndicator());
          }

          // Fallback to empty form if something went wrong
          _form ??= _createBasicForm();

          return ReactiveForm(
            // Removed BlocBuilder since we're not using cubit state
            formGroup: _form!,
            child: SingleChildScrollView(
              padding: EdgeInsets.all(AppTheme.spacingMd.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Personal Information Section
                  Text(
                    'Personal Information'.tr(),
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: AppTheme.spacingMd.h),
                  ReactiveTextField<String>(
                    formControlName: 'name',
                    decoration: InputDecoration(
                      labelText: 'Full Name'.tr(),
                      prefixIcon: const Icon(Icons.person_outline),
                      border: const OutlineInputBorder(),
                    ),
                    validationMessages: {
                      ValidationMessage.required: (_) =>
                          'Name is required'.tr(),
                    },
                  ),
                  SizedBox(height: AppTheme.spacingMd.h),
                  ReactiveTextField<String>(
                    formControlName: 'email',
                    decoration: InputDecoration(
                      labelText: 'Email'.tr(),
                      prefixIcon: const Icon(Icons.email_outlined),
                      border: const OutlineInputBorder(),
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
                  ReactiveTextField<String>(
                    formControlName: 'phone',
                    decoration: InputDecoration(
                      labelText: 'Phone Number'.tr(),
                      prefixIcon: const Icon(Icons.phone_outlined),
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.phone,
                    validationMessages: {
                      ValidationMessage.required: (_) =>
                          'Phone number is required'.tr(),
                    },
                  ),
                  SizedBox(height: AppTheme.spacingMd.h),
                  ReactiveDropdownSearch<String>(
                    formControlName: 'nationality',
                    items: nationalityOptions,
                    itemAsString: (item) => item,
                    labelText: 'Nationality'.tr(),
                    hintText: 'Select your nationality'.tr(),
                    validationMessages: {
                      ValidationMessage.required: (_) =>
                          'Nationality is required'.tr(),
                    },
                  ),
                  SizedBox(height: AppTheme.spacingMd.h),
                  ReactiveGenderDropdown(
                    formControlName: 'gender',
                    validationMessages: {
                      ValidationMessage.required: (_) =>
                          'Gender is required'.tr(),
                    },
                  ),
                  SizedBox(height: AppTheme.spacingLg.h),

                  // Professional Details Section
                  Text(
                    'Professional Details'.tr(),
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(height: AppTheme.spacingMd.h),
                  ReactiveTextField<String>(
                    formControlName: 'jobTitle',
                    decoration: InputDecoration(
                      labelText: 'Job Title'.tr(),
                      prefixIcon: const Icon(Icons.work_outline),
                      border: const OutlineInputBorder(),
                    ),
                    validationMessages: {
                      ValidationMessage.required: (_) =>
                          'Job title is required'.tr(),
                    },
                  ),
                  SizedBox(height: AppTheme.spacingMd.h),
                  ReactiveTextField<String>(
                    formControlName: 'location',
                    decoration: InputDecoration(
                      labelText: 'Location'.tr(),
                      prefixIcon: const Icon(Icons.location_on_outlined),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: AppTheme.spacingMd.h),
                  ReactiveTextField<String>(
                    formControlName: 'company',
                    decoration: InputDecoration(
                      labelText: 'Company'.tr(),
                      prefixIcon: const Icon(Icons.business_outlined),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: AppTheme.spacingMd.h),
                  ReactiveTextField<String>(
                    formControlName: 'education',
                    decoration: InputDecoration(
                      labelText: 'Education'.tr(),
                      prefixIcon: const Icon(Icons.school_outlined),
                      border: const OutlineInputBorder(),
                    ),
                  ),
                  SizedBox(height: AppTheme.spacingMd.h),
                  ReactiveTextField<String>(
                    formControlName: 'linkedin',
                    decoration: InputDecoration(
                      labelText: 'LinkedIn Profile'.tr(),
                      hintText: 'https://linkedin.com/in/yourprofile',
                      prefixIcon: const Icon(Icons.link_outlined),
                      border: const OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.url,
                    validationMessages: {
                      'linkedinUrl': (_) =>
                          'Please enter a valid LinkedIn URL'.tr(),
                    },
                  ),
                  SizedBox(height: AppTheme.spacingLg.h),

                  // Save Button
                  SizedBox(
                    width: double.infinity,
                    child: ReactiveFormConsumer(
                      key: const Key('edit_profile_form'),
                      builder: (context, form, child) => ElevatedButton(
                        onPressed: form.valid && !_isUpdating
                            ? () async {
                                print(
                                  '\n\n########## [EDIT_PROFILE] SAVE BUTTON CLICKED ##########',
                                );
                                print(
                                  '[EDIT_PROFILE] Form valid: ${form.valid}',
                                );
                                print(
                                  '[EDIT_PROFILE] Form values: ${form.value}',
                                );
                                print(
                                  '[EDIT_PROFILE] Form errors: ${form.errors}',
                                );

                                setState(() {
                                  _isUpdating = true;
                                });
                                try {
                                  print(
                                    '[EDIT_PROFILE] Calling cubit.updateProfile()...',
                                  );
                                  await context
                                      .read<ProfileCubit>()
                                      .updateProfile(form);
                                  print(
                                    '[EDIT_PROFILE] ✅ Profile update completed successfully',
                                  );
                                  print(
                                    '[EDIT_PROFILE] Current cubit state: ${context.read<ProfileCubit>().state.profile?.name}',
                                  );

                                  // Navigate back after successful save
                                  print(
                                    '[EDIT_PROFILE] Navigating back to profile screen...',
                                  );
                                  Navigator.of(context).pop();
                                } catch (e) {
                                  print(
                                    '[EDIT_PROFILE] ❌ Profile update error: $e',
                                  );
                                  print(
                                    '[EDIT_PROFILE] Stack trace: ${StackTrace.current}',
                                  );
                                } finally {
                                  if (mounted) {
                                    setState(() {
                                      _isUpdating = false;
                                    });
                                  }
                                  print(
                                    '########## [EDIT_PROFILE] SAVE FLOW COMPLETE ##########\n\n',
                                  );
                                }
                              }
                            : null,
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(
                            vertical: AppTheme.spacingMd.h,
                          ),
                          backgroundColor: AppTheme.primaryColor,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              AppTheme.radiusDefault.r,
                            ),
                          ),
                        ),
                        child: _isUpdating
                            ? SizedBox(
                                height: 20.h,
                                width: 20.w,
                                child: const CircularProgressIndicator(
                                  strokeWidth: 2,
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                    Colors.white,
                                  ),
                                ),
                              )
                            : Text(
                                'Save Changes'.tr(),
                                style: theme.textTheme.titleMedium?.copyWith(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                      ),
                    ),
                  ),
                  SizedBox(height: AppTheme.spacingMd.h),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  /// Create a basic form with empty/default values
  FormGroup _createBasicForm() => fb.group(<String, Object>{
    'name': FormControl<String>(value: ''),
    'email': FormControl<String>(value: ''),
    'phone': FormControl<String>(value: ''),
    'nationality': FormControl<String>(value: ''),
    'gender': FormControl<String>(value: ''),
    'jobTitle': FormControl<String>(value: ''),
    'location': FormControl<String>(value: ''),
    'company': FormControl<String>(value: ''),
    'education': FormControl<String>(value: ''),
    'linkedin': FormControl<String>(value: ''),
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
    print('[EDIT_PROFILE] Updating form with profile data');
    print('[EDIT_PROFILE] Name: ${profile.name}');

    form.control('name').value = _cleanValue(profile.name);
    form.control('email').value = _cleanValue(profile.email);
    form.control('phone').value = _cleanValue(profile.phone);
    form.control('nationality').value = _cleanValue(profile.nationality);
    form.control('gender').value = _cleanValue(profile.gender);
    form.control('jobTitle').value = _cleanValue(profile.jobTitle);
    form.control('location').value = _cleanValue(profile.location);
    form.control('company').value = _cleanValue(profile.company);
    form.control('education').value = _cleanValue(profile.education);
    form.control('linkedin').value = _cleanValue(profile.linkedin);

    print('[EDIT_PROFILE] Form updated. Current values: ${form.value}');
  }
}
