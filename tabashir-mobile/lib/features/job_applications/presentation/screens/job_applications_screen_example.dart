import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/features/job_applications/domain/repositories/job_applications_repository.dart';
import 'package:tabashir/features/job_applications/presentation/cubit/job_applications_cubit.dart';

/// Example usage of JobApplicationsCubit in a screen
class JobApplicationsScreenExample extends StatelessWidget {
  const JobApplicationsScreenExample({super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
    // Create the cubit with repository injection
    create: (_) => JobApplicationsCubit(
      getIt<JobApplicationsRepository>(),
    )..loadAppliedJobs(email: 'user@example.com'),
    child: const JobApplicationsView(),
  );
}

class JobApplicationsView extends StatelessWidget {
  const JobApplicationsView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('My Applications'),
      actions: [
        // Refresh button
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: () {
            context.read<JobApplicationsCubit>().refresh(
              email: 'user@example.com',
            );
          },
        ),
      ],
    ),
    body: BlocBuilder<JobApplicationsCubit, JobApplicationsState>(
      builder: (context, state) {
        if (state.status == JobApplicationsStatus.loading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }

        if (state.status == JobApplicationsStatus.error) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(
                  Icons.error_outline,
                  size: 64,
                  color: Colors.red,
                ),
                const SizedBox(height: 16),
                Text(
                  state.errorMessage,
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    context.read<JobApplicationsCubit>().refresh(
                      email: 'user@example.com',
                    );
                  },
                  child: const Text('Retry'),
                ),
              ],
            ),
          );
        }

        return Column(
          children: [
            // Total applications count
            Card(
              margin: const EdgeInsets.all(16),
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Total Applications:',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      '${state.totalApplications}',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            // Applications list
            Expanded(
              child: state.appliedJobs.isEmpty
                  ? const Center(
                      child: Text('No applications yet'),
                    )
                  : ListView.builder(
                      itemCount: state.appliedJobs.length,
                      itemBuilder: (context, index) {
                        final job = state.appliedJobs[index];
                        return Card(
                          margin: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: ListTile(
                            title: Text(job.jobTitle ?? 'Unknown Position'),
                            // subtitle: Text(
                            //   'Applied on: ${job.appliedAt ?? 'N/A'}',
                            // ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                            ),
                            onTap: () {
                              // Navigate to application details
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        );
      },
    ),
  );
}

/// Alternative: Using MultiBlocProvider for multiple cubits
class JobApplicationsScreenWithCount extends StatelessWidget {
  const JobApplicationsScreenWithCount({super.key});

  @override
  Widget build(BuildContext context) => MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (_) => JobApplicationsCubit(
          getIt<JobApplicationsRepository>(),
        ),
      ),
    ],
    child: const JobApplicationsCountView(),
  );
}

class JobApplicationsCountView extends StatelessWidget {
  const JobApplicationsCountView({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    body: BlocListener<JobApplicationsCubit, JobApplicationsState>(
      listener: (context, state) {
        if (state.status == JobApplicationsStatus.error) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: ${state.errorMessage}'),
              backgroundColor: Colors.red,
            ),
          );
        }
      },
      child: BlocBuilder<JobApplicationsCubit, JobApplicationsState>(
        builder: (context, state) => Column(
          children: [
            ElevatedButton(
              onPressed: () {
                // Load applications
                context.read<JobApplicationsCubit>().loadAppliedJobs(
                  email: 'user@example.com',
                );
              },
              child: const Text('Load Applications'),
            ),
            ElevatedButton(
              onPressed: () {
                // Load count only
                context.read<JobApplicationsCubit>().loadApplicationsCount(
                  email: 'user@example.com',
                );
              },
              child: const Text('Load Count'),
            ),
            Text('Count: ${state.totalApplications}'),
            Expanded(
              child: ListView.builder(
                itemCount: state.appliedJobs.length,
                itemBuilder: (context, index) {
                  final job = state.appliedJobs[index];
                  return ListTile(
                    title: Text(job.jobTitle ?? 'Unknown'),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
