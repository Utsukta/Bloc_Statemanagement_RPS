import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rpsbloc/homepage/home/bloc/homepage_bloc.dart';
import 'package:rpsbloc/loginpage/bloc/login_bloc.dart';
import 'package:rpsbloc/registerpage/bloc/register_bloc.dart';
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
        )
      ],
      child: const MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'RPS',
          home: SplashScreen()),
    );
  }
}
