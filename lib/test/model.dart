class Email {
  String email;

  Email({
    required this.email,
  });

  factory Email.fromJson(Map<String, dynamic> json) => Email(
        email: json["email"],
      );

  Map<String, dynamic> toJson() => {
        "email": email,
      };
}
