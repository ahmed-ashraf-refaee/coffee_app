import 'package:coffee_app/features/splash/presentation/view/splash_view.dart';
import 'package:go_router/go_router.dart';

import '../../features/home/presentation/view/home_view.dart';

abstract class AppRouter {
  static const kHomeView = "/homeView";
  static const kCartView = "/cartView";
  static const kDetailsView = "/detailsView";
  static final router = GoRouter(
    routes: [
      GoRoute(path: '/', builder: (context, state) => const SplashView()),

      GoRoute(path: kHomeView, builder: (context, state) => const HomeView()),
    ],
  );
}
