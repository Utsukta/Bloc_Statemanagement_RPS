import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meta/meta.dart';
import 'package:rpsbloc/error/exceptions.dart';
import 'package:rpsbloc/homepage/model/homepage_model.dart';
import 'package:rpsbloc/homepage/repository/homepage_api.dart';
part 'homepage_event.dart';
part 'homepage_state.dart';

class HomepageBloc extends Bloc<HomepageEvent, HomepageState> {
  final homepagerepository = HomePageRepository();
  HomepageBloc() : super(HomepageInitial()) {
    on<HomePageDataFetchedEvent>(homePageDataFetchedEvent);
  }

  FutureOr<void> homePageDataFetchedEvent(
      HomePageDataFetchedEvent event, Emitter<HomepageState> emit) async {
    emit(HomepageLoading());

    try {
      final response = await homepagerepository.homeapi();
      final userdetails = homepagerepository.userdetails;
      final services = homepagerepository.services;
      final quicksend = homepagerepository.quicksends;
      final transaction = homepagerepository.transaction;

      if (response is CredentialMismatchedException) {
        emit(HomepageError(response.errormessage));
      } else if (response is UnauthorizedException) {
        emit(HomepageError(response.errormessage));
      } else if (response is NotFoundException) {
        emit(HomepageError(response.errormessage));
      } else if (response is ServerErrorException) {
        emit(HomepageError(response.errormessage));
      } else if (response is BadRequestException) {
        emit(HomepageError(response.errormessage));
      } else {
        emit(HomepageSuccess(
            response, userdetails!, services!, quicksend!, transaction!));
      }
    } catch (e) {
      emit(HomepageError(e.toString()));
    }
  }
}
