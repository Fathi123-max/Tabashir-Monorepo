import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/features/home/domain/repositories/home_repository.dart';

class HomeExploreCitiesGridWidget extends StatelessWidget {
  const HomeExploreCitiesGridWidget({
    required this.cityJobCounts,
    super.key,
  });

  final List<CityJobCount> cityJobCounts;

  @override
  Widget build(BuildContext context) {
    if (cityJobCounts.isEmpty) return const SizedBox.shrink();
    
    return Wrap(
      spacing: AppTheme.spacingMd.w,
      runSpacing: AppTheme.spacingMd.h,
      children: cityJobCounts.map((cityData) {
        return GestureDetector(
          onTap: () {
            // Encode the city name and navigate to jobs screen with filter
            // Adjust the route format based on your router's design
            context.go('/jobs?city=${Uri.encodeComponent(cityData.city)}');
          },
          child: Container(
            padding: EdgeInsets.symmetric(
              horizontal: AppTheme.spacingLg.w,
              vertical: AppTheme.spacingMd.h,
            ),
            decoration: BoxDecoration(
              color: AppTheme.primaryColor.withOpacity(0.05),
              borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
              border: Border.all(
                color: AppTheme.primaryColor.withOpacity(0.2),
              ),
            ),
            child: Row(
               mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.location_city, size: 16.sp, color: AppTheme.primaryColor),
                SizedBox(width: AppTheme.spacingSm.w),
                Text(
                  cityData.city,
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: AppTheme.primaryColor,
                  ),
                ),
                SizedBox(width: AppTheme.spacingSm.w),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 6.w, vertical: 2.h),
                  decoration: BoxDecoration(
                    color: AppTheme.primaryColor,
                    borderRadius: BorderRadius.circular(10.r),
                  ),
                  child: Text(
                    '${cityData.count}',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 10.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
