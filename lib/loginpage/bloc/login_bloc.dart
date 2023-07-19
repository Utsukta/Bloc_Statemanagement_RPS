import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rpsbloc/error/exceptions.dart';
import 'package:rpsbloc/loginpage/repository/login_api.dart';
part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final loginRepository = LoginRepository();

  LoginBloc() : super(LoginInitial()) {
    on<LoginButtonCLickedEvent>(loginButtonCLickedEvent);
    on<LogoutSuccessEvent>(logoutSuccessEvent);
  }

  FutureOr<void> loginButtonCLickedEvent(
      LoginButtonCLickedEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());

    try {
      await loginRepository.loginapi(
        event.email,
        event.password,
      );
      emit(LoginSuccessState());
    } on UnprocessableEntity catch (e) {
      emit(LoginErrorState(e.error));
    } on SocketException {
      emit(LoginErrorState("No Internet Connection"));
    } on Defaultexception catch (e) {
      emit(LoginErrorState(e.error));
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }

  FutureOr<void> logoutSuccessEvent(
      LogoutSuccessEvent event, Emitter<LoginState> emit) {
    emit(LogoutSuccessState());
  }
}
