import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import '../../../../core/network/models/resume_response/resume_item.dart';
import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_theme.dart';
import '../../domain/repositories/resume_vault_repository.dart';
import '../cubit/resume_vault_cubit.dart';

import '../widgets/resume_card.dart';
import '../widgets/resume_vault_info_dialog.dart';
import '../widgets/resume_vault_empty_state.dart';
import '../widgets/resume_vault_error_state.dart';
import '../widgets/resume_vault_options_sheet.dart';
import '../widgets/add_resume_options_sheet.dart';

class ResumeVaultScreen extends StatefulWidget {
  const ResumeVaultScreen({super.key});

  @override
  State<ResumeVaultScreen> createState() => _ResumeVaultScreenState();
}

class _ResumeVaultScreenState extends State<ResumeVaultScreen> {
  @override
  void initState() {
    super.initState();
    print('🔵 [RESUME_VAULT_SCREEN] initState() called');
  }

  @override
  Widget build(BuildContext context) {
    print('🔵 [RESUME_VAULT_SCREEN] Building screen');
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        title: Text(
          'Resume Vault'.tr(),
          style: theme.textTheme.displayMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 0,
        backgroundColor: theme.scaffoldBackgroundColor,
        scrolledUnderElevation: 0,
        actions: [
          IconButton(
            icon: const Icon(Icons.info_outline),
            onPressed: () => ResumeVaultInfoDialog.show(context),
          ),
        ],
      ),
      body: BlocConsumer<ResumeVaultCubit, ResumeVaultState>(
        listener: (context, state) {
          print(
            '🔵 [RESUME_VAULT_SCREEN] Listener called with state: ${state.status}',
          );
          if (state.hasError && state.errorMessage != null) {
            print(
              '🔵 [RESUME_VAULT_SCREEN] Showing error: ${state.errorMessage}',
            );
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.errorMessage!),
                backgroundColor: AppTheme.errorColor,
              ),
            );
          }
          // Show success messages for various operations
          if (state.status == ResumeVaultStatus.success) {
            if (state.resumes.isNotEmpty) {
              print(
                '🔵 [RESUME_VAULT_SCREEN] Loaded ${state.resumes.length} resumes successfully',
              );
            }
          }
        },
        builder: (context, state) {
          print(
            '🔵 [RESUME_VAULT_SCREEN] Builder called with status: ${state.status}, resumes count: ${state.resumes.length}',
          );

          if (state.status == ResumeVaultStatus.loading) {
            print('🔵 [RESUME_VAULT_SCREEN] Showing loading indicator');
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 16),
                  Text('Loading your resumes...'),
                ],
              ),
            );
          }

          if (state.status == ResumeVaultStatus.failure) {
            print('🔵 [RESUME_VAULT_SCREEN] Showing error state');
            return ResumeVaultErrorState(
              onRetry: () {
                print(
                  '🔵 [RESUME_VAULT_SCREEN] Retry tapped, reloading resumes...',
                );
                context.read<ResumeVaultCubit>().loadResumes();
              },
            );
          }

          if (state.isEmpty) {
            print('🔵 [RESUME_VAULT_SCREEN] Showing empty state (no resumes)');
            print(
              '🔵 [RESUME_VAULT_SCREEN] Tip: Tap the + button to add your first resume!',
            );
            return ResumeVaultEmptyState(
              onAddResume: () => _showAddResumeOptions(context),
            );
          }

          return Stack(
            children: [
              _buildContent(context, state),
              if (state.isUploading)
                ColoredBox(
                  color: Colors.black.withOpacity(0.5),
                  child: Center(
                    child: Container(
                      padding: EdgeInsets.all(AppTheme.spacingXl.w),
                      decoration: BoxDecoration(
                        color: theme.cardTheme.color,
                        borderRadius: BorderRadius.circular(
                          AppTheme.radiusLarge.r,
                        ),
                      ),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation<Color>(
                              AppTheme.primaryColor,
                            ),
                          ),
                          SizedBox(height: AppTheme.spacingMd.h),
                          Text(
                            'Uploading resume...'.tr(),
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
            ],
          );
        },
      ),
      floatingActionButton: BlocBuilder<ResumeVaultCubit, ResumeVaultState>(
        builder: (context, state) {
          if (state.isUploading) {
            return const SizedBox.shrink();
          }

          return Padding(
            padding: EdgeInsets.only(
              right: AppTheme.spacingLg.w,
              bottom: AppTheme.spacingLg.h,
            ),
            child: FloatingActionButton.extended(
              onPressed: () => _showAddResumeOptions(context),
              icon: Icon(
                Icons.add_circle_outlined,
                size: 28.sp,
              ),
              label: Text(
                'Add Resume'.tr(),
                style: TextStyle(
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w700,
                  fontFamily: 'Inter'.tr(),
                ),
              ),
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
              elevation: 12,
              highlightElevation: 16,
              extendedPadding: EdgeInsets.symmetric(
                horizontal: AppTheme.spacingMd.w,
                vertical: AppTheme.spacingMd.h,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildContent(BuildContext context, ResumeVaultState state) {
    print(
      '🔵 [RESUME_VAULT_SCREEN] Building content with ${state.resumes.length} resumes',
    );

    // Filter out duplicates by filename to hide duplicate resumes
    final uniqueResumes = <String>{};
    final filteredResumes = state.resumes.where((resume) {
      final key = '${resume.name}_${resume.id}';
      if (uniqueResumes.contains(key)) {
        return false;
      }
      uniqueResumes.add(key);
      return true;
    }).toList();

    print(
      '🔵 [RESUME_VAULT_SCREEN] After filtering duplicates: ${filteredResumes.length} unique resumes',
    );

    return RefreshIndicator(
      onRefresh: () async {
        print(
          '🔵 [RESUME_VAULT_SCREEN] Refresh indicator triggered, reloading...',
        );
        await context.read<ResumeVaultCubit>().loadResumes();
      },
      child: ListView.builder(
        padding: EdgeInsets.all(AppTheme.spacingMd.w),
        itemCount: filteredResumes.length,
        itemBuilder: (context, index) {
          final resume = filteredResumes[index];
          print(
            '🔵 [RESUME_VAULT_SCREEN] Building card for resume: ${resume.name}',
          );
          return Padding(
            padding: EdgeInsets.only(bottom: AppTheme.spacingMd.h),
            child: ResumeCard(
              resume: resume,
              onTap: () => _viewResume(context, resume),
              onMorePressed: () => _showResumeOptions(context, resume, index),
            ),
          );
        },
      ),
    );
  }

  void _viewResume(BuildContext context, ResumeItem resume) {
    print('🔵 [RESUME_VAULT_SCREEN] View resume tapped for: ${resume.name}');

    // Create a core ResumeItem for the preview
    final coreResume = ResumeItem(
      id: resume.id,
      filename: resume.name,
      originalUrl: resume.filePath ?? '',
      formatedUrl: null,
      isAiResume: false,
      createdAt: DateTime.now(),
      updatedAt: DateTime.now(),
    );

    // Navigate to resume preview
    context.push(
      RouteNames.resumePreview,
      extra: coreResume,
    );
  }

  Future<void> _showAddResumeOptions(BuildContext context) async {
    print('🔵 [RESUME_VAULT_SCREEN] Add resume options requested');
    await AddResumeOptionsSheet.show(context);
  }

  Future<void> _showResumeOptions(
    BuildContext context,
    ResumeItem resume,
    int index,
  ) async {
    print(
      '🔵 [RESUME_VAULT_SCREEN] Resume options requested for: ${resume.name}',
    );
    final cubit = context.read<ResumeVaultCubit>();
    await ResumeVaultOptionsSheet.show(context, resume, index, cubit);
  }
}
