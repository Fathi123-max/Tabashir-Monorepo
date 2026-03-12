import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:tabashir/core/config/animation_config.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabashir/core/theme/app_theme.dart';

/// Custom page route with magical AI-themed animations
class MagicPageRoute<T> extends PageRouteBuilder<T> {
  MagicPageRoute({
    required this.child,
    this.transitionType = MagicTransitionType.slideWithSparkles,
    this.duration = const Duration(milliseconds: 800),
    this.withParticles = true,
  }) : super(
         transitionDuration: duration,
         reverseTransitionDuration: duration,
         pageBuilder: (context, animation, secondaryAnimation) => child,
       );
  final Widget child;
  final Duration duration;
  final MagicTransitionType transitionType;
  final bool withParticles;

  @override
  Widget buildTransitions(
    BuildContext context,
    Animation<double> animation,
    Animation<double> secondaryAnimation,
    Widget child,
  ) {
    switch (transitionType) {
      case MagicTransitionType.slideWithSparkles:
        return _buildSlideWithSparkles(context, animation, child);
      case MagicTransitionType.fadeWithGlow:
        return _buildFadeWithGlow(context, animation, child);
      case MagicTransitionType.scaleWithParticles:
        return _buildScaleWithParticles(context, animation, child);
      case MagicTransitionType.morphing:
        return _buildMorphingTransition(context, animation, child);
      case MagicTransitionType.holographic:
        return _buildHolographicTransition(context, animation, child);
    }
  }

  Widget _buildSlideWithSparkles(
    BuildContext context,
    Animation<double> animation,
    Widget child,
  ) {
    final slideAnimation =
        Tween<Offset>(
          begin: const Offset(1, 0),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOutQuart,
          ),
        );

    final sparkleAnimation =
        Tween<double>(
          begin: 0,
          end: 1,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.elasticOut,
          ),
        );

    return Stack(
      children: [
        SlideTransition(
          position: slideAnimation,
          child: child,
        ),
        if (withParticles)
          _SparkleOverlay(
            animation: sparkleAnimation,
            particleCount: 20,
          ),
      ],
    );
  }

  Widget _buildFadeWithGlow(
    BuildContext context,
    Animation<double> animation,
    Widget child,
  ) {
    final fadeAnimation =
        Tween<double>(
          begin: 0,
          end: 1,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          ),
        );

    final glowAnimation =
        Tween<double>(
          begin: 0,
          end: 1,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          ),
        );

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Opacity(
        opacity: fadeAnimation.value,
        child: Transform.scale(
          scale: 0.8 + (0.2 * fadeAnimation.value),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: AppTheme.primaryColor.withOpacity(
                    AnimationConfig.glowFactor * glowAnimation.value,
                  ),
                  blurRadius: 30.w * glowAnimation.value,
                  spreadRadius: 10.w * glowAnimation.value,
                ),
              ],
            ),
            child: child,
          ),
        ),
      ),
      child: child,
    );
  }

  Widget _buildScaleWithParticles(
    BuildContext context,
    Animation<double> animation,
    Widget child,
  ) {
    final scaleAnimation =
        Tween<double>(
          begin: 0.5,
          end: 1,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.elasticOut,
          ),
        );

    final particleAnimation =
        Tween<double>(
          begin: 0,
          end: 1,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeOut,
          ),
        );

    return Stack(
      children: [
        AnimatedBuilder(
          animation: scaleAnimation,
          builder: (context, child) => Transform.scale(
            scale: scaleAnimation.value,
            child: Opacity(
              opacity: animation.value,
              child: child,
            ),
          ),
          child: child,
        ),
        if (withParticles)
          _ParticleField(
            animation: particleAnimation,
            particleCount: 15,
            color: AppTheme.primaryColor,
          ),
      ],
    );
  }

  Widget _buildMorphingTransition(
    BuildContext context,
    Animation<double> animation,
    Widget child,
  ) {
    final morphAnimation =
        Tween<double>(
          begin: 0,
          end: 1,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOutCubic,
          ),
        );

    return AnimatedBuilder(
      animation: morphAnimation,
      builder: (context, child) => Transform(
        transform: Matrix4.identity()
          ..setEntry(3, 2, 0.001)
          ..rotateY(math.pi * morphAnimation.value * 0.5),
        child: child,
      ),
      child: child,
    );
  }

  Widget _buildHolographicTransition(
    BuildContext context,
    Animation<double> animation,
    Widget child,
  ) {
    final shimmerAnimation =
        Tween<double>(
          begin: -1,
          end: 2,
        ).animate(
          CurvedAnimation(
            parent: animation,
            curve: Curves.easeInOut,
          ),
        );

    return AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Opacity(
        opacity: animation.value,
        child: ShaderMask(
          blendMode: BlendMode.srcIn,
          shaderCallback: (bounds) => LinearGradient(
            colors: [
              Colors.transparent,
              AppTheme.white.withOpacity(0.5 * animation.value),
              Colors.transparent,
            ],
            begin: Alignment(shimmerAnimation.value, 0),
            end: Alignment(-shimmerAnimation.value, 0),
          ).createShader(bounds),
          child: Transform.scale(
            scale: 0.95 + (0.05 * animation.value),
            child: child,
          ),
        ),
      ),
      child: child,
    );
  }
}

/// Overlay widget for sparkles effect
class _SparkleOverlay extends StatelessWidget {
  const _SparkleOverlay({
    required this.animation,
    required this.particleCount,
  });
  final Animation<double> animation;
  final int particleCount;

  @override
  Widget build(BuildContext context) => IgnorePointer(
    child: AnimatedBuilder(
      animation: animation,
      builder: (context, child) => Stack(
        children: List.generate(
          particleCount,
          (index) {
            final random = math.Random(index);
            final startX = random.nextDouble();
            final startY = random.nextDouble();
            final size = random.nextDouble() * 4 + 2;

            return Positioned(
              left: startX * MediaQuery.of(context).size.width,
              top: startY * MediaQuery.of(context).size.height,
              child: Transform.scale(
                scale: animation.value,
                child: Opacity(
                  opacity: animation.value,
                  child: Icon(
                    Icons.auto_awesome,
                    size: size.sp,
                    color: AppTheme.white.withOpacity(0.8),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    ),
  );
}

/// Widget for particle field animation
class _ParticleField extends StatelessWidget {
  const _ParticleField({
    required this.animation,
    required this.particleCount,
    required this.color,
  });
  final Animation<double> animation;
  final int particleCount;
  final Color color;

  @override
  Widget build(BuildContext context) => AnimatedBuilder(
    animation: animation,
    builder: (context, child) => CustomPaint(
      painter: _ParticlePainter(
        animationValue: animation.value,
        particleCount: particleCount,
        color: color,
      ),
      size: Size.infinite,
    ),
  );
}

/// Custom painter for particles
class _ParticlePainter extends CustomPainter {
  _ParticlePainter({
    required this.animationValue,
    required this.particleCount,
    required this.color,
  });
  final double animationValue;
  final int particleCount;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.6 * animationValue)
      ..style = PaintingStyle.fill;

    final random = math.Random(42);

    for (var i = 0; i < particleCount; i++) {
      final x = random.nextDouble() * size.width;
      final y = random.nextDouble() * size.height;
      final radius = (random.nextDouble() * 3 + 1) * animationValue;

      canvas.drawCircle(
        Offset(x, y),
        radius,
        paint,
      );
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) => true;
}

/// Types of magical transitions
enum MagicTransitionType {
  slideWithSparkles,
  fadeWithGlow,
  scaleWithParticles,
  morphing,
  holographic,
}

/// Helper class for magical navigation
class MagicNavigationHelper {
  /// Navigate with a magical slide transition
  static void pushSlideWithSparkles(
    BuildContext context,
    String route, {
    MagicTransitionType transitionType = MagicTransitionType.slideWithSparkles,
  }) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (context, animation, secondaryAnimation) =>
            _getRouteWidget(route, context),
        transitionsBuilder: (context, animation, secondaryAnimation, child) {
          final routeWidget = _getRouteWidget(route, context);
          final magicRoute = MagicPageRoute(
            child: routeWidget,
            transitionType: transitionType,
          );
          return magicRoute.buildTransitions(
            context,
            animation,
            secondaryAnimation,
            child,
          );
        },
      ),
    );
  }

  /// Navigate with a custom transition
  static void pushCustom(
    BuildContext context,
    Widget Function() pageBuilder, {
    MagicTransitionType transitionType = MagicTransitionType.slideWithSparkles,
  }) {
    Navigator.of(context).push(
      MagicPageRoute(
        child: pageBuilder(),
        transitionType: transitionType,
      ),
    );
  }

  static Widget _getRouteWidget(String route, BuildContext context) {
    // This is a placeholder - in real usage, you'd get the actual widget
    // For now, we'll just return a placeholder
    return ColoredBox(
      color: AppTheme.primaryColor,
      child: const Center(
        child: Text(
          'Loading...',
          style: TextStyle(color: Colors.white),
        ),
      ),
    );
  }
}
