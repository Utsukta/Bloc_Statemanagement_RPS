class ResendMobile {
  String mobile;

  ResendMobile({
    required this.mobile,
  });

  factory ResendMobile.fromJson(Map<String, dynamic> json) => ResendMobile(
        mobile: json["mobile"],
      );

  Map<String, dynamic> toJson() => {
        "mobile": mobile,
      };
}
