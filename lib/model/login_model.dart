//model for login page
class Loginmodel {
  final String email;
  final String password;
  final String deviceId;

  Loginmodel({
    required this.email,
    required this.password,
    required this.deviceId,
  });

  factory Loginmodel.fromJson(Map<String, dynamic> json) {
    return Loginmodel(
      email: json["email"],
      password: json["password"],
      deviceId: json["device_id"],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'password': password,
      'device_id': deviceId,
    };
  }
}
