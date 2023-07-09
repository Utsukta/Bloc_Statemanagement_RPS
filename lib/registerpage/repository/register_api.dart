import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:rpsbloc/error/exceptions.dart';
import 'package:rpsbloc/registerpage/model/register_model.dart';
import 'package:device_info_plus/device_info_plus.dart';

class RegisterRepository {
  Future registerapi(
      String email, String password, String confirmpassword) async {
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
      final registermodel = Registermodel(
          email: email,
          password: password,
          confirmpassword: confirmpassword,
          deviceId: deviceid);
      final response = await http.post(
          Uri.parse('https://rpsremit.truestreamz.com/api/v1/register'),
          body: registermodel.toJson());

      if (response.statusCode == 200) {
        return response;
      } else if (response.statusCode == 422) {
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
      throw e.toString();
    }
  }
}
