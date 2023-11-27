import 'dart:io';

import 'package:dio/dio.dart';
import 'package:mush_room/common/api_result.dart';

abstract class AppRepository {
  ApiResult<T> parseError<T>(DioException e, {T? data}) {
    if (e.type == DioErrorType.unknown) {
      var err = e.error;

      if (err is SocketException) {
        if (err.osError?.errorCode == 101) {
          return ApiResult.connectionFailed(data: data);
        }
      }
      if (err is HttpException) {
        return ApiResult.connectionFailed(message: err.uri.toString());
      }
    }

    if (e.type == DioErrorType.connectionTimeout) {
      return ApiResult.error("Connection Timeout. Please try again",
          data: data);
    }
    if ([403].contains(e.response?.statusCode)) {
      return ApiResult.sessionExpired(data: data);
    }

    if ([400].contains(e.response?.statusCode)) {
      var response = e.response!.data.toString();

      if (response.contains("ValidationError")) {
        var res = response.split("Validation Error: (u")[1];
        RegExp exp = RegExp("'(.*?)'");
        var result = exp.stringMatch(res) ?? "''";
        result = (result.substring(1, result.length - 1));
        return ApiResult.error(result, data: data);
      }
      return ApiResult.error(e.message, data: data);
    } else {
      return ApiResult.error(e.message, data: data);
    }
  }
}
