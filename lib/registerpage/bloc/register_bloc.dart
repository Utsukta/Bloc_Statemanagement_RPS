import 'dart:async';
import 'dart:io';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:rpsbloc/error/exceptions.dart';
import 'package:rpsbloc/registerpage/repository/register_api.dart';
part 'register_event.dart';
part 'register_state.dart';

class RegisterBloc extends Bloc<RegisterEvent, RegisterState> {
  final registerRepository = RegisterRepository();
  RegisterBloc() : super(RegisterInitial()) {
    on<RegisterButtonClickedEvent>(registerButtonClickedEvent);
  }

  FutureOr<void> registerButtonClickedEvent(
      RegisterButtonClickedEvent event, Emitter<RegisterState> emit) async {
    emit(RegisterLoading());

    try {
      await registerRepository.registerapi(
          event.email, event.password, event.confirmpassword);
      emit(RegisterSuccess());
    } on BadRequestException catch (e) {
      emit(RegisterError(e.error));
    } on UnprocessableEntity catch (e) {
      emit(RegisterError(e.error));
    } on SocketException {
      emit(RegisterError("No Internet Connection"));
    } on Defaultexception catch (e) {
      emit(RegisterError(e.error));
    }
  }
}
