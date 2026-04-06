import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:tabashir/core/di/injection.dart';
import 'package:tabashir/core/services/auth_session_service.dart';
import 'package:tabashir/core/services/google_signin_service.dart';
import 'package:tabashir/core/services/apple_signin_service.dart';

import '../../../../core/theme/app_theme.dart';
import '../../../../core/router/route_names.dart';
import '../cubit/auth_cubit.dart';
import '../widgets/signup_header_widget.dart';
import '../widgets/social_login_button.dart';
import '../widgets/signup_divider_widget.dart';
import '../widgets/signup_text_field_widget.dart';
import '../widgets/terms_checkbox_widget.dart';
import '../widgets/create_account_button_widget.dart';
import '../widgets/signin_link_widget.dart';
import '../widgets/ai_assistant_widget.dart';

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
  final _dobController = TextEditingController();
  DateTime? _selectedDob;
  bool _agreedToTerms = false;
  bool _obscurePassword = true;
  bool _obscureConfirmPassword = true;

  @override
  void dispose() {
    _fullNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _dobController.dispose();
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
        .replaceAll(RegExp('[^a-z ]'), '')
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

  Future<void> _selectDateOfBirth() async {
    final now = DateTime.now();
    final picked = await showDatePicker(
      context: context,
      initialDate: now.subtract(const Duration(days: 365 * 25)),
      firstDate: now.subtract(const Duration(days: 365 * 120)),
      lastDate: now,
      helpText: 'Select your date of birth'.tr(),
    );

    if (picked != null) {
      final age = now.difference(picked).inDays ~/ 365;
      if (age < 16) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('You must be at least 16 years old to use this app'.tr()),
              backgroundColor: AppTheme.errorColor,
            ),
          );
        }
        return;
      }

      setState(() {
        _selectedDob = picked;
        _dobController.text = DateFormat('yyyy-MM-dd').format(picked);
      });
    }
  }

  Future<void> _createAccount() async {
    if (!_formKey.currentState!.validate()) return;
    if (!_agreedToTerms) {
      _showMessage('Please agree to the terms and conditions'.tr());
      return;
    }
    if (_selectedDob == null) {
      _showMessage('Please select your date of birth'.tr());
      return;
    }

    final name = _fullNameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    try {
      await _authCubit.register(name: name, email: email, password: password);
      final state = _authCubit.state;
      if (state.status == AuthStatus.registerSuccess) {
        final isAuthenticated =
            await AuthSessionService.instance.isAuthenticated;
        if (isAuthenticated && mounted) {
          Future.delayed(const Duration(milliseconds: 150), () {
            if (mounted) context.go(RouteNames.onboardingWizard);
          });
        } else if (mounted) {
          _showMessage(
            'Authentication failed after registration. Please try logging in.'
                .tr(),
          );
        }
      } else if (state.status == AuthStatus.error && mounted) {
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
        body: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                AppTheme.primaryColor.withOpacity(0.08),
                theme.scaffoldBackgroundColor,
              ],
            ),
          ),
          child: SafeArea(
            child: LayoutBuilder(
              builder: (context, constraints) => SingleChildScrollView(
                padding: EdgeInsets.symmetric(
                  horizontal: AppTheme.spacingLg.w,
                  vertical: AppTheme.spacingMd.h,
                ),
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: 448.w),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        // Compact Header
                        SizedBox(height: AppTheme.spacingMd.h),
                        const SignupHeaderWidget(),
                        SizedBox(height: AppTheme.spacingLg.h),

                        // Social Login - Compact
                        SocialLoginButton(
                          platform: SocialPlatform.google,
                          text: 'Sign up with Google'.tr(),
                          onPressed: () async {
                            try {
                              await getIt<GoogleSignInService>().signIn();
                              if (mounted) {
                                Future.delayed(
                                  const Duration(milliseconds: 150),
                                  () {
                                    if (mounted)
                                      context.go(RouteNames.onboardingWizard);
                                  },
                                );
                              }
                            } catch (e) {
                              _showMessage('Google sign-up failed: $e');
                            }
                          },
                        ),
                        SizedBox(height: AppTheme.spacingSm.h),
                        SocialLoginButton(
                          platform: SocialPlatform.apple,
                          text: 'Sign up with Apple'.tr(),
                          onPressed: () async {
                            try {
                              await AppleSignInService.instance.signIn();
                              if (mounted) {
                                Future.delayed(
                                  const Duration(milliseconds: 150),
                                  () {
                                    if (mounted)
                                      context.go(RouteNames.onboardingWizard);
                                  },
                                );
                              }
                            } catch (e) {
                              _showMessage('Apple sign-up failed: $e');
                            }
                          },
                        ),
                        SizedBox(height: AppTheme.spacingMd.h),

                        // Divider
                        const SignupDividerWidget(),
                        SizedBox(height: AppTheme.spacingMd.h),

                        // Form Fields - Compact
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
                        SizedBox(height: AppTheme.spacingSm.h),
                        
                        // Date of Birth Field
                        GestureDetector(
                          onTap: _selectDateOfBirth,
                          child: AbsorbPointer(
                            child: SignupTextFieldWidget(
                              controller: _dobController,
                              hintText: 'Date of Birth'.tr(),
                              keyboardType: TextInputType.datetime,
                              suffixIcon: const Icon(Icons.calendar_today_outlined),
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please select your date of birth'.tr();
                                }
                                return null;
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: AppTheme.spacingSm.h),
                        SignupTextFieldWidget(
                          controller: _emailController,
                          hintText: 'Email'.tr(),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return 'Please enter your email'.tr();
                            }
                            if (!RegExp(
                              r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                            ).hasMatch(value)) {
                              return 'Please enter a valid email'.tr();
                            }
                            return null;
                          },
                        ),
                        SizedBox(height: AppTheme.spacingSm.h),
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
                        SizedBox(height: AppTheme.spacingSm.h),
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
                        SizedBox(height: AppTheme.spacingSm.h),

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

                        // Demo Data Button - Compact
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
                            final isLoading =
                                state.status == AuthStatus.loading;
                            return CreateAccountButtonWidget(
                              onPressed: (isLoading || !_agreedToTerms)
                                  ? null
                                  : _createAccount,
                              isEnabled: _agreedToTerms && !isLoading,
                              isLoading: isLoading,
                            );
                          },
                        ),
                        SizedBox(height: AppTheme.spacingSm.h),

                        // AI Assistant - Compact
                        AIAssistantWidget(
                          message:
                              "After signup, I'll help you build a standout profile in under 2 minutes."
                                  .tr(),
                        ),
                        SizedBox(height: AppTheme.spacingMd.h),

                        // Sign In Link - Always visible
                        SigninLinkWidget(
                          onTap: () {
                            context.pushReplacement(RouteNames.login);
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
    );
  }
}
