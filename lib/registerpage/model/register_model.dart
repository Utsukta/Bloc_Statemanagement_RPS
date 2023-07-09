class Registermodel {
  final String email;
  final String password;
  final String confirmpassword;
  final String deviceId;

  Registermodel(
      {required this.email,
      required this.password,
      required this.confirmpassword,
      required this.deviceId});

  factory Registermodel.fromJson(Map<String, dynamic> json) {
    return Registermodel(
        email: json['email'],
        password: json['password'],
        confirmpassword: json['password_confirmation'],
        deviceId: json['device_id']);
  }

  Map<String, dynamic> toJson() {
    return {
      "email": email,
      "password": password,
      "password_confirmation": confirmpassword,
      "device_id": deviceId
    };
  }
}
