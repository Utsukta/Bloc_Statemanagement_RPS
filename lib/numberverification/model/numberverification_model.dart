class Numberverification {
  String mobile;

  Numberverification({
    required this.mobile,
  });

  factory Numberverification.fromJson(Map<String, dynamic> json) =>
      Numberverification(
        mobile: json["mobile"],
      );

  Map<String, dynamic> toJson() => {
        "mobile": mobile,
      };
}

