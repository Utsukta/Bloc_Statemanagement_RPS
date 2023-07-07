import 'dart:convert';
import 'dart:io';
import 'package:rpsbloc/bloc/login_bloc.dart';

import '../view/login_view.dart';

import 'package:device_info_plus/device_info_plus.dart';

import 'package:http/http.dart' as http;

import '../model/login_model.dart';

class LoginRepository {
  final loginview = LoginView();

  Future loginapi(String email, String password) async {
    try {
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
      print(response.statusCode);

      if (response.statusCode == 200) {
        return response;
      } else if (response.statusCode == 422) {
        return LoginErrorState('Credential Mismatched');
      } else {
        return "error";
      }
    } catch (e) {
      throw e.toString();
    }
  }
}
