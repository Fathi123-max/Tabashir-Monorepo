import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/core/services/job_match_service.dart';
import 'package:tabashir/features/home/presentation/cubit/home_cubit.dart';
import 'package:tabashir/features/home/presentation/cubit/home_state.dart';
import 'package:tabashir/features/home/presentation/widgets/home_job_card_widget.dart';
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
  late final ProfileCubit _profileCubit;
  late final JobsRepository _jobsRepository;
  final JobMatchService _jobMatchService = getIt<JobMatchService>();

  // Loading states
  Set<String> _appliedJobs = <String>{};
  bool _isFetchingAppliedJobs = false;

  @override
  void initState() {
    super.initState();
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
          .map((job) => job.jobId?.toString() ?? '')
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

  @override
  Widget build(BuildContext context) => BlocProvider.value(
        value: _profileCubit,
        child: BlocBuilder<HomeCubit, HomeState>(
          builder: (context, homeState) {
            // Get matched jobs from home state (fetched from AI API)
            final matchedJobs = homeState.matchedJobsList;

            // Show empty state if no jobs
            if (matchedJobs.isEmpty) {
              return Container(
                padding: EdgeInsets.all(16.w),
                child: Center(
                  child: Text(
                    'No AI matches available yet'.tr(),
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
                children: matchedJobs.map((job) {
                  const isPrimary = false;

                  return HomeJobCardWidget(
                    title: job.title,
                    company: job.company,
                    employmentType: 'Full-time', // Add to model if needed
                    level: 'Not specified',
                    matchPercentage: _jobMatchService.formatMatchPercentage(
                      job.matchPercentage,
                    ),
                    isPrimary: isPrimary,
                    jobId: job.id,
                    onApplyTap: () async {
                      // All cards: Navigate to job details
                      await context.pushNamed(
                        'job-detail-screen',
                        pathParameters: {'jobId': job.id},
                      );
                    },
                    isApplied: _appliedJobs.contains(job.id),
                  );
                }).toList(),
              ),
            );
          },
        ),
      );
}
