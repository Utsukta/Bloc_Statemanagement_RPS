import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rpsbloc/error/exceptions.dart';
import 'package:rpsbloc/numberverification/model/mobileotpverification_model.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class MobileOTPVerificationRepository {
  final storetoken = const FlutterSecureStorage();
  Future mobileotpverificationapi(String mobile, String code) async {
    String? accessToken = await storetoken.read(key: 'accessToken');

    String? refreshToken = await storetoken.read(key: 'refreshToken');
    final mobileotpverificationmodel =
        MobileOtpVerification(mobile: mobile, code: code);

    final response = await http.post(
        Uri.parse('https://rpsremit.truestreamz.com/api/v1/mobileverify'),
        headers: {'Authorization': 'Bearer $accessToken'},
        body: mobileotpverificationmodel.toJson());

    Future<void> saveAccessToken(String accessToken) async {
      await storetoken.write(key: 'accessToken', value: accessToken);
    }

    var responsedata = jsonDecode(response.body);
    print(responsedata);
    switch (response.statusCode) {
      case 200:
        return responsedata;
      case 401:
        final newAccessToken = await refreshAccessToken(refreshToken!);
        if (newAccessToken != null) {
          accessToken = newAccessToken;
          await saveAccessToken(accessToken);
          return await mobileotpverificationapi(mobile, code);
        }
        break;
      case 400:
        throw BadRequestException(error: responsedata["error"]);
      case 422:
        throw UnprocessableEntity(error: responsedata["error"]);
      case 500:
        throw ServerErrorException(error: responsedata["error"]);
      default:
        throw Defaultexception(error: responsedata["error"]);
    }
  }
}

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
  return null;
}
