import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:rpsbloc/loginRegisterPage/model/loginregister_model.dart';
import 'package:rpsbloc/loginRegisterPage/repository/loginregister_api.dart';
part 'loginregister_event.dart';
part 'loginregister_state.dart';

class LoginregisterBloc extends Bloc<LoginregisterEvent, LoginregisterState> {
  // have used late here
  // late LoginRegisterRepository loginregisterrepository;
  final loginregisterrepository = LoginRegisterRepository();
  LoginregisterBloc() : super(LoginregisterInitial()) {
    on<LoginregisterSuccessEvent>(loginregisterSuccessEvent);
  }

  FutureOr<void> loginregisterSuccessEvent(
      LoginregisterSuccessEvent event, Emitter<LoginregisterState> emit) async {
    emit(LoginregisterloadingState());
    try {
      final response = await loginregisterrepository.exchangeRate();
      emit(LoginregisterSuccessState(response));
    } catch (e) {
      throw e.toString();
    }
  }
}
