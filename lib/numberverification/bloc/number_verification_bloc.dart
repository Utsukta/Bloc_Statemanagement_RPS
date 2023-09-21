import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:rpsbloc/error/exceptions.dart';
import 'package:rpsbloc/numberverification/repository/numberverification_api.dart';
import 'package:rpsbloc/numberverification/repository/resendcode_api.dart';

import '../repository/mobileotpverification_api.dart';

part 'number_verification_event.dart';
part 'number_verification_state.dart';

class NumberVerificationBloc
    extends Bloc<NumberVerificationEvent, NumberVerificationState> {
  NumberVerificationRepository numberVerificationRepository =
      NumberVerificationRepository();
  MobileOTPVerificationRepository mobileOTPVerificationRepository =
      MobileOTPVerificationRepository();
  ResendCodeRepository resendCodeRepository = ResendCodeRepository();
  NumberVerificationBloc() : super(NumberVerificationInitial()) {
    on<SentOTPButtonCLickedEvent>(sentOTPButtonCLickedEvent);
    on<MobileVerifyButtonClickedEvent>(mobileverifyButtonClickedEvent);
    on<ResendCodeButtonClicked>(resendCodeButtonClicked);
  }

  FutureOr<void> sentOTPButtonCLickedEvent(SentOTPButtonCLickedEvent event,
      Emitter<NumberVerificationState> emit) async {
    emit(NumberVerificationLoadingState());
    print("here");

    try {
      var response = await numberVerificationRepository
          .numberverificationapi(event.mobile);
      print("${response["data"]["code"]}");
      emit(NumberVerificationSuccess(response["data"]["code"]));
      emit(NumberVerificationInitial());
    } on Defaultexception catch (e) {
      emit(NumberVerificationErrorState(e.error));
    }
  }

  FutureOr<void> mobileverifyButtonClickedEvent(
      MobileVerifyButtonClickedEvent event,
      Emitter<NumberVerificationState> emit) async {
    emit(MobileOTPVerificationLoadingState());
    try {
      var response = await mobileOTPVerificationRepository
          .mobileotpverificationapi(event.mobile, event.code);
      emit(MobileOTPVerificationSuccessState(response["data"]));
    } on Defaultexception catch (e) {
      emit(MobileOTPVerificationErrorState(e.error));
    }
  }

  FutureOr<void> resendCodeButtonClicked(ResendCodeButtonClicked event,
      Emitter<NumberVerificationState> emit) async {
    emit(ResendMobileCodeLoadingState());
    try {
      var response =
          await resendCodeRepository.resendmobilecodeapi(event.mobile);

      emit(ResendMobileCodeSuccessState(data: response["data"]["code"]));
      emit(NumberVerificationInitial());
    } on Defaultexception catch (e) {
      emit(ResendMobileCodeErrorState(e.error));
    }
  }
}
