import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:rpsbloc/error/exceptions.dart';
import 'package:rpsbloc/registerpage/model/register_model.dart';
import 'package:device_info_plus/device_info_plus.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class RegisterRepository {
  final storetoken = const FlutterSecureStorage(); //use get_it here
  Future registerapi(
      String email, String password, String confirmpassword) async {
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
    final registermodel = Registermodel(
        email: email,
        password: password,
        confirmpassword: confirmpassword,
        deviceId: deviceid);
    final response = await http.post(
        Uri.parse('https://rpsremit.truestreamz.com/api/v1/register'),
        body: registermodel.toJson());
    final responsedata = jsonDecode(response.body);
    print(responsedata);
    print(response);

    switch (response.statusCode) {
      case 200:
        var accessToken = responsedata['data']['access_token'];
        var refreshToken = responsedata["data"]["refresh_token"];
        await storetoken.write(key: 'refreshToken', value: refreshToken);
        await storetoken.write(key: 'accessToken', value: accessToken);

        return responsedata;

      //changed
      case 400:
        throw BadRequestException(error: responsedata["error"]);

      case 422:
        throw UnprocessableEntity(error: responsedata["error"]);

      case 500:
      default:
        throw Defaultexception(error: responsedata["error"]);
    }
  }
}
