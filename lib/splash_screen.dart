import 'dart:async';
import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:rpsbloc/routes/app_router.gr.dart';


@RoutePage()
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
      AutoRouter.of(context).push(const LoginRegisterRoute());
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    const SplashScreen();
    super.dispose();
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
              child: Image.asset(
                'assets/images/splash.png',
                height: 150,
                width: MediaQuery.of(context).size.width,
              ),
            )));
  }
}
