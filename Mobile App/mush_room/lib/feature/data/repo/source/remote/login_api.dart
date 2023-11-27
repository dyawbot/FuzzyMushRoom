import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:retrofit/retrofit.dart';

import '../../../models/login_user_data_dto.dart';

part 'login_api.g.dart';

@injectable
@RestApi(baseUrl: 'http://192.168.254.103:5000')
abstract class LoginApi {
  factory LoginApi(Dio dio, {String? baseUrl}) = _LoginApi;

  @factoryMethod
  static create(Dio dio) => LoginApi(dio);

  @POST("{url}")
  // @Body(nullToAbsent: true)
  // @FormUrlEncoded()
  @MultiPart()
  Future<LoginUserDataDto> getLoginUser({
    @Path("url") required String url,
    @Part(name: "username") required String username,
    @Part(name: "password") required String password,
  });
}
