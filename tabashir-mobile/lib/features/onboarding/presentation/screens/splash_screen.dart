import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _initAnimations();
    _navigate();
  }

  void _initAnimations() {
    _controller = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _fadeAnimation =
        Tween<double>(
          begin: 0,
          end: 1,
        ).animate(
          CurvedAnimation(
            parent: _controller,
            curve: const Interval(0.5, 1, curve: Curves.easeOut),
          ),
        );

    _controller.forward();
  }

  Future<void> _navigate() async {
    // Simulate a small delay for the splash screen animations
    await Future.delayed(const Duration(seconds: 2));

    // Let the router's redirect logic handle navigation
    // The router will check authentication and redirect appropriately
    context.go('/');
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    backgroundColor: const Color(
      0xFFFFFFFF,
    ), // background-light: '#ffffff'.tr()
    body: Container(
      width: double.infinity,
      height: double.infinity,
      decoration: const BoxDecoration(
        color: Color(0xFFFFFFFF), // background-light: '#ffffff'.tr()
      ),
      child: Center(
        child: AnimatedBuilder(
          animation: _controller,
          builder: (context, child) => Container(
            padding: const EdgeInsets.all(16),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Main title with gradient
                _buildTitle(),
                const SizedBox(height: 12),
                // Subtitle text
                FadeTransition(
                  opacity: _fadeAnimation,
                  child: Text(
                    'Your AI job assistant for the Middle East'.tr(),
                    style: const TextStyle(
                      color: Color(0xFF6B7280), // text color from HTML
                      fontSize: 16,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ),
  );

  Widget _buildTitle() => ShaderMask(
    blendMode: BlendMode.srcIn,
    shaderCallback: (bounds) => const LinearGradient(
      colors: [
        Color(0xFF042052), // gradient-start: '#042052'.tr()
        Color(0xFF0D57E1), // gradient-end: '#0D57E1'.tr()
      ],
    ).createShader(bounds),
    child: Text(
      'Tabashir'.tr(),
      style: const TextStyle(
        fontSize: 28,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
  );
}
