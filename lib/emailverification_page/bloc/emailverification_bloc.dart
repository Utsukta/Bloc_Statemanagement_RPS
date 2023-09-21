import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:rpsbloc/emailverification_page/repository/emailverification_api.dart';
import 'package:rpsbloc/error/exceptions.dart';
part 'emailverification_event.dart';
part 'emailverification_state.dart';

class EmailverificationBloc
    extends Bloc<EmailverificationEvent, EmailverificationState> {
  EmailVerificationRepository emailVerificationRepository =
      EmailVerificationRepository();
  ResendCodeRepository resendCodeRepository = ResendCodeRepository();

  EmailverificationBloc() : super(EmailverificationInitial()) {
    on<VerifyButtonClickedEvent>(emailverifiedevent);
    on<ResendCodeButtonClicked>(resendCodeButtonClicked);
  }

  FutureOr<void> emailverifiedevent(VerifyButtonClickedEvent event,
      Emitter<EmailverificationState> emit) async {
    emit(EmailverificationLoadingState());
    try {
      var response = await emailVerificationRepository.emailverificationapi(
          event.email, event.code);
      emit(EmailverificationSuccess(response["data"]));
    } on Defaultexception catch (e) {
      emit(EmailverificationErrorState(e.error));
    }
  }

  FutureOr<void> resendCodeButtonClicked(ResendCodeButtonClicked event,
      Emitter<EmailverificationState> emit) async {
    emit(ResendCodeLoadingState());
    try {
      var response = await resendCodeRepository.resendcodeapi(event.email);

      emit(ResendCodeSuccessState(data: response["data"]));
      emit(EmailverificationInitial());
    } on Defaultexception catch (e) {
      emit(ResendCodeErrorState(e.error));
    }
  }
}
