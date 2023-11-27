import 'package:floor/floor.dart';

import 'app_entity.dart';

@Entity(tableName: LoginEntity.tableName)
class LoginEntity extends AppEntity {
  @ignore
  static const String tableName = "login_entity_tbl";

  @primaryKey
  final int id = 0;

  final String? username;
  final String? password;
  final String? token;

  LoginEntity(
      {required this.username, required this.password, required this.token});

  @override
  List<Object?> get props => [id, username, password, token];
}
