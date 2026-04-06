// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'messages_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_MessagesState _$MessagesStateFromJson(Map<String, dynamic> json) =>
    _MessagesState(
      status:
          $enumDecodeNullable(_$MessagesStatusEnumMap, json['status']) ??
          MessagesStatus.initial,
      messages:
          (json['messages'] as List<dynamic>?)
              ?.map(
                (e) => NotificationModel.fromJson(e as Map<String, dynamic>),
              )
              .toList() ??
          const [],
      unreadCount: (json['unreadCount'] as num?)?.toInt() ?? 0,
      isLoading: json['isLoading'] as bool? ?? false,
      hasError: json['hasError'] as bool? ?? false,
      errorMessage: json['errorMessage'] as String? ?? '',
      blockedUsers:
          (json['blockedUsers'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$MessagesStateToJson(_MessagesState instance) =>
    <String, dynamic>{
      'status': _$MessagesStatusEnumMap[instance.status]!,
      'messages': instance.messages,
      'unreadCount': instance.unreadCount,
      'isLoading': instance.isLoading,
      'hasError': instance.hasError,
      'errorMessage': instance.errorMessage,
      'blockedUsers': instance.blockedUsers,
    };

const _$MessagesStatusEnumMap = {
  MessagesStatus.initial: 'initial',
  MessagesStatus.loading: 'loading',
  MessagesStatus.loaded: 'loaded',
  MessagesStatus.error: 'error',
};
