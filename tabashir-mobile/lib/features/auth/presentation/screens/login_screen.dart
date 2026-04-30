import 'dart:async';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';
import 'package:flutter/services.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/core/services/google_signin_service.dart';
import 'package:tabashir/core/services/apple_signin_service.dart';

import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_theme.dart';
import '../cubit/auth_cubit.dart';
import '../widgets/login_header_widget.dart';
import '../widgets/login_email_field_widget.dart';
import '../widgets/login_password_field_widget.dart';
import '../widgets/login_signin_button_widget.dart';
import '../widgets/signup_divider_widget.dart';
import '../widgets/signup_link_widget.dart';
import '../widgets/social_login_button.dart';
import '../widgets/ai_assistant_widget.dart';

/// Login screen for Tabashir application
class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late final AuthCubit _authCubit;

  @override
  void initState() {
    super.initState();
    _authCubit = getIt<AuthCubit>();
    _emailController.text = 'profiletest@tabashir.com';
    _passwordController.text = 'password123';
  }

  @override
  void dispose() {
    _authCubit.close();
    super.dispose();
  }

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _isPasswordVisible = false;

  Future<void> _handleSignIn() async {
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _showMessage('Please fill in all fields'.tr());
      return;
    }

    if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(email)) {
      _showMessage('Please enter a valid email address'.tr());
      return;
    }

    try {
      await _authCubit.login(email: email, password: password);
      final state = _authCubit.state;
      if (state.status == AuthStatus.error) {
        _showMessage(
          state.errorMessage.isNotEmpty
              ? state.errorMessage
              : 'Login failed. Please try again.'.tr(),
        );
      }
    } catch (e) {
      _showMessage('Login failed: $e'.tr());
    }
  }

  void _showMessage(String message, {bool isError = true}) {
    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? AppTheme.errorColor : AppTheme.primaryColor,
        duration: const Duration(seconds: 3),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium.r),
        ),
        margin: EdgeInsets.all(AppTheme.spacingMd.w),
      ),
    );
  }

  /// Handles errors from social sign-in providers
  /// Distinguishes between user cancellation and actual errors
  void _handleSocialSignInError(Object error, String provider) {
    // Don't show error message for user cancellations
    if (_isUserCancellation(error, provider)) {
      // Silently ignore - user chose to cancel
      return;
    }

    // Show user-friendly error message for actual errors
    final message = _getFriendlyErrorMessage(error, provider);
    _showMessage(message);
  }

  /// Check if the error is due to user cancelling the auth dialog
  bool _isUserCancellation(Object error, String provider) {
    // Apple Sign-In cancellation
    if (error is AuthorizationErrorCode) {
      return true;
    }

    // Google Sign-In cancellation (PlatformException with specific code)
    final errorString = error.toString().toLowerCase();
    if (errorString.contains('sign_in_canceled') ||
        errorString.contains('cancelled') ||
        errorString.contains('canceled') ||
        errorString.contains('12501')) {
      // Google Sign-In cancel code
      return true;
    }

    return false;
  }

  /// Get a user-friendly error message
  String _getFriendlyErrorMessage(Object error, String provider) {
    final errorString = error.toString();

    // Network errors
    if (errorString.contains('socket') ||
        errorString.contains('network') ||
        errorString.contains('connection')) {
      return 'Unable to connect. Please check your internet connection.'.tr();
    }

    // Account errors
    if (errorString.contains('no account')) {
      return 'No $provider account found. Please try another sign-in method.'
          .tr();
    }

    // Permission errors
    if (errorString.contains('permission') ||
        errorString.contains('access denied')) {
      return '$provider permission denied. Please enable permissions in settings.'
          .tr();
    }

    // Generic error with provider name
    return 'Unable to sign in with $provider. Please try again.'.tr();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Ensure system navigation bar is transparent for better aesthetics
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.transparent,
        systemNavigationBarIconBrightness: theme.brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark,
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: theme.brightness == Brightness.dark
            ? Brightness.light
            : Brightness.dark,
      ),
    );

    return BlocProvider.value(
      value: _authCubit,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.primaryColor.withOpacity(0.12),
                AppTheme.primaryColor.withOpacity(0.04),
                theme.scaffoldBackgroundColor,
              ],
              stops: const [0.0, 0.4, 1.0],
            ),
          ),
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                    minHeight: constraints.maxHeight,
                  ),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingLg.w,
                      vertical: AppTheme.spacingMd.h,
                    ),
                    child: Center(
                      child: ConstrainedBox(
                        constraints: BoxConstraints(maxWidth: 448.w),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            // Compact Header
                            SizedBox(height: AppTheme.spacingMd.h),
                            const LoginHeaderWidget(),
                            SizedBox(height: AppTheme.spacingLg.h),

                            // Social Login - Compact
                            SocialLoginButton(
                              platform: SocialPlatform.google,
                              text: 'Sign in with Google'.tr(),
                              onPressed: () async {
                                try {
                                  await getIt<GoogleSignInService>().signIn();
                                  // Success - router will handle navigation
                                } catch (e) {
                                  _handleSocialSignInError(e, 'Google');
                                }
                              },
                              useAppTheme: false,
                            ),
                            if (theme.platform == TargetPlatform.iOS) ...[
                              SizedBox(height: AppTheme.spacingSm.h),
                              SocialLoginButton(
                                platform: SocialPlatform.apple,
                                text: 'Sign in with Apple'.tr(),
                                onPressed: () async {
                                  try {
                                    await AppleSignInService.instance.signIn();
                                    // Success - router will handle navigation
                                  } catch (e) {
                                    _handleSocialSignInError(e, 'Apple');
                                  }
                                },
                                useAppTheme: false,
                              ),
                            ],
                            SizedBox(height: AppTheme.spacingMd.h),

                            // Divider
                            const SignupDividerWidget(),
                            SizedBox(height: AppTheme.spacingMd.h),

                            // Form Fields
                            LoginEmailFieldWidget(
                              controller: _emailController,
                            ),
                            SizedBox(height: AppTheme.spacingSm.h),
                            LoginPasswordFieldWidget(
                              controller: _passwordController,
                              isPasswordVisible: _isPasswordVisible,
                              onTogglePasswordVisibility: (isVisible) {
                                setState(() {
                                  _isPasswordVisible = isVisible;
                                });
                              },
                            ),
                            SizedBox(height: AppTheme.spacingMd.h),

                            // Sign In Button
                            BlocBuilder<AuthCubit, AuthState>(
                              builder: (context, state) {
                                final isLoading =
                                    state.status == AuthStatus.loading;
                                return LoginSigninButtonWidget(
                                  onPressed: isLoading ? null : _handleSignIn,
                                  isLoading: isLoading,
                                );
                              },
                            ),
                            SizedBox(height: AppTheme.spacingSm.h),

                            // AI Assistant - Compact
                            AIAssistantWidget(
                              message:
                                  'Your AI assistant is ready to resume your job search.'
                                      .tr(),
                              useAppTheme: false,
                            ),
                            SizedBox(height: AppTheme.spacingMd.h),

                            // Sign Up Link - Always visible at bottom
                            SignupLinkWidget(
                              onTap: () {
                                context.pushReplacement(RouteNames.register);
                              },
                            ),
                            SizedBox(height: AppTheme.spacingMd.h),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
