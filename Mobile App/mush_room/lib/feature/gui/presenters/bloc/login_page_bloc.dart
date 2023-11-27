import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:mush_room/common/api_result.dart';
import 'package:mush_room/feature/domain/entities/login_entity.dart';
import 'package:mush_room/feature/domain/parameters/login_params.dart';
import 'package:mush_room/feature/domain/usecases/login_usecase.dart';

part 'login_page_event.dart';
part 'login_page_state.dart';

@injectable
class LoginPageBloc extends Bloc<LoginPageEvent, LoginPageState> {
  final LoginUsecase _loginUsecase;
  LoginPageBloc(this._loginUsecase) : super(LoginPageInitial()) {
    on<GetLoginParamsEvent>((event, emit) async {
      //

      var result = await _loginUsecase(event.params);
      var status = result.status;
      print(result);

      if (status == Status.success) {
        var data = result.data;
        if (data != null) {
          emit(LoginSuccessState(data));
        } else {
          emit(LoginErrorState(result.message!));
        }
      } else {
        emit(LoginErrorState(result.message!));
      }
    });
  }
}
