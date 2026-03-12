import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/features/jobs/presentation/cubit/saved_jobs_cubit.dart';
import 'package:tabashir/features/jobs/presentation/widgets/card_style_option.dart';

class SavedJobsControls extends StatelessWidget {
  const SavedJobsControls({
    required this.cardStyle,
    required this.isGridView,
    super.key,
  });

  final String cardStyle;
  final bool isGridView;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: AppTheme.spacingMd.w,
        vertical: AppTheme.spacingSm.h,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // Card Style Toggle
          Expanded(
            child: Row(
              children: [
                CardStyleOption(
                  label: 'Standard',
                  isSelected: cardStyle == 'standard',
                  onTap: () {
                    context.read<SavedJobsCubit>().updateCardStyle('standard');
                  },
                ),
                SizedBox(width: AppTheme.spacingSm.w),
                CardStyleOption(
                  label: 'Minimal',
                  isSelected: cardStyle == 'minimal',
                  onTap: () {
                    context.read<SavedJobsCubit>().updateCardStyle('minimal');
                  },
                ),
              ],
            ),
          ),

          // View Toggle
          Row(
            children: [
              Container(
                width: 40.w,
                height: 40.w,
                decoration: BoxDecoration(
                  color: isGridView
                      ? theme.inputDecorationTheme.fillColor
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(
                    AppTheme.radiusDefault.r,
                  ),
                ),
                child: IconButton(
                  onPressed: () {
                    context.read<SavedJobsCubit>().setGridView();
                  },
                  icon: Icon(
                    Icons.grid_view,
                    color: isGridView
                        ? theme.iconTheme.color
                        : theme.colorScheme.onSurfaceVariant,
                    size: 20.sp,
                  ),
                  padding: EdgeInsets.zero,
                ),
              ),
              SizedBox(width: AppTheme.spacingSm.w),
              SizedBox(
                width: 40.w,
                height: 40.w,
                child: IconButton(
                  onPressed: () {
                    context.read<SavedJobsCubit>().setListView();
                  },
                  icon: Icon(
                    Icons.view_list,
                    color: !isGridView
                        ? theme.iconTheme.color
                        : theme.colorScheme.onSurfaceVariant,
                    size: 20.sp,
                  ),
                  padding: EdgeInsets.zero,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
