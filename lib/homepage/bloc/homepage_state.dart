// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'homepage_bloc.dart';

@immutable
abstract class HomepageState {}

class HomepageInitial extends HomepageState {}

class HomepageLoading extends HomepageState {}

class HomepageSuccess extends HomepageState {
  final Homepagemodel homepagemodel;
  final Userdetails userdetails;
  final Services services;
  final Quicksend quicksend;
  final Transaction transaction;
  HomepageSuccess(
    this.homepagemodel,
    this.userdetails,
    this.services,
    this.quicksend,
    this.transaction,
  );
}

class HomepageError extends HomepageState {
  final String message;

  HomepageError(this.message);
}
