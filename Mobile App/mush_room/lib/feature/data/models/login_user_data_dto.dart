import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:mush_room/feature/domain/entities/app_entity.dart';
import 'package:mush_room/feature/domain/entities/login_entity.dart';

import 'app_dto.dart';

part 'login_user_data_dto.g.dart';

// @JsonSerializable()
@JsonSerializable()
class LoginUserDataDto extends AppDto {
  final String? username;
  final String? password;
  final String? token;

  LoginUserDataDto(
      {required this.username, required this.password, required this.token});
  @override
  LoginEntity toEntity() =>
      LoginEntity(username: username, password: password, token: token);

  factory LoginUserDataDto.fromJson(Map<String, dynamic> json) =>
      _$LoginUserDataDtoFromJson(json);

  Map<String, dynamic> toJson() => _$LoginUserDataDtoToJson(this);
}
