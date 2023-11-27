part of 'login_page_bloc.dart';

abstract class LoginPageState extends Equatable {
  const LoginPageState();
}

class LoginPageInitial extends LoginPageState {
  @override
  List<Object> get props => [];
}

class LoginSuccessState extends LoginPageState {
  final LoginEntity loginEntity;
  const LoginSuccessState(this.loginEntity);
  @override
  List<Object> get props => [loginEntity];
}

class LoginErrorState extends LoginPageState {
  final String message;
  const LoginErrorState(this.message);
  @override
  List<Object> get props => [message];
}

class LoginNoCredentialState extends LoginPageState {
  @override
  List<Object> get props => [];
}
