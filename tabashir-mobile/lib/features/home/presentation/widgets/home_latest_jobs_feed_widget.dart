import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tabashir/features/home/presentation/cubit/home_cubit.dart';
import 'package:tabashir/features/home/presentation/cubit/home_state.dart';
import 'package:tabashir/features/home/presentation/widgets/home_job_card_widget.dart';

class HomeLatestJobsFeedWidget extends StatefulWidget {
  const HomeLatestJobsFeedWidget({super.key});

  @override
  State<HomeLatestJobsFeedWidget> createState() => _HomeLatestJobsFeedWidgetState();
}

class _HomeLatestJobsFeedWidgetState extends State<HomeLatestJobsFeedWidget> {
  final Set<String> _applyingJobs = <String>{};

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, homeState) {
        final latestJobs = homeState.latestJobsList;
        
        if (latestJobs.isEmpty) {
          return Center(
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Text(
                'No new opportunities available'.tr(),
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurfaceVariant,
                ),
              ),
            ),
          );
        }

        return ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          itemCount: latestJobs.length,
          separatorBuilder: (context, index) => SizedBox(height: 12.h),
          itemBuilder: (context, index) {
            final job = latestJobs[index];
            final jobId = job['id']?.toString() ?? job['job_id']?.toString() ?? '';
            
            return HomeJobCardWidget(
              title: (job['title'] ?? job['job_title']) as String? ?? 'Untitled Position',
              company: (job['company'] ?? job['company_name']) as String? ?? 'Unknown Company',
              employmentType: (job['employmentType'] ?? job['job_type']) as String? ?? 'Full-time',
              level: (job['level'] ?? 'Not specified') as String? ?? 'Not specified',
              matchPercentage: job['matchPercentage']?.toString() ?? 'N/A',
              isPrimary: false,
              jobId: jobId,
              onApplyTap: () {
                if (jobId.isNotEmpty) {
                  context.pushNamed(
                    'job-detail-screen',
                    pathParameters: {'jobId': jobId},
                  );
                }
              },
              isApplied: false,
              isLoading: _applyingJobs.contains(jobId),
            );
          },
        );
      },
    );
  }
}
