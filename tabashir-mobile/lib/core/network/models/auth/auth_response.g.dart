// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthResponse _$AuthResponseFromJson(Map<String, dynamic> json) =>
    _AuthResponse(
      success: json['success'] as bool?,
      message: json['message'] as String?,
      data: json['data'] == null
          ? null
          : UserData.fromJson(json['data'] as Map<String, dynamic>),
      token: json['token'] as String?,
      accessToken: json['accessToken'] as String?,
      refreshToken: json['refreshToken'] as String?,
      user: json['user'] == null
          ? null
          : UserData.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$AuthResponseToJson(_AuthResponse instance) =>
    <String, dynamic>{
      'success': instance.success,
      'message': instance.message,
      'data': instance.data,
      'token': instance.token,
      'accessToken': instance.accessToken,
      'refreshToken': instance.refreshToken,
      'user': instance.user,
    };

_UserData _$UserDataFromJson(Map<String, dynamic> json) => _UserData(
  id: json['id'] as String?,
  name: json['name'] as String?,
  email: json['email'] as String?,
  userType: json['userType'] as String?,
  profileImage: json['profileImage'] as String?,
  phone: json['phone'] as String?,
  dateOfBirth: json['dateOfBirth'] as String?,
  createdAt: json['createdAt'] as String?,
  updatedAt: json['updatedAt'] as String?,
);

Map<String, dynamic> _$UserDataToJson(_UserData instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'email': instance.email,
  'userType': instance.userType,
  'profileImage': instance.profileImage,
  'phone': instance.phone,
  'dateOfBirth': instance.dateOfBirth,
  'createdAt': instance.createdAt,
  'updatedAt': instance.updatedAt,
};
