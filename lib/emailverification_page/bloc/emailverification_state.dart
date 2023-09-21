part of 'emailverification_bloc.dart';

abstract class EmailverificationState {}

class EmailverificationInitial extends EmailverificationState {}

class EmailverificationLoadingState extends EmailverificationState {}

class EmailverificationSuccess extends EmailverificationState {
  final String message;

  EmailverificationSuccess(this.message);
}

class EmailverificationErrorState extends EmailverificationState {
  final String error;

  EmailverificationErrorState(this.error);
}

class ResendCodeInitalState extends EmailverificationState {}

class ResendCodeLoadingState extends EmailverificationState {}

class ResendCodeSuccessState extends EmailverificationState {
  final String data;
  ResendCodeSuccessState({required this.data});
}

class ResendCodeErrorState extends EmailverificationState {
  final String error;

  ResendCodeErrorState(this.error);
}
