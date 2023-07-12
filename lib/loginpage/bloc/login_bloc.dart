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
  }

  FutureOr<void> loginButtonCLickedEvent(
      LoginButtonCLickedEvent event, Emitter<LoginState> emit) async {
    emit(LoginLoadingState());

    try {
      await loginRepository.loginapi(event.email, event.password);

      emit(LoginSuccessState());
    } on CredentialMismatchedException {
      emit(LoginErrorState("Credential Mismatched"));
    } on SocketException {
      emit(LoginErrorState("No Internet Connection"));
    } on BadRequestException {
      emit(LoginErrorState("Bad Request"));
    } on UnauthorizedException {
      emit(LoginErrorState("Authentication is required"));
    } on ForbiddenException {
      emit(LoginErrorState("Forbidden"));
    } on NotFoundException {
      emit(LoginErrorState("Not Found"));
    } on ServerErrorException {
      emit(LoginErrorState("Cannot handle the request"));
    } on BadGatewayException {
      emit(LoginErrorState("Bad Gateway"));
    } on ServiceUnavaiableException {
      emit(LoginErrorState("Service is not available"));
    } on Exception {
      emit(LoginErrorState("Error has occuured"));
    }
  }
}
