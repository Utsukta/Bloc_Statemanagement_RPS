import 'dart:async';
import 'dart:convert';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:rpsbloc/repository/login_repository.dart';
import '../model/login_model.dart';
import '../view/login_view.dart';
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
     

      if (response == Null) {
        emit(LoginErrorState('Error occureed home_bloc'));
      } else if (response is LoginErrorState) {
        emit(response);
      }

      else {
        emit(LoginSuccessState());
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
