import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rpsbloc/homepage/home/bloc/homepage_bloc.dart';
import 'package:rpsbloc/homepage/home/view/homepage_view.dart';
import 'package:rpsbloc/homepage/profile/bloc/profile_bloc.dart';
import 'package:rpsbloc/loginpage/bloc/login_bloc.dart';
import 'package:rpsbloc/loginpage/view/login_view.dart';
import 'package:rpsbloc/loginregisterpage.dart';
import 'package:rpsbloc/registerpage/bloc/register_bloc.dart';
import 'package:rpsbloc/registerpage/view/register_view.dart';
import 'package:rpsbloc/splash_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => LoginBloc(),
        ),
        BlocProvider(
          create: (context) => RegisterBloc(),
        ),
        BlocProvider(
          create: (context) => HomepageBloc(),
        ),
        BlocProvider(
          create: (context) => ProfileBloc(),
        ),
      ],
      child: MaterialApp(
          routes: {
            '/loginregisterpage': (context) => const LoginRegisterPage(),
            '/login': (context) => const LoginPageView(),
            '/register': (context) => const RegisterPageView(),
            '/homepage': (context) => const HomePageView(),
          },
          debugShowCheckedModeBanner: false,
          title: 'RPS',
          home: const SplashScreen()),
    );
  }
}
