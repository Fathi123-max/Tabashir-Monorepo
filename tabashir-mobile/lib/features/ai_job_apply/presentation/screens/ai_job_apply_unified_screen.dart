import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/core/services/ai_job_apply_config_service.dart';
import 'package:tabashir/features/ai_job_apply/data/models/location_preference_model.dart';
import 'package:tabashir/features/ai_job_apply/data/models/personal_details_model.dart';
import 'package:tabashir/features/ai_job_apply/data/models/target_role_model.dart';
import 'package:tabashir/features/profile/presentation/cubit/profile_cubit.dart';

import 'package:tabashir/features/ai_job_apply/presentation/cubit/ai_job_apply_cubit.dart';
import 'package:tabashir/features/ai_job_apply/presentation/cubit/ai_job_apply_state.dart';
import 'package:tabashir/features/ai_job_apply/presentation/screens/ai_job_apply_results_screen.dart';
import 'package:tabashir/features/ai_job_apply/presentation/widgets/ai_location_suggestion.dart';
import 'package:tabashir/features/ai_job_apply/presentation/widgets/ai_recommendation_card.dart';
import 'package:tabashir/features/ai_job_apply/presentation/widgets/create_resume_bottom_sheet.dart';
import 'package:tabashir/features/ai_job_apply/presentation/widgets/gender_chip.dart';
import 'package:tabashir/features/ai_job_apply/presentation/widgets/location_chip.dart';
import 'package:tabashir/features/ai_job_apply/presentation/widgets/resume_selection_card.dart';
import 'package:tabashir/features/ai_job_apply/presentation/widgets/role_chip.dart';
import 'package:tabashir/features/ai_job_apply/presentation/widgets/visa_toggle.dart';

/// Unified AI Job Apply screen

// Predefined choices for better UX
// Configuration is now in AiJobApplyConfigService
// See: lib/core/services/ai_job_apply_config_service.dart

/// Combines all 5 steps: Resume Selection, Target Roles, Location Preferences, Personal Details, Review
class AiJobApplyUnifiedScreen extends StatefulWidget {
  /// Creates the unified AI job apply screen
  const AiJobApplyUnifiedScreen({super.key});

  @override
  State<AiJobApplyUnifiedScreen> createState() =>
      _AiJobApplyUnifiedScreenState();
}

class _AiJobApplyUnifiedScreenState extends State<AiJobApplyUnifiedScreen> {
  /// Current step index (0-4)
  int _currentStep = 0;
  late final AiJobApplyCubit _cubit;
  late final TextEditingController _customRoleController;
  late final ProfileCubit _profileCubit;

  @override
  void initState() {
    super.initState();
    // Initialize cubit from DI
    _cubit = getIt<AiJobApplyCubit>();
    _profileCubit = getIt<ProfileCubit>();
    // Initialize controller
    _customRoleController = TextEditingController();
    // Load initial data asynchronously
    _loadInitialData();
  }

  Future<void> _loadInitialData() async {
    await _cubit.loadResumes();
    await _cubit.loadAvailableRoles();
    await _cubit.loadAvailableLocations();
  }

  @override
  void dispose() {
    _cubit.close();
    _customRoleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => BlocProvider.value(
    value: _cubit,
    child: Scaffold(
      body: BlocListener<AiJobApplyCubit, AiJobApplyState>(
        listener: (context, state) {
          if (state.submissionResult != null) {
            Navigator.of(context).push(
              MaterialPageRoute<void>(
                builder: (context) => AiJobApplyResultsScreen(
                  response: state.submissionResult!,
                ),
              ),
            );
          } else if (state.submissionError.isNotEmpty) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.submissionError),
                backgroundColor: Colors.red,
              ),
            );
          }
        },
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppTheme.blue900, // #042052
                AppTheme.primaryColor, // #0D57E1
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              children: [
                // Main Content
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: 16.w,
                      vertical: 24.h,
                    ),
                    child: IndexedStack(
                      index: _currentStep,
                      children: [
                        // Step 0: Resume Selection
                        _buildResumeStep(),

                        // Step 1: Target Roles
                        _buildTargetRolesStep(),

                        // Step 2: Location Preferences
                        _buildLocationStep(),

                        // Step 3: Personal Details
                        _buildPersonalDetailsStep(),

                        // Step 4: Review
                        _buildReviewStep(),
                      ],
                    ),
                  ),
                ),

                // Bottom Navigation Buttons
                _buildBottomButtons(),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  Widget _buildResumeStep() => BlocBuilder<AiJobApplyCubit, AiJobApplyState>(
    builder: (context, state) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Title section
        _buildTitleSection(
          'Which resume should I use?'.tr(),
          'You can apply to multiple jobs with one profile.'.tr(),
        ),

        SizedBox(height: 24.h),

        // Resume list - Make it scrollable
        Expanded(
          child: state.isLoading
              ? _buildLoadingState(context)
              : SingleChildScrollView(
                  child: Column(
                    children: [
                      // Resume cards
                      ...state.resumes
                          .map(
                            (resume) => Padding(
                              padding: EdgeInsets.only(bottom: 12.h),
                              child: ResumeSelectionCard(
                                resume: resume,
                                isSelected: state.selectedResumeId == resume.id,
                                onTap: () => context
                                    .read<AiJobApplyCubit>()
                                    .selectResume(
                                      resume.id,
                                    ),
                              ),
                            ),
                          )
                          .toList(),

                      SizedBox(height: 16.h),

                      // Create new resume button
                      _buildCreateNewButton(context),

                      SizedBox(height: 16.h),

                      // AI recommendation
                      if (state.resumes.isNotEmpty)
                        AIRecommendationCard(
                          resumeTitle: state.resumes
                              .firstWhere(
                                (r) => r.isRecommended,
                                orElse: () => state.resumes.first,
                              )
                              .title,
                          matchPercentage: state.resumes
                              .firstWhere(
                                (r) => r.isRecommended,
                                orElse: () => state.resumes.first,
                              )
                              .matchPercentage,
                        ),
                    ],
                  ),
                ),
        ),
      ],
    ),
  );

  Widget
  _buildTargetRolesStep() => BlocBuilder<AiJobApplyCubit, AiJobApplyState>(
    builder: (context, state) => SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header
          _buildStepHeader(
            'What roles are you targeting?'.tr(),
          ),
          SizedBox(height: 16.h),

          // Recommendation Card
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppTheme.white.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: AppTheme.white.withValues(alpha: 0.2),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(
                      Icons.lightbulb_outline,
                      color: AppTheme.white,
                      size: 20.w,
                    ),
                    SizedBox(width: 8.w),
                    Text(
                      'Recommendation',
                      style: TextStyle(
                        color: AppTheme.white,
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 8.h),
                Text(
                  'Select 3-5 roles that best match your skills and experience. This helps us find the most relevant job opportunities for you.',
                  style: TextStyle(
                    color: AppTheme.white.withValues(alpha: 0.8),
                    fontSize: 12.sp,
                    height: 1.4,
                  ),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.h),

          // Quick Selection - Popular Roles
          Container(
            padding: EdgeInsets.all(16.w),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(
                color: AppTheme.primaryColor.withValues(alpha: 0.3),
              ),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Quick Select Popular Roles',
                  style: TextStyle(
                    color: AppTheme.white,
                    fontSize: 14.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                SizedBox(height: 12.h),
                Wrap(
                  spacing: 8.w,
                  runSpacing: 8.h,
                  children: AiJobApplyConfigService.popularRoles.take(AiJobApplyConfigService.maxRolesToShow).map((role) {
                    final isSelected = state.selectedRoles.any(
                      (r) => r.title == role,
                    );
                    return GestureDetector(
                      onTap: () {
                        final existingRole = state.availableRoles.firstWhere(
                          (r) => r.title == role,
                          orElse: () => TargetRoleModel(
                            id: role.toLowerCase().replaceAll(' ', '_'),
                            title: role,
                            isCustom: true,
                          ),
                        );
                        context.read<AiJobApplyCubit>().toggleRole(
                          existingRole,
                        );
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: 12.w,
                          vertical: 6.h,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? AppTheme.white
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(20.r),
                          border: Border.all(
                            color: AppTheme.white,
                            width: 1,
                          ),
                        ),
                        child: Text(
                          role,
                          style: TextStyle(
                            color: isSelected
                                ? AppTheme.primaryColor
                                : AppTheme.white,
                            fontSize: 12.sp,
                            fontWeight: isSelected
                                ? FontWeight.w600
                                : FontWeight.normal,
                          ),
                        ),
                      ),
                    );
                  }).toList(),
                ),
              ],
            ),
          ),

          SizedBox(height: 24.h),

          // Role Chips
          Wrap(
            spacing: 12.w,
            runSpacing: 12.h,
            children: state.availableRoles.map((role) {
              final isSelected = state.selectedRoles.any(
                (r) => r.id == role.id,
              );
              final showRemove = isSelected && role.isCustom;

              return RoleChip(
                role: role,
                isSelected: isSelected,
                onTap: () => context.read<AiJobApplyCubit>().toggleRole(role),
                onRemove: showRemove
                    ? () => context.read<AiJobApplyCubit>().removeRole(
                        role.id,
                      )
                    : null,
              );
            }).toList(),
          ),

          SizedBox(height: 16.h),

          // Custom Role Input
          _buildCustomRoleInput(context, state),

          SizedBox(height: 16.h),
        ],
      ),
    ),
  );

  Widget _buildLocationStep() => BlocBuilder<AiJobApplyCubit, AiJobApplyState>(
    builder: (context, state) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // Header
        _buildStepHeader(
          'Where would you like to work?'.tr(),
        ),

        SizedBox(height: 16.h),

        // Recommendation Card
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppTheme.white.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: AppTheme.white.withValues(alpha: 0.2),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.location_on_outlined,
                    color: AppTheme.white,
                    size: 20.w,
                  ),
                  SizedBox(width: 8.w),
                  Text(
                    'Location Tips',
                    style: TextStyle(
                      color: AppTheme.white,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              SizedBox(height: 8.h),
              Text(
                'Choose your preferred work locations. Consider commute time, work-life balance, and job market opportunities in each area.',
                style: TextStyle(
                  color: AppTheme.white.withValues(alpha: 0.8),
                  fontSize: 12.sp,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),

        SizedBox(height: 24.h),

        // Quick Selection - Popular Locations
        Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: AppTheme.primaryColor.withValues(alpha: 0.3),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Quick Select Popular Locations',
                style: TextStyle(
                  color: AppTheme.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12.h),
              Wrap(
                spacing: 8.w,
                runSpacing: 8.h,
                children: AiJobApplyConfigService.popularLocations.take(AiJobApplyConfigService.maxLocationsToShow).map((
                  location,
                ) {
                  final isSelected = state.selectedLocations.any(
                    (l) => l.name == location,
                  );
                  return GestureDetector(
                    onTap: () {
                      final existingLocation = state.availableLocations
                          .firstWhere(
                            (l) => l.name == location,
                            orElse: () => LocationPreferenceModel(
                              id: location.toLowerCase().replaceAll(' ', '_'),
                              name: location,
                              isCustom: true,
                            ),
                          );
                      context.read<AiJobApplyCubit>().toggleLocation(
                        existingLocation,
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                        horizontal: 12.w,
                        vertical: 6.h,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? AppTheme.white : Colors.transparent,
                        borderRadius: BorderRadius.circular(20.r),
                        border: Border.all(
                          color: AppTheme.white,
                          width: 1,
                        ),
                      ),
                      child: Text(
                        location,
                        style: TextStyle(
                          color: isSelected
                              ? AppTheme.primaryColor
                              : AppTheme.white,
                          fontSize: 12.sp,
                          fontWeight: isSelected
                              ? FontWeight.w600
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ],
          ),
        ),

        SizedBox(height: 24.h),

        // Location Chips
        Wrap(
          spacing: 12.w,
          runSpacing: 12.h,
          children: state.availableLocations.map((location) {
            final isSelected = state.selectedLocations.any(
              (l) => l.id == location.id,
            );

            return LocationChip(
              location: location,
              isSelected: isSelected,
              onTap: () =>
                  context.read<AiJobApplyCubit>().toggleLocation(location),
            );
          }).toList(),
        ),

        SizedBox(height: 16.h),

        // Add Location Dropdown
        SizedBox(
          width: double.infinity,
          child: DropdownButtonFormField<String>(
            initialValue: state.dropdownSelection.isEmpty
                ? null
                : state.dropdownSelection,
            decoration: InputDecoration(
              hintText: 'Add another city…'.tr(),
              hintStyle: TextStyle(
                color: AppTheme.white.withValues(alpha: 0.6),
                fontSize: 16.sp,
              ),
              filled: true,
              fillColor: AppTheme.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide.none,
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
            ),
            style: TextStyle(
              color: AppTheme.zinc900,
              fontSize: 16.sp,
              fontWeight: FontWeight.normal,
            ),
            icon: Icon(
              Icons.keyboard_arrow_down,
              color: AppTheme.zinc900,
              size: 24.sp,
            ),
            items: [
              DropdownMenuItem<String>(
                value: '',
                enabled: false,
                child: Text('Add another city…'.tr()),
              ),
              ...state.availableLocations
                  .where(
                    (l) => !state.selectedLocations.any((s) => s.id == l.id),
                  )
                  .map(
                    (location) => DropdownMenuItem<String>(
                      value: location.id,
                      child: Text(location.name),
                    ),
                  ),
            ],
            onChanged: (value) {
              if (value != null && value.isNotEmpty) {
                context.read<AiJobApplyCubit>().addLocationFromDropdown(
                  value,
                );
              }
            },
          ),
        ),

        SizedBox(height: 16.h),

        // AI Suggestion
        if (state.aiSuggestionLocation != null) ...[
          GestureDetector(
            onTap: () => context
                .read<AiJobApplyCubit>()
                .addLocationFromDropdown(state.aiSuggestionLocation!.id),
            child: AILocationSuggestion(
              suggestion: state.aiSuggestionLocation!,
              onTap: () =>
                  context.read<AiJobApplyCubit>().addLocationFromDropdown(
                    state.aiSuggestionLocation!.id,
                  ),
            ),
          ),
        ],
      ],
    ),
  );

  Widget _buildPersonalDetailsStep() =>
      BlocBuilder<AiJobApplyCubit, AiJobApplyState>(
        builder: (context, state) => SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header
              _buildStepHeader(
                'Quick personal info'.tr(),
              ),

              SizedBox(height: 32.h),

              // Nationality Dropdown
              _buildNationalityDropdown(context, state),

              SizedBox(height: 24.h),

              // Gender Selection
              _buildGenderSelection(context, state),

              SizedBox(height: 24.h),

              // Visa Sponsorship Toggle
              _buildVisaToggle(context, state),

              SizedBox(height: 32.h),

              // Privacy Notice
              _buildPrivacyNotice(context),
            ],
          ),
        ),
      );

  Widget _buildReviewStep() => BlocBuilder<AiJobApplyCubit, AiJobApplyState>(
    builder: (context, state) => SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header Label
          _buildHeaderLabel(context),

          SizedBox(height: 16.h),

          // Header Title
          _buildStepHeader(
            'Ready to apply?'.tr(),
            subtitle: 'Review your application details before submitting.'.tr(),
          ),

          SizedBox(height: 32.h),

          // Summary Card
          _buildSummaryCard(context, state),

          SizedBox(height: 16.h),

          // AI Confidence
          _buildAIConfidence(context, state),

          SizedBox(height: 16.h),

          // Warning Notice
          _buildWarningNotice(context, state),
        ],
      ),
    ),
  );

  // Shared UI builders
  Widget _buildTitleSection(String title, String subtitle) => Column(
    children: [
      Text(
        'AI Job Apply'.tr(),
        style: TextStyle(
          color: AppTheme.white.withValues(alpha: 0.9),
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.5,
          height: 1.2,
        ),
      ),
      SizedBox(height: 16.h),
      Center(
        child: Text(
          title,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppTheme.white,
            fontSize: 32.sp,
            fontWeight: FontWeight.bold,
            letterSpacing: -0.5,
            height: 1.2,
          ),
        ),
      ),
      SizedBox(height: 12.h),
      Center(
        child: Text(
          subtitle,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: AppTheme.white.withValues(alpha: 0.85),
            fontSize: 16.sp,
            fontWeight: FontWeight.normal,
            height: 1.5,
          ),
        ),
      ),
    ],
  );

  Widget _buildStepHeader(
    String title, {
    String? subtitle,
  }) => Center(
    child: Column(
      children: [
        if (subtitle != null) ...[
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.white,
              fontSize: 32.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
              height: 1.2,
            ),
          ),
          SizedBox(height: 12.h),
          Text(
            subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.white.withValues(alpha: 0.85),
              fontSize: 16.sp,
              fontWeight: FontWeight.normal,
              height: 1.5,
            ),
          ),
        ] else ...[
          Text(
            title,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: AppTheme.white,
              fontSize: 32.sp,
              fontWeight: FontWeight.bold,
              letterSpacing: -0.5,
              height: 1.2,
            ),
          ),
        ],
      ],
    ),
  );

  Widget _buildLoadingState(BuildContext context) => Center(
    child: Padding(
      padding: EdgeInsets.symmetric(vertical: 40.h),
      child: CircularProgressIndicator(
        color: AppTheme.primaryColor,
      ),
    ),
  );

  Widget _buildCreateNewButton(BuildContext context) => InkWell(
    onTap: () => CreateResumeBottomSheet.show(context),
    borderRadius: BorderRadius.circular(12.r),
    child: Container(
      decoration: BoxDecoration(
        color: AppTheme.white,
        borderRadius: BorderRadius.circular(12.r),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.1),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          vertical: 16.h,
          horizontal: 16.w,
        ),
        child: Row(
          children: [
            Container(
              width: 40.w,
              height: 40.w,
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withValues(alpha: 0.1),
                borderRadius: BorderRadius.circular(8.r),
              ),
              child: Icon(
                Icons.add_circle,
                color: AppTheme.primaryColor,
                size: 24.sp,
              ),
            ),
            SizedBox(width: 16.w),
            Expanded(
              child: Text(
                'Create New with AI'.tr(),
                style: TextStyle(
                  color: AppTheme.primaryColor,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      ),
    ),
  );

  Widget _buildCustomRoleInput(
    BuildContext context,
    AiJobApplyState state,
  ) {
    // Update controller text when state changes
    if (_customRoleController.text != state.customRoleTitle) {
      _customRoleController.text = state.customRoleTitle;
    }

    return SizedBox(
      width: double.infinity,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Add Custom Title'.tr(),
            style: TextStyle(
              color: AppTheme.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.w500,
              height: 1.2,
            ),
          ),
          SizedBox(height: 8.h),
          TextField(
            controller: _customRoleController,
            style: TextStyle(
              color: AppTheme.white,
              fontSize: 16.sp,
              fontWeight: FontWeight.normal,
            ),
            decoration: InputDecoration(
              hintText: 'e.g. Backend Engineer'.tr(),
              hintStyle: TextStyle(
                color: AppTheme.white.withValues(alpha: 0.6),
                fontSize: 16.sp,
                fontWeight: FontWeight.normal,
              ),
              filled: true,
              fillColor: AppTheme.white.withValues(alpha: 0.1),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(
                  color: AppTheme.white.withValues(alpha: 0.3),
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(
                  color: AppTheme.white.withValues(alpha: 0.3),
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(12.r),
                borderSide: BorderSide(
                  color: AppTheme.white.withValues(alpha: 0.5),
                ),
              ),
              contentPadding: EdgeInsets.symmetric(
                horizontal: 16.w,
                vertical: 16.h,
              ),
            ),
            onChanged: (value) =>
                context.read<AiJobApplyCubit>().updateCustomRoleTitle(value),
            onSubmitted: (value) {
              if (value.trim().isNotEmpty) {
                context.read<AiJobApplyCubit>().addCustomRole(value);
                // Clear the field after adding
                _customRoleController.clear();
              }
            },
          ),
        ],
      ),
    );
  }

  Widget _buildNationalityDropdown(
    BuildContext context,
    AiJobApplyState state,
  ) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Nationality'.tr(),
        style: TextStyle(
          color: AppTheme.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          height: 1.2,
        ),
      ),
      SizedBox(height: 8.h),
      SizedBox(
        width: double.infinity,
        child: DropdownButtonFormField<String>(
          value: state.nationality != null &&
                  AiJobApplyConfigService.nationalities.any(
                    (n) =>
                        n.toLowerCase().replaceAll(' ', '_') == state.nationality,
                  )
              ? state.nationality
              : null,
          decoration: InputDecoration(
            filled: true,
            fillColor: AppTheme.white,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide.none,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: 16.w,
              vertical: 16.h,
            ),
          ),
          style: TextStyle(
            color: AppTheme.zinc900,
            fontSize: 16.sp,
            fontWeight: FontWeight.normal,
          ),
          icon: Icon(
            Icons.keyboard_arrow_down,
            color: AppTheme.zinc900,
            size: 24.sp,
          ),
          items: AiJobApplyConfigService.nationalities.map((nationality) {
            final value = nationality.toLowerCase().replaceAll(' ', '_');
            return DropdownMenuItem<String>(
              value: value,
              child: Text(nationality.tr()),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              context.read<AiJobApplyCubit>().updateNationality(value);
            }
          },
        ),
      ),
    ],
  );

  Widget _buildGenderSelection(
    BuildContext context,
    AiJobApplyState state,
  ) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Gender (Optional)'.tr(),
        style: TextStyle(
          color: AppTheme.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          height: 1.2,
        ),
      ),
      SizedBox(height: 12.h),
      Row(
        children: [
          Expanded(
            child: GenderChip(
              gender: Gender.male,
              isSelected: state.gender == Gender.male,
              onTap: () => context.read<AiJobApplyCubit>().updateGender(
                Gender.male,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: GenderChip(
              gender: Gender.female,
              isSelected: state.gender == Gender.female,
              onTap: () => context.read<AiJobApplyCubit>().updateGender(
                Gender.female,
              ),
            ),
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: GenderChip(
              gender: Gender.preferNotToSay,
              isSelected: state.gender == Gender.preferNotToSay,
              onTap: () => context.read<AiJobApplyCubit>().updateGender(
                Gender.preferNotToSay,
              ),
            ),
          ),
        ],
      ),
    ],
  );

  Widget _buildVisaToggle(
    BuildContext context,
    AiJobApplyState state,
  ) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'I require visa sponsorship'.tr(),
        style: TextStyle(
          color: AppTheme.white,
          fontSize: 16.sp,
          fontWeight: FontWeight.normal,
          height: 1.4,
        ),
      ),
      SizedBox(height: 12.h),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              'Toggle if you need visa sponsorship for this position'.tr(),
              style: TextStyle(
                color: AppTheme.white.withValues(alpha: 0.7),
                fontSize: 14.sp,
                fontWeight: FontWeight.normal,
                height: 1.4,
              ),
            ),
          ),
          SizedBox(width: 16.w),
          VisaToggle(
            value: state.requiresVisaSponsorship,
            onChanged: (value) =>
                context.read<AiJobApplyCubit>().toggleVisaSponsorship(),
          ),
        ],
      ),
    ],
  );

  Widget _buildPrivacyNotice(BuildContext context) => Container(
    padding: EdgeInsets.all(16.w),
    decoration: BoxDecoration(
      color: AppTheme.white.withValues(alpha: 0.1),
      borderRadius: BorderRadius.circular(12.r),
      border: Border.all(
        color: AppTheme.white.withValues(alpha: 0.2),
      ),
    ),
    child: Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(
              Icons.shield_outlined,
              color: AppTheme.white,
              size: 20.sp,
            ),
            SizedBox(width: 12.w),
            Expanded(
              child: Text(
                'This info is shared only with employers you apply to.'.tr(),
                style: TextStyle(
                  color: AppTheme.white,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.w500,
                  height: 1.5,
                ),
              ),
            ),
          ],
        ),
        SizedBox(height: 16.h),
        Row(
          children: [
            Icon(
              Icons.lock_outline,
              color: AppTheme.yellow500,
              size: 16.sp,
            ),
            SizedBox(width: 8.w),
            Expanded(
              child: Text(
                'Your data is secure — I never store sensitive info.'.tr(),
                style: TextStyle(
                  color: AppTheme.white.withValues(alpha: 0.8),
                  fontSize: 13.sp,
                  fontWeight: FontWeight.normal,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ),
      ],
    ),
  );

  Widget _buildHeaderLabel(BuildContext context) => Column(
    children: [
      Text(
        'AI Job Apply'.tr(),
        style: TextStyle(
          color: AppTheme.white.withValues(alpha: 0.9),
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          letterSpacing: 1.5,
          height: 1.2,
        ),
      ),
      SizedBox(height: 16.h),
    ],
  );

  Widget _buildSummaryCard(
    BuildContext context,
    AiJobApplyState state,
  ) => Container(
    padding: EdgeInsets.all(16.w),
    decoration: BoxDecoration(
      color: AppTheme.white,
      borderRadius: BorderRadius.circular(12.r),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.1),
          blurRadius: 10,
          offset: const Offset(0, 4),
        ),
      ],
    ),
    child: Column(
      children: [
        // Resumes
        _buildSummaryItem(
          icon: Icons.description_outlined,
          iconColor: AppTheme.green500,
          label: 'Resumes'.tr(),
          value:
              '${state.resumes.where((r) => r.id == state.selectedResumeId).length} selected'
                  .tr(),
        ),

        SizedBox(height: 16.h),

        // Positions
        _buildSummaryItem(
          icon: Icons.work_outline,
          iconColor: AppTheme.green500,
          label: 'Positions'.tr(),
          value: state.selectedRoles.isNotEmpty
              ? state.selectedRoles.map((r) => r.title).join(', '.tr())
              : 'Not specified'.tr(),
        ),

        SizedBox(height: 16.h),

        // Cities
        _buildSummaryItem(
          icon: Icons.location_on_outlined,
          iconColor: AppTheme.green500,
          label: 'Cities'.tr(),
          value: state.selectedLocations.isNotEmpty
              ? state.selectedLocations.map((l) => l.name).join(', '.tr())
              : 'Not specified'.tr(),
        ),

        SizedBox(height: 16.h),

        Divider(
          color: AppTheme.gray200,
          height: 1.h,
        ),

        SizedBox(height: 16.h),

        // Jobs Found
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Jobs Found'.tr(),
              style: TextStyle(
                color: AppTheme.zinc900,
                fontSize: 16.sp,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              '${state.selectedRoles.length * state.selectedLocations.length} matching roles'
                  .tr(),
              style: TextStyle(
                color: AppTheme.primaryColor,
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ],
    ),
  );

  Widget _buildSummaryItem({
    required IconData icon,
    required Color iconColor,
    required String label,
    required String value,
  }) => Row(
    children: [
      Container(
        width: 40.w,
        height: 40.w,
        decoration: BoxDecoration(
          color: iconColor.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(8.r),
        ),
        child: Icon(
          icon,
          color: iconColor,
          size: 20.sp,
        ),
      ),
      SizedBox(width: 16.w),
      Expanded(
        child: Text(
          label,
          style: TextStyle(
            color: AppTheme.zinc900,
            fontSize: 16.sp,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
      Expanded(
        child: Text(
          value,
          style: TextStyle(
            color: AppTheme.zinc500,
            fontSize: 14.sp,
            fontWeight: FontWeight.normal,
          ),
        ),
      ),
    ],
  );

  Widget _buildAIConfidence(
    BuildContext context,
    AiJobApplyState state,
  ) {
    final confidence = AiJobApplyConfigService.defaultAiConfidence;

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withValues(alpha: 0.2),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Row(
        children: [
          Icon(
            Icons.auto_awesome,
            color: AppTheme.primaryColor,
            size: 32.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text.rich(
              TextSpan(
                style: TextStyle(
                  color: AppTheme.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.normal,
                ),
                children: [
                  TextSpan(text: "I'm ".tr()),
                  TextSpan(
                    text: '$confidence% confident'.tr(),
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  TextSpan(text: ' these roles fit your profile.'.tr()),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWarningNotice(
    BuildContext context,
    AiJobApplyState state,
  ) {
    final jobsCount =
        state.selectedRoles.length * state.selectedLocations.length;
    final estimatedTime = (jobsCount * 2.2).round(); // ~2.2 seconds per job

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        color: AppTheme.amber500.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppTheme.amber500.withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.warning_amber,
            color: AppTheme.amber500,
            size: 20.sp,
          ),
          SizedBox(width: 12.w),
          Expanded(
            child: Text(
              "Applying to $jobsCount jobs may take $estimatedTime seconds. You'll get a report after."
                  .tr(),
              style: TextStyle(
                color: AppTheme.white.withValues(alpha: 0.8),
                fontSize: 14.sp,
                fontWeight: FontWeight.normal,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomButtons() => Container(
    padding: EdgeInsets.all(16.w),
    child: SafeArea(
      top: false,
      child: Column(
        children: [
          // Main action button
          SizedBox(
            width: double.infinity,
            height: 56.h,
            child: ElevatedButton(
              onPressed: () async {
                await _handleContinue();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppTheme.white,
                foregroundColor: AppTheme.primaryColor,
                elevation: 0,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.r),
                ),
              ),
              child: BlocBuilder<AiJobApplyCubit, AiJobApplyState>(
                builder: (context, state) {
                  if (state.isSubmittingApplication) {
                    return SizedBox(
                      width: 24.w,
                      height: 24.w,
                      child: CircularProgressIndicator(
                        color: AppTheme.primaryColor,
                        strokeWidth: 2.w,
                      ),
                    );
                  }
                  return Text(
                    _getButtonText(),
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 0.5,
                    ),
                  );
                },
              ),
            ),
          ),

          SizedBox(height: 8.h),

          // Navigation row
          Row(
            children: [
              // Previous button
              Expanded(
                flex: _currentStep == 0 ? 0 : 1,
                child: _currentStep == 0
                    ? const SizedBox.shrink()
                    : TextButton(
                        onPressed: _currentStep > 0
                            ? () {
                                setState(() {
                                  _currentStep--;
                                });
                              }
                            : null,
                        style: TextButton.styleFrom(
                          minimumSize: Size(double.infinity, 48.h),
                        ),
                        child: Text(
                          'Back'.tr(),
                          style: TextStyle(
                            color: AppTheme.white.withValues(alpha: 0.7),
                            fontSize: 14.sp,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  String _getButtonText() {
    switch (_currentStep) {
      case 0:
        return 'Continue'.tr();
      case 1:
        return 'Continue'.tr();
      case 2:
        return 'Continue'.tr();
      case 3:
        return 'Review Applications'.tr();
      case 4:
        return 'Apply Now'.tr();
      default:
        return 'Continue'.tr();
    }
  }

  Future<void> _handleContinue() async {
    switch (_currentStep) {
      case 0: // Resume selection
        await _cubit.continueWithSelectedResume();
      case 1: // Target roles
        // Validate that at least one role is selected
        final state = _cubit.state;
        if (state.selectedRoles.isEmpty &&
            state.customRoleTitle.trim().isEmpty) {
          _showValidationError(
            'Please select at least one target role or add a custom role',
          );
          return;
        }
        await _cubit.continueWithSelectedRoles();
      case 2: // Location preferences
        // Validate that at least one location is selected
        final locationState = _cubit.state;
        if (locationState.selectedLocations.isEmpty) {
          _showValidationError('Please select at least one preferred location');
          return;
        }
        await _cubit.continueWithSelectedLocations();
      case 3: // Personal details
        await _cubit.continueToReview();
      case 4: // Review - submit
        try {
          // Get user email from ProfileCubit
          final profileState = _profileCubit.state;
          final email = profileState.profile?.email ?? '';

          if (email.isNotEmpty) {
            await _cubit.submitApplication(email: email);
          } else {
            // Try to load profile data if not available
            await _profileCubit.loadProfileData();

            // Check again after loading
            final updatedProfileState = _profileCubit.state;
            final updatedEmail = updatedProfileState.profile?.email ?? '';

            if (updatedEmail.isNotEmpty) {
              await _cubit.submitApplication(email: updatedEmail);
            } else {
              if (mounted) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      'Please ensure you are logged in with a valid email address',
                    ),
                    backgroundColor: Colors.red,
                    duration: Duration(seconds: 4),
                  ),
                );
              }
            }
          }
        } catch (e) {
          if (mounted) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text('Authentication error: ${e.toString()}'.tr()),
                backgroundColor: Colors.red,
              ),
            );
          }
        }
        return;
    }

    // Move to next step
    if (mounted && _currentStep < 4) {
      setState(() {
        _currentStep++;
      });
    }
  }

  void _showValidationError(String message) {
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message.tr()),
          backgroundColor: Colors.red,
          duration: const Duration(seconds: 3),
          action: SnackBarAction(
            label: 'OK',
            textColor: Colors.white,
            onPressed: () {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
            },
          ),
        ),
      );
    }
  }
}
