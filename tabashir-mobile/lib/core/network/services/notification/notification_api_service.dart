import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:tabashir/features/notifications/data/models/notification_model.dart';
import 'package:tabashir/core/network/models/_base/api_response.dart';

part 'notification_api_service.g.dart';
part 'notification_api_service.freezed.dart';

@RestApi(baseUrl: '/api/mobile/notifications')
abstract class NotificationApiService {
  factory NotificationApiService(Dio dio, {String baseUrl}) =
      _NotificationApiService;

  @GET('/count')
  Future<HttpResponse<NotificationCountResponse>> getNotificationCount();

  @GET('/')
  Future<HttpResponse<NotificationsListResponse>> getNotifications();

  @PATCH('/')
  Future<HttpResponse<void>> markAsRead({
    @Body() required Map<String, dynamic> body,
  });
}

@freezed
sealed class NotificationCountResponse with _$NotificationCountResponse {
  const factory NotificationCountResponse({
    required int unreadCount,
    required bool hasUnread,
  }) = _NotificationCountResponse;

  factory NotificationCountResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationCountResponseFromJson(json);
}

@freezed
sealed class NotificationsListResponse with _$NotificationsListResponse {
  const factory NotificationsListResponse({
    required List<NotificationModel> notifications,
  }) = _NotificationsListResponse;

  factory NotificationsListResponse.fromJson(Map<String, dynamic> json) =>
      _$NotificationsListResponseFromJson(json);
}
