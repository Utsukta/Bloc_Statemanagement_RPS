import 'dart:async';
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
      final response =
          await loginRepository.loginapi(event.email, event.password);
      print(response);



      if (response is CredentialMismatchedException) {
        emit(LoginErrorState(response.errormessage));
      } else if (response is UnauthorizedException) {
        emit(LoginErrorState(response.errormessage));
      } else if (response is NotFoundException) {
        emit(LoginErrorState(response.errormessage));
      } else if (response is ServerErrorException) {
        emit(LoginErrorState(response.errormessage));
      } else if (response is BadRequestException) {
        emit(LoginErrorState(response.errormessage));
      } else {
        emit(LoginSuccessState());
      }
    } catch (e) {
      emit(LoginErrorState(e.toString()));
    }
  }
}
