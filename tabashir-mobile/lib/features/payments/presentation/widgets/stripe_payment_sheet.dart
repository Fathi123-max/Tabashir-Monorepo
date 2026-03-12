import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/core/models/stripe/stripe_enums.dart';

import '../cubit/payment_cubit.dart';

/// Widget that displays the Stripe Payment Sheet
/// Call [initPaymentSheet] first, then [presentPaymentSheet] for the user
class StripePaymentSheetWidget extends StatefulWidget {
  const StripePaymentSheetWidget({
    required this.onPaymentComplete,
    super.key,
    this.onError,
    this.merchantDisplayName = 'Tabashir',
  });

  final VoidCallback onPaymentComplete;
  final Function(String error)? onError;
  final String merchantDisplayName;

  @override
  State<StripePaymentSheetWidget> createState() =>
      _StripePaymentSheetWidgetState();
}

class _StripePaymentSheetWidgetState extends State<StripePaymentSheetWidget> {
  bool _isInitialized = false;
  bool _isProcessing = false;

  @override
  Widget build(
    BuildContext context,
  ) => BlocConsumer<PaymentCubit, PaymentState>(
    listener: (context, state) {
      if (state.status == PaymentStatus.success) {
        if (state.paymentSheetInitialized && !_isInitialized) {
          setState(() {
            _isInitialized = true;
          });
        }
      } else if (state.status == PaymentStatus.failed) {
        setState(() {
          _isProcessing = false;
        });
        widget.onError?.call(state.errorMessage);
      } else if (state.status == PaymentStatus.success &&
          state.paymentSuccessful) {
        setState(() {
          _isProcessing = false;
        });
        widget.onPaymentComplete();
      }
    },
    builder: (context, state) {
      if (state.status == PaymentStatus.loading) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      }

      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Payment sheet initialization is done via Cubit
          // The actual payment sheet UI is handled by Stripe's native component

          // Custom UI for the payment button
          if (_isInitialized) ...[
            SizedBox(height: 16.h),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _isProcessing
                    ? null
                    : () async {
                        setState(() {
                          _isProcessing = true;
                        });

                        context.read<PaymentCubit>().processPaymentSheet();
                      },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppTheme.primaryColor,
                  foregroundColor: Colors.white,
                  padding: EdgeInsets.symmetric(vertical: 16.h),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12.r),
                  ),
                ),
                child: _isProcessing
                    ? SizedBox(
                        height: 20.h,
                        width: 20.w,
                        child: const CircularProgressIndicator(
                          strokeWidth: 2,
                          valueColor: AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      )
                    : Text(
                        'Pay Now',
                        style: TextStyle(
                          fontSize: 16.sp,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
              ),
            ),
          ] else ...[
            // Payment sheet not yet initialized
            Text(
              'Initializing payment...',
              style: TextStyle(
                fontSize: 14.sp,
                color: Colors.grey[600],
              ),
            ),
          ],

          // Payment methods hint
          if (_isInitialized) ...[
            SizedBox(height: 12.h),
            Text(
              'Secure payment powered by Stripe',
              style: TextStyle(
                fontSize: 12.sp,
                color: Colors.grey[600],
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ],
      );
    },
  );
}

/// Widget for displaying payment status
class PaymentStatusWidget extends StatelessWidget {
  const PaymentStatusWidget({
    required this.status,
    super.key,
    this.errorMessage,
  });

  final PaymentStatus status;
  final String? errorMessage;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case PaymentStatus.initial:
      case PaymentStatus.loading:
        return const SizedBox.shrink();

      case PaymentStatus.processing:
        return Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.blue[50],
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Colors.blue.shade200,
            ),
          ),
          child: Row(
            children: [
              SizedBox(
                height: 20.h,
                width: 20.w,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor: AlwaysStoppedAnimation<Color>(
                    AppTheme.primaryColor,
                  ),
                ),
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  'Processing your payment...',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.blue[800],
                  ),
                ),
              ),
            ],
          ),
        );

      case PaymentStatus.success:
        return Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.green[50],
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Colors.green.shade200,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.check_circle,
                color: Colors.green[600],
                size: 24.h,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  'Payment successful!',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.green[800],
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
        );

      case PaymentStatus.failed:
        return Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.red[50],
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Colors.red.shade200,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.error,
                color: Colors.red[600],
                size: 24.h,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Payment failed',
                      style: TextStyle(
                        fontSize: 14.sp,
                        color: Colors.red[800],
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    if (errorMessage != null) ...[
                      SizedBox(height: 4.h),
                      Text(
                        errorMessage!,
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.red[700],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
            ],
          ),
        );

      case PaymentStatus.canceled:
        return Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.grey[100],
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Colors.grey.shade300,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.cancel,
                color: Colors.grey[600],
                size: 24.h,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  'Payment was canceled',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.grey[700],
                  ),
                ),
              ),
            ],
          ),
        );

      case PaymentStatus.requiresAction:
        return Container(
          padding: EdgeInsets.all(16.w),
          decoration: BoxDecoration(
            color: Colors.orange[50],
            borderRadius: BorderRadius.circular(12.r),
            border: Border.all(
              color: Colors.orange.shade200,
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.security,
                color: Colors.orange[600],
                size: 24.h,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Text(
                  'Authentication required',
                  style: TextStyle(
                    fontSize: 14.sp,
                    color: Colors.orange[800],
                  ),
                ),
              ),
            ],
          ),
        );

      default:
        return const SizedBox.shrink();
    }
  }
}
