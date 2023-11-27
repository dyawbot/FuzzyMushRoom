import 'package:mush_room/common/api_result.dart';
import 'package:mush_room/feature/data/repo/interface/app_repository.dart';
import 'package:mush_room/feature/domain/entities/login_entity.dart';
import 'package:mush_room/feature/domain/parameters/login_params.dart';

abstract class LoginRepository extends AppRepository {
  Future<ApiResult<LoginEntity>> loginRepository(LoginParams params);
}
