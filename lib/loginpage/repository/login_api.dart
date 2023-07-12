import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:rpsbloc/error/exceptions.dart';
import 'package:rpsbloc/loginpage/bloc/login_bloc.dart';
import 'package:rpsbloc/loginpage/model/login_model.dart';
import '../view/login_view.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginRepository {
  final loginview = const LoginPageView();
  final storetoken = const FlutterSecureStorage();

  Future loginapi(String email, String password) async {
    // try {
    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    late String deviceid;
    if (Platform.isIOS) {
      var iosDeviceInfo = await deviceInfo.iosInfo;
      deviceid = iosDeviceInfo.model;
    } else if (Platform.isAndroid) {
      var androidDeviceInfo = await deviceInfo.androidInfo;
      deviceid = androidDeviceInfo.device;
    } else if (Platform.isWindows) {
      var windowDeviceInfo = await deviceInfo.windowsInfo;
      deviceid = windowDeviceInfo.productName;
    }
    if (Platform.isMacOS) {
      var isMacOS = await deviceInfo.macOsInfo;
      deviceid = isMacOS.computerName;
    }
    final loginmodel =
        Loginmodel(email: email, password: password, deviceId: deviceid);

    final response = await http.post(
        Uri.parse('https://rpsremit.truestreamz.com/api/v1/login/'),
        body: loginmodel.toJson());

    switch (response.statusCode) {
      case 200:
        var responsedata = jsonDecode(response.body);
        var accesstoken = responsedata['data']['access_token'];
        await storetoken.write(key: 'token', value: accesstoken);
        return response;
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
