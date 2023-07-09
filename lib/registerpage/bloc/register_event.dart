// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'register_bloc.dart';

@immutable
abstract class RegisterEvent {}

class RegisterButtonClickedEvent extends RegisterEvent {
  final String email;
  final String password;
  final String confirmpassword;
  RegisterButtonClickedEvent({
    required this.email,
    required this.password,
    required this.confirmpassword,
  });
}
