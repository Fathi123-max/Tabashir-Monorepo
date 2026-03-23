import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/features/ai_job_apply/presentation/cubit/ai_job_apply_cubit.dart';
import 'package:tabashir/features/ai_job_apply/presentation/cubit/ai_job_apply_state.dart';
import 'package:tabashir/features/home/presentation/cubit/home_cubit.dart';
import 'package:tabashir/features/home/presentation/cubit/home_state.dart';
import 'package:tabashir/features/home/presentation/widgets/home_job_card_widget.dart';
import 'package:tabashir/features/jobs/presentation/cubit/jobs_cubit.dart';
import 'package:tabashir/features/jobs/domain/repositories/jobs_repository.dart';
import 'package:tabashir/features/profile/presentation/cubit/profile_cubit.dart';

class HomeJobCardsHorizontalListWidget extends StatefulWidget {
  const HomeJobCardsHorizontalListWidget({super.key});

  @override
  State<HomeJobCardsHorizontalListWidget> createState() =>
      _HomeJobCardsHorizontalListWidgetState();
}

class _HomeJobCardsHorizontalListWidgetState
    extends State<HomeJobCardsHorizontalListWidget> {
  late final AiJobApplyCubit _aiJobApplyCubit;
  late final ProfileCubit _profileCubit;
  late final JobsRepository _jobsRepository;

  // Loading states
  final Set<String> _applyingJobs = <String>{};
  Set<String> _appliedJobs = <String>{};
  bool _isFetchingAppliedJobs = false;

  @override
  void initState() {
    super.initState();
    _aiJobApplyCubit = getIt<AiJobApplyCubit>();
    _profileCubit = getIt<ProfileCubit>();
    _jobsRepository = getIt<JobsRepository>();

    // Load profile data and applied jobs to ensure email + state available
    WidgetsBinding.instance.addPostFrameCallback((_) async {
      await _initializeData();
    });
  }

  Future<void> _initializeData() async {
    await _profileCubit.loadProfileData();
    await _loadAppliedJobs();
  }

  Future<void> _loadAppliedJobs() async {
    if (_isFetchingAppliedJobs) return;
    final email = _profileCubit.state.profile?.email;
    if (email == null || email.isEmpty) return;

    setState(() {
      _isFetchingAppliedJobs = true;
    });

    try {
      final response = await _jobsRepository.getAppliedJobs(email: email);
      final ids = response.jobs
          .map((job) => job.jobId)
          .where((id) => id.isNotEmpty)
          .toSet();
      setState(() {
        _appliedJobs = ids;
      });
    } catch (e) {
      debugPrint('[HOME_WIDGET] Failed to load applied jobs: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isFetchingAppliedJobs = false;
        });
      }
    }
  }

  // Apply to job method
  Future<void> _applyToJob(String jobId) async {
    if (_appliedJobs.contains(jobId)) {
      _showErrorSnackBar('You have already applied to this job.');
      return;
    }
    if (_applyingJobs.contains(jobId)) {
      return; // Already applying
    }

    setState(() {
      _applyingJobs.add(jobId);
    });

    try {
      // Get user email from profile
      final profileState = _profileCubit.state;

      // Debug logging
      print('[HOME_WIDGET] Profile status: ${profileState.status}');
      print('[HOME_WIDGET] Profile data: ${profileState.profile}');
      print('[HOME_WIDGET] Email: ${profileState.profile?.email}');

      // If profile is not loaded, try to load it
      if (profileState.status == ProfileStatus.initial) {
        print('[HOME_WIDGET] Profile not loaded, loading now...');
        await _profileCubit.loadProfileData();
        // Wait a bit for the load to complete
        await Future<void>.delayed(const Duration(milliseconds: 500));

        // Check again after loading
        final updatedState = _profileCubit.state;
        print('[HOME_WIDGET] Updated profile status: ${updatedState.status}');
        print('[HOME_WIDGET] Updated profile data: ${updatedState.profile}');
      }

      if (profileState.status != ProfileStatus.success ||
          profileState.profile?.email == null ||
          profileState.profile!.email.isEmpty) {
        _showErrorSnackBar('User email not found. Please update your profile.');
        return;
      }

      final email = profileState.profile!.email;

      // Use AiJobApplyCubit to apply with default resume
      await _aiJobApplyCubit.applyToSpecificJob(
        jobId: jobId,
        email: email,
      );

      setState(() {
        _appliedJobs.add(jobId);
      });
    } catch (e) {
      _showErrorSnackBar(e.toString());
    } finally {
      setState(() {
        _applyingJobs.remove(jobId);
      });
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
      ),
    );
  }

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider.value(value: _aiJobApplyCubit),
      BlocProvider.value(value: _profileCubit),
    ],
    child: MultiBlocListener(
      listeners: [
        // Listen to AI job apply state for application feedback
        BlocListener<AiJobApplyCubit, AiJobApplyState>(
          listener: (context, state) {
            if (state.submissionResult != null) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Application submitted successfully!'),
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
      child: BlocBuilder<HomeCubit, HomeState>(
        builder: (context, homeState) {
          // Get saved jobs from JobsCubit state
          final jobsState = context.watch<JobsCubit>().state;
          final savedJobs = jobsState is JobsStateLoaded
              ? jobsState.savedJobs
              : <String>{};

          // Get featured jobs from home state (fetched from API)
          final featuredJobs = homeState.jobs;

          // Show empty state if no jobs
          if (featuredJobs.isEmpty) {
            return Container(
              padding: EdgeInsets.all(16.w),
              child: Center(
                child: Text(
                  'No featured jobs available'.tr(),
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurfaceVariant,
                  ),
                ),
              ),
            );
          }

          return SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: featuredJobs.asMap().entries.map((entry) {
                final index = entry.key;
                final job = entry.value;
                final isPrimary =
                    index <
                    2; // First 2 cards show "Apply Now", rest show "View Details"

                return HomeJobCardWidget(
                  title: (job['title'] ?? job['job_title']) as String? ?? 'Untitled Position',
                  company: (job['company'] ?? job['company_name']) as String? ?? 'Unknown Company',
                  employmentType:
                      (job['employmentType'] ?? job['job_type']) as String? ?? 'Full-time',
                  level: (job['level'] ?? 'Not specified') as String? ?? 'Not specified',
                  matchPercentage: job['matchPercentage'] as String? ?? 'N/A',
                  isBookmarked: savedJobs.contains(job['id']?.toString()),
                  isPrimary: isPrimary,
                  jobId: job['id']?.toString(),
                  onBookmarkTap: () {
                    final jobId = job['id']?.toString();
                    if (jobId != null) {
                      context.read<JobsCubit>().toggleSaveJob(jobId);
                    }
                  },
                  onApplyTap: () {
                    final jobId = job['id']?.toString();
                    if (jobId != null) {
                      if (isPrimary) {
                        // First 2 cards: Apply directly
                        _applyToJob(jobId);
                      } else {
                        // Other cards: Navigate to job details
                        context.pushNamed(
                          'job-detail-screen',
                          pathParameters: {'jobId': jobId},
                        );
                      }
                    }
                  },
                  isApplied: _appliedJobs.contains(job['id']?.toString()),
                  isLoading: _applyingJobs.contains(job['id']?.toString()),
                );
              }).toList(),
            ),
          );
        },
      ),
    ),
  );
}
