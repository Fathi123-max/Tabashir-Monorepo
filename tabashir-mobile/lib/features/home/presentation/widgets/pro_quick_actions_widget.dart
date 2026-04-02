import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/core/router/route_names.dart';
import 'package:tabashir/features/shared/widgets/pro_badge_widget.dart';

/// Pro Quick Actions Widget
/// Premium action cards for Pro users with AI tools and priority features
class ProQuickActionsWidget extends StatelessWidget {
  const ProQuickActionsWidget({super.key});

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      // Header with Pro badge
      Padding(
        padding: EdgeInsets.symmetric(horizontal: AppTheme.spacingMd.w),
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(AppTheme.spacingSm.w),
              decoration: BoxDecoration(
                gradient: AppTheme.goldGradient,
                borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
                boxShadow: [
                  BoxShadow(
                    color: AppTheme.goldColor.withOpacity(0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Icon(
                Icons.bolt_rounded,
                size: 20.sp,
                color: Colors.white,
              ),
            ),
            SizedBox(width: AppTheme.spacingMd.w),
            Text(
              'Pro Quick Actions',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20.sp,
                  ),
            ),
            SizedBox(width: AppTheme.spacingSm.w),
            Transform.scale(
              scale: 0.6,
              child: ProBadgeWidget(
                size: ProBadgeSize.small,
                showTooltip: false,
              ),
            ),
          ],
        ),
      ),
      SizedBox(height: AppTheme.spacingMd.h),
      // Action grid
      Padding(
        padding: EdgeInsets.symmetric(horizontal: AppTheme.spacingMd.w),
        child: GridView.count(
          crossAxisCount: 2,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          mainAxisSpacing: AppTheme.spacingMd.h,
          crossAxisSpacing: AppTheme.spacingMd.w,
          childAspectRatio: 1.3,
          children: [
            // AI Resume Builder
            _ProActionCard(
              icon: Icons.smart_toy_rounded,
              label: 'AI Resume',
              subtitle: 'Build in seconds',
              gradient: AppTheme.proGradient,
              onTap: () => context.push(RouteNames.aiResumeBuilder),
            ),
            // AI Cover Letter
            _ProActionCard(
              icon: Icons.edit_note_rounded,
              label: 'Cover Letter',
              subtitle: 'AI-powered',
              gradient: AppTheme.goldGradient,
              onTap: () => context.push(RouteNames.services),
            ),
            // Priority Matches
            _ProActionCard(
              icon: Icons.star_rounded,
              label: 'Priority',
              subtitle: 'Top applicants',
              gradient: AppTheme.proGradient,
              onTap: () => context.push(RouteNames.jobs),
            ),
            // Salary Insights
            _ProActionCard(
              icon: Icons.analytics_rounded,
              label: 'Salary Info',
              subtitle: 'Market data',
              gradient: AppTheme.successGradient,
              onTap: () => context.push(RouteNames.services),
            ),
          ],
        ),
      ),
    ],
  );
}

class _ProActionCard extends StatefulWidget {
  const _ProActionCard({
    required this.icon,
    required this.label,
    required this.subtitle,
    required this.gradient,
    required this.onTap,
  });

  final IconData icon;
  final String label;
  final String subtitle;
  final LinearGradient gradient;
  final VoidCallback onTap;

  @override
  State<_ProActionCard> createState() => _ProActionCardState();
}

class _ProActionCardState extends State<_ProActionCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails details) {
    setState(() => _isPressed = true);
    _controller.forward();
  }

  void _onTapUp(TapUpDetails details) {
    setState(() => _isPressed = false);
    _controller.reverse();
  }

  void _onTapCancel() {
    setState(() => _isPressed = false);
    _controller.reverse();
  }

  @override
  Widget build(BuildContext context) => GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        onTap: widget.onTap,
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) => Transform.scale(
            scale: _scaleAnimation.value,
            child: child,
          ),
          child: Container(
            decoration: BoxDecoration(
              gradient: widget.gradient,
              borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
              boxShadow: [
                BoxShadow(
                  color: widget.gradient.colors.first.withOpacity(0.3),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Stack(
              children: [
                // Background pattern
                Positioned(
                  right: -10,
                  bottom: -10,
                  child: Icon(
                    widget.icon,
                    size: 80.sp,
                    color: Colors.white.withOpacity(0.1),
                  ),
                ),
                // Content
                Padding(
                  padding: EdgeInsets.all(AppTheme.spacingMd.w),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Icon
                      Container(
                        padding: EdgeInsets.all(AppTheme.spacingSm.w),
                        decoration: BoxDecoration(
                          color: Colors.white.withOpacity(0.2),
                          borderRadius:
                              BorderRadius.circular(AppTheme.radiusSmall.r),
                        ),
                        child: Icon(
                          widget.icon,
                          size: 24.sp,
                          color: Colors.white,
                        ),
                      ),
                      // Text
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.label,
                            style: TextStyle(
                              fontSize: 14.sp,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 2.h),
                          Text(
                            widget.subtitle,
                            style: TextStyle(
                              fontSize: 11.sp,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      );
}
