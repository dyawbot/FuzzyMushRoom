part of 'login_page_bloc.dart';

abstract class LoginPageEvent extends Equatable {
  const LoginPageEvent();
}

class GetLoginParamsEvent extends LoginPageEvent {
  final LoginParams params;

  const GetLoginParamsEvent(this.params);
  @override
  List<Object> get props => [params];
}
