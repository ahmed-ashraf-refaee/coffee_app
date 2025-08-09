import 'package:coffee_app/features/navigation/presentation/manager/navigator_cubit/navigator_cubit.dart';
import 'package:coffee_app/features/profile/presentation/view/profile_view.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/view/home_view.dart';
import '../../features/navigation/presentation/view/app_navigation.dart';
import '../../features/splash/presentation/view/splash_view.dart';

abstract class AppRouter {
  static const kHomeView = "/homeView";
  static const kNavigationView = "/navigationView";
  static const kCartView = "/cartView";
  static const kDetailsView = "/detailsView";
  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => ProfileView()),
      GoRoute(
        path: kNavigationView,
        builder: (context, state) => BlocProvider(
          create: (context) => AppNavigatorCubit(),
          child: AppNavigation(),
        ),
      ),

      GoRoute(path: kHomeView, builder: (context, state) => const HomeView()),
    ],
  );
}
