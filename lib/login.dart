import 'package:flutter/material.dart';
import 'package:rpsbloc/view/login_view.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LoginView(),
    );
  }
}
