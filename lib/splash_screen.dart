import 'dart:async';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      Navigator.pushNamedAndRemoveUntil(context, '/test', (route) => false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 9, 90, 155),
                image: DecorationImage(
                    image: AssetImage('assets/icons/splash-bg.png'),
                    fit: BoxFit.cover)),
            child: Center(
              child: Image.asset('assets/images/splash.png'),
            )));
  }
}
