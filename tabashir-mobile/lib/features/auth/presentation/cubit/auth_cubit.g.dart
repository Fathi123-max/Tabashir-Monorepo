// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_cubit.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_AuthState _$AuthStateFromJson(Map<String, dynamic> json) => _AuthState(
  status:
      $enumDecodeNullable(_$AuthStatusEnumMap, json['status']) ??
      AuthStatus.initial,
  email: json['email'] as String? ?? '',
  password: json['password'] as String? ?? '',
  name: json['name'] as String? ?? '',
  errorMessage: json['errorMessage'] as String? ?? '',
  isEmailVerified: json['isEmailVerified'] as bool? ?? false,
  verificationCode: json['verificationCode'] as String?,
  userType: json['userType'] as String? ?? '',
);

Map<String, dynamic> _$AuthStateToJson(_AuthState instance) =>
    <String, dynamic>{
      'status': _$AuthStatusEnumMap[instance.status]!,
      'email': instance.email,
      'password': instance.password,
      'name': instance.name,
      'errorMessage': instance.errorMessage,
      'isEmailVerified': instance.isEmailVerified,
      'verificationCode': instance.verificationCode,
      'userType': instance.userType,
    };

const _$AuthStatusEnumMap = {
  AuthStatus.initial: 'initial',
  AuthStatus.loading: 'loading',
  AuthStatus.loginSuccess: 'loginSuccess',
  AuthStatus.registerSuccess: 'registerSuccess',
  AuthStatus.emailSent: 'emailSent',
  AuthStatus.emailVerified: 'emailVerified',
  AuthStatus.error: 'error',
};
