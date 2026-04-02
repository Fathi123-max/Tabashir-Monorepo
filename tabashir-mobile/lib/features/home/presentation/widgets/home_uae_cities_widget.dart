import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/features/home/domain/repositories/home_repository.dart';
import 'package:tabashir/features/home/presentation/cubit/home_cubit.dart';
import 'package:tabashir/features/home/presentation/cubit/home_state.dart';

/// Displays UAE cities with job counts as horizontal scrollable chips
class HomeUAECitiesWidget extends StatelessWidget {
  const HomeUAECitiesWidget({super.key});

  // UAE cities filter list
  static const Set<String> _uaeCities = {
    'Dubai',
    'Abu Dhabi',
    'Sharjah',
    'Ajman',
    'Ras Al Khaimah',
    'Fujairah',
    'Umm Al Quwain',
  };

  /// Filter city counts to UAE cities only
  List<CityJobCount> _filterUAECities(List<CityJobCount> allCities) {
    return allCities.where((city) => _uaeCities.contains(city.city)).toList()
      ..sort((a, b) => b.count.compareTo(a.count)); // Sort by count descending
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        final allCityCounts = state.cityJobCounts;
        final uaeCityCounts = _filterUAECities(allCityCounts);

        // Don't show section if no UAE cities data
        if (uaeCityCounts.isEmpty) {
          return const SizedBox.shrink();
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Horizontal scrollable chips
            SizedBox(
              height: 44.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: AppTheme.spacingLg.w),
                itemCount: uaeCityCounts.length,
                itemBuilder: (context, index) {
                  final cityData = uaeCityCounts[index];
                  return Padding(
                    padding: EdgeInsets.only(right: AppTheme.spacingMd.w),
                    child: _CityChip(cityData: cityData),
                  );
                },
              ),
            ),
            SizedBox(height: AppTheme.spacingXl.h),
          ],
        );
      },
    );
  }
}

/// Individual city chip widget
class _CityChip extends StatelessWidget {
  const _CityChip({required this.cityData});

  final CityJobCount cityData;

  @override
  Widget build(BuildContext context) => GestureDetector(
    onTap: () {
      // Navigate to jobs screen filtered by city
      context.push('/jobs?city=${Uri.encodeComponent(cityData.city)}');
    },
    child: Container(
      padding: EdgeInsets.symmetric(
        horizontal: AppTheme.spacingMd.w,
        vertical: AppTheme.spacingSm.h,
      ),
      decoration: BoxDecoration(
        color: AppTheme.primaryColor.withOpacity(0.08),
        borderRadius: BorderRadius.circular(AppTheme.radiusFull.r),
        border: Border.all(
          color: AppTheme.primaryColor.withOpacity(0.2),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            Icons.location_city_rounded,
            size: 18.sp,
            color: AppTheme.primaryColor,
          ),
          SizedBox(width: AppTheme.spacingSm.w),
          Text(
            cityData.city,
            style: TextStyle(
              fontWeight: FontWeight.w600,
              color: AppTheme.primaryColor,
              fontSize: 14.sp,
            ),
          ),
          SizedBox(width: AppTheme.spacingSm.w),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 2.h),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor,
              borderRadius: BorderRadius.circular(AppTheme.radiusFull.r),
            ),
            child: Text(
              '${cityData.count}',
              style: TextStyle(
                color: Colors.white,
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
