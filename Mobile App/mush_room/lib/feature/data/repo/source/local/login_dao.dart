import 'package:floor/floor.dart';
import 'package:injectable/injectable.dart';
import 'package:mush_room/feature/data/repo/source/local/app_dao.dart';

import 'package:mush_room/feature/domain/entities/login_entity.dart';

import '../../../db/app_database.dart';

@injectable
@dao
abstract class LoginDao extends AppDao<LoginEntity> {
  @factoryMethod
  static LoginDao create(AppDatabase db) => db.loginDAO;

  @Query("SELECT * FROM ${LoginEntity.tableName}")
  Future<LoginEntity?> getAllUser();
}
