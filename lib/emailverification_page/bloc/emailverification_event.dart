part of 'emailverification_bloc.dart';

@immutable
abstract class EmailverificationEvent {}

class VerifyButtonClickedEvent extends EmailverificationEvent {
  final String email;
  final String code;

  VerifyButtonClickedEvent({required this.email, required this.code});
}

class ResendCodeButtonClicked extends EmailverificationEvent {
  final String email;
  ResendCodeButtonClicked({required this.email});
}
