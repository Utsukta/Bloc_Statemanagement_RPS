class MobileOtpVerification {
  String mobile;
  String code;

  MobileOtpVerification({
    required this.mobile,
    required this.code,
  });

  factory MobileOtpVerification.fromJson(Map<String, dynamic> json) =>
      MobileOtpVerification(
        mobile: json["mobile"],
        code: json["code"],
      );

  Map<String, dynamic> toJson() => {
        "mobile": mobile,
        "code": code,
      };
}
