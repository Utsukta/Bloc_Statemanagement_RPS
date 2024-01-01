 import 'dart:convert';

ExchangeRate exchangeRateFromJson(String str) => ExchangeRate.fromJson(json.decode(str));

String exchangeRateToJson(ExchangeRate data) => json.encode(data.toJson());

class ExchangeRate {
    bool status;
    Data data;

    ExchangeRate({
        required this.status,
        required this.data,
    });

    factory ExchangeRate.fromJson(Map<String, dynamic> json) => ExchangeRate(
        status: json["status"],
        data: Data.fromJson(json["data"]),
    );

    Map<String, dynamic> toJson() => {
        "status": status,
        "data": data.toJson(),
    };
}

class Data {
    int unit;
    String code;
    double rate;
    DateTime createdAt;
    String flag;

    Data({
        required this.unit,
        required this.code,
        required this.rate,
        required this.createdAt,
        required this.flag,
    });

    factory Data.fromJson(Map<String, dynamic> json) => Data(
        unit: json["unit"],
        code: json["code"],
        rate: json["rate"]?.toDouble(),
        createdAt: DateTime.parse(json["created_at"]),
        flag: json["flag"],
    );

    Map<String, dynamic> toJson() => {
        "unit": unit,
        "code": code,
        "rate": rate,
        "created_at": createdAt.toIso8601String(),
        "flag": flag,
    };
}

