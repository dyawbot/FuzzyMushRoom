import 'package:equatable/equatable.dart';

enum Status { loading, success, error, initial, saved }

enum ErrorType {
  noInternet,
  serverDowm,
  sessionExpired,
  noSession,
  serverNotSupported,
  invalidUsernamePassword,
  usernameAndPasswordNotSupported,
  generic,
  connectionFailed,
}

class ApiResult<T> extends Equatable {
  final Status status;
  final T? data;
  final String? message;
  final ErrorType? errorType;

  const ApiResult._(
      {required this.status, this.data, this.message, this.errorType});

  const ApiResult.error(this.message,
      {this.status = Status.error,
      this.errorType = ErrorType.generic,
      this.data});

  const ApiResult.loading(
      {this.status = Status.loading, this.data, this.message, this.errorType});

  const ApiResult.success(this.data,
      {this.status = Status.success, this.message, this.errorType});
  const ApiResult.deleteSuccess(
    this.message, {
    this.data,
    this.status = Status.success,
    this.errorType,
  });
  const ApiResult.connectionFailed(
      {this.data,
      this.status = Status.error,
      this.message = "Connection Failed",
      this.errorType = ErrorType.connectionFailed});

  const ApiResult.invalidUsernamePassword(
      {this.data,
      this.status = Status.error,
      this.message = "Invalid Username and Password",
      this.errorType = ErrorType.invalidUsernamePassword});

  const ApiResult.sessionExpired(
      {this.status = Status.error,
      this.message = "No Internet Connection",
      this.data,
      this.errorType = ErrorType.sessionExpired});

  @override
  List<Object?> get props => [status, data, message, errorType];
}
