import 'package:easy_localization/easy_localization.dart';

import 'package:flutter/material.dart' hide FilterChip;
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../core/theme/app_theme.dart';
import '../cubit/jobs_cubit.dart';
import 'job_filter_chip.dart';
import 'salary_range_slider.dart';

class JobFilterBottomSheet extends StatefulWidget {
  const JobFilterBottomSheet({
    required this.jobsCubit,
    super.key,
  });
  final JobsCubit jobsCubit;

  @override
  State<JobFilterBottomSheet> createState() => _JobFilterBottomSheetState();
}

class _JobFilterBottomSheetState extends State<JobFilterBottomSheet> {
  late List<String> selectedLocations;
  late List<String> selectedJobTypes;
  late List<String> selectedExperienceLevels;
  late int minSalary;
  late int maxSalary;

  @override
  void initState() {
    super.initState();
    final state = widget.jobsCubit.state;
    if (state is JobsStateLoaded) {
      selectedLocations = List.from(state.selectedLocations);
      selectedJobTypes = List.from(state.selectedJobTypes);
      selectedExperienceLevels = List.from(state.selectedExperienceLevels);
      minSalary = state.minSalary;
      maxSalary = state.maxSalary;
    } else {
      selectedLocations = [];
      selectedJobTypes = [];
      selectedExperienceLevels = [];
      minSalary = 0;
      maxSalary = 100000;
    }
  }

  void _toggleLocation(String location) {
    setState(() {
      if (selectedLocations.contains(location)) {
        selectedLocations.remove(location);
      } else {
        selectedLocations.add(location);
      }
    });
  }

  void _toggleJobType(String jobType) {
    setState(() {
      if (selectedJobTypes.contains(jobType)) {
        selectedJobTypes.remove(jobType);
      } else {
        selectedJobTypes.add(jobType);
      }
    });
  }

  void _toggleExperienceLevel(String level) {
    setState(() {
      if (selectedExperienceLevels.contains(level)) {
        selectedExperienceLevels.remove(level);
      } else {
        selectedExperienceLevels.add(level);
      }
    });
  }

  void _applyFilters() {
    widget.jobsCubit.updateLocationFilter(selectedLocations);
    widget.jobsCubit.updateJobTypeFilter(selectedJobTypes);
    widget.jobsCubit.updateExperienceLevelFilter(
      selectedExperienceLevels,
    );
    widget.jobsCubit.updateSalaryRange(minSalary, maxSalary);
    Navigator.of(context).pop();
  }

  void _clearAllFilters() {
    setState(() {
      selectedLocations.clear();
      selectedJobTypes.clear();
      selectedExperienceLevels.clear();
      minSalary = 0;
      maxSalary = 100000;
    });
    widget.jobsCubit.clearFilters();
  }

  int get activeFilterCount =>
      selectedLocations.length +
      selectedJobTypes.length +
      selectedExperienceLevels.length +
      (minSalary > 0 || maxSalary < 100000 ? 1 : 0);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cubit = widget.jobsCubit;

    return DraggableScrollableSheet(
      initialChildSize: 0.9,
      maxChildSize: 0.95,
      minChildSize: 0.5,
      expand: false,
      builder: (context, scrollController) => SingleChildScrollView(
        controller: scrollController,
        child: Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          child: Container(
            padding: EdgeInsets.all(AppTheme.spacingMd.w),
            decoration: BoxDecoration(
              color: theme.colorScheme.surface,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(AppTheme.radiusLarge.r),
                topRight: Radius.circular(AppTheme.radiusLarge.r),
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.1),
                  blurRadius: 10,
                  offset: const Offset(0, -2),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Handle
                Center(
                  child: Container(
                    width: 40.w,
                    height: 4.h,
                    decoration: BoxDecoration(
                      color: theme.colorScheme.onSurfaceVariant,
                      borderRadius: BorderRadius.circular(2.r),
                    ),
                  ),
                ),
                SizedBox(height: AppTheme.spacingMd.h),

                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Filters'.tr(),
                      style: theme.textTheme.headlineSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    if (activeFilterCount > 0)
                      TextButton(
                        onPressed: _clearAllFilters,
                        child: Text(
                          'Clear All'.tr(),
                          style: TextStyle(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
                SizedBox(height: AppTheme.spacingSm.h),

                // Active filters count
                if (activeFilterCount > 0)
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingMd.w,
                      vertical: AppTheme.spacingSm.h,
                    ),
                    decoration: BoxDecoration(
                      color: AppTheme.primaryColor.withOpacity(0.15),
                      borderRadius: BorderRadius.circular(
                        AppTheme.radiusDefault.r,
                      ),
                      border: Border.all(
                        color: AppTheme.primaryColor.withOpacity(0.3),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.filter_list,
                          size: 16.sp,
                          color: AppTheme.primaryColor,
                        ),
                        SizedBox(width: AppTheme.spacingXs.w),
                        Text(
                          '$activeFilterCount ${activeFilterCount > 1 ? "filters".tr() : "filter".tr()} ${"active".tr()}',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: AppTheme.primaryColor,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                SizedBox(height: AppTheme.spacingMd.h),

                // Location/Work Mode Filter
                _buildFilterSection(
                  'Location / Work Mode'.tr(),
                  cubit.locationOptions,
                  selectedLocations,
                  _toggleLocation,
                ),
                SizedBox(height: AppTheme.spacingLg.h),

                // Job Type Filter
                _buildFilterSection(
                  'Job Type'.tr(),
                  cubit.jobTypeOptions,
                  selectedJobTypes,
                  _toggleJobType,
                ),
                SizedBox(height: AppTheme.spacingLg.h),

                // Experience Level Filter
                _buildFilterSection(
                  'Experience Level'.tr(),
                  cubit.experienceLevelOptions,
                  selectedExperienceLevels,
                  _toggleExperienceLevel,
                ),
                SizedBox(height: AppTheme.spacingLg.h),

                // Salary Range Filter
                Text(
                  'Salary Range'.tr(),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(height: AppTheme.spacingMd.h),
                SalaryRangeSlider(
                  min: 0,
                  max: 100000,
                  minValue: minSalary,
                  maxValue: maxSalary,
                  onMinChanged: (value) {
                    setState(() {
                      minSalary = value;
                    });
                  },
                  onMaxChanged: (value) {
                    setState(() {
                      maxSalary = value;
                    });
                  },
                ),
                SizedBox(height: AppTheme.spacingXxl.h),

                // Apply Button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _applyFilters,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppTheme.primaryColor,
                      foregroundColor: Colors.white,
                      elevation: 2,
                      shadowColor: Colors.black.withOpacity(0.2),
                      padding: EdgeInsets.symmetric(
                        vertical: AppTheme.spacingMd.h,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppTheme.radiusDefault.r,
                        ),
                      ),
                    ),
                    child: Text(
                      'Apply Filters'.tr(),
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
                SizedBox(height: AppTheme.spacingLg.h),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildFilterSection(
    String title,
    List<String> options,
    List<String> selectedItems,
    void Function(String) onTap,
  ) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: AppTheme.spacingMd.h),
        Wrap(
          spacing: AppTheme.spacingSm.w,
          runSpacing: AppTheme.spacingSm.h,
          children: options.map((option) {
            final isSelected = selectedItems.contains(option);
            return FilterChip(
              label: option,
              isSelected: isSelected,
              onTap: () => onTap(option),
            );
          }).toList(),
        ),
      ],
    );
  }
}
