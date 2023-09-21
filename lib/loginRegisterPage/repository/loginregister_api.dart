import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:rpsbloc/loginRegisterPage/model/loginregister_model.dart';

class LoginRegisterRepository {
  Future exchangeRate() async {
    final response = await http.get(
        Uri.parse('https://rpsremit.truestreamz.com/api/v1/exchange_rate/'));

    switch (response.statusCode) {
      case 200:
        final exchangeratedata =
            ExchangeRate.fromJson(jsonDecode(response.body));
        return exchangeratedata;
    }
  }
}
