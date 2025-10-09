import 'package:coffee_app/core/model/product_model.dart';
import 'package:coffee_app/features/admin/presentation/view/add_product_view/add_product_view.dart';
import 'package:coffee_app/features/admin/presentation/view/stock_view/stock_view.dart';
import 'package:coffee_app/features/authentication/presentation/view/authentication_view/authentication_view.dart';
import 'package:coffee_app/features/authentication/presentation/view/forgot_password_view/forgot_password_view.dart';
import 'package:coffee_app/features/checkout/presentation/views/address_view/add_address_view.dart';
import 'package:coffee_app/features/checkout/presentation/views/address_view/address_view.dart';
import 'package:coffee_app/features/checkout/presentation/views/checkout_view/checkout_view.dart';
import 'package:coffee_app/features/checkout/presentation/views/payment_view/payment_view.dart';
import 'package:coffee_app/features/home/presentation/view/details_view/details_view.dart';
import 'package:coffee_app/features/navigation/presentation/manager/navigator_cubit/navigator_cubit.dart';
import 'package:coffee_app/features/profile/presentation/view/language_select_view.dart';
import 'package:coffee_app/features/splash/presentation/view/splash_view.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../features/checkout/data/repo/order/order_repo_impl.dart';
import '../../features/checkout/presentation/manager/order/order_cubit.dart';
import '../../features/maps/presentation/view/map_view.dart';
import '../../features/navigation/presentation/view/app_navigation.dart';

abstract class AppRouter {
  static const kHomeView = "/homeView";
  static const kNavigationView = "/navigationView";
  static const kCartView = "/cartView";
  static const kDetailsView = "/detailsView";
  static const kAuthView = "/authView";
  static const kSplashView = "/splashView";
  static const kForgotPass = "/forgotPass";
  static const kResetPassword = "/reset-password";
  static const kLanguageSelect = "/languageSelect";
  static const kPaymentView = "/paymentView";
  static const kCheckoutView = "/checkoutView";
  static const kAddressView = "/addressView";
  static const kAddAddressView = "/addAddressView";
  static const kMapView = "/mapView";

  static final router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) =>
            const Scaffold(body: SafeArea(child: StockScreen())),
      ),
      GoRoute(
        path: kCheckoutView,
        builder: (context, state) {
          return BlocProvider(
            create: (context) => OrderCubit(OrderRepoImpl()),
            child: CheckoutView(
              checkoutSummery: state.extra as Map<String, double>,
            ),
          );
        },
      ),
      GoRoute(
        path: kDetailsView,
        builder: (context, state) {
          final Map<String, dynamic> extra =
              state.extra as Map<String, dynamic>;
          final String tag = extra['tag'] as String;
          final ProductModel product = extra['product'] as ProductModel;
          return DetailsView(product: product, tag: tag);
        },
      ),
      GoRoute(
        path: kLanguageSelect,
        builder: (context, state) => const LanguageSelectView(),
      ),
      GoRoute(
        path: kNavigationView,
        builder: (context, state) => BlocProvider(
          create: (context) => AppNavigatorCubit(),
          child: const AppNavigation(),
        ),
      ),
      GoRoute(
        path: kAuthView,
        builder: (context, state) => const AuthenticationView(),
      ),
      GoRoute(
        path: kForgotPass,
        builder: (context, state) => const ForgotPasswordView(),
      ),
      GoRoute(
        path: kResetPassword,
        builder: (context, state) => const ForgotPasswordView(
          forgotPasswordState: ForgotPasswordState.resetPassword,
        ),
      ),
      GoRoute(
        path: kPaymentView,
        builder: (context, state) => const PaymentView(),
      ),
      GoRoute(
        path: kAddressView,
        builder: (context, state) => const AddressView(),
      ),
      GoRoute(
        path: kAddAddressView,
        builder: (context, state) {
          return const AddAddressView();
        },
      ),
      GoRoute(
        path: kMapView,
        builder: (context, state) {
          final Map<String, double>? latlong =
              state.extra as Map<String, double>?;
          return MapsView(latlong: latlong);
        },
      ),
    ],
  );
}
