import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../core/theme/app_theme.dart';
import '../cubit/home_cubit.dart';
import '../cubit/home_state.dart';
import 'home_stat_card_widget.dart';

class HomeStatsCardsRowWidget extends StatelessWidget {
  const HomeStatsCardsRowWidget({super.key});

  @override
  Widget build(BuildContext context) => BlocBuilder<HomeCubit, HomeState>(
    builder: (context, state) => SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      padding: EdgeInsets.symmetric(horizontal: AppTheme.spacingMd.w),
      child: Row(
        children: [
          HomeStatCardWidget(
            value: state.matchedJobsList.length.toString(),
            label: 'ai_matches'.tr(),
          ),
          SizedBox(width: AppTheme.spacingSm.w),
          HomeStatCardWidget(
            value: state.totalApplications.toString(),
            label: 'applied_jobs'.tr(),
          ),
        ],
      ),
    ),
  );
}
