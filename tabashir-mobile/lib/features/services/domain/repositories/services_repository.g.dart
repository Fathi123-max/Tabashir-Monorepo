// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'services_repository.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Service _$ServiceFromJson(Map<String, dynamic> json) => _Service(
  id: json['id'] as String,
  name: json['name'] as String,
  description: json['description'] as String,
  category: json['category'] as String,
  icon: json['icon'] as String,
  price: (json['price'] as num?)?.toDouble() ?? 0.0,
  isAvailable: json['isAvailable'] as bool? ?? true,
  features:
      (json['features'] as List<dynamic>?)?.map((e) => e as String).toList() ??
      const [],
);

Map<String, dynamic> _$ServiceToJson(_Service instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'description': instance.description,
  'category': instance.category,
  'icon': instance.icon,
  'price': instance.price,
  'isAvailable': instance.isAvailable,
  'features': instance.features,
};

_ServiceBooking _$ServiceBookingFromJson(Map<String, dynamic> json) =>
    _ServiceBooking(
      id: json['id'] as String,
      serviceId: json['serviceId'] as String,
      userId: json['userId'] as String,
      bookingDate: DateTime.parse(json['bookingDate'] as String),
      status: json['status'] as String,
      totalPrice: (json['totalPrice'] as num).toDouble(),
      details: json['details'] as Map<String, dynamic>?,
    );

Map<String, dynamic> _$ServiceBookingToJson(_ServiceBooking instance) =>
    <String, dynamic>{
      'id': instance.id,
      'serviceId': instance.serviceId,
      'userId': instance.userId,
      'bookingDate': instance.bookingDate.toIso8601String(),
      'status': instance.status,
      'totalPrice': instance.totalPrice,
      'details': instance.details,
    };
