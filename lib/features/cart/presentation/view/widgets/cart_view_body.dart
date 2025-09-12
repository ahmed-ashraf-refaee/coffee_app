import 'package:coffee_app/core/widgets/custom_elevated_button.dart';
import 'package:coffee_app/features/cart/presentation/manager/cart_cubit/cart_cubit.dart';
import 'package:coffee_app/features/cart/presentation/view/widgets/cart_list_item.dart';
import 'package:coffee_app/features/cart/presentation/view/widgets/summary_line.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

import '../../../../../core/utils/text_styles.dart';
import '../../../../../core/widgets/custom_icon_button.dart';
import '../../../../../core/widgets/loading_list_tile.dart';
import '../../../../../generated/l10n.dart';
import '../../../../navigation/presentation/manager/navigator_cubit/navigator_cubit.dart';

class CartViewBody extends StatelessWidget {
  const CartViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                collapsedHeight: 48 + 16,
                toolbarHeight: 48,
                backgroundColor: context.colors.surface,
                leadingWidth: 48,
                leading: CustomIconButton(
                  padding: 8,
                  onPressed: () => BlocProvider.of<AppNavigatorCubit>(
                    context,
                  ).setCurrentIndex(0),
                  child: Icon(
                    Ionicons.chevron_back,
                    color: context.colors.onSecondary,
                  ),
                ),
                actions: [
                  CustomIconButton(
                    padding: 8,
                    onPressed: () {
                      BlocProvider.of<CartCubit>(context).clearCart();
                    },
                    child: Icon(
                      Ionicons.bag_remove_outline,
                      color: context.colors.primary,
                    ),
                  ),
                ],
              ),
              BlocBuilder<CartCubit, CartState>(
                builder: (context, state) {
                  if (state is CartLoading) {
                    return SliverList.builder(
                      itemCount: 7,
                      itemBuilder: (context, index) {
                        return const Padding(
                          padding: EdgeInsets.only(bottom: 16),
                          child: LoadingListTile(),
                        );
                      },
                    );
                  } else if (state is CartSuccess) {
                    if (state.cartItems.isEmpty) {
                      return SliverFillRemaining(
                        child: Center(
                          child: Text(
                            'Your Cart is empty',
                            textAlign: TextAlign.center,

                            style: TextStyles.medium20.copyWith(fontSize: 26),
                          ),
                        ),
                      );
                    }
                    return SliverList.builder(
                      itemCount: state.cartItems.length,
                      itemBuilder: (context, index) {
                        final product = state.cartItems[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 16),
                          child: CartListItem(cartItem: product),
                        );
                      },
                    );
                  } else if (state is CartFailure) {
                    return SliverFillRemaining(
                      child: Center(
                        child: Text(
                          state.error,
                          textAlign: TextAlign.center,
                          style: TextStyles.medium20.copyWith(fontSize: 26),
                        ),
                      ),
                    );
                  } else {
                    return SliverFillRemaining(
                      child: Center(
                        child: Text(
                          'Something went wrong!',
                          textAlign: TextAlign.center,

                          style: TextStyles.medium20.copyWith(fontSize: 26),
                        ),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),

        Container(
          padding: const EdgeInsets.only(top: 16),
          color: context.colors.surface,
          width: context.width,
          child: BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              if (state is CartSuccess) {
                final subTotal = state.cartItems.fold<double>(
                  0,
                  (sum, e) => sum + (e.quantity * e.productVariant!.price),
                );
                final shipping = (subTotal * 0.1);

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  spacing: 8,
                  children: [
                    SummaryLine(
                      label: S.current.sub_total,
                      value: subTotal.toStringAsFixed(2),
                      style: TextStyles.regular16,
                    ),
                    SummaryLine(
                      value: shipping.toStringAsFixed(2),
                      label: S.current.shipping,
                      style: TextStyles.regular16,
                    ),
                    Divider(color: context.colors.onSecondary, thickness: 1),
                    SummaryLine(
                      label: S.current.total_price,
                      value: (subTotal + shipping).toStringAsFixed(2),
                      style: TextStyles.regular16,
                    ),
                    CustomElevatedButton(
                      onPressed: () {},
                      child: Text(
                        S.current.continue_with_payment,
                        style: TextStyles.medium20.copyWith(
                          color: context.colors.onPrimary,
                        ),
                      ),
                    ),
                  ],
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }
}
