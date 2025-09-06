import 'package:coffee_app/features/cart/presentation/view/cart_view.dart';
import 'package:coffee_app/features/home/presentation/manager/home_category_cubit/home_category_cubit.dart';
import 'package:coffee_app/features/home/presentation/manager/home_products_cubit/home_product_cubit.dart';
import 'package:coffee_app/features/home/presentation/view/home_view/home_view.dart';
import 'package:coffee_app/features/profile/presentation/view/profile_view.dart';
import 'package:coffee_app/features/wishlist/presentation/view/wishlist_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_container.dart';
import '../manager/navigator_cubit/navigator_cubit.dart';
import 'widgets/custom_bottom_nav_bar.dart';

class AppNavigation extends StatelessWidget {
  const AppNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => HomeProductCubit()..getProducts()),
          BlocProvider(
            create: (context) => HomeCategoryCubit()..getCategories(),
          ),
        ],
        child: BlocBuilder<AppNavigatorCubit, AppNavigatorState>(
          builder: (context, state) {
            return CustomContainer(
              child: state is AppNavigatorToHomeView
                  ? const HomeView()
                  : state is AppNavigatorToCartView
                  ? const CartView()
                  : state is AppNavigatorToWishlistView
                  ? const WishlistView()
                  : state is AppNavigatorToProfileView
                  ? const ProfileView()
                  : Container(),
            );
          },
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }
}
