import 'package:coffee_app/features/cart/presentation/view/cart_view.dart';
import 'package:coffee_app/features/home/presentation/manager/home_category_cubit/home_category_cubit.dart';
import 'package:coffee_app/features/home/presentation/manager/home_products_cubit/home_product_cubit.dart';
import 'package:coffee_app/features/home/presentation/manager/home_top_products_cubit/home_top_products_cubit.dart';
import 'package:coffee_app/features/home/presentation/manager/review_cubit/review_cubit.dart';
import 'package:coffee_app/features/home/presentation/view/home_view/home_view.dart';
import 'package:coffee_app/features/profile/presentation/manager/locale_cubit/locale_cubit.dart';
import 'package:coffee_app/features/profile/presentation/view/profile_view/profile_view.dart';
import 'package:coffee_app/features/wishlist/presentation/view/wishlist_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/widgets/custom_container.dart';
import '../../../admin/presentation/manager/admin_role_cubit/admin_role_cubit.dart';
import '../../../admin/presentation/manager/admin_role_cubit/admin_role_state.dart';
import '../../../admin/presentation/manager/analysis_cubit/analysis_cubit.dart';
import '../../../admin/presentation/view/add_product_view/add_product_view.dart';
import '../../../admin/presentation/view/analysis_view/analysis_view.dart';
import '../../../admin/presentation/view/stock_view/stock_view.dart';
import '../../../cart/presentation/manager/cart_cubit/cart_cubit.dart';
import '../../../wishlist/presentation/manager/wishlist/wishlist_cubit.dart';
import '../manager/navigator_cubit/navigator_cubit.dart';
import 'widgets/custom_bottom_nav_bar.dart';

class AppNavigation extends StatefulWidget {
  const AppNavigation({super.key});

  @override
  State<AppNavigation> createState() => _AppNavigationState();
}

class _AppNavigationState extends State<AppNavigation> {
  @override
  void initState() {
    BlocProvider.of<CartCubit>(context).loadCart();
    BlocProvider.of<WishlistCubit>(context).getWishlist();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (context) => HomeCategoryCubit()..getCategories(),
          ),
          BlocProvider(
            create: (context) => HomeTopProductsCubit()..getTopProducts(),
          ),
          BlocProvider(
            create: (context) => AnalysisCubit()..getDashboardAnalysis(),
          ),
        ],
        child: BlocBuilder<AppNavigatorCubit, AppNavigatorState>(
          builder: (context, state) {
            return BlocListener<LocaleCubit, Locale>(
              listener: (context, locale) {
                context.read<HomeCategoryCubit>().getCategories();
                context.read<HomeProductCubit>().getProducts();
                context.read<HomeTopProductsCubit>().getTopProducts();
                context.read<CartCubit>().loadCart();
                context.read<WishlistCubit>().getWishlist();
              },
              child: BlocBuilder<AdminRoleCubit, AdminRoleState>(
                builder: (context, isAdmin) {
                  return CustomContainer(
                    child: _buildView(state, isAdmin.isAdminMode),
                  );
                },
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: CustomBottomNavBar(),
    );
  }

  Widget _buildView(AppNavigatorState state, bool isAdmin) {
    if (isAdmin) {
      // Admin Views
      if (state is AppNavigatorToHomeView) return const AnalysisView();
      if (state is AppNavigatorToCartView) return const StockView();
      if (state is AppNavigatorToWishlistView) return const AddProductView();
      if (state is AppNavigatorToProfileView) return const ProfileView();
    } else {
      // Normal User Views
      if (state is AppNavigatorToHomeView) return const HomeView();
      if (state is AppNavigatorToCartView) return const CartView();
      if (state is AppNavigatorToWishlistView) return const WishlistView();
      if (state is AppNavigatorToProfileView) return const ProfileView();
    }
    return Container();
  }
}
