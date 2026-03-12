import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:tabashir/core/theme/app_theme.dart';

/// Legacy Google Pay button widget (DEPRECATED)
/// Use PlatformPayButtonWidget instead for unified Apple Pay / Google Pay
@Deprecated('Use PlatformPayButtonWidget instead')
class GooglePayButtonWidget extends StatefulWidget {
  const GooglePayButtonWidget({
    required this.onPressed,
    super.key,
    this.amount,
    this.currency = 'USD',
  });

  final VoidCallback onPressed;
  final double? amount;
  final String currency;

  @override
  State<GooglePayButtonWidget> createState() => _GooglePayButtonWidgetState();
}

@Deprecated('Use PlatformPayButtonWidget instead')
class _GooglePayButtonWidgetState extends State<GooglePayButtonWidget> {
  bool _isAvailable = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkGooglePayAvailability();
  }

  Future<void> _checkGooglePayAvailability() async {
    try {
      final isSupported = await Stripe.instance.isPlatformPaySupported(
        googlePay: const IsGooglePaySupportedParams(),
      );
      if (mounted) {
        setState(() {
          _isAvailable = isSupported;
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
          _isAvailable = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const SizedBox.shrink();
    }

    if (!_isAvailable) {
      return const SizedBox.shrink();
    }

    // Use PlatformPayButton instead of direct GooglePayButton
    return PlatformPayButton(
      type: PlatformButtonType.buy,
      appearance: PlatformButtonStyle.black,
      onPressed: widget.onPressed,
    );
  }
}
