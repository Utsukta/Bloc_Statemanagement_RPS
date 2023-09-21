part of 'loginregister_bloc.dart';

@immutable
abstract class LoginregisterState {}

class LoginregisterInitial extends LoginregisterState {}

class LoginregisterloadingState extends LoginregisterState {}

class LoginregisterSuccessState extends LoginregisterState {
  final ExchangeRate exchangeratedate;

  LoginregisterSuccessState(this.exchangeratedate);
}

class LoginregisterErrorState extends LoginregisterState {}
