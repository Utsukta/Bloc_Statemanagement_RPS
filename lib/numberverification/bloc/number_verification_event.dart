part of 'number_verification_bloc.dart';

@immutable
class NumberVerificationEvent {}

class SentOTPButtonCLickedEvent extends NumberVerificationEvent {
  final String mobile;
  SentOTPButtonCLickedEvent(this.mobile);
}

class MobileVerifyButtonClickedEvent extends NumberVerificationEvent {
  final String mobile;
  final String code;
  MobileVerifyButtonClickedEvent(this.mobile, this.code);
}

class ResendCodeButtonClicked extends NumberVerificationEvent {
  final String mobile;
  ResendCodeButtonClicked(this.mobile);
}
