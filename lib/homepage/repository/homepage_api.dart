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
    String? accessToken = await storetoken.read(key: 'accessToken');

    String? refreshToken = await storetoken.read(key: 'refreshToken');
    // print("refreshtoken is $refreshToken");

    Future<void> saveAccessToken(String accessToken) async {
      await storetoken.write(key: 'accessToken', value: accessToken);
      // print(' refreshed access token is $accessToken');
    }

    final response = await http.get(
      Uri.parse('https://rpsremit.truestreamz.com/api/v1/home_api/'),
      headers: {'Authorization': 'Bearer $accessToken??'},
    );
    final responsedata = jsonDecode(response.body);

    switch (response.statusCode) {
      case 200:
        var homePageModel = Homepagemodel.fromJson(jsonDecode(response.body));
        userdetails = Userdetails.fromJson(homePageModel.data
            .firstWhere((element) => element["type"] == "detail"));

        services = Services.fromJson(homePageModel.data
            .firstWhere((element) => element["type"] == "services"));

        quicksends = Quicksend.fromJson(homePageModel.data
            .firstWhere((element) => element["type"] == "quick_send"));

        transaction = Transaction.fromJson(homePageModel.data
            .firstWhere((element) => element["type"] == "transaction"));
        break;

      // return homePageModel;

      case 401:
        final newAccessToken = await refreshAccessToken(refreshToken!);
        if (newAccessToken != null) {
          accessToken = newAccessToken;
          await saveAccessToken(accessToken);
          return await homeapi();
        }
        break;

      default:
        throw Defaultexception(error: responsedata["error"]);
    }
  }

  // ignore: body_might_complete_normally_nullable
  Future<String?> refreshAccessToken(String refreshToken) async {
    final response = await http.post(
      Uri.parse('https://rpsremit.truestreamz.com/api/token/refresh/'),
      body: {'refresh': refreshToken},
    );

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);
      return responseData['access'];
    } else if (response.statusCode == 401) {
      throw RefreshTokenExpired();
    }
  }

  Future logoutAccessTokenDelete() async {
    await storetoken.delete(key: 'accessToken');
  }
}
