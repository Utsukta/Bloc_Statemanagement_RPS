part of 'login_bloc.dart';

abstract class LoginEvent {}

class LoginButtonCLickedEvent extends LoginEvent {
  final String email;
  final String password;
  final String? error;

  LoginButtonCLickedEvent(
      {required this.email, required this.password, this.error});
}
