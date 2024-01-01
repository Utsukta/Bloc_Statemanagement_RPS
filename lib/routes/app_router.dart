import 'package:auto_route/auto_route.dart';
import 'package:rpsbloc/routes/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends $AppRouter {
  @override
  List<AutoRoute> get routes => [
        AutoRoute(page: SplashRoute.page, initial: true),
        AutoRoute(page: LoginRegisterRoute.page),
        AutoRoute(page: RegisterRouteView.page),
        AutoRoute(page: LoginRouteView.page),
        AutoRoute(page: EmailVerificationView.page),
        AutoRoute(page: BarRoute.page),
        AutoRoute(page: HomeRouteView.page),
        AutoRoute(page: Profile.page),
        AutoRoute(page: NumberVerificationRoute.page),
        AutoRoute(page: MobileOTPVerification.page),
        AutoRoute(page: Recepient.page),
      ];
}
