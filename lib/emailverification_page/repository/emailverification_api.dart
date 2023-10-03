import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rpsbloc/emailverification_page/model/emailverification_model.dart';
import 'package:rpsbloc/error/exceptions.dart';

class EmailVerificationRepository {
  Future emailverificationapi(String email, String code) async {
    final emailverificationmodel = Emailverification(email: email, code: code);
    final response = await http.post(
        Uri.parse('https://rpsremit.truestreamz.com/api/v1/emailverify'),
        body: emailverificationmodel.toJson());
    var responsedata = jsonDecode(response.body);

    switch (response.statusCode) {
      case 200:
        return responsedata;

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

class ResendCodeRepository {
  Future resendcodeapi(String email) async {
    final resendmodel = Resend(email: email);

    final response = await http.post(
        Uri.parse('https://rpsremit.truestreamz.com/api/v1/email'),
        body: resendmodel.toJson());
    var responsedata = jsonDecode(response.body);

    switch (response.statusCode) {
      case 200:
        return responsedata;
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
