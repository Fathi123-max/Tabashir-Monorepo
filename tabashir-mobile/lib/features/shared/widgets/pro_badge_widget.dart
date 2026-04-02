import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabashir/core/theme/app_theme.dart';

/// Pro Badge Widget with shimmer animation
/// Displays a premium badge for Pro users with golden crown icon
class ProBadgeWidget extends StatefulWidget {
  const ProBadgeWidget({
    super.key,
    this.size = ProBadgeSize.medium,
    this.showTooltip = true,
    this.onTap,
  });

  final ProBadgeSize size;
  final bool showTooltip;
  final VoidCallback? onTap;

  @override
  State<ProBadgeWidget> createState() => _ProBadgeWidgetState();
}

enum ProBadgeSize { small, medium, large }

class _ProBadgeWidgetState extends State<ProBadgeWidget>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _shimmerAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _shimmerAnimation = Tween<double>(begin: -1, end: 2).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
    _controller.repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = _getSize();
    final iconSize = _getIconSize();

    return GestureDetector(
      onTap: widget.onTap,
      child: widget.showTooltip
          ? Tooltip(
              message: 'Pro Member - Unlock premium features',
              preferBelow: false,
              child: _buildBadge(size, iconSize),
            )
          : _buildBadge(size, iconSize),
    );
  }

  Widget _buildBadge(double size, double iconSize) => AnimatedBuilder(
        animation: _shimmerAnimation,
        builder: (context, child) => Container(
          width: size,
          height: size * 0.75,
          decoration: BoxDecoration(
            gradient: AppTheme.goldGradient,
            borderRadius: BorderRadius.circular(size * 0.25),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppTheme.goldColor.withOpacity(0.4),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
              BoxShadow(
                color: Colors.white.withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, -2),
              ),
            ],
          ),
          child: Stack(
            children: [
              // Shimmer effect overlay
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(size * 0.25),
                  child: Transform.translate(
                    offset: Offset(_shimmerAnimation.value * size, 0),
                    child: Container(
                      decoration: BoxDecoration(
                        gradient: AppTheme.shimmerGradient,
                      ),
                    ),
                  ),
                ),
              ),
              // Crown icon and PRO text
              Center(
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      Icons.workspace_premium_rounded,
                      size: iconSize,
                      color: Colors.white,
                    ),
                    if (widget.size != ProBadgeSize.small) ...[
                      SizedBox(width: size * 0.1),
                      Text(
                        'PRO',
                        style: TextStyle(
                          fontSize: iconSize * 0.9,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                          letterSpacing: 1,
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        ),
      );

  double _getSize() {
    switch (widget.size) {
      case ProBadgeSize.small:
        return 40.w;
      case ProBadgeSize.medium:
        return 64.w;
      case ProBadgeSize.large:
        return 96.w;
    }
  }

  double _getIconSize() {
    switch (widget.size) {
      case ProBadgeSize.small:
        return 16.sp;
      case ProBadgeSize.medium:
        return 24.sp;
      case ProBadgeSize.large:
        return 36.sp;
    }
  }
}
