import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rpsbloc/loginRegisterPage/model/loginregister_model.dart';

class LoginRegisterRepository {
  Future exchangeRate() async {
    var response = await http.get(
        Uri.parse('https://rpsremit.truestreamz.com/api/v1/exchange_rate/'));

    switch (response.statusCode) {
      case 200:
        var exchangeratedata = ExchangeRate.fromJson(jsonDecode(response.body));

        return exchangeratedata;
    }
  }
}
