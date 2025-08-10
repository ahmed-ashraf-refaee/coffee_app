import 'package:coffee_app/features/navigation/presentation/manager/navigator_cubit/navigator_cubit.dart';
import 'package:coffee_app/features/authentication/presentation/view/authentication_view.dart';
import 'package:coffee_app/features/splash/presentation/view/splash_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/navigation/presentation/view/app_navigation.dart';

abstract class AppRouter {
  static const kHomeView = "/homeView";
  static const kNavigationView = "/navigationView";
  static const kCartView = "/cartView";
  static const kDetailsView = "/detailsView";
  static const kSignupView = "/signupView";
  static const kLoginView = "/loginView";
  static const kSplashView = "/splashView";
  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => SplashView()),
      GoRoute(
        path: kNavigationView,
        builder: (context, state) => BlocProvider(
          create: (context) => AppNavigatorCubit(),
          child: AppNavigation(),
        ),
      ),

      // GoRoute(path: kHomeView, builder: (context, state) => const HomeView()),
      //GoRoute(path: '/', builder: (context, state) => AuthenticationView()),
      //GoRoute(path: '/', builder: (context, state) => AppNavigation()),

      //GoRoute(path: kSplashView, builder: (context, state) => SplashView()),
      GoRoute(path: kHomeView, builder: (context, state) => const HomeView()),
    ],
  );
}
