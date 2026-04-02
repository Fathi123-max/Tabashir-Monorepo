import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/features/ai_job_apply/presentation/cubit/ai_job_apply_cubit.dart';
import 'package:tabashir/features/ai_job_apply/presentation/cubit/ai_job_apply_state.dart';
import 'package:tabashir/features/jobs/data/models/job_details.dart';
import 'package:tabashir/features/jobs/presentation/widgets/job_details_widgets.dart';
// import 'package:tabashir/features/jobs/presentation/widgets/job_details_widgets.dart'; // Removed - SimilarOpportunitiesWidget no longer used
import 'package:tabashir/features/profile/presentation/cubit/profile_cubit.dart';
import '../cubit/job_details_cubit.dart';

class JobDetailScreen extends StatefulWidget {
  const JobDetailScreen({required this.jobId, super.key});
  final String jobId;

  @override
  State<JobDetailScreen> createState() => _JobDetailScreenState();
}

class _JobDetailScreenState extends State<JobDetailScreen> {
  late final ProfileCubit _profileCubit;
  bool _isApplying = false;

  @override
  void initState() {
    super.initState();
    _profileCubit = getIt<ProfileCubit>();

    // Initialize the profile state after the widget is built
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _profileCubit.loadProfileData();
    });
  }

  @override
  void dispose() {
    // Don't dispose _profileCubit as it's managed by get_it
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider.value(value: _profileCubit),
      BlocProvider(
        create: (context) =>
            JobDetailsCubit(service: getIt(), profileCubit: _profileCubit)
              ..getJobDetails(widget.jobId),
      ),
      // Provide AiJobApplyCubit for application feedback
      BlocProvider(
        create: (context) => getIt<AiJobApplyCubit>(),
      ),
      // Provide AiJobApplyCubit for application feedback
      BlocProvider(
        create: (context) => getIt<AiJobApplyCubit>(),
      ),
    ],
    child: MultiBlocListener(
      listeners: [
        // Listen to job details state changes
        BlocListener<JobDetailsCubit, JobDetailsState>(
          listener: (context, state) {
            if (state is JobDetailsError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message),
                  backgroundColor: Colors.red,
                ),
              );
            }
          },
        ),
        // Listen to AI job apply state for application feedback
        BlocListener<AiJobApplyCubit, AiJobApplyState>(
          listener: (context, state) {
            if (state.submissionResult != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Application submitted successfully!'.tr()),
                  backgroundColor: Colors.green,
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
        ),
      ],
      child: BlocBuilder<JobDetailsCubit, JobDetailsState>(
        builder: (context, state) => Scaffold(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          appBar: AppBar(
            backgroundColor: Theme.of(context).colorScheme.surface,
            foregroundColor: Theme.of(context).colorScheme.onSurface,
            elevation: 0,
            scrolledUnderElevation:
                Theme.of(context).appBarTheme.scrolledUnderElevation ?? 4,
            iconTheme: Theme.of(context).appBarTheme.iconTheme,
            actionsIconTheme: Theme.of(context).appBarTheme.actionsIconTheme,
            surfaceTintColor: Colors.transparent,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new),
              onPressed: () => Navigator.of(context).pop(),
              tooltip: 'Back'.tr(),
            ),
            // Hidden: Share and Save buttons
            // actions: [
            //   BlocBuilder<JobDetailsCubit, JobDetailsState>(
            //     builder: (context, state) {
            //       final isSaved = state is JobDetailsLoaded && state.isSaved;
            //       return IconButton(
            //         icon: Icon(isSaved ? Icons.star : Icons.star_border),
            //         color: isSaved ? AppTheme.primaryColor : null,
            //         onPressed: () => _onSave(context, widget.jobId),
            //         tooltip: isSaved ? 'Unsave'.tr() : 'Save'.tr(),
            //       );
            //     },
            //   ),
            //   IconButton(
            //     icon: const Icon(Icons.share),
            //     onPressed: () => _onShare(context),
            //     tooltip: 'Share'.tr(),
            //   ),
            // ],
          ),
          body: Column(
            children: [
              // Main Content
              Expanded(
                child: _buildContent(context, state, widget.jobId),
              ),

              // Footer
              _buildFooter(context, state, widget.jobId),
            ],
          ),
        ),
      ),
    ),
  );
  Widget _buildFooter(
    BuildContext context,
    JobDetailsState state,
    String jobId,
  ) {
    if (state is! JobDetailsLoaded) {
      return Container(); // Don't show footer when loading or in error state
    }

    return JobDetailsFooter(
      onApply: () => _onApply(context),
      onSaveForLater: () => _onSave(context, jobId),
      showLoading:
          _isApplying ||
          context.watch<AiJobApplyCubit>().state.isSubmittingApplication,
      isApplied: state.isApplied,
      isSaved: state.isSaved,
    );
  }

  Widget _buildContent(
    BuildContext context,
    JobDetailsState state,
    String jobId,
  ) => switch (state) {
    JobDetailsInitial() => Center(
      child: Text(
        'Select a job to view details'.tr(),
        semanticsLabel: 'No job selected'.tr(),
      ),
    ),
    JobDetailsLoading() => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(),
          const SizedBox(height: 16),
          Text('Loading job details...'.tr()),
        ],
      ),
    ),
    JobDetailsError(:final message) => Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 60,
          ),
          const SizedBox(height: 16),
          Text(
            'Error: $message'.tr(),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () =>
                context.read<JobDetailsCubit>().getJobDetails(jobId),
            child: Text('Retry'.tr()),
          ),
        ],
      ),
    ),
    JobDetailsLoaded(:final jobDetails) => SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: AppTheme.spacingMd.w, vertical: AppTheme.spacingMd.h),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Job Title Section - Full width, no extra margins
          Semantics(
            label:
                'Job title: ${jobDetails.title}, Company: ${jobDetails.company}'
                    .tr(),
            child: JobTitleSection(
              title: jobDetails.title,
              company: jobDetails.company,
              location: jobDetails.location,
              matchPercentage: jobDetails.matchPercentage,
              salary: jobDetails.salary,
            ),
          ),

          SizedBox(height: AppTheme.spacingMd.h),

          // Company Details
          CompanyDetailsWidget(
            companyName: jobDetails.company,
            onViewProfile: _onViewProfile,
          ),

          SizedBox(height: AppTheme.spacingLg.h),

          // Job Tags
          Semantics(
            label: 'Job tags: ${jobDetails.tags.join(", ")}'.tr(),
            child: JobTagsWidget(
              tags: jobDetails.tags,
            ),
          ),

          SizedBox(height: AppTheme.spacingLg.h),

          // Job Details Sections
          _buildJobDetailsSections(jobDetails),
        ],
      ),
    ),
    // TODO: Handle this case.
    JobDetailsState() => throw UnimplementedError(),
  };

  Widget _buildJobDetailsSections(JobDetails jobDetails) => Column(
    children: [
      // Employment Type, Experience Level, Working Hours
      if (jobDetails.employmentType != null ||
          jobDetails.experienceLevel != null ||
          jobDetails.workingHours != null ||
          jobDetails.workingDays != null) ...[
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(AppTheme.spacingMd.w),
          decoration: BoxDecoration(
            color: AppTheme.primaryColor.withOpacity(0.05),
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
            border: Border.all(
              color: AppTheme.primaryColor.withOpacity(0.15),
            ),
          ),
          child: Wrap(
            spacing: AppTheme.spacingSm.w,
            runSpacing: AppTheme.spacingSm.h,
            children: [
              if (jobDetails.employmentType != null)
                _buildInfoChip(
                  icon: Icons.work_outline_rounded,
                  label: jobDetails.employmentType!,
                ),
              if (jobDetails.experienceLevel != null)
                _buildInfoChip(
                  icon: Icons.trending_up_rounded,
                  label: jobDetails.experienceLevel!,
                ),
              if (jobDetails.workingHours != null)
                _buildInfoChip(
                  icon: Icons.schedule_rounded,
                  label: jobDetails.workingHours!,
                ),
              if (jobDetails.workingDays != null)
                _buildInfoChip(
                  icon: Icons.calendar_today_rounded,
                  label: jobDetails.workingDays!,
                ),
            ],
          ),
        ),
        SizedBox(height: AppTheme.spacingMd.h),
      ],

      // Skills Section
      if (jobDetails.skills.isNotEmpty) ...[
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(AppTheme.spacingMd.w),
          decoration: BoxDecoration(
            color: AppTheme.zinc50,
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
            border: Border.all(
              color: AppTheme.zinc200!,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.psychology_rounded,
                    size: 20.sp,
                    color: AppTheme.primaryColor,
                  ),
                  SizedBox(width: AppTheme.spacingSm.w),
                  Text(
                    'Required Skills',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.zinc900,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppTheme.spacingMd.h),
              Wrap(
                spacing: AppTheme.spacingSm.w,
                runSpacing: AppTheme.spacingSm.h,
                children: jobDetails.skills
                    .map(
                      (skill) => Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: AppTheme.spacingMd.w,
                          vertical: AppTheme.spacingXs.h,
                        ),
                        decoration: BoxDecoration(
                          color: AppTheme.primaryColor.withOpacity(0.08),
                          borderRadius: BorderRadius.circular(AppTheme.radiusFull.r),
                          border: Border.all(
                            color: AppTheme.primaryColor.withOpacity(0.2),
                          ),
                        ),
                        child: Text(
                          skill,
                          style: TextStyle(
                            fontSize: 12.sp,
                            fontWeight: FontWeight.w600,
                            color: AppTheme.primaryColor,
                          ),
                        ),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
        SizedBox(height: AppTheme.spacingMd.h),
      ],

      // About the Role
      ExpandableSection(
        title: 'About the Role'.tr(),
        initiallyExpanded: false,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BulletPointWidget(
              text: jobDetails.description,
            ),
          ],
        ),
      ),

      // Requirements
      if (jobDetails.requirements.isNotEmpty) ...[
        ExpandableSection(
          title: 'Requirements'.tr(),
          initiallyExpanded: false,
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: jobDetails.requirements
                .map(
                  (req) => req.contains('Proficiency'.tr())
                      ? BulletPointWithBadgeWidget(text: req)
                      : BulletPointWidget(text: req),
                )
                .toList(),
          ),
        ),
      ],

      // Contact Information
      if (jobDetails.phone != null ||
          jobDetails.applicationEmail != null ||
          jobDetails.applyUrl != null) ...[
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(AppTheme.spacingMd.w),
          decoration: BoxDecoration(
            color: AppTheme.zinc50,
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
            border: Border.all(
              color: AppTheme.zinc200!,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Icon(
                    Icons.contact_mail_rounded,
                    size: 20.sp,
                    color: AppTheme.primaryColor,
                  ),
                  SizedBox(width: AppTheme.spacingSm.w),
                  Text(
                    'Contact Information',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.zinc900,
                    ),
                  ),
                ],
              ),
              SizedBox(height: AppTheme.spacingMd.h),
              if (jobDetails.phone != null) ...[
                _buildContactRow(
                  icon: Icons.phone_rounded,
                  label: jobDetails.phone!,
                ),
                SizedBox(height: AppTheme.spacingSm.h),
              ],
              if (jobDetails.applicationEmail != null) ...[
                _buildContactRow(
                  icon: Icons.email_rounded,
                  label: jobDetails.applicationEmail!,
                ),
                SizedBox(height: AppTheme.spacingSm.h),
              ],
              if (jobDetails.applyUrl != null) ...[
                _buildContactRow(
                  icon: Icons.link_rounded,
                  label: 'Apply Online',
                  isLink: true,
                  url: jobDetails.applyUrl!,
                ),
              ],
            ],
          ),
        ),
        SizedBox(height: AppTheme.spacingMd.h),
      ],

      // Posted Date & Source
      if (jobDetails.postedDate != null || jobDetails.source != null) ...[
        Container(
          width: double.infinity,
          padding: EdgeInsets.all(AppTheme.spacingMd.w),
          decoration: BoxDecoration(
            color: AppTheme.zinc50,
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
            border: Border.all(
              color: AppTheme.zinc200!,
            ),
          ),
          child: Wrap(
            spacing: AppTheme.spacingMd.w,
            runSpacing: AppTheme.spacingSm.h,
            children: [
              if (jobDetails.postedDate != null)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.access_time_rounded,
                      size: 16.sp,
                      color: AppTheme.zinc400,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Posted ${_formatPostedDate(jobDetails.postedDate!)}',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppTheme.zinc500,
                      ),
                    ),
                  ],
                ),
              if (jobDetails.source != null)
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.source_rounded,
                      size: 16.sp,
                      color: AppTheme.zinc400,
                    ),
                    SizedBox(width: 4.w),
                    Text(
                      'Source: ${jobDetails.source!}',
                      style: TextStyle(
                        fontSize: 13.sp,
                        color: AppTheme.zinc500,
                      ),
                    ),
                  ],
                ),
            ],
          ),
        ),
      ],
    ],
  );

  Widget _buildInfoChip({
    required IconData icon,
    required String label,
  }) =>
      Container(
        padding: EdgeInsets.symmetric(
          horizontal: AppTheme.spacingSm.w,
          vertical: AppTheme.spacingXs.h,
        ),
        decoration: BoxDecoration(
          color: AppTheme.zinc100,
          borderRadius: BorderRadius.circular(AppTheme.radiusSmall.r),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(
              icon,
              size: 14.sp,
              color: AppTheme.zinc600,
            ),
            SizedBox(width: 4.w),
            Text(
              label,
              style: TextStyle(
                fontSize: 12.sp,
                color: AppTheme.zinc700,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      );

  Widget _buildContactRow({
    required IconData icon,
    required String label,
    bool isLink = false,
    String? url,
  }) =>
      Row(
        children: [
          Icon(
            icon,
            size: 18.sp,
            color: AppTheme.primaryColor,
          ),
          SizedBox(width: 8.w),
          isLink
              ? Expanded(
                  child: GestureDetector(
                    onTap: () {
                      // TODO: Open URL
                      print('Open URL: $url');
                    },
                    child: Text(
                      label,
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: AppTheme.primaryColor,
                        fontWeight: FontWeight.w600,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                )
              : Expanded(
                  child: Text(
                    label,
                    style: TextStyle(
                      fontSize: 14.sp,
                      color: AppTheme.zinc700,
                    ),
                  ),
                ),
        ],
      );

  String _formatPostedDate(String dateStr) {
    try {
      final date = DateTime.parse(dateStr);
      final now = DateTime.now();
      final difference = now.difference(date);

      if (difference.inDays == 0) {
        return 'today';
      } else if (difference.inDays == 1) {
        return 'yesterday';
      } else if (difference.inDays < 7) {
        return '${difference.inDays} days ago';
      } else if (difference.inDays < 30) {
        return '${(difference.inDays / 7).floor()} weeks ago';
      } else if (difference.inDays < 365) {
        return '${(difference.inDays / 30).floor()} months ago';
      } else {
        return '${(difference.inDays / 365).floor()} years ago';
      }
    } catch (e) {
      return dateStr;
    }
  }

  // Callback methods
  void _onShare(BuildContext context) {
    if (context.read<JobDetailsCubit>().state is JobDetailsLoaded) {
      final jobId = (context.read<JobDetailsCubit>().state as JobDetailsLoaded)
          .jobDetails
          .id;
      context.read<JobDetailsCubit>().shareJob(jobId);
    }
  }

  void _onSave(BuildContext context, String jobId) {
    context.read<JobDetailsCubit>().toggleSaveJob(jobId);
  }

  void _onViewProfile() {
    // Implementation for viewing company profile
  }

  Future<void> _onApply(BuildContext context) async {
    if (context.read<JobDetailsCubit>().state is JobDetailsLoaded) {
      final loadedState =
          context.read<JobDetailsCubit>().state as JobDetailsLoaded;
      if (loadedState.isApplied) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('You have already applied to this job.'.tr()),
            backgroundColor: Colors.orange,
          ),
        );
        return;
      }

      // Set loading state to true
      setState(() {
        _isApplying = true;
      });

      try {
        // Get user email from profile
        var profileState = context.read<ProfileCubit>().state;

        // Debug logging
        print('[JOB_DETAILS_SCREEN] Profile status: ${profileState.status}');
        print('[JOB_DETAILS_SCREEN] Profile data: ${profileState.profile}');
        print('[JOB_DETAILS_SCREEN] Email: ${profileState.profile?.email}');

        // If profile is not loaded, try to load it
        if (profileState.status == ProfileStatus.initial) {
          print('[JOB_DETAILS_SCREEN] Profile not loaded, loading now...');
          await context.read<ProfileCubit>().loadProfileData();

          // Get the updated state after loading
          profileState = context.read<ProfileCubit>().state;
          print(
            '[JOB_DETAILS_SCREEN] Updated profile status: ${profileState.status}',
          );
          print(
            '[JOB_DETAILS_SCREEN] Updated profile data: ${profileState.profile}',
          );
        }

        if (profileState.status != ProfileStatus.success ||
            profileState.profile?.email == null ||
            profileState.profile!.email.isEmpty) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text(
                'User email not found. Please update your profile.',
              ),
              backgroundColor: Colors.red,
            ),
          );
          return;
        }

        final jobId = loadedState.jobDetails.id;
        context.read<JobDetailsCubit>().applyToJob(jobId);
      } finally {
        // Always reset loading state in the finally block to ensure it's reset even if there's an error
        setState(() {
          _isApplying = false;
        });
      }
    }
  }
}
