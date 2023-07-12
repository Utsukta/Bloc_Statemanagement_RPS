import 'dart:async';
import 'dart:io';
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

      emit(HomepageSuccess(
          response, userdetails!, services!, quicksend!, transaction!));
    } on CredentialMismatchedException {
      emit(HomepageError("Credential Mismatched"));
    } on SocketException {
      emit(HomepageError("No Internet Connection"));
    } on BadRequestException {
      emit(HomepageError("Bad Request"));
    } on UnauthorizedException {
      emit(HomepageError("Authentication is required"));
    } on ForbiddenException {
      emit(HomepageError("Dorbidden"));
    } on NotFoundException {
      emit(HomepageError("Not Found"));
    } on ServerErrorException {
      emit(HomepageError("Cannot handle the request"));
    } on BadGatewayException {
      emit(HomepageError("Bad Gateway"));
    } on ServiceUnavaiableException {
      emit(HomepageError("Service is not available"));
    } on Exception {
      emit(HomepageError("Error has occuured"));
    }
  }
}
