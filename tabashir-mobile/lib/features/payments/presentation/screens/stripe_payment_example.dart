import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart' hide Card;
import 'package:tabashir/core/constants/stripe_constants.dart';
import 'package:tabashir/core/services/stripe_service.dart';
import 'package:tabashir/core/theme/app_theme.dart';
import 'package:tabashir/features/payments/presentation/cubit/payment_cubit.dart';
import 'package:tabashir/features/payments/presentation/widgets/stripe_payment_sheet.dart';
import 'package:tabashir/features/payments/presentation/widgets/apple_pay_button.dart';

/// Example usage of Stripe Payment integration
/// This demonstrates the latest flutter_stripe 12.1.0 best practices
class StripePaymentExample extends StatefulWidget {
  const StripePaymentExample({super.key});

  @override
  State<StripePaymentExample> createState() => _StripePaymentExampleState();
}

class _StripePaymentExampleState extends State<StripePaymentExample> {
  late final PaymentCubit _paymentCubit;
  final _amountController = TextEditingController(
    text: '1000',
  ); // Amount in cents

  @override
  void initState() {
    super.initState();
    _paymentCubit = context.read<PaymentCubit>();
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  /// Example: Initialize Payment Sheet with Apple Pay and Google Pay
  Future<void> _initializePaymentSheet() async {
    try {
      // In a real app, fetch these from your backend
      const customerId = 'customer_123';
      const customerEphemeralKeySecret = 'ephemeral_key_123';
      const paymentIntentClientSecret = 'pi_client_secret_123';

      // Configure Apple Pay (optional)
      const applePay = PaymentSheetApplePay(
        merchantCountryCode: 'US',
      );

      // Configure Google Pay (optional)
      const googlePay = PaymentSheetGooglePay(
        merchantCountryCode: 'US',
        testEnv: StripeConstants.isTestMode,
      );

      await _paymentCubit.initPaymentSheet(
        customerId: customerId,
        customerEphemeralKeySecret: customerEphemeralKeySecret,
        paymentIntentClientSecret: paymentIntentClientSecret,
        merchantDisplayName: 'Tabashir',
        applePay: applePay,
        googlePay: googlePay,
      );
    } catch (e) {
      _showError('Failed to initialize payment sheet: $e');
    }
  }

  /// Example: Process payment using Payment Sheet
  Future<void> _processPayment() async {
    if (context.mounted) {
      await _paymentCubit.processPaymentSheet();
    }
  }

  /// Example: Process payment using Platform Pay (Apple Pay / Google Pay)
  Future<void> _processPlatformPay() async {
    try {
      // Get the client secret from your backend
      const paymentIntentClientSecret = 'pi_client_secret_123';

      // Use PlatformPayButton widget instead (recommended)
      // This will be handled by the onPressed callback in PlatformPayButtonWidget
    } catch (e) {
      _showError('Platform pay failed: $e');
    }
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
          // Payment amount input
          TextField(
            controller: _amountController,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              labelText: 'Amount (in cents)',
              border: OutlineInputBorder(),
            ),
          ),
          SizedBox(height: 20.h),

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

          // Payment Sheet initialization button
          ElevatedButton.icon(
            onPressed: _initializePaymentSheet,
            icon: const Icon(Icons.payment),
            label: const Text('Initialize Payment Sheet'),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppTheme.primaryColor,
              foregroundColor: Colors.white,
              padding: EdgeInsets.symmetric(vertical: 16.h),
            ),
          ),
          SizedBox(height: 12.h),

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
          // This is the recommended approach for native payments
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
                  _buildInfoPoint('Uses flutter_stripe 12.1.0 latest API'),
                  _buildInfoPoint('PaymentSheet with Apple Pay & Google Pay'),
                  _buildInfoPoint('PlatformPayButton for native payments'),
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
