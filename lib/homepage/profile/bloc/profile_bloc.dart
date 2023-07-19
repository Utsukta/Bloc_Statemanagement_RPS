import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(ProfileInitial()) {
    on<ProfileEvent>((event, emit) {});
    on<ExitbuttonClickedEvent>(exitbuttonClickedEvent);
  }

  FutureOr<void> exitbuttonClickedEvent(
      ExitbuttonClickedEvent event, Emitter<ProfileState> emit) {
    emit(ExitbuttonClickedState());
  }
}
