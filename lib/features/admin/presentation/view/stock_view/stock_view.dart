import 'package:coffee_app/core/widgets/custom_app_bar.dart';
import 'package:coffee_app/features/admin/presentation/view/stock_view/widgets/loading_stock_product_card.dart';
import 'package:coffee_app/features/home/presentation/manager/home_products_cubit/home_product_cubit.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../core/utils/text_styles.dart';
import '../../../../../core/widgets/custom_icon_button.dart';
import '../../../../../generated/l10n.dart';
import '../../../../home/presentation/manager/home_filter_cubit/home_filter_cubit.dart';
import '../../../../home/presentation/view/home_view/widgets/filter_overlay.dart';
import 'widgets/stock_product_card.dart';

class StockScreen extends StatefulWidget {
  const StockScreen({super.key});

  @override
  State<StockScreen> createState() => _StockScreenState();
}

class _StockScreenState extends State<StockScreen> {
  final TextEditingController _searchController = TextEditingController();
  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        spacing: 16,
        children: [
          CustomAppBar(
            leading: CustomIconButton(
              padding: 8,
              onPressed: () {},
              child: Icon(
                Ionicons.chevron_back,
                color: context.colors.onSecondary,
              ),
            ),
          ),
          _buildHeader(context),
          BlocBuilder<HomeProductCubit, HomeProductState>(
            builder: (context, state) {
              if (state is HomeProductsDataLoading) {
                return Expanded(
                  child: ListView.builder(
                    itemCount: 3,
                    padding: const EdgeInsets.only(bottom: 8.0),
                    itemBuilder: (context, index) => const Padding(
                      padding: EdgeInsets.only(bottom: 8.0),
                      child: LoadingStockProductCard(),
                    ),
                  ),
                );
              }

              if (state is HomeProductsDataFailure) {
                return Center(
                  child: Text(
                    'Error: ${state.error}',
                    style: TextStyles.regular15.copyWith(
                      color: context.colors.error,
                    ),
                  ),
                );
              }

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

                return Expanded(
                  child: ListView.builder(
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      final product = products[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: StockProductCard(product: product),
                      );
                    },
                  ),
                );
              }

              // Default (initial) state
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Admin Dashboard',
          style: TextStyles.bold20.copyWith(color: context.colors.onSurface),
        ),
        const SizedBox(height: 4),
        Text(
          'Manage your products and stock levels',
          style: TextStyles.regular15.copyWith(
            color: context.colors.onSecondary,
          ),
        ),
        const SizedBox(height: 20),
        Row(
          children: [
            Expanded(
              child: SizedBox(
                height: 48,
                child: TextField(
                  onSubmitted: (value) {},
                  textInputAction: TextInputAction.search,
                  keyboardType: TextInputType.text,
                  controller: _searchController,
                  decoration: InputDecoration(
                    prefixIcon: CustomIconButton(
                      onPressed: () {},
                      child: const Icon(Ionicons.search_outline),
                    ),
                    hintText: S.current.search,
                    prefixIconColor: context.colors.onSecondary,
                    hintStyle: TextStyles.medium16.copyWith(
                      color: context.colors.onSecondary,
                    ),
                  ),
                  onChanged: (value) {
                    context.read<HomeFilterCubit>().selectedQuery = value;
                    context.read<HomeFilterCubit>().setSearch();
                  },
                ),
              ),
            ),
            const SizedBox(width: 8),
            CustomIconButton(
              onPressed: () {
                filterOverlay(context);
              },
              hight: 48,
              width: 48,
              child: BlocBuilder<HomeFilterCubit, HomeFilterState>(
                builder: (context, state) {
                  return Icon(
                    Ionicons.filter,
                    color: context.read<HomeFilterCubit>().isFiltered()
                        ? context.colors.primary
                        : context.colors.onSecondary,
                  );
                },
              ),
            ),
          ],
        ),
      ],
    );
  }
}
