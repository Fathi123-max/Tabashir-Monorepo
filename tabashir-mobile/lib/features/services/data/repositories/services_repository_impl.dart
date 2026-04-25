import 'dart:convert';

import 'package:injectable/injectable.dart';
import 'package:tabashir/core/services/local_persistence_service.dart';
import 'package:tabashir/features/services/domain/repositories/services_repository.dart';

/// Implementation of [ServicesRepository]
/// Handles services operations using [LocalPersistenceService] for local storage
@Injectable(as: ServicesRepository)
class ServicesRepositoryImpl implements ServicesRepository {
  ServicesRepositoryImpl(this._persistenceService);

  final LocalPersistenceService _persistenceService;

  @override
  Future<List<Service>> getAllServices() async {
    try {
      final prefs = _persistenceService.prefs;
      final servicesJson = prefs.getString('all_services');
      if (servicesJson == null || servicesJson.isEmpty) {
        return <Service>[];
      }

      final servicesList = jsonDecode(servicesJson) as List<dynamic>;
      return servicesList
          .map((json) => Service.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      throw Exception('Failed to get all services: $e');
    }
  }

  @override
  Future<List<Service>> getServicesByCategory({
    required String category,
  }) async {
    try {
      final allServices = await getAllServices();
      return allServices
          .where((service) => service.category == category)
          .toList();
    } catch (e) {
      throw Exception('Failed to get services by category: $e');
    }
  }

  @override
  Future<Service> getServiceById({
    required String serviceId,
  }) async {
    try {
      final allServices = await getAllServices();
      final service = allServices.firstWhere(
        (service) => service.id == serviceId,
        orElse: () => throw Exception('Service not found'),
      );
      return service;
    } catch (e) {
      throw Exception('Failed to get service by ID: $e');
    }
  }

  @override
  Future<List<ServiceBooking>> getUserBookings({
    required String userId,
    String? status,
  }) async {
    try {
      final prefs = _persistenceService.prefs;
      final bookingsJson = prefs.getString('service_bookings_$userId');
      if (bookingsJson == null || bookingsJson.isEmpty) {
        return <ServiceBooking>[];
      }

      final bookingsList = jsonDecode(bookingsJson) as List<dynamic>;
      var bookings = bookingsList
          .map((json) => ServiceBooking.fromJson(json as Map<String, dynamic>))
          .toList();

      // Filter by status if provided
      if (status != null) {
        bookings = bookings
            .where((booking) => booking.status == status)
            .toList();
      }

      // Sort by booking date (newest first)
      bookings.sort((a, b) => b.bookingDate.compareTo(a.bookingDate));

      return bookings;
    } catch (e) {
      throw Exception('Failed to get user bookings: $e');
    }
  }

  @override
  Future<ServiceBooking> createBooking({
    required String serviceId,
    required String userId,
    required DateTime bookingDate,
    Map<String, dynamic>? details,
  }) async {
    try {
      final service = await getServiceById(serviceId: serviceId);
      final bookingId = 'booking_${DateTime.now().millisecondsSinceEpoch}';

      final booking = ServiceBooking(
        id: bookingId,
        serviceId: serviceId,
        userId: userId,
        bookingDate: bookingDate,
        status: 'pending',
        totalPrice: service.price,
        details: details,
      );

      // Save booking
      final prefs = _persistenceService.prefs;
      final bookingsJson = prefs.getString('service_bookings_$userId');
      final bookings = <ServiceBooking>[];

      if (bookingsJson != null && bookingsJson.isNotEmpty) {
        final bookingsList = jsonDecode(bookingsJson) as List<dynamic>;
        bookings.addAll(
          bookingsList.map(
            (json) => ServiceBooking.fromJson(json as Map<String, dynamic>),
          ),
        );
      }

      bookings.add(booking);
      final updatedJson = jsonEncode(bookings.map((b) => b.toJson()).toList());
      await prefs.setString('service_bookings_$userId', updatedJson);

      return booking;
    } catch (e) {
      throw Exception('Failed to create booking: $e');
    }
  }

  @override
  Future<void> updateBookingStatus({
    required String bookingId,
    required String status,
  }) async {
    try {
      final prefs = _persistenceService.prefs;
      final allKeys = prefs.getKeys().where(
        (key) => key.startsWith('service_bookings_'),
      );

      for (final key in allKeys) {
        final bookingsJson = prefs.getString(key);
        if (bookingsJson == null || bookingsJson.isEmpty) continue;

        final bookingsList = jsonDecode(bookingsJson) as List<dynamic>;
        final bookings = bookingsList
            .map(
              (json) => ServiceBooking.fromJson(json as Map<String, dynamic>),
            )
            .toList();

        final bookingIndex = bookings.indexWhere((b) => b.id == bookingId);
        if (bookingIndex != -1) {
          bookings[bookingIndex] = bookings[bookingIndex].copyWith(
            status: status,
          );
          final updatedJson = jsonEncode(
            bookings.map((b) => b.toJson()).toList(),
          );
          await prefs.setString(key, updatedJson);
          break;
        }
      }
    } catch (e) {
      throw Exception('Failed to update booking status: $e');
    }
  }

  @override
  Future<void> cancelBooking({
    required String bookingId,
  }) async {
    try {
      await updateBookingStatus(bookingId: bookingId, status: 'cancelled');
    } catch (e) {
      throw Exception('Failed to cancel booking: $e');
    }
  }

  @override
  Future<ServiceBooking> getBookingById({
    required String bookingId,
  }) async {
    try {
      final prefs = _persistenceService.prefs;
      final allKeys = prefs.getKeys().where(
        (key) => key.startsWith('service_bookings_'),
      );

      for (final key in allKeys) {
        final bookingsJson = prefs.getString(key);
        if (bookingsJson == null || bookingsJson.isEmpty) continue;

        final bookingsList = jsonDecode(bookingsJson) as List<dynamic>;
        final bookings = bookingsList
            .map(
              (json) => ServiceBooking.fromJson(json as Map<String, dynamic>),
            )
            .toList();

        try {
          return bookings.firstWhere((b) => b.id == bookingId);
        } catch (e) {
          // Continue searching
        }
      }

      throw Exception('Booking not found');
    } catch (e) {
      throw Exception('Failed to get booking by ID: $e');
    }
  }

  @override
  Future<List<String>> getServiceCategories() async {
    try {
      final allServices = await getAllServices();
      final categories = allServices
          .map((service) => service.category)
          .toSet()
          .toList();
      return categories;
    } catch (e) {
      throw Exception('Failed to get service categories: $e');
    }
  }

  @override
  Future<List<Service>> searchServices({
    required String query,
    String? category,
  }) async {
    try {
      final allServices = await getAllServices();
      final lowerQuery = query.toLowerCase();

      var services = allServices.where((service) {
        final name = service.name.toLowerCase();
        final desc = service.description.toLowerCase();
        return name.contains(lowerQuery) || desc.contains(lowerQuery);
      }).toList();

      // Filter by category if provided
      if (category != null && category.isNotEmpty) {
        services = services
            .where((service) => service.category == category)
            .toList();
      }

      return services;
    } catch (e) {
      throw Exception('Failed to search services: $e');
    }
  }

  @override
  Future<List<Service>> getServiceRecommendations({
    required String userId,
    int limit = 5,
  }) async {
    try {
      final allServices = await getAllServices();
      final availableServices = allServices
          .where((s) => s.isAvailable)
          .toList();

      // For now, return first 5 available services
      // In a real implementation, this would use user preferences/history
      final recommendations = availableServices.take(limit).toList();

      return recommendations;
    } catch (e) {
      throw Exception('Failed to get service recommendations: $e');
    }
  }
}
