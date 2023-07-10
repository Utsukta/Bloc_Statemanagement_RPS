import 'dart:async';
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
      final response = await registerRepository.registerapi(
          event.email, event.password, event.confirmpassword);

      // if (response is CredentialMismatchedException) {
      //   emit(RegisterError(response.errormessage));
      // }
      if (response is UnauthorizedException) {
        emit(RegisterError(response.errormessage));
      } else if (response is NotFoundException) {
        emit(RegisterError(response.errormessage));
      } else if (response is ServerErrorException) {
        emit(RegisterError(response.errormessage));
      } else if (response is BadRequestException) {
        emit(RegisterError(response.errormessage));
      } else {
        emit(RegisterSuccess());
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
