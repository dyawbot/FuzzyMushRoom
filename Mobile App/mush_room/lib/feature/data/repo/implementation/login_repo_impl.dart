import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:mush_room/common/api_result.dart';
import 'package:mush_room/feature/data/repo/interface/login_repository.dart';
import 'package:mush_room/feature/data/repo/source/local/login_dao.dart';
import 'package:mush_room/feature/data/repo/source/remote/login_api.dart';
import 'package:mush_room/feature/domain/entities/login_entity.dart';
import 'package:mush_room/feature/domain/parameters/login_params.dart';

@Injectable(as: LoginRepository)
class LoginRepoImpl extends LoginRepository {
  LoginDao _loginDao;
  LoginApi _loginApi;
  final InternetConnectionChecker _internetConnectionChecker;

  LoginRepoImpl(this._loginApi, this._loginDao,
      @Named("global") this._internetConnectionChecker);
  @override
  Future<ApiResult<LoginEntity>> loginRepository(LoginParams params) async {
    var loginUserDataDao = await _loginDao.getAllUser();
    print(params.username);
    //Check internet
    if (!(await _internetConnectionChecker.hasConnection)) {
      return ApiResult.sessionExpired();
    }

    if (loginUserDataDao == null) {
      try {
        if (![params.username, params.password].contains(null) ||
            ![params.username, params.password].contains("")) {
          var response = await _loginApi.getLoginUser(
              url: "http://192.168.254.103:5000/api/login",
              username: params.username!,
              password: params.password!);

          await _loginDao.insert(response.toEntity());
          return ApiResult.success(loginUserDataDao);
        } else {
          return ApiResult.invalidUsernamePassword();
        }
      } on DioException catch (e) {
        return ApiResult.error("Connection error: $e");
      } catch (e) {
        return ApiResult.error("Connection error: $e");
      }
    } else {
      return ApiResult.success(loginUserDataDao);
    }
  }
}
