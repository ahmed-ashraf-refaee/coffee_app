import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:coffee_app/generated/l10n.dart';

import '../../../../../../core/utils/text_styles.dart';
import '../../../../../home/presentation/manager/home_products_cubit/home_product_cubit.dart';
import 'loading_stock_product_card.dart';
import 'stock_product_card.dart';

class StockListBody extends StatelessWidget {
  const StockListBody({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = S.current;

    return BlocBuilder<HomeProductCubit, HomeProductState>(
      builder: (context, state) {
        if (state is HomeProductsDataLoading) {
          return ListView.builder(
            itemCount: 3,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) => const Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: LoadingStockProductCard(),
            ),
          );
        }

        if (state is HomeProductsDataFailure) {
          return Center(
            child: Text(
              '${l10n.errorPrefix} ${state.error}',
              style: TextStyles.regular15.copyWith(color: context.colors.error),
            ),
          );
        }

        if (state is HomeProductsDataSuccess) {
          final products = state.products;

          if (products.isEmpty) {
            return Center(
              child: Text(
                l10n.noProductsFound,
                style: TextStyles.regular15.copyWith(
                  color: context.colors.onSecondary,
                ),
              ),
            );
          }

          return ListView.builder(
            itemCount: products.length,
            padding: EdgeInsets.zero,
            itemBuilder: (context, index) {
              final product = products[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: StockProductCard(product: product),
              );
            },
          );
        }

        return const SizedBox.shrink();
      },
    );
  }
}
