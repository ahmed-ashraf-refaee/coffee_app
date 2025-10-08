import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../core/utils/text_styles.dart';
import '../../../../../home/presentation/manager/home_products_cubit/home_product_cubit.dart';
import 'loading_stock_product_card.dart';
import 'stock_product_card.dart';

/// Extracted widget for handling the product list display logic
class StockListBody extends StatelessWidget {
  const StockListBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeProductCubit, HomeProductState>(
      builder: (context, state) {
        // --- Loading State ---
        if (state is HomeProductsDataLoading) {
          return ListView.builder(
            itemCount: 3,
            padding: EdgeInsets.zero, // Padding is handled by the main view
            itemBuilder: (context, index) => const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: LoadingStockProductCard(),
            ),
          );
        }

        // --- Failure State ---
        if (state is HomeProductsDataFailure) {
          return Center(
            child: Text(
              'Error: ${state.error}',
              style: TextStyles.regular15.copyWith(color: context.colors.error),
            ),
          );
        }

        // --- Success State ---
        if (state is HomeProductsDataSuccess) {
          final products = state.products;

          if (products.isEmpty) {
            return Center(
              child: Text(
                'No products found',
                style: TextStyles.regular15.copyWith(
                  color: context.colors.onSecondary,
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: products.length,
            padding: EdgeInsets.zero, // Padding is handled by the main view
            itemBuilder: (context, index) {
              final product = products[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: StockProductCard(product: product),
              );
            },
          );
        }

        // --- Default (initial) state ---
        // Consider having the cubit load data immediately upon creation or navigating here
        return const SizedBox.shrink();
      },
    );
  }
}
