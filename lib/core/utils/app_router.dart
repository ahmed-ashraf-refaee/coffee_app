import 'package:coffee_app/features/home/presentation/view/details_view/details_view.dart';
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
  static const kAuthView = "/authView";
  static const kSplashView = "/splashView";
  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashView()),
      GoRoute(
        path: "$kDetailsView/:tag",
        builder: (context, state) {
          final String tag = state.pathParameters['tag']!;
          return DetailsView(tag: tag);
        },
      ),
      GoRoute(
        path: kNavigationView,
        builder: (context, state) => BlocProvider(
          create: (context) => AppNavigatorCubit(),
          child: const AppNavigation(),
        ),
      ),

      // GoRoute(path: kHomeView, builder: (context, state) => const HomeView()),
      GoRoute(
        path: 'kAuthView',
        builder: (context, state) => const AuthenticationView(),
      ),
      //GoRoute(path: '/', builder: (context, state) => AppNavigation()),

      //GoRoute(path: kSplashView, builder: (context, state) => SplashView()),
      //GoRoute(path: kHomeView, builder: (context, state) => const HomeView()),
    ],
  );
}
