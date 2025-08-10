import 'package:coffee_app/features/authentication/presentation/view/authentication_view.dart';
import 'package:coffee_app/features/splash/presentation/view/splash_view.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/view/home_view.dart';
import '../../features/navigation/presentation/view/app_navigation.dart';

abstract class AppRouter {
  static const kHomeView = "/homeView";
  static const kCartView = "/cartView";
  static const kDetailsView = "/detailsView";
  static const kSignupView = "/signupView";
  static const kLoginView = "/loginView";
  static const kSplashView = "/splashView";
  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => AuthenticationView()),
      //GoRoute(path: '/', builder: (context, state) => AppNavigation()),

      //GoRoute(path: kSplashView, builder: (context, state) => SplashView()),
      GoRoute(path: kHomeView, builder: (context, state) => const HomeView()),
    ],
  );
}
