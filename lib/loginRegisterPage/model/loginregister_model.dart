class ExchangeRate {
  bool status;
  List<Datum> data;

  ExchangeRate({
    required this.status,
    required this.data,
  });

  factory ExchangeRate.fromJson(Map<String, dynamic> json) => ExchangeRate(
        status: json["status"],
        data: List<Datum>.from(json["data"].map((x) => Datum.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "data": List<dynamic>.from(data.map((x) => x.toJson())),
      };
}

class Datum {
  int id;
  String nationality;
  String flag;
  int unit;
  String code;
  double rate;
  int status;
  DateTime createdAt;
  DateTime updatedAt;
  dynamic updatedBy;

  Datum({
    required this.id,
    required this.nationality,
    required this.flag,
    required this.unit,
    required this.code,
    required this.rate,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
    this.updatedBy,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        id: json["id"],
        nationality: json["nationality"],
        flag: json["flag"],
        unit: json["unit"],
        code: json["code"],
        rate: json["rate"]?.toDouble(),
        status: json["status"],
        createdAt: DateTime.parse(json["created_at"]),
        updatedAt: DateTime.parse(json["updated_at"]),
        updatedBy: json["updated_by"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "nationality": nationality,
        "flag": flag,
        "unit": unit,
        "code": code,
        "rate": rate,
        "status": status,
        "created_at": createdAt.toIso8601String(),
        "updated_at": updatedAt.toIso8601String(),
        "updated_by": updatedBy,
      };
}
