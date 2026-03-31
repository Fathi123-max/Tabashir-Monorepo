import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tabashir/core/constants/countries.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/features/ai_job_apply/data/models/location_preference_model.dart';
import 'package:tabashir/features/ai_job_apply/data/models/personal_details_model.dart';
import 'package:tabashir/features/ai_job_apply/data/models/target_role_model.dart';
import 'package:tabashir/features/ai_job_apply/presentation/widgets/gender_chip.dart';
import 'package:tabashir/features/ai_job_apply/presentation/widgets/location_chip.dart';
import 'package:tabashir/features/ai_job_apply/presentation/widgets/role_chip.dart';
import 'package:tabashir/features/onboarding/presentation/cubit/onboarding_wizard_cubit.dart';
import 'package:tabashir/features/onboarding/presentation/cubit/onboarding_wizard_state.dart';

class OnboardingWizardScreen extends StatefulWidget {
  const OnboardingWizardScreen({super.key});

  @override
  State<OnboardingWizardScreen> createState() => _OnboardingWizardScreenState();
}

class _OnboardingWizardScreenState extends State<OnboardingWizardScreen> {
  late final PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _onStepChanged(int step) {
    _pageController.animateToPage(
      step - 1,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeInOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<OnboardingWizardCubit>(),
      child: BlocListener<OnboardingWizardCubit, OnboardingWizardState>(
        listenWhen: (previous, current) =>
            previous.currentStep != current.currentStep,
        listener: (context, state) {
          _onStepChanged(state.currentStep);

          if (state.submissionResult != null) {
            // Navigate to results or home
            context.go('/');
          }
        },
        child: Scaffold(
          body: Container(
            decoration: BoxDecoration(
              gradient: AppTheme.primaryGradient,
            ),
            child: SafeArea(
              child: Column(
                children: [
                  _buildHeader(context),
                  _buildProgressBar(),
                  Expanded(
                    child:
                        BlocBuilder<
                          OnboardingWizardCubit,
                          OnboardingWizardState
                        >(
                          builder: (context, state) {
                            return PageView(
                              controller: _pageController,
                              physics: const NeverScrollableScrollPhysics(),
                              children: [
                                _ResumeUploadStep(),
                                _TargetRolesStep(),
                                _LocationStep(),
                                _PersonalDetailsStep(),
                                _ProcessingStep(),
                              ],
                            );
                          },
                        ),
                  ),
                  _buildFooter(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(20.w),
      child: Row(
        children: [
          BlocBuilder<OnboardingWizardCubit, OnboardingWizardState>(
            builder: (context, state) {
              if (state.currentStep > 1 && state.currentStep < 5) {
                return IconButton(
                  icon: const Icon(Icons.arrow_back, color: Colors.white),
                  onPressed: () =>
                      context.read<OnboardingWizardCubit>().previousStep(),
                );
              }
              return const SizedBox.shrink();
            },
          ),
          const Spacer(),
          Text(
            'Onboarding',
            style: TextStyle(
              color: Colors.white,
              fontSize: 20.sp,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          const SizedBox(width: 48), // To balance the back button
        ],
      ),
    );
  }

  Widget _buildProgressBar() {
    return BlocBuilder<OnboardingWizardCubit, OnboardingWizardState>(
      builder: (context, state) {
        return Container(
          height: 4.h,
          margin: EdgeInsets.symmetric(horizontal: 20.w),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.2),
            borderRadius: BorderRadius.circular(2.r),
          ),
          child: Row(
            children: [
              Expanded(
                flex: state.currentStep,
                child: Container(
                  decoration: BoxDecoration(
                    color: AppTheme.accentColor,
                    borderRadius: BorderRadius.circular(2.r),
                  ),
                ),
              ),
              Expanded(
                flex: 5 - state.currentStep,
                child: const SizedBox.shrink(),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildFooter() {
    return BlocBuilder<OnboardingWizardCubit, OnboardingWizardState>(
      builder: (context, state) {
        if (state.currentStep == 5) return const SizedBox.shrink();

        return Padding(
          padding: EdgeInsets.all(20.w),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              if (state.currentStep > 1)
                TextButton(
                  onPressed: () =>
                      context.read<OnboardingWizardCubit>().previousStep(),
                  child: Text(
                    'Back',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 16.sp,
                    ),
                  ),
                )
              else
                const SizedBox.shrink(),

              if (state.currentStep < 4 && state.currentStep > 1)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.accentColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: 32.w,
                      vertical: 12.h,
                    ),
                  ),
                  onPressed: () =>
                      context.read<OnboardingWizardCubit>().nextStep(),
                  child: Text(
                    'Next',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                )
              else if (state.currentStep == 4)
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.accentColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: 32.w,
                      vertical: 12.h,
                    ),
                  ),
                  onPressed: () =>
                      context.read<OnboardingWizardCubit>().submitOnboarding(),
                  child: Text(
                    'Finish',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
            ],
          ),
        );
      },
    );
  }
}

class _ResumeUploadStep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingWizardCubit, OnboardingWizardState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.cloud_upload_outlined,
                size: 80.sp,
                color: Colors.white,
              ),
              SizedBox(height: 24.h),
              Text(
                'Upload your Resume',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 12.h),
              Text(
                'We will use AI to suggest the best roles for you',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 16.sp,
                ),
                textAlign: TextAlign.center,
              ),
              SizedBox(height: 48.h),
              if (state.isLoading)
                const CircularProgressIndicator(color: Colors.white)
              else
                ElevatedButton.icon(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppTheme.primaryColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: 24.w,
                      vertical: 16.h,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12.r),
                    ),
                  ),
                  onPressed: () =>
                      context.read<OnboardingWizardCubit>().pickFile(),
                  icon: const Icon(Icons.attach_file),
                  label: Text(
                    state.fileName ?? 'Choose File',
                    style: TextStyle(fontSize: 18.sp),
                  ),
                ),
              if (state.errorMessage != null) ...[
                SizedBox(height: 16.h),
                Text(
                  state.errorMessage!,
                  style: TextStyle(color: Colors.redAccent, fontSize: 14.sp),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}

class _TargetRolesStep extends StatefulWidget {
  @override
  State<_TargetRolesStep> createState() => _TargetRolesStepState();
}

class _TargetRolesStepState extends State<_TargetRolesStep> {
  final TextEditingController _roleController = TextEditingController();

  @override
  void dispose() {
    _roleController.dispose();
    super.dispose();
  }

  void _addRole(BuildContext context) {
    final role = _roleController.text.trim();
    if (role.isNotEmpty) {
      context.read<OnboardingWizardCubit>().addCustomRole(role);
      _roleController.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingWizardCubit, OnboardingWizardState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Target Roles',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Select or add the roles you are interested in',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 24.h),
              Row(
                children: [
                  Expanded(
                    child: SizedBox(
                      height: 48.h,
                      child: TextField(
                        controller: _roleController,
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                        decoration: InputDecoration(
                          hintText: 'e.g. Flutter Developer',
                          hintStyle: TextStyle(
                            color: Colors.white.withOpacity(0.5),
                          ),
                          filled: true,
                          fillColor: Colors.white.withOpacity(0.1),
                          contentPadding: EdgeInsets.symmetric(
                            horizontal: 16.w,
                          ),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(
                              color: Colors.white.withOpacity(0.3),
                            ),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: BorderSide(
                              color: Colors.white.withOpacity(0.3),
                            ),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12.r),
                            borderSide: const BorderSide(color: Colors.white),
                          ),
                        ),
                        onSubmitted: (_) => _addRole(context),
                      ),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  GestureDetector(
                    onTap: () => _addRole(context),
                    child: Container(
                      height: 48.h,
                      width: 48.h,
                      decoration: BoxDecoration(
                        color: AppTheme.accentColor,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: Icon(Icons.add, color: Colors.white, size: 24.sp),
                    ),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              Expanded(
                child: SingleChildScrollView(
                  child: Wrap(
                    spacing: 12.w,
                    runSpacing: 12.h,
                    children: state.suggestedRoles.map((role) {
                      return RoleChip(
                        role: TargetRoleModel(id: role, title: role),
                        isSelected: state.selectedRoles.contains(role),
                        onTap: () => context
                            .read<OnboardingWizardCubit>()
                            .toggleRole(role),
                      );
                    }).toList(),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _LocationStep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingWizardCubit, OnboardingWizardState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Preferred Locations',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 8.h),
              Text(
                'Where would you like to work in the UAE?',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.7),
                  fontSize: 16.sp,
                ),
              ),
              SizedBox(height: 24.h),
              Expanded(
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 3,
                    crossAxisSpacing: 12.w,
                    mainAxisSpacing: 12.h,
                  ),
                  itemCount: OnboardingWizardCubit.uaeCities.length,
                  itemBuilder: (context, index) {
                    final city = OnboardingWizardCubit.uaeCities[index];
                    return LocationChip(
                      location: LocationPreferenceModel(id: city, name: city),
                      isSelected: state.selectedLocations.contains(city),
                      onTap: () => context
                          .read<OnboardingWizardCubit>()
                          .toggleLocation(city),
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _PersonalDetailsStep extends StatelessWidget {
  Future<void> _showNationalityPicker(
    BuildContext context,
    OnboardingWizardState state,
  ) async {
    final result = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) {
        String searchQuery = '';
        return StatefulBuilder(
          builder: (context, setState) {
            final filteredCountries = worldCountries.entries.where((entry) {
              return entry.value.toLowerCase().contains(
                searchQuery.toLowerCase(),
              );
            }).toList();

            return Container(
              height: MediaQuery.of(context).size.height * 0.75,
              decoration: BoxDecoration(
                color: AppTheme.primaryFromColor,
                borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
              ),
              child: Column(
                children: [
                  Container(
                    padding: EdgeInsets.all(20.w),
                    child: Text(
                      'Select Nationality',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20.sp,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: 20.w),
                    child: TextField(
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        hintText: 'Search...',
                        hintStyle: TextStyle(
                          color: Colors.white.withOpacity(0.5),
                        ),
                        prefixIcon: const Icon(
                          Icons.search,
                          color: Colors.white,
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.1),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12.r),
                          borderSide: BorderSide.none,
                        ),
                      ),
                      onChanged: (value) => setState(() => searchQuery = value),
                    ),
                  ),
                  SizedBox(height: 16.h),
                  Expanded(
                    child: ListView.builder(
                      itemCount: filteredCountries.length,
                      itemBuilder: (context, index) {
                        final country = filteredCountries[index];
                        return ListTile(
                          title: Text(
                            country.value,
                            style: const TextStyle(color: Colors.white),
                          ),
                          onTap: () => Navigator.pop(context, country.key),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );

    if (result != null && context.mounted) {
      context.read<OnboardingWizardCubit>().updatePersonalDetails(
        nationality: result,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingWizardCubit, OnboardingWizardState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Personal Details',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(height: 24.h),
              Text(
                'Nationality',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12.h),
              GestureDetector(
                onTap: () => _showNationalityPicker(context, state),
                child: Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: 16.w,
                    vertical: 16.h,
                  ),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12.r),
                    border: Border.all(color: Colors.white.withOpacity(0.3)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        worldCountries[state.nationality] ??
                            'United Arab Emirates',
                        style: TextStyle(color: Colors.white, fontSize: 16.sp),
                      ),
                      const Icon(Icons.arrow_drop_down, color: Colors.white),
                    ],
                  ),
                ),
              ),
              SizedBox(height: 32.h),
              Text(
                'Gender',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
              SizedBox(height: 12.h),
              Row(
                children: [
                  Expanded(
                    child: GenderChip(
                      gender: Gender.male,
                      isSelected: state.gender == 'male',
                      onTap: () => context
                          .read<OnboardingWizardCubit>()
                          .updatePersonalDetails(gender: 'male'),
                    ),
                  ),
                  SizedBox(width: 12.w),
                  Expanded(
                    child: GenderChip(
                      gender: Gender.female,
                      isSelected: state.gender == 'female',
                      onTap: () => context
                          .read<OnboardingWizardCubit>()
                          .updatePersonalDetails(gender: 'female'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}

class _ProcessingStep extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OnboardingWizardCubit, OnboardingWizardState>(
      builder: (context, state) {
        return Padding(
          padding: EdgeInsets.all(24.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (state.isProcessing) ...[
                const CircularProgressIndicator(color: Colors.white),
                SizedBox(height: 24.h),
                Text(
                  'Processing your application...',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Our AI is analyzing your profile to find the best matches',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 16.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
              ] else if (state.submissionResult != null) ...[
                Icon(
                  Icons.check_circle_outline,
                  size: 80.sp,
                  color: AppTheme.accentColor,
                ),
                SizedBox(height: 24.h),
                Text(
                  'All Set!',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  'Your profile has been successfully set up.',
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 16.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 48.h),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppTheme.accentColor,
                    padding: EdgeInsets.symmetric(
                      horizontal: 48.w,
                      vertical: 16.h,
                    ),
                  ),
                  onPressed: () => context.go('/'),
                  child: Text(
                    'Get Started',
                    style: TextStyle(
                      fontSize: 18.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ] else if (state.errorMessage != null) ...[
                Icon(Icons.error_outline, size: 80.sp, color: Colors.redAccent),
                SizedBox(height: 24.h),
                Text(
                  'Something went wrong',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: 12.h),
                Text(
                  state.errorMessage!,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.7),
                    fontSize: 14.sp,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 32.h),
                ElevatedButton(
                  onPressed: () =>
                      context.read<OnboardingWizardCubit>().submitOnboarding(),
                  child: const Text('Try Again'),
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
