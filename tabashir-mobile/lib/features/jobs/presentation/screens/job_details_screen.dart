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
            actions: [
              BlocBuilder<JobDetailsCubit, JobDetailsState>(
                builder: (context, state) {
                  final isSaved = state is JobDetailsLoaded && state.isSaved;
                  return IconButton(
                    icon: Icon(isSaved ? Icons.star : Icons.star_border),
                    color: isSaved ? AppTheme.primaryColor : null,
                    onPressed: () => _onSave(context, widget.jobId),
                    tooltip: isSaved ? 'Unsave'.tr() : 'Save'.tr(),
                  );
                },
              ),
              IconButton(
                icon: const Icon(Icons.share),
                onPressed: () => _onShare(context),
                tooltip: 'Share'.tr(),
              ),
            ],
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
          // Job Title Section
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

          SizedBox(height: 24.h),

          // Match Alert
          JobMatchAlert(
            alertText:
                jobDetails.overview ??
                "Your experience aligns perfectly with what they're looking for."
                    .tr(),
          ),

          SizedBox(height: 24.h),

          // Company Details
          CompanyDetailsWidget(
            companyName: jobDetails.company,
            onViewProfile: _onViewProfile,
          ),

          SizedBox(height: 24.h),

          // Job Tags
          Semantics(
            label: 'Job tags: ${jobDetails.tags.join(", ")}'.tr(),
            child: JobTagsWidget(
              tags: jobDetails.tags,
            ),
          ),

          SizedBox(height: 24.h),

          // Job Details Sections
          _buildJobDetailsSections(jobDetails),

          SizedBox(height: 24.h),

          // Similar Opportunities (Removed)
          // Semantics(
          //   label: 'Similar job opportunities'.tr(),
          //   child: SimilarOpportunitiesWidget(
          //     opportunities: jobDetails.similarOpportunities
          //         .map(
          //           (job) => {
          //             'title': job.title,
          //             'company': job.company,
          //             'match': job.matchPercentage,
          //             'tags': job.tags,
          //           },
          //         )
          //         .toList(),
          //   ),
          // ),
        ],
      ),
    ),
    // TODO: Handle this case.
    JobDetailsState() => throw UnimplementedError(),
  };

  Widget _buildJobDetailsSections(JobDetails jobDetails) => Column(
    children: [
      // About the Role
      ExpandableSection(
        title: 'About the Role'.tr(),
        initiallyExpanded: true,
        content: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BulletPointWidget(
              text: jobDetails.description,
            ),
          ],
        ),
      ),

      // Requirements - only show if not empty
      if (jobDetails.requirements.isNotEmpty) ...[
        SizedBox(height: 16.h),
        ExpandableSection(
          title: 'Requirements'.tr(),
          initiallyExpanded: true,
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
    ],
  );

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
