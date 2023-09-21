part of 'number_verification_bloc.dart';

@immutable
class NumberVerificationState {}

class NumberVerificationInitial extends NumberVerificationState {}

class NumberVerificationLoadingState extends NumberVerificationState {}

class NumberVerificationSuccess extends NumberVerificationState {
  final int mobile;
  NumberVerificationSuccess(this.mobile);
}

class NumberVerificationErrorState extends NumberVerificationState {
  final String error;
  NumberVerificationErrorState(this.error);
}

class MobileOTPVerificationLoadingState extends NumberVerificationState {}

class MobileOTPVerificationErrorState extends NumberVerificationState {
  final String error;
  MobileOTPVerificationErrorState(this.error);
}

class MobileOTPVerificationSuccessState extends NumberVerificationState {
  final String message;

  MobileOTPVerificationSuccessState(this.message);
}

class ResendMobileCodeInitalState extends NumberVerificationState {}

class ResendMobileCodeLoadingState extends NumberVerificationState {}

class ResendMobileCodeSuccessState extends NumberVerificationState {
  final int data;
  ResendMobileCodeSuccessState({required this.data});
}

class ResendMobileCodeErrorState extends NumberVerificationState {
  final String error;

  ResendMobileCodeErrorState(this.error);
}
