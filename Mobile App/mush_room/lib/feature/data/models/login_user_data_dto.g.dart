// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'login_user_data_dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LoginUserDataDto _$LoginUserDataDtoFromJson(Map<String, dynamic> json) =>
    LoginUserDataDto(
      username: json['username'] as String?,
      password: json['password'] as String?,
      token: json['token'] as String?,
    );

Map<String, dynamic> _$LoginUserDataDtoToJson(LoginUserDataDto instance) =>
    <String, dynamic>{
      'username': instance.username,
      'password': instance.password,
      'token': instance.token,
    };
