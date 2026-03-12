import 'package:freezed_annotation/freezed_annotation.dart';

part 'services_repository.freezed.dart';
part 'services_repository.g.dart';

@freezed
sealed class Service with _$Service {
  const factory Service({
    required String id,
    required String name,
    required String description,
    required String category,
    required String icon,
    @Default(0.0) double price,
    @Default(true) bool isAvailable,
    @Default([]) List<String> features,
  }) = _Service;

  factory Service.fromJson(Map<String, dynamic> json) =>
      _$ServiceFromJson(json);
}

@freezed
sealed class ServiceBooking with _$ServiceBooking {
  const factory ServiceBooking({
    required String id,
    required String serviceId,
    required String userId,
    required DateTime bookingDate,
    required String status, // 'pending', 'confirmed', 'completed', 'cancelled'
    required double totalPrice,
    Map<String, dynamic>? details,
  }) = _ServiceBooking;

  factory ServiceBooking.fromJson(Map<String, dynamic> json) =>
      _$ServiceBookingFromJson(json);
}

/// Repository interface for services operations
/// Defines the contract for services data operations
abstract class ServicesRepository {
  /// Get all available services
  /// Returns list of [Service]
  Future<List<Service>> getAllServices();

  /// Get services by category
  /// Returns list of [Service]
  Future<List<Service>> getServicesByCategory({
    required String category,
  });

  /// Get service by ID
  /// Returns [Service]
  Future<Service> getServiceById({
    required String serviceId,
  });

  /// Get user bookings
  /// Returns list of [ServiceBooking]
  Future<List<ServiceBooking>> getUserBookings({
    required String userId,
    String? status,
  });

  /// Create a new booking
  /// Returns the created [ServiceBooking]
  Future<ServiceBooking> createBooking({
    required String serviceId,
    required String userId,
    required DateTime bookingDate,
    Map<String, dynamic>? details,
  });

  /// Update booking status
  /// Returns void when operation is complete
  Future<void> updateBookingStatus({
    required String bookingId,
    required String status,
  });

  /// Cancel a booking
  /// Returns void when operation is complete
  Future<void> cancelBooking({
    required String bookingId,
  });

  /// Get booking by ID
  /// Returns [ServiceBooking]
  Future<ServiceBooking> getBookingById({
    required String bookingId,
  });

  /// Get service categories
  /// Returns list of categories
  Future<List<String>> getServiceCategories();

  /// Search services
  /// Returns list of [Service]
  Future<List<Service>> searchServices({
    required String query,
    String? category,
  });

  /// Get service recommendations
  /// Returns list of [Service]
  Future<List<Service>> getServiceRecommendations({
    required String userId,
    int limit = 5,
  });
}
