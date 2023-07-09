part of 'login_bloc.dart';


abstract class LoginEvent {}

class LoginButtonCLickedEvent extends LoginEvent {
  final String email;
  final String password;

  LoginButtonCLickedEvent(this.email, this.password);
}

