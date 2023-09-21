import 'dart:convert';

import 'package:rpsbloc/error/exceptions.dart';
import 'package:http/http.dart' as http;
import 'package:rpsbloc/test/model.dart';

class ResendCode {
  Future test(String email) async {
    final emailmodel = Email(email: email);
    final response = await http.post(
        Uri.parse('https://rpsremit.truestreamz.com/api/v1/email'),
        body: emailmodel.toJson());
    var responsedata = jsonDecode(response.body);

    switch (response.statusCode) {
      case 200:
        return response;
      case 500:
        throw ServerErrorException(error: responsedata["error"]);

      default:
        throw Defaultexception(error: responsedata["error"]);
    }
  }
}
