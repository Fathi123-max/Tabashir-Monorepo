import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/features/services/presentation/cubit/interview_training_cubit.dart';

class WaitlistForm extends StatefulWidget {
  const WaitlistForm({super.key});

  @override
  State<WaitlistForm> createState() => _WaitlistFormState();
}

class _WaitlistFormState extends State<WaitlistForm> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void _submitWaitlist() {
    if (_formKey.currentState!.validate()) {
      context.read<InterviewTrainingCubit>().submitWaitlist(
        _emailController.text,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<InterviewTrainingCubit, InterviewTrainingState>(
      listener: (context, state) {
        if (state is InterviewTrainingWaitlistSuccess) {
          // Show snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Row(
                children: [
                  Icon(
                    Icons.check_circle,
                    color: Colors.white,
                    size: 20.sp,
                  ),
                  SizedBox(width: AppTheme.spacingSm.w),
                  const Text('Thanks for joining the waitlist!'),
                ],
              ),
              backgroundColor: const Color(0xFF2D3748),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
              ),
              margin: EdgeInsets.only(
                bottom: 100.h,
                left: AppTheme.spacingMd.w,
                right: AppTheme.spacingMd.w,
              ),
              duration: const Duration(seconds: 3),
            ),
          );
        } else if (state is InterviewTrainingError) {
          // Show error snackbar
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message),
              backgroundColor: AppTheme.errorColor,
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppTheme.radiusDefault.r),
              ),
              margin: EdgeInsets.only(
                bottom: 100.h,
                left: AppTheme.spacingMd.w,
                right: AppTheme.spacingMd.w,
              ),
              duration: const Duration(seconds: 3),
            ),
          );
        }
      },
      builder: (context, state) {
        final isLoading = state is InterviewTrainingLoading;
        final isSuccess = state is InterviewTrainingWaitlistSuccess;

        return Form(
          key: _formKey,
          child: Column(
            children: [
              // Email Input
              TextFormField(
                controller: _emailController,
                enabled: !isLoading && !isSuccess,
                keyboardType: TextInputType.emailAddress,
                style: theme.textTheme.bodyLarge,
                decoration: InputDecoration(
                  hintText: 'Enter your email for early access',
                  filled: true,
                  fillColor: theme.inputDecorationTheme.fillColor,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppTheme.radiusDefault.r,
                    ),
                    borderSide: BorderSide(
                      color: theme.dividerTheme.color ?? AppTheme.borderLight,
                    ),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppTheme.radiusDefault.r,
                    ),
                    borderSide: BorderSide(
                      color: theme.dividerTheme.color ?? AppTheme.borderLight,
                    ),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppTheme.radiusDefault.r,
                    ),
                    borderSide: BorderSide(
                      color: AppTheme.primaryColor,
                      width: 2,
                    ),
                  ),
                  errorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppTheme.radiusDefault.r,
                    ),
                    borderSide: BorderSide(
                      color: AppTheme.errorColor,
                    ),
                  ),
                  focusedErrorBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(
                      AppTheme.radiusDefault.r,
                    ),
                    borderSide: BorderSide(
                      color: AppTheme.errorColor,
                      width: 2,
                    ),
                  ),
                  contentPadding: EdgeInsets.symmetric(
                    horizontal: AppTheme.spacingMd.w,
                    vertical: AppTheme.spacingMd.h,
                  ),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter your email';
                  }
                  if (!RegExp(
                    r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
                  ).hasMatch(value)) {
                    return 'Please enter a valid email address';
                  }
                  return null;
                },
              ),
              SizedBox(height: AppTheme.spacingSm.h),

              // Submit Button
              SizedBox(
                width: double.infinity,
                height: 56.h,
                child: Container(
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient,
                    borderRadius: BorderRadius.circular(
                      AppTheme.radiusDefault.r,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryColor.withOpacity(
                          0.3,
                        ),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: ElevatedButton(
                    onPressed: isLoading || isSuccess ? null : _submitWaitlist,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      foregroundColor: Colors.white,
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      disabledBackgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(
                          AppTheme.radiusDefault.r,
                        ),
                      ),
                    ),
                    child: Text(
                      isLoading
                          ? 'Submitting...'
                          : (isSuccess ? 'Joined!' : 'Join Waitlist'),
                      style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: AppTheme.spacingSm.h),

              // Signup Count
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.check_circle,
                    size: 16.sp,
                    color: AppTheme.successColor,
                  ),
                  SizedBox(width: AppTheme.spacingXs.w),
                  Text(
                    '3,200+ job seekers already signed up',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }
}
