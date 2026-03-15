import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';
import 'package:dio/dio.dart';
import 'package:tabashir/core/network/models/_base/api_response.dart';

part 'notification_api_service.g.dart';
part 'notification_api_service.freezed.dart';

@RestApi(baseUrl: '/api/v1/home')
abstract class NotificationApiService {
  factory NotificationApiService(Dio dio, {String baseUrl}) = _NotificationApiService;

  @GET('/notifications/count')
  Future<HttpResponse<NotificationCountResponse>> getNotificationCount();
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
