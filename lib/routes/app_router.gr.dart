// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:auto_route/auto_route.dart' as _i13;
import 'package:flutter/material.dart' as _i14;
import 'package:rpsbloc/emailverification_page/view/emailverification_view.dart'
    as _i2;
import 'package:rpsbloc/homepage/barpage.dart/barpage.dart' as _i1;
import 'package:rpsbloc/homepage/home/view/homepage_view.dart' as _i4;
import 'package:rpsbloc/homepage/home_view.dart' as _i3;
import 'package:rpsbloc/homepage/profile/profile.dart' as _i9;
import 'package:rpsbloc/homepage/recepient.dart' as _i10;
import 'package:rpsbloc/loginpage/view/login_view.dart' as _i5;
import 'package:rpsbloc/loginRegisterPage/view/loginregister_view.dart' as _i6;
import 'package:rpsbloc/numberverification/view/mobileoptverification_view.dart'
    as _i7;
import 'package:rpsbloc/numberverification/view/numberverification_view.dart'
    as _i8;
import 'package:rpsbloc/registerpage/view/register_view.dart' as _i11;
import 'package:rpsbloc/splash_screen.dart' as _i12;

abstract class $AppRouter extends _i13.RootStackRouter {
  $AppRouter({super.navigatorKey});

  @override
  final Map<String, _i13.PageFactory> pagesMap = {
    BarRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i1.BarPage(),
      );
    },
    EmailVerificationView.name: (routeData) {
      final pathParams = routeData.inheritedPathParams;
      final args = routeData.argsAs<EmailVerificationViewArgs>(
          orElse: () =>
              EmailVerificationViewArgs(text: pathParams.getString('text')));
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i2.EmailVerificationView(
          key: args.key,
          text: args.text,
        ),
      );
    },
    HomeRouteView.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i3.HomePageView(),
      );
    },
    HomepageWidget.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i4.HomepageWidget(),
      );
    },
    LoginRouteView.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i5.LoginPageView(),
      );
    },
    LoginRegisterRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i6.LoginRegisterPage(),
      );
    },
    MobileOTPVerification.name: (routeData) {
      final args = routeData.argsAs<MobileOTPVerificationArgs>();
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: _i7.MobileOTPVerification(
          key: args.key,
          number: args.number,
        ),
      );
    },
    NumberVerificationRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i8.NumberVerificationPage(),
      );
    },
    Profile.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i9.Profile(),
      );
    },
    Recepient.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i10.Recepient(),
      );
    },
    RegisterRouteView.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i11.RegisterPageView(),
      );
    },
    SplashRoute.name: (routeData) {
      return _i13.AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const _i12.SplashScreen(),
      );
    },
  };
}

/// generated route for
/// [_i1.BarPage]
class BarRoute extends _i13.PageRouteInfo<void> {
  const BarRoute({List<_i13.PageRouteInfo>? children})
      : super(
          BarRoute.name,
          initialChildren: children,
        );

  static const String name = 'BarRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i2.EmailVerificationView]
class EmailVerificationView
    extends _i13.PageRouteInfo<EmailVerificationViewArgs> {
  EmailVerificationView({
    _i14.Key? key,
    required String text,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          EmailVerificationView.name,
          args: EmailVerificationViewArgs(
            key: key,
            text: text,
          ),
          rawPathParams: {'text': text},
          initialChildren: children,
        );

  static const String name = 'EmailVerificationView';

  static const _i13.PageInfo<EmailVerificationViewArgs> page =
      _i13.PageInfo<EmailVerificationViewArgs>(name);
}

class EmailVerificationViewArgs {
  const EmailVerificationViewArgs({
    this.key,
    required this.text,
  });

  final _i14.Key? key;

  final String text;

  @override
  String toString() {
    return 'EmailVerificationViewArgs{key: $key, text: $text}';
  }
}

/// generated route for
/// [_i3.HomePageView]
class HomeRouteView extends _i13.PageRouteInfo<void> {
  const HomeRouteView({List<_i13.PageRouteInfo>? children})
      : super(
          HomeRouteView.name,
          initialChildren: children,
        );

  static const String name = 'HomeRouteView';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i4.HomepageWidget]
class HomepageWidget extends _i13.PageRouteInfo<void> {
  const HomepageWidget({List<_i13.PageRouteInfo>? children})
      : super(
          HomepageWidget.name,
          initialChildren: children,
        );

  static const String name = 'HomepageWidget';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i5.LoginPageView]
class LoginRouteView extends _i13.PageRouteInfo<void> {
  const LoginRouteView({List<_i13.PageRouteInfo>? children})
      : super(
          LoginRouteView.name,
          initialChildren: children,
        );

  static const String name = 'LoginRouteView';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i6.LoginRegisterPage]
class LoginRegisterRoute extends _i13.PageRouteInfo<void> {
  const LoginRegisterRoute({List<_i13.PageRouteInfo>? children})
      : super(
          LoginRegisterRoute.name,
          initialChildren: children,
        );

  static const String name = 'LoginRegisterRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i7.MobileOTPVerification]
class MobileOTPVerification
    extends _i13.PageRouteInfo<MobileOTPVerificationArgs> {
  MobileOTPVerification({
    _i14.Key? key,
    required String number,
    List<_i13.PageRouteInfo>? children,
  }) : super(
          MobileOTPVerification.name,
          args: MobileOTPVerificationArgs(
            key: key,
            number: number,
          ),
          initialChildren: children,
        );

  static const String name = 'MobileOTPVerification';

  static const _i13.PageInfo<MobileOTPVerificationArgs> page =
      _i13.PageInfo<MobileOTPVerificationArgs>(name);
}

class MobileOTPVerificationArgs {
  const MobileOTPVerificationArgs({
    this.key,
    required this.number,
  });

  final _i14.Key? key;

  final String number;

  @override
  String toString() {
    return 'MobileOTPVerificationArgs{key: $key, number: $number}';
  }
}

/// generated route for
/// [_i8.NumberVerificationPage]
class NumberVerificationRoute extends _i13.PageRouteInfo<void> {
  const NumberVerificationRoute({List<_i13.PageRouteInfo>? children})
      : super(
          NumberVerificationRoute.name,
          initialChildren: children,
        );

  static const String name = 'NumberVerificationRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i9.Profile]
class Profile extends _i13.PageRouteInfo<void> {
  const Profile({List<_i13.PageRouteInfo>? children})
      : super(
          Profile.name,
          initialChildren: children,
        );

  static const String name = 'Profile';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i10.Recepient]
class Recepient extends _i13.PageRouteInfo<void> {
  const Recepient({List<_i13.PageRouteInfo>? children})
      : super(
          Recepient.name,
          initialChildren: children,
        );

  static const String name = 'Recepient';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i11.RegisterPageView]
class RegisterRouteView extends _i13.PageRouteInfo<void> {
  const RegisterRouteView({List<_i13.PageRouteInfo>? children})
      : super(
          RegisterRouteView.name,
          initialChildren: children,
        );

  static const String name = 'RegisterRouteView';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}

/// generated route for
/// [_i12.SplashScreen]
class SplashRoute extends _i13.PageRouteInfo<void> {
  const SplashRoute({List<_i13.PageRouteInfo>? children})
      : super(
          SplashRoute.name,
          initialChildren: children,
        );

  static const String name = 'SplashRoute';

  static const _i13.PageInfo<void> page = _i13.PageInfo<void>(name);
}
