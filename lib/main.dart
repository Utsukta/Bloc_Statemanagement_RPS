import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rpsbloc/emailverification_page/bloc/emailverification_bloc.dart';
import 'package:rpsbloc/homepage/home/bloc/homepage_bloc.dart';
import 'package:rpsbloc/homepage/profile/bloc/profile_bloc.dart';
import 'package:rpsbloc/loginRegisterPage/bloc/loginregister_bloc.dart';
import 'package:rpsbloc/loginpage/bloc/login_bloc.dart';
import 'package:rpsbloc/numberverification/bloc/number_verification_bloc.dart';
import 'package:rpsbloc/registerpage/bloc/register_bloc.dart';
import 'package:rpsbloc/routes/app_router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    final appRouter = AppRouter();
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
        BlocProvider(
          create: (context) => LoginregisterBloc(),
        ),
        BlocProvider(
          create: (context) => EmailverificationBloc(),
        ),
        BlocProvider(
          create: (context) => NumberVerificationBloc(),
        ),
      ],
      child: MaterialApp.router(
        routerConfig: appRouter.config(),
        // routes: {
        //   '/loginregisterpage': (context) => const LoginRegisterPage(),
        //   '/login': (context) => const LoginPageView(),
        //   '/register': (context) => const RegisterPageView(),
        //   '/homepage': (context) => const HomePageView(),
        //   '/numberverificationpage': (context) =>
        //       const NumberVerificationPage(),
        // },
        debugShowCheckedModeBanner: false,
        title: 'RPS',
      ),
    );
  }
}
