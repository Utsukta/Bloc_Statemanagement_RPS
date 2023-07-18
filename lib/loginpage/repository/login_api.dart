import 'dart:convert';
import 'dart:io';
import 'package:rpsbloc/error/exceptions.dart';
import 'package:rpsbloc/loginpage/model/login_model.dart';
import '../view/login_view.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class LoginRepository {
  final loginview = const LoginPageView();
  final storetoken = const FlutterSecureStorage();

  Future loginapi(
    String email,
    String password,
  ) async {
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

    var responsedata = jsonDecode(response.body);

    switch (response.statusCode) {
      case 200:
        var accessToken = responsedata['data']['access_token'];
        print('loginpage $accessToken');
        var refreshToken = responsedata["data"]["refresh_token"];
        await storetoken.write(key: 'refreshToken', value: refreshToken);
        await storetoken.write(key: 'accessToken', value: accessToken);
        return response;

      case 422:
        throw UnprocessableEntity(error: responsedata["error"]);

    

      default:
        throw Defaultexception(error: responsedata["error"]);
    }
  }
}
