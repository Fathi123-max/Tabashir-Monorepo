import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/core/services/auth_session_service.dart';
import 'package:tabashir/core/services/google_signin_service.dart';
import 'package:tabashir/core/services/apple_signin_service.dart';

import '../../../../core/router/route_names.dart';
import '../../../../core/theme/app_theme.dart';
import '../cubit/auth_cubit.dart';
import '../widgets/ai_assistant_widget.dart';
import '../widgets/forgot_password_link_widget.dart';
import '../widgets/login_email_field_widget.dart';
import '../widgets/login_header_widget.dart';
import '../widgets/login_password_field_widget.dart';
import '../widgets/login_signin_button_widget.dart';
import '../widgets/signup_divider_widget.dart';
import '../widgets/signup_link_widget.dart';
import '../widgets/social_login_button.dart';

/// Login screen for Tabashir application
/// Path: lib/features/auth/presentation/screens/login_screen.dart
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

    // Pre-fill with test credentials for testing purposes
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

    // Validate input
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

      // Check the state after login
      final state = _authCubit.state;
      if (state.status == AuthStatus.loginSuccess) {
        // Token is already set in AuthCubit, just navigate to main app
        if (mounted) {
          context.go('/');
        }
      } else if (state.status == AuthStatus.error) {
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

  void _showMessage(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: AppTheme.errorColor,
        duration: const Duration(seconds: 3),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;

    return BlocProvider.value(
      value: _authCubit,
      child: Scaffold(
        backgroundColor: colorScheme.surface,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: AppTheme.spacingMd.w,
                vertical: AppTheme.spacingXl.h,
              ),
              child: ConstrainedBox(
                constraints: BoxConstraints(maxWidth: 448.w),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    // Header Section
                    const LoginHeaderWidget(),
                    SizedBox(height: AppTheme.spacingLg.h),

                    // Social Login Buttons
                    // TO ACTIVATE: Uncomment the code below and import GoogleSignInService
                    SocialLoginButton(
                      platform: SocialPlatform.google,
                      text: 'Sign in with Google'.tr(),
                      onPressed: () async {
                        try {
                          final idToken = await getIt<GoogleSignInService>()
                              .signIn();
                          await AuthSessionService.instance.setLoggedIn(
                            token: idToken,
                          );
                          if (mounted) context.go('/');
                        } catch (e) {
                          _showMessage('Google sign-in failed: $e');
                        }
                      },
                      useAppTheme: false, // Use login-specific styling
                    ),
                    SizedBox(height: AppTheme.spacingSm.h),
                    // Apple Sign-In configured for production
                    // Uses ae.tabashir bundle ID with custom backend API
                    SocialLoginButton(
                      platform: SocialPlatform.apple,
                      text: 'Sign in with Apple'.tr(),
                      onPressed: () async {
                        try {
                          await AppleSignInService.instance.signIn();
                          // Backend verification complete, JWT stored in AuthSessionService
                          if (mounted) {
                            context.go('/');
                          }
                        } catch (e) {
                          _showMessage('Apple sign-in failed: $e');
                        }
                      },
                      useAppTheme: false, // Use login-specific styling
                    ),
                    SizedBox(height: AppTheme.spacingLg.h),

                    // Divider with 'or'.tr() text
                    const SignupDividerWidget(),
                    SizedBox(height: AppTheme.spacingLg.h),

                    // Email Input
                    LoginEmailFieldWidget(
                      controller: _emailController,
                    ),
                    SizedBox(height: AppTheme.spacingMd.h),

                    // Password Input
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

                    // Forgot Password Link
                    ForgotPasswordLinkWidget(
                      onPressed: () {
                        // Navigate to forgot password
                      },
                    ),
                    SizedBox(height: AppTheme.spacingMd.h),

                    // Sign In Button
                    BlocBuilder<AuthCubit, AuthState>(
                      builder: (context, state) {
                        final isLoading = state.status == AuthStatus.loading;
                        return LoginSigninButtonWidget(
                          onPressed: isLoading ? null : _handleSignIn,
                          isLoading: isLoading,
                        );
                      },
                    ),
                    SizedBox(height: AppTheme.spacingMd.h),

                    // AI Assistant Info Banner
                    AIAssistantWidget(
                      message:
                          'Your AI assistant is ready to resume your job search.'
                              .tr(),
                      useAppTheme: false, // Use login-specific styling
                    ),
                    SizedBox(height: AppTheme.spacingLg.h),

                    // Sign Up Link
                    SignupLinkWidget(
                      onTap: () {
                        context.pushReplacement(RouteNames.register);
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
