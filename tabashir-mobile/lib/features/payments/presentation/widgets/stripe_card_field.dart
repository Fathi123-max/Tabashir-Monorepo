import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:tabashir/core/theme/app_theme.dart';

/// Widget for collecting card details using Stripe CardField
class StripeCardFieldWidget extends StatefulWidget {
  const StripeCardFieldWidget({
    required this.onCardChanged,
    super.key,
    this.initialDetails,
  });

  final Function(CardFieldInputDetails?) onCardChanged;
  final CardDetails? initialDetails;

  @override
  State<StripeCardFieldWidget> createState() => _StripeCardFieldWidgetState();
}

class _StripeCardFieldWidgetState extends State<StripeCardFieldWidget> {
  CardFieldInputDetails? _cardDetails;

  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text(
        'Card Details',
        style: TextStyle(
          fontSize: 16.sp,
          fontWeight: FontWeight.w600,
          color: AppTheme.primaryColor,
        ),
      ),
      SizedBox(height: 12.h),
      CardField(
        onCardChanged: (details) {
          setState(() {
            _cardDetails = details;
          });
          widget.onCardChanged(details);
        },
        numberHintText: '1234 1234 1234 1234',
        expirationHintText: 'MM/YY',
        cvcHintText: 'CVC',
        style: const TextStyle(
          fontSize: 16,
          color: Colors.black,
        ),
      ),
      SizedBox(height: 8.h),
      // Show card details
      if (_cardDetails != null) ...[
        SizedBox(height: 8.h),
        Container(
          padding: EdgeInsets.all(12.w),
          decoration: BoxDecoration(
            color: Colors.grey[50],
            borderRadius: BorderRadius.circular(8.r),
            border: Border.all(
              color: Colors.grey.shade300,
            ),
          ),
          child: Row(
            children: [
              Icon(
                _getCardIcon(_cardDetails!.brand ?? 'Unknown'),
                size: 32.h,
                color: AppTheme.primaryColor,
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _formatCardNumber(
                        _cardDetails!.last4 ?? '',
                        _cardDetails!.brand ?? 'Unknown',
                      ),
                      style: TextStyle(
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    if (_cardDetails!.expiryMonth != null &&
                        _cardDetails!.expiryYear != null) ...[
                      SizedBox(height: 4.h),
                      Text(
                        'Expires ${_cardDetails!.expiryMonth}/${_cardDetails!.expiryYear}',
                        style: TextStyle(
                          fontSize: 12.sp,
                          color: Colors.grey[600],
                        ),
                      ),
                    ],
                  ],
                ),
              ),
              if (_cardDetails!.complete)
                Icon(
                  Icons.check_circle,
                  color: Colors.green[600],
                  size: 20.h,
                ),
            ],
          ),
        ),
      ],
    ],
  );

  IconData _getCardIcon(String brand) {
    switch (brand.toLowerCase()) {
      case 'visa':
        return Icons.credit_card;
      case 'mastercard':
        return Icons.credit_card;
      case 'amex':
      case 'american_express':
        return Icons.credit_card;
      default:
        return Icons.credit_card;
    }
  }

  String _formatCardNumber(String number, String brand) {
    // Format card number based on brand
    if (brand.toLowerCase() == 'amex' ||
        brand.toLowerCase() == 'american_express') {
      // AMEX: 4-6-5 format
      if (number.length >= 4) {
        return '${number.substring(0, 4)} ${number.substring(4, number.length > 10 ? 10 : number.length)} ${number.length > 10 ? number.substring(10) : ''}';
      }
    } else {
      // Standard: 4-4-4-4 format
      if (number.length >= 4) {
        return '${number.substring(0, 4)} ${number.substring(4, number.length > 8 ? 8 : number.length)} ${number.length > 8 ? number.substring(8, number.length > 12 ? 12 : number.length) : ''} ${number.length > 12 ? number.substring(12) : ''}';
      }
    }
    return number;
  }
}
