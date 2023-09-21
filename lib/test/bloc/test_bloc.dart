import 'dart:async';
import 'package:bloc/bloc.dart';

import 'package:rpsbloc/test/repository.dart';

part 'test_event.dart';
part 'test_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  ResendCode resendCode = ResendCode();

  TestBloc() : super(TestInitial()) {
    on<Testbuttonevet>(testbuttonevet);
  }

  FutureOr<void> testbuttonevet(
      Testbuttonevet event, Emitter<TestState> emit) async {
    emit(Testloading());
    var response;

    try {
      response = await resendCode.test(event.email);

      emit(TestSuccess(data: response));
    } catch (e) {}
  }
}
