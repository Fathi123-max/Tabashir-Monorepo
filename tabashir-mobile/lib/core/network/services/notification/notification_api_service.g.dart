// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'notification_api_service.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_NotificationCountResponse _$NotificationCountResponseFromJson(
  Map<String, dynamic> json,
) => _NotificationCountResponse(
  unreadCount: (json['unreadCount'] as num).toInt(),
  hasUnread: json['hasUnread'] as bool,
);

Map<String, dynamic> _$NotificationCountResponseToJson(
  _NotificationCountResponse instance,
) => <String, dynamic>{
  'unreadCount': instance.unreadCount,
  'hasUnread': instance.hasUnread,
};

// dart format off

// **************************************************************************
// RetrofitGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps,no_leading_underscores_for_local_identifiers,unused_element,unnecessary_string_interpolations,unused_element_parameter

class _NotificationApiService implements NotificationApiService {
  _NotificationApiService(this._dio, {this.baseUrl, this.errorLogger}) {
    baseUrl ??= '/api/mobile';
  }

  final Dio _dio;

  String? baseUrl;

  final ParseErrorLogger? errorLogger;

  @override
  Future<HttpResponse<NotificationCountResponse>> getNotificationCount() async {
    final _extra = <String, dynamic>{};
    final queryParameters = <String, dynamic>{};
    final _headers = <String, dynamic>{};
    const Map<String, dynamic>? _data = null;
    final _options = _setStreamType<HttpResponse<NotificationCountResponse>>(
      Options(method: 'GET', headers: _headers, extra: _extra)
          .compose(
            _dio.options,
            '/notifications/count',
            queryParameters: queryParameters,
            data: _data,
          )
          .copyWith(baseUrl: _combineBaseUrls(_dio.options.baseUrl, baseUrl)),
    );
    final _result = await _dio.fetch<Map<String, dynamic>>(_options);
    late NotificationCountResponse _value;
    try {
      _value = NotificationCountResponse.fromJson(_result.data!);
    } on Object catch (e, s) {
      errorLogger?.logError(e, s, _options);
      rethrow;
    }
    final httpResponse = HttpResponse(_value, _result);
    return httpResponse;
  }

  RequestOptions _setStreamType<T>(RequestOptions requestOptions) {
    if (T != dynamic &&
        !(requestOptions.responseType == ResponseType.bytes ||
            requestOptions.responseType == ResponseType.stream)) {
      if (T == String) {
        requestOptions.responseType = ResponseType.plain;
      } else {
        requestOptions.responseType = ResponseType.json;
      }
    }
    return requestOptions;
  }

  String _combineBaseUrls(String dioBaseUrl, String? baseUrl) {
    if (baseUrl == null || baseUrl.trim().isEmpty) {
      return dioBaseUrl;
    }

    final url = Uri.parse(baseUrl);

    if (url.isAbsolute) {
      return url.toString();
    }

    return Uri.parse(dioBaseUrl).resolveUri(url).toString();
  }
}

// dart format on
