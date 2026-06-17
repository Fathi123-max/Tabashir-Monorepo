import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/utils/app_logger.dart';
import 'home_quick_action_card_widget.dart';

class HomeQuickActionsGridWidget extends StatelessWidget {
  const HomeQuickActionsGridWidget({super.key});

  @override
  Widget build(BuildContext context) => GridView.count(
    crossAxisCount: 2,
    shrinkWrap: true,
    physics: const NeverScrollableScrollPhysics(),
    mainAxisSpacing: AppTheme.spacingMd.h,
    crossAxisSpacing: AppTheme.spacingMd.w,
    children: [
      // Saved Jobs
      HomeQuickActionCardWidget(
        icon: Icons.bookmark_outline_rounded,
        label: 'Saved Jobs'.tr(),
        onTap: () {
          AppLogger.debug(
            '[QUICK_ACTIONS] Navigate to Saved Jobs',
            tag: 'Home',
          );
          context.push(RouteNames.savedJobs);
        },
      ),
      // AI Services
      HomeQuickActionCardWidget(
        icon: Icons.auto_awesome_rounded,
        label: 'AI Services'.tr(),
        onTap: () {
          AppLogger.debug('[QUICK_ACTIONS] Navigate to Services', tag: 'Home');
          context.push(RouteNames.services);
        },
      ),
    ],
  );
}
