import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/network/models/ai_resume/resume_models.dart';
import '../../../../../core/theme/app_theme.dart';
import '../../cubit/ai_resume_builder_cubit.dart';
import '../../widgets/shared/form_fields.dart';

class PersonalDetailsStep extends StatefulWidget {
  const PersonalDetailsStep({super.key});

  @override
  State<PersonalDetailsStep> createState() => _PersonalDetailsStepState();
}

class _PersonalDetailsStepState extends State<PersonalDetailsStep> {
  late TextEditingController fullNameController;
  late TextEditingController emailController;
  late TextEditingController phoneController;
  late TextEditingController cityController;
  late TextEditingController nationalityController;
  late TextEditingController linkedinController;
  late TextEditingController githubController;

  @override
  void initState() {
    super.initState();
    final details = context.read<AiResumeBuilderCubit>().state.resumeData.personalDetails;
    fullNameController = TextEditingController(text: details?.fullName);
    emailController = TextEditingController(text: details?.email);
    phoneController = TextEditingController(text: details?.phoneNumber);
    cityController = TextEditingController(text: details?.city);
    nationalityController = TextEditingController(text: details?.nationality);
    linkedinController = TextEditingController(text: details?.linkedin);
    githubController = TextEditingController(text: details?.github);
  }

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    phoneController.dispose();
    cityController.dispose();
    nationalityController.dispose();
    linkedinController.dispose();
    githubController.dispose();
    super.dispose();
  }

  void _updateCubit() {
    final cubit = context.read<AiResumeBuilderCubit>();
    final currentDetails = cubit.state.resumeData.personalDetails ?? const PersonalDetails();
    
    cubit.updatePersonalDetails(
      currentDetails.copyWith(
        fullName: fullNameController.text,
        email: emailController.text,
        phoneNumber: phoneController.text,
        city: cityController.text,
        nationality: nationalityController.text,
        linkedin: linkedinController.text.isNotEmpty ? linkedinController.text : null,
        github: githubController.text.isNotEmpty ? githubController.text : null,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AiResumeBuilderCubit, AiResumeBuilderState>(
      builder: (context, state) {
        final details = state.resumeData.personalDetails;

        return SingleChildScrollView(
          padding: EdgeInsets.all(AppTheme.spacingMd.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Personal Details'.tr(),
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: AppTheme.spacingXs.h),
              Text(
                'Tell us about yourself. This information will appear on your resume.'
                    .tr(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: AppTheme.textMutedLight,
                ),
              ),
              SizedBox(height: AppTheme.spacingXl.h),
              Form(
                child: Column(
                  children: [
                    AppTextField(
                      label: 'Full Name *'.tr(),
                      hint: 'Enter your full name'.tr(),
                      controller: fullNameController,
                      onChanged: (_) => _updateCubit(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Full name is required'.tr();
                        }
                        return null;
                      },
                    ),
                    SizedBox(height: AppTheme.spacingMd.h),
                    AppTextField(
                      label: 'Email *'.tr(),
                      hint: 'your.email@example.com'.tr(),
                      controller: emailController,
                      onChanged: (_) => _updateCubit(),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Email is required'.tr();
                        }
                        if (!RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'.tr(),
                        ).hasMatch(value)) {
                          return 'Enter a valid email'.tr();
                        }
                        return null;
                      },
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: AppTheme.spacingMd.h),
                    AppTextField(
                      label: 'Phone Number'.tr(),
                      hint: '+1 (555) 123-4567'.tr(),
                      controller: phoneController,
                      onChanged: (_) => _updateCubit(),
                      keyboardType: TextInputType.phone,
                    ),
                    SizedBox(height: AppTheme.spacingMd.h),
                    AppDropdownField<String>(
                      label: 'Country'.tr(),
                      hint: 'Select your country'.tr(),
                      value: details?.country,
                      items: [
                        DropdownMenuItem(value: 'AE', child: Text('United Arab Emirates'.tr())),
                        DropdownMenuItem(value: 'SA', child: Text('Saudi Arabia'.tr())),
                        DropdownMenuItem(value: 'QA', child: Text('Qatar'.tr())),
                        DropdownMenuItem(value: 'KW', child: Text('Kuwait'.tr())),
                        DropdownMenuItem(value: 'US', child: Text('United States'.tr())),
                        DropdownMenuItem(value: 'UK', child: Text('United Kingdom'.tr())),
                      ],
                      onChanged: (value) {
                        final cubit = context.read<AiResumeBuilderCubit>();
                        final currentDetails = cubit.state.resumeData.personalDetails ?? const PersonalDetails();
                        cubit.updatePersonalDetails(currentDetails.copyWith(country: value));
                      },
                    ),
                    SizedBox(height: AppTheme.spacingMd.h),
                    AppTextField(
                      label: 'City'.tr(),
                      hint: 'Enter your city'.tr(),
                      controller: cityController,
                      onChanged: (_) => _updateCubit(),
                    ),
                    SizedBox(height: AppTheme.spacingMd.h),
                    AppTextField(
                      label: 'Nationality'.tr(),
                      hint: 'Enter your nationality'.tr(),
                      controller: nationalityController,
                      onChanged: (_) => _updateCubit(),
                    ),
                    SizedBox(height: AppTheme.spacingLg.h),
                    _buildSocialLinksSection(context, state),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildSocialLinksSection(
    BuildContext context,
    AiResumeBuilderState state,
  ) {
    final theme = Theme.of(context);
    final socialLinks = state.resumeData.personalDetails?.socialLinks ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Social Links'.tr(),
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            TextButton.icon(
              onPressed: () => _showAddSocialLinkDialog(context, state),
              icon: const Icon(Icons.add, size: 18),
              label: Text('Add Social Link'.tr()),
            ),
          ],
        ),
        SizedBox(height: AppTheme.spacingSm.h),
        if (socialLinks.isEmpty)
          Container(
            padding: EdgeInsets.all(AppTheme.spacingLg.w),
            decoration: BoxDecoration(
              color: theme.brightness == Brightness.light
                  ? const Color(0xFFF1F5F9)
                  : const Color(0xFF1E293B),
              borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
            ),
            child: Column(
              children: [
                Icon(
                  Icons.link_outlined,
                  size: 48.sp,
                  color: theme.iconTheme.color?.withOpacity(0.3),
                ),
                SizedBox(height: AppTheme.spacingSm.h),
                Text(
                  'No social links added yet'.tr(),
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: AppTheme.textMutedLight,
                  ),
                ),
              ],
            ),
          )
        else
          ...socialLinks.asMap().entries.map((entry) {
            final index = entry.key;
            final link = entry.value;
            return Container(
              margin: EdgeInsets.only(bottom: AppTheme.spacingSm.h),
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
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          link.platform ?? '',
                          style: theme.textTheme.labelLarge,
                        ),
                        Text(
                          link.url ?? '',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: AppTheme.textMutedLight,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () => _removeSocialLink(context, index),
                    icon: const Icon(Icons.delete_outline),
                    color: AppTheme.errorColor,
                  ),
                ],
              ),
            );
          }),
      ],
    );
  }

  void _showAddSocialLinkDialog(
    BuildContext context,
    AiResumeBuilderState state,
  ) {
    final formKey = GlobalKey<FormState>();
    final cubit = context.read<AiResumeBuilderCubit>();
    var platform = '';
    var url = '';

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
                Row(
                  children: [
                    Container(
                      padding: EdgeInsets.all(AppTheme.spacingMd.w),
                      decoration: BoxDecoration(
                        color: AppTheme.accentColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(
                          AppTheme.radiusDefault.r,
                        ),
                      ),
                      child: Icon(
                        Icons.link_outlined,
                        color: AppTheme.accentColor,
                        size: 24.sp,
                      ),
                    ),
                    SizedBox(width: AppTheme.spacingMd.w),
                    Expanded(
                      child: Text(
                        'Add Social Link'.tr(),
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: AppTheme.spacingLg.h),
                Form(
                  key: formKey,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      AppDropdownField<String>(
                        label: 'Select Platform *'.tr(),
                        hint: 'Choose platform'.tr(),
                        items: [
                          DropdownMenuItem(value: 'LinkedIn', child: Text('LinkedIn'.tr())),
                          DropdownMenuItem(value: 'GitHub', child: Text('GitHub'.tr())),
                          DropdownMenuItem(value: 'Twitter', child: Text('Twitter'.tr())),
                          DropdownMenuItem(value: 'Portfolio', child: Text('Portfolio'.tr())),
                        ],
                        onChanged: (value) => platform = value ?? '',
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Platform is required'.tr();
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: AppTheme.spacingMd.h),
                      AppTextField(
                        label: 'URL *'.tr(),
                        hint: 'https://linkedin.com/in/yourprofile',
                        onChanged: (value) => url = value,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'URL is required'.tr();
                          }
                          return null;
                        },
                      ),
                    ],
                  ),
                ),
                SizedBox(height: AppTheme.spacingLg.h),
                Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => Navigator.pop(context),
                        child: Text('Cancel'.tr()),
                      ),
                    ),
                    SizedBox(width: AppTheme.spacingMd.w),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            final currentDetails =
                                state.resumeData.personalDetails ??
                                const PersonalDetails();
                            final updatedLinks = [
                              ...currentDetails.socialLinks,
                              SocialLink(platform: platform, url: url),
                            ];
                            cubit.updatePersonalDetails(
                              currentDetails.copyWith(
                                socialLinks: updatedLinks,
                              ),
                            );
                            Navigator.pop(context);
                          }
                        },
                        child: Text('Add Link'.tr()),
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

  void _removeSocialLink(BuildContext context, int index) {
    final cubit = context.read<AiResumeBuilderCubit>();
    final currentDetails = cubit.state.resumeData.personalDetails ?? const PersonalDetails();
    final updatedLinks = [...currentDetails.socialLinks];
    updatedLinks.removeAt(index);
    cubit.updatePersonalDetails(
      currentDetails.copyWith(socialLinks: updatedLinks),
    );
  }
}
