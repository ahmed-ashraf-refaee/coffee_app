import 'package:coffee_app/features/home/presentation/manager/home_products_cubit/home_product_cubit.dart';
import 'package:coffee_app/features/home/presentation/view/home_view/widgets/home_list_item.dart';
import 'package:coffee_app/features/home/presentation/view/home_view/widgets/loading_home_list_item.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ProductsGrid extends StatelessWidget {
  const ProductsGrid({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeProductCubit, HomeProductState>(
      builder: (context, state) {
        if (state is HomeProductsDataSuccess) {
          return SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid.builder(
              itemCount: state.products.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: context.width > 500 ? 4 : 2,
                childAspectRatio: 3 / 4,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) => HomeListItem(
                key: Key(state.products[index].id.toString()),
                product: state.products[index],
              ),
            ),
          );
        } else if (state is HomeProductsDataLoading) {
          return SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid.builder(
              itemCount: 8,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: context.width > 500 ? 4 : 2,
                childAspectRatio: 3 / 4,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemBuilder: (context, index) => const LoadingHomeListItem(),
            ),
          );
        } else if (state is HomeProductsDataFailure) {
          return SliverToBoxAdapter(child: Center(child: Text(state.error)));
        }
        return const SliverToBoxAdapter(child: Center(child: SizedBox()));
      },
    );
  }
}
