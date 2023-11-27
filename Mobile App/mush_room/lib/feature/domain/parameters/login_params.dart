// import 'package:equatable/equatable.dart';

import '../../../common/usecase.dart';

class LoginParams extends Params {
  final String? username;
  final String? password;

  LoginParams({required this.username, required this.password});

  @override
  List<Object?> get props => [username, password];
}
