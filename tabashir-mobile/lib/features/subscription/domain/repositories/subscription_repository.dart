import 'package:tabashir/core/network/models/subscription/subscription_response.dart';
import 'package:tabashir/core/network/models/subscription/subscription_debug_response.dart';

/// Repository interface for subscription operations
/// Defines the contract for subscription data operations
abstract class SubscriptionRepository {
  /// Get latest subscription information
  /// Returns [SubscriptionResponse] with current subscription details
  Future<SubscriptionResponse> getLatestSubscription();

  /// Get debug subscription data (for development/testing)
  /// Returns [SubscriptionDebugResponse] with debug information
  Future<SubscriptionDebugResponse> debugSubscription();

  /// Test subscription endpoints
  /// Returns [SubscriptionResponse] with test results
  Future<SubscriptionResponse> testSubscription();
}
