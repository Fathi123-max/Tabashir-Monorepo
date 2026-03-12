import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/core/services/auth_session_service.dart';
import 'package:tabashir/core/services/google_signin_service.dart';
import 'package:tabashir/core/services/apple_signin_service.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/router/route_names.dart';
import '../cubit/auth_cubit.dart';
import '../widgets/ai_assistant_widget.dart';
import '../widgets/create_account_button_widget.dart';
import '../widgets/signin_link_widget.dart';
import '../widgets/social_login_button.dart';
import '../widgets/signup_divider_widget.dart';
import '../widgets/signup_header_widget.dart';
import '../widgets/signup_text_field_widget.dart';
import '../widgets/terms_checkbox_widget.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  late final AuthCubit _authCubit;
  final _random = Random();

  static const _dummyFirstNames = [
    'John',
    'Jane',
    'Alex',
    'Maria',
    'Chris',
    'Nadia',
    'Omar',
    'Sara',
    'Leo',
    'Layla',
  ];

  static const _dummyLastNames = [
    'Doe',
    'Smith',
    'Johnson',
    'Hassan',
    'Williams',
    'Brown',
    'Khan',
    'Ibrahim',
    'Martinez',
    'Chen',
  ];

  static const _dummyEmailDomains = [
    'example.com',
    'mail.com',
    'test.dev',
    'demo.io',
  ];

  static const _dummyPasswordSpecials = ['!', '@', '#', r'$'];

  @override
  void initState() {
    super.initState();
    _authCubit = getIt<AuthCubit>();
  }

  final _formKey = GlobalKey<FormState>();
  final _fullNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _agreedToTerms = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _authCubit.close();
    super.dispose();
  }

  String _generateDummyFullName() {
    final firstName =
        _dummyFirstNames[_random.nextInt(_dummyFirstNames.length)];
    final lastName = _dummyLastNames[_random.nextInt(_dummyLastNames.length)];
    return '$firstName $lastName';
  }

  String _generateDummyEmail(String fullName) {
    final base = fullName
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z ]'), '')
        .trim()
        .replaceAll(' ', '.');
    final suffix = 10 + _random.nextInt(90);
    final domain =
        _dummyEmailDomains[_random.nextInt(_dummyEmailDomains.length)];
    return '$base$suffix@$domain';
  }

  String _generateDummyPassword() {
    final number = 1000 + _random.nextInt(9000);
    final special =
        _dummyPasswordSpecials[_random.nextInt(_dummyPasswordSpecials.length)];
    final letters = String.fromCharCodes(
      List.generate(
        4,
        (_) => _random.nextBool()
            ? 65 + _random.nextInt(26)
            : 97 + _random.nextInt(26),
      ),
    );
    return 'Pa$letters$number$special';
  }

  Future<void> _createAccount() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    if (!_agreedToTerms) {
      _showMessage('Please agree to the terms and conditions'.tr());
      return;
    }

    final name = _fullNameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    try {
      await _authCubit.register(
        name: name,
        email: email,
        password: password,
      );

      final state = _authCubit.state;
      if (state.status == AuthStatus.registerSuccess) {
        // Verify user is properly authenticated before navigating
        final isAuthenticated =
            await AuthSessionService.instance.isAuthenticated;
        if (isAuthenticated) {
          // Navigate to resume import screen for new users
          if (mounted) {
            context.go(RouteNames.resumeImport);
          }
        } else {
          // If user is not authenticated, show error message
          _showMessage(
            'Authentication failed after registration. Please try logging in.'
                .tr(),
          );
        }
      } else if (state.status == AuthStatus.error) {
        _showMessage(
          state.errorMessage.isNotEmpty
              ? state.errorMessage
              : 'Registration failed. Please try again.'.tr(),
        );
      }
    } catch (e) {
      _showMessage('Registration failed: $e'.tr());
    }
  }

  void _fillDummyData() {
    final fullName = _generateDummyFullName();
    final email = _generateDummyEmail(fullName);
    final password = _generateDummyPassword();

    setState(() {
      _fullNameController.text = fullName;
      _emailController.text = email;
      _passwordController.text = password;
      _confirmPasswordController.text = password;
      _agreedToTerms = true;
    });

    // Re-run validation to show immediate feedback with the dummy data
    _formKey.currentState?.validate();
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

    return BlocProvider.value(
      value: _authCubit,
      child: Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(
                horizontal: AppTheme.spacingMd.w,
                vertical: AppTheme.spacingXl.h,
              ),
              child: Container(
                constraints: BoxConstraints(maxWidth: 448.w),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      // Header
                      const SignupHeaderWidget(),
                      SizedBox(height: AppTheme.spacingLg.h),

                      // Social Login Buttons
                      // TO ACTIVATE: Uncomment the code below and import GoogleSignInService
                      SocialLoginButton(
                        platform: SocialPlatform.google,
                        text: 'Sign up with Google'.tr(),
                        onPressed: () async {
                          try {
                            final idToken = await getIt<GoogleSignInService>()
                                .signIn();
                            await AuthSessionService.instance.setLoggedIn(
                              token: idToken,
                            );
                            if (mounted) context.go('/');
                          } catch (e) {
                            _showMessage('Google sign-up failed: $e');
                          }
                        },
                      ),
                      SizedBox(height: AppTheme.spacingSm.h),
                      // Apple Sign-In configured for production
                      // Uses ae.tabashir bundle ID with custom backend API
                      SocialLoginButton(
                        platform: SocialPlatform.apple,
                        text: 'Sign up with Apple'.tr(),
                        onPressed: () async {
                          try {
                            await AppleSignInService.instance.signIn();
                            // Backend verification complete, JWT stored in AuthSessionService
                            // Navigate to resume import for new users to upload and parse CV
                            if (mounted) {
                              context.go(RouteNames.resumeImport);
                            }
                          } catch (e) {
                            _showMessage('Apple sign-up failed: $e');
                          }
                        },
                      ),
                      SizedBox(height: AppTheme.spacingLg.h),

                      // Divider
                      const SignupDividerWidget(),
                      SizedBox(height: AppTheme.spacingLg.h),

                      // Form Fields
                      SignupTextFieldWidget(
                        controller: _fullNameController,
                        hintText: 'Full Name'.tr(),
                        keyboardType: TextInputType.name,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your full name'.tr();
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: AppTheme.spacingMd.h),

                      SignupTextFieldWidget(
                        controller: _emailController,
                        hintText: 'Email'.tr(),
                        keyboardType: TextInputType.emailAddress,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter your email'.tr();
                          }
                          if (!RegExp(
                            r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$'.tr(),
                          ).hasMatch(value)) {
                            return 'Please enter a valid email'.tr();
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: AppTheme.spacingMd.h),

                      SignupTextFieldWidget(
                        controller: _passwordController,
                        hintText: 'Password'.tr(),
                        obscureText: _obscurePassword,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscurePassword = !_obscurePassword;
                            });
                          },
                          icon: Icon(
                            _obscurePassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: theme.colorScheme.onSurfaceVariant,
                            size: 20.sp,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please enter a password'.tr();
                          }
                          if (value.length < 8) {
                            return 'Password must be at least 8 characters'
                                .tr();
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: AppTheme.spacingXs.h),
                      Padding(
                        padding: EdgeInsets.only(left: AppTheme.spacingSm.w),
                        child: Text(
                          'At least 8 characters'.tr(),
                          style: theme.textTheme.bodySmall?.copyWith(
                            fontSize: 11.sp,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                      SizedBox(height: AppTheme.spacingMd.h),

                      SignupTextFieldWidget(
                        controller: _confirmPasswordController,
                        hintText: 'Confirm Password'.tr(),
                        obscureText: _obscureConfirmPassword,
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _obscureConfirmPassword =
                                  !_obscureConfirmPassword;
                            });
                          },
                          icon: Icon(
                            _obscureConfirmPassword
                                ? Icons.visibility_outlined
                                : Icons.visibility_off_outlined,
                            color: theme.colorScheme.onSurfaceVariant,
                            size: 20.sp,
                          ),
                        ),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Please confirm your password'.tr();
                          }
                          if (value != _passwordController.text) {
                            return 'Passwords do not match'.tr();
                          }
                          return null;
                        },
                      ),
                      SizedBox(height: AppTheme.spacingMd.h),

                      // Terms Checkbox
                      TermsCheckboxWidget(
                        value: _agreedToTerms,
                        onChanged: (value) {
                          setState(() {
                            _agreedToTerms = value;
                          });
                        },
                      ),
                      SizedBox(height: AppTheme.spacingSm.h),

                      OutlinedButton.icon(
                        onPressed: _fillDummyData,
                        icon: const Icon(Icons.auto_fix_high_outlined),
                        label: Text('Fill demo data'.tr()),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: theme.colorScheme.primary,
                          side: BorderSide(color: theme.colorScheme.primary),
                          padding: EdgeInsets.symmetric(
                            vertical: AppTheme.spacingSm.h,
                          ),
                        ),
                      ),
                      SizedBox(height: AppTheme.spacingMd.h),

                      // Create Account Button
                      BlocBuilder<AuthCubit, AuthState>(
                        builder: (context, state) {
                          final isLoading = state.status == AuthStatus.loading;
                          return CreateAccountButtonWidget(
                            onPressed: (isLoading || !_agreedToTerms)
                                ? null
                                : _createAccount,
                            isEnabled: _agreedToTerms && !isLoading,
                            isLoading: isLoading,
                          );
                        },
                      ),
                      SizedBox(height: AppTheme.spacingLg.h),

                      // AI Assistant Info
                      const AIAssistantWidget(
                        message:
                            "After signup, I'.tr()ll help you build a standout profile in under 2 minutes.",
                      ),
                      SizedBox(height: AppTheme.spacingLg.h),

                      // Sign In Link
                      SigninLinkWidget(
                        onTap: () {
                          context.pushReplacement(RouteNames.login);
                        },
                      ),
                    ],
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
