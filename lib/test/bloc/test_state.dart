part of 'test_bloc.dart';

class TestState {}

class TestInitial extends TestState {}

class Testloading extends TestState {}

class TestSuccess extends TestState {
  final String data;
  TestSuccess({required this.data});
}

class Testerror extends TestState {
  String error;
  Testerror({required this.error});
}
