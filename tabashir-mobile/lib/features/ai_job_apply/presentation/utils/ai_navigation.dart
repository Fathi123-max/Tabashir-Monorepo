import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/core/config/animation_config.dart';

/// Navigation modes for AI-themed transitions
enum AiNavigationMode {
  /// Magical slide with sparkles (default)
  magical,

  /// Fade with glowing effect
  fadeGlow,

  /// Scale with particle effects
  particleScale,

  /// 3D morphing transition
  morph,

  /// Holographic shimmer effect
  holographic,
}

/// Enhanced navigator with magical transitions
class AiNavigator {
  /// Navigate with the specified navigation mode
  static Future<void> navigate(
    BuildContext context,
    String location, {
    AiNavigationMode mode = AiNavigationMode.magical,
    Object? extra,
  }) async {
    // Add a slight delay to allow animations to trigger
    await Future.delayed(AnimationConfig.navigationDelay);

    // Add magical overlay before navigation
    _showTransitionOverlay(context, mode);

    // Perform navigation with the delay to show animation
    Future.delayed(AnimationConfig.transitionDelay, () {
      if (context.mounted) {
        context.go(location, extra: extra);
      }
    });
  }

  /// Push a new route with magical transition
  static Future<void> push(
    BuildContext context,
    String location, {
    AiNavigationMode mode = AiNavigationMode.magical,
    Object? extra,
  }) async {
    await Future.delayed(AnimationConfig.navigationDelay);
    _showTransitionOverlay(context, mode);
    Future.delayed(AnimationConfig.transitionDelay, () {
      if (context.mounted) {
        context.push(location, extra: extra);
      }
    });
  }

  /// Show transition overlay with the specified mode
  static void _showTransitionOverlay(
    BuildContext context,
    AiNavigationMode mode,
  ) {
    final overlay = Overlay.of(context);
    final animationController = AnimationController(
      duration: AnimationConfig.transitionDuration,
      vsync: Navigator.of(context),
    );

    final animation =
        Tween<double>(
          begin: 0,
          end: 1,
        ).animate(
          CurvedAnimation(
            parent: animationController,
            curve: Curves.easeInOut,
          ),
        );

    final overlayEntry = OverlayEntry(
      builder: (context) => AnimatedBuilder(
        animation: animation,
        builder: (context, child) => AnimatedBuilder(
          animation: animation,
          builder: (context, child) => Stack(
            children: [
              // Transition particles
              _buildParticles(context, animation, mode),
              // Gradient overlay
              _buildGradientOverlay(context, animation),
              // Sparkle effects
              if (mode == AiNavigationMode.magical)
                _buildSparkles(context, animation),
            ],
          ),
        ),
      ),
    );

    overlay.insert(overlayEntry);
    animationController.forward();

    // Remove overlay after animation
    Future.delayed(AnimationConfig.nextAnimationDelay, () {
      animationController.reverse().then((_) {
        overlayEntry.remove();
      });
    });
  }

  /// Build particles based on the navigation mode
  static Widget _buildParticles(
    BuildContext context,
    Animation<double> animation,
    AiNavigationMode mode,
  ) {
    final particleCount = mode == AiNavigationMode.particleScale ? 25 : 15;
    final color = mode == AiNavigationMode.fadeGlow
        ? AppTheme.primaryColor
        : AppTheme.white.withOpacity(0.6);

    return CustomPaint(
      painter: _ParticlePainter(
        animationValue: animation.value,
        particleCount: particleCount,
        color: color,
        mode: mode,
      ),
      size: Size.infinite,
    );
  }

  /// Build gradient overlay
  static Widget _buildGradientOverlay(
    BuildContext context,
    Animation<double> animation,
  ) => IgnorePointer(
    child: Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryColor.withOpacity(0.3 * animation.value),
            AppTheme.blue900.withOpacity(0.5 * animation.value),
            AppTheme.primaryColor.withOpacity(0.3 * animation.value),
          ],
        ),
      ),
    ),
  );

  /// Build sparkle effects for magical mode
  static Widget _buildSparkles(
    BuildContext context,
    Animation<double> animation,
  ) {
    final random = math.Random(42);

    return IgnorePointer(
      child: Stack(
        children: List.generate(20, (index) {
          final startX = random.nextDouble();
          final startY = random.nextDouble();
          final delay = random.nextDouble() * 0.3;

          return AnimatedBuilder(
            animation: animation,
            builder: (context, child) {
              final delayAnimation =
                  Tween<double>(
                    begin: 0,
                    end: math.max(0, animation.value - delay) * 1.3,
                  ).animate(
                    CurvedAnimation(
                      parent: animation,
                      curve: Curves.elasticOut,
                    ),
                  );

              final opacityValue = delayAnimation.value.clamp(0.0, 1.0);

              return Positioned(
                left: startX * MediaQuery.of(context).size.width,
                top: startY * MediaQuery.of(context).size.height,
                child: Transform.scale(
                  scale: opacityValue,
                  child: Opacity(
                    opacity: opacityValue,
                    child: Icon(
                      Icons.auto_awesome,
                      size: 20.sp,
                      color: AppTheme.white.withOpacity(0.9),
                    ),
                  ),
                ),
              );
            },
          );
        }),
      ),
    );
  }
}

/// Custom painter for particles
class _ParticlePainter extends CustomPainter {
  _ParticlePainter({
    required this.animationValue,
    required this.particleCount,
    required this.color,
    required this.mode,
  });
  final double animationValue;
  final int particleCount;
  final Color color;
  final AiNavigationMode mode;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color.withOpacity(0.8 * _easeOutQuart(animationValue))
      ..style = PaintingStyle.fill;

    final random = math.Random(42);

    for (var i = 0; i < particleCount; i++) {
      final angle = (i / particleCount) * 2 * math.pi;
      final radius = 50.w * animationValue;
      final x = size.width / 2 + math.cos(angle) * radius;
      final y = size.height / 2 + math.sin(angle) * radius;

      final particleRadius =
          _getParticleSize(i) * _easeOutQuart(animationValue);

      canvas.drawCircle(
        Offset(x, y),
        particleRadius,
        paint,
      );

      // Draw stars for magical mode
      if (mode == AiNavigationMode.magical && i % 3 == 0) {
        _drawStar(canvas, Offset(x, y), particleRadius * 1.5, paint);
      }
    }
  }

  void _drawStar(Canvas canvas, Offset center, double radius, Paint paint) {
    if (animationValue <= 0) return;

    final colorWithOpacity = (AppTheme.yellow500 ?? Colors.amber).withOpacity(
      AnimationConfig.animationFactor * animationValue,
    );
    final starPaint = Paint()
      ..color = colorWithOpacity
      ..style = PaintingStyle.fill;

    final path = Path();
    const points = AnimationConfig.aiJobApplySteps;

    for (var i = 0; i < points * 2; i++) {
      final angle = (i * math.pi) / points;
      final r = i % 2 == 0 ? radius : radius / 2;
      final x = center.dx + math.cos(angle) * r;
      final y = center.dy + math.sin(angle) * r;

      if (i == 0) {
        path.moveTo(x, y);
      } else {
        path.lineTo(x, y);
      }
    }
    path.close();

    canvas.drawPath(path, starPaint);
  }

  double _getParticleSize(int index) {
    if (mode == AiNavigationMode.particleScale) {
      return (index % 3 + 1) * 1.5;
    }
    return (index % 2 + 1) * 1.0;
  }

  double _easeOutQuart(double t) => 1 - (--t) * t * t * t;

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) =>
      oldDelegate.animationValue != animationValue ||
      oldDelegate.particleCount != particleCount ||
      oldDelegate.color != color ||
      oldDelegate.mode != mode;
}

/// Extension to add magical navigation to BuildContext
extension AiNavigationExtension on BuildContext {
  /// Navigate with magical slide transition
  void aiPush(
    String location, {
    AiNavigationMode mode = AiNavigationMode.magical,
  }) {
    AiNavigator.push(this, location, mode: mode);
  }

  /// Go with magical transition
  void aiGo(
    String location, {
    AiNavigationMode mode = AiNavigationMode.magical,
  }) {
    AiNavigator.navigate(this, location, mode: mode);
  }
}
