import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:tabashir/core/theme/app_theme.dart';

/// Platform Pay button widget (Apple Pay / Google Pay)
/// Automatically shows/hides based on device support
/// This is the recommended approach for flutter_stripe 9.0+
class PlatformPayButtonWidget extends StatefulWidget {
  const PlatformPayButtonWidget({
    required this.onPressed,
    super.key,
    this.type = PlatformButtonType.plain,
    this.appearance = PlatformButtonStyle.automatic,
    this.borderRadius = 4,
  });

  final VoidCallback onPressed;
  final PlatformButtonType type;
  final PlatformButtonStyle appearance;
  final int borderRadius;

  @override
  State<PlatformPayButtonWidget> createState() =>
      _PlatformPayButtonWidgetState();
}

class _PlatformPayButtonWidgetState extends State<PlatformPayButtonWidget> {
  bool _isAvailable = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkPlatformPayAvailability();
  }

  Future<void> _checkPlatformPayAvailability() async {
    try {
      // Check if platform pay is supported on this device
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
      return SizedBox(
        width: double.infinity,
        height: 56.h,
        child: const Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    if (!_isAvailable) {
      // Return an alternative payment button or nothing
      return const SizedBox.shrink();
    }

    // Use Stripe's PlatformPayButton for both Apple Pay and Google Pay
    return SizedBox(
      width: double.infinity,
      height: 56.h,
      child: PlatformPayButton(
        onPressed: widget.onPressed,
        type: widget.type,
        appearance: widget.appearance,
        borderRadius: widget.borderRadius,
      ),
    );
  }
}

/// Legacy Apple Pay button widget (DEPRECATED)
/// Use PlatformPayButtonWidget instead
@Deprecated('Use PlatformPayButtonWidget instead')
class ApplePayButtonWidget extends StatefulWidget {
  const ApplePayButtonWidget({
    required this.onPressed,
    super.key,
    this.amount,
    this.currency = 'USD',
    this.merchantDisplayName = 'Tabashir',
  });

  final VoidCallback onPressed;
  final double? amount;
  final String currency;
  final String merchantDisplayName;

  @override
  State<ApplePayButtonWidget> createState() => _ApplePayButtonWidgetState();
}

@Deprecated('Use PlatformPayButtonWidget instead')
class _ApplePayButtonWidgetState extends State<ApplePayButtonWidget> {
  bool _isAvailable = false;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _checkApplePayAvailability();
  }

  Future<void> _checkApplePayAvailability() async {
    try {
      if (defaultTargetPlatform == TargetPlatform.iOS) {
        final isSupported = await Stripe.instance.isPlatformPaySupported(
          googlePay: const IsGooglePaySupportedParams(),
        );
        if (mounted) {
          setState(() {
            _isAvailable = isSupported;
            _isLoading = false;
          });
        }
      } else {
        if (mounted) {
          setState(() {
            _isAvailable = false;
            _isLoading = false;
          });
        }
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

    // Use PlatformPayButton instead of direct ApplePayButton
    return PlatformPayButton(
      onPressed: widget.onPressed,
    );
  }
}
