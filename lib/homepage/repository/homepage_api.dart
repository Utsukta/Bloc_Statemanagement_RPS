import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'package:rpsbloc/error/exceptions.dart';
import 'package:rpsbloc/homepage/model/homepage_model.dart';

class HomePageRepository {
  Userdetails? userdetails;
  Services? services;
  Quicksend? quicksends;
  Transaction? transaction;
  final storetoken = const FlutterSecureStorage();
  Future<dynamic> homeapi() async {
    String? accesstoken = await storetoken.read(key: 'token');
    final response = await http.get(
        Uri.parse('https://rpsremit.truestreamz.com/api/v1/home_api/'),
        headers: {'Authorization': ' Bearer $accesstoken'});

    switch (response.statusCode) {
      case 200:
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
      case 400:
        throw BadRequestException();
      case 401:
        throw UnauthorizedException();
      case 403:
        throw ForbiddenException();
      case 404:
        throw NotFoundException();
      case 422:
        throw CredentialMismatchedException();
      case 500:
        throw ServerErrorException();
      case 502:
        throw BadGatewayException();
      case 503:
        throw ServiceUnavaiableException();
      default:
        throw Exception();
    }
  }
}
