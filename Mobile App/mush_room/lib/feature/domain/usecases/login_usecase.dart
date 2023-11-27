import 'package:injectable/injectable.dart';
import 'package:mush_room/common/api_result.dart';
import 'package:mush_room/common/usecase.dart';
import 'package:mush_room/feature/data/repo/interface/login_repository.dart';
import 'package:mush_room/feature/domain/entities/login_entity.dart';
import 'package:mush_room/feature/domain/parameters/login_params.dart';

@injectable
class LoginUsecase
    extends Usecase<Future<ApiResult<LoginEntity>>, LoginParams> {
  final LoginRepository _repository;
  LoginUsecase(this._repository);

  @override
  call(LoginParams params) => _repository.loginRepository(params);
}
