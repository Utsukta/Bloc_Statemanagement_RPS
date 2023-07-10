import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:rpsbloc/error/exceptions.dart';
import 'package:rpsbloc/homepage/bloc/homepage_bloc.dart';
import 'package:rpsbloc/homepage/model/homepage_model.dart';

class HomePageRepository {
  Userdetails? userdetails;
  Services? services;
  Quicksend? quicksends;
  Transaction? transaction;
  final storetoken = const FlutterSecureStorage();
  Future<dynamic> homeapi() async {
    try {
      String? accesstoken = await storetoken.read(key: 'token');
      final response = await http.get(
          Uri.parse('https://rpsremit.truestreamz.com/api/v1/home_api/'),
          headers: {'Authorization': ' Bearer $accesstoken'});

      if (response.statusCode == 200) {
        var homePageModel = Homepagemodel.fromJson(jsonDecode(response.body));
        userdetails = Userdetails.fromJson(homePageModel.data
            .firstWhere((element) => (element["type"] == "detail")));

        services = Services.fromJson(homePageModel.data
            .firstWhere((element) => (element["type"] == "services")));

        quicksends = Quicksend.fromJson(homePageModel.data
            .firstWhere((element) => (element["type"] == "quick_send")));

        transaction = Transaction.fromJson(homePageModel.data
            .firstWhere((element) => (element["type"] == "transaction")));

        return homePageModel;
      } else if (response.statusCode == 422) {
        // return HomepageError("cred");

        return CredentialMismatchedException();
      } else if (response.statusCode == 400) {
        return BadRequestException();
      } else if (response.statusCode == 401) {
        return UnauthorizedException();
      } else if (response.statusCode == 404) {
        return NotFoundException();
      } else {
        return ServerErrorException();
      }
    } catch (e) {
      throw '$e.toString()';
    }
  }
}
