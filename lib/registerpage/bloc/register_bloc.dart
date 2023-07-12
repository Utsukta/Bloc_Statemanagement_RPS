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
      final response = await registerRepository.registerapi(
          event.email, event.password, event.confirmpassword);
      emit(RegisterSuccess());
    } on CredentialMismatchedException {
      emit(RegisterError("Credential Mismatched"));
    } on SocketException {
      emit(RegisterError("No Internet Connection"));
    } on BadRequestException {
      emit(RegisterError("Bad Request"));
    } on UnauthorizedException {
      emit(RegisterError("Authentication is required"));
    } on ForbiddenException {
      emit(RegisterError("Forbidden"));
    } on NotFoundException {
      emit(RegisterError("Not Found"));
    } on ServerErrorException {
      emit(RegisterError("Cannot handle the request"));
    } on BadGatewayException {
      emit(RegisterError("Bad Gateway"));
    } on ServiceUnavaiableException {
      emit(RegisterError("Service is not available"));
    } on Exception {
      emit(RegisterError("Error has occuured"));
    }
  }
}
