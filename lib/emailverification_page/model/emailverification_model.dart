class Emailverification {
  String email;
  String? code;

  Emailverification({
    required this.email,
    this.code,
  });

  factory Emailverification.fromJson(Map<String, dynamic> json) =>
      Emailverification(
        email: json["email"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
        "code": code,
      };
}

//for resend code
class Resend {
  String email;

  Resend({
    required this.email,
  });

  factory Resend.fromJson(Map<String, dynamic> json) => Resend(
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
      };
}
