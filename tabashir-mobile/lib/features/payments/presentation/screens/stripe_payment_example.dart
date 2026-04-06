import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/features/payments/presentation/cubit/payment_cubit.dart';
import 'package:tabashir/features/payments/presentation/widgets/apple_pay_button.dart';
import 'package:tabashir/features/payments/presentation/widgets/stripe_payment_sheet.dart';

/// Example usage of Stripe Payment integration
/// This demonstrates the latest PaymentPlatform abstraction.
/// On Android, Stripe is used; on iOS, Apple IAP is used.
class StripePaymentExample extends StatefulWidget {
  const StripePaymentExample({super.key});

  @override
  State<StripePaymentExample> createState() => _StripePaymentExampleState();
}

class _StripePaymentExampleState extends State<StripePaymentExample> {
  late final PaymentCubit _paymentCubit;

  @override
  void initState() {
    super.initState();
    _paymentCubit = context.read<PaymentCubit>();
  }

  /// Process a payment via the unified PaymentPlatform.
  Future<void> _processPayment() async {
    await _paymentCubit.processPayment(
      serviceId: 'your_service_id',
      amount: 1000, // in cents
    );
  }

  /// Example: Process payment using Platform Pay (Apple Pay / Google Pay)
  Future<void> _processPlatformPay() async {
    // Get the client secret from your backend
    // Use PlatformPayButton widget instead (recommended)
    // This will be handled by the onPressed callback in PlatformPayButtonWidget
  }

  void _showError(String message) {
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(message),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text('Stripe Payment Example'),
      backgroundColor: AppTheme.primaryColor,
      foregroundColor: Colors.white,
    ),
    body: SingleChildScrollView(
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Payment status widget
          BlocBuilder<PaymentCubit, PaymentState>(
            builder: (context, state) => PaymentStatusWidget(
              status: state.status,
              errorMessage: state.errorMessage.isNotEmpty
                  ? state.errorMessage
                  : null,
            ),
          ),
          SizedBox(height: 20.h),

          // Process payment button
          ElevatedButton.icon(
            onPressed: _processPayment,
            icon: const Icon(Icons.check_circle),
            label: const Text('Process Payment'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16.h),
            ),
          ),
          SizedBox(height: 20.h),

          // Platform Pay Button (Apple Pay / Google Pay)
          Text(
            'Native Payments',
            style: TextStyle(
              fontSize: 18.sp,
              fontWeight: FontWeight.w600,
              color: AppTheme.primaryColor,
            ),
          ),
          SizedBox(height: 12.h),
          PlatformPayButtonWidget(
            onPressed: _processPlatformPay,
          ),
          SizedBox(height: 20.h),

          // Info card
          Card(
            elevation: 2,
            child: Padding(
              padding: EdgeInsets.all(16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Implementation Notes',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  SizedBox(height: 8.h),
                  _buildInfoPoint(
                    'Uses PaymentPlatform abstraction',
                  ),
                  _buildInfoPoint('Android: Stripe SDK, iOS: Apple IAP'),
                  _buildInfoPoint('Proper error handling & state management'),
                  _buildInfoPoint('Clean Architecture with BLoC pattern'),
                ],
              ),
            ),
          ),
        ],
      ),
    ),
  );

  Widget _buildInfoPoint(String text) => Padding(
    padding: EdgeInsets.symmetric(vertical: 4.h),
    child: Row(
      children: [
        Icon(
          Icons.check_circle,
          size: 16.h,
          color: AppTheme.primaryColor,
        ),
        SizedBox(width: 8.w),
        Expanded(
          child: Text(
            text,
            style: TextStyle(fontSize: 14.sp),
          ),
        ),
      ],
    ),
  );
}
