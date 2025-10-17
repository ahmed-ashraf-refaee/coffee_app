import 'package:coffee_app/core/utils/text_styles.dart';
import 'package:coffee_app/features/navigation/presentation/manager/navigator_cubit/navigator_cubit.dart';
import 'package:coffee_app/features/wishlist/presentation/manager/wishlist/wishlist_cubit.dart';
import 'package:coffee_app/features/wishlist/presentation/view/widgets/wishlist_list_item.dart';
import 'package:coffee_app/generated/l10n.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../core/widgets/custom_icon_button.dart';
import '../../../../../core/widgets/loading_list_tile.dart';

class WishListViewBody extends StatelessWidget {
  const WishListViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          collapsedHeight: 48 + 16,
          toolbarHeight: 48,
          backgroundColor: context.colors.surface,
          leadingWidth: 48,
          leading: CustomIconButton(
            padding: 8,
            onPressed: () {
              BlocProvider.of<AppNavigatorCubit>(context).setCurrentIndex(0);
            },
            child: Icon(
              Ionicons.chevron_back,
              color: context.colors.onSecondary,
            ),
          ),
          actions: [
            CustomIconButton(
              padding: 8,
              onPressed: () {
                context.read<WishlistCubit>().removeAllWishlist();
              },
              child: Icon(
                Ionicons.heart_dislike_outline,
                color: context.colors.primary,
              ),
            ),
          ],
        ),
        BlocBuilder<WishlistCubit, WishlistState>(
          builder: (context, state) {
            if (state is WishlistLoading) {
              return SliverList.builder(
                itemCount: 7,
                itemBuilder: (context, index) {
                  return const Padding(
                    padding: EdgeInsets.only(bottom: 16),
                    child: LoadingListTile(),
                  );
                },
              );
            } else if (state is WishlistSuccess) {
              if (state.products.isEmpty) {
                return SliverFillRemaining(
                  child: Center(
                    child: Text(
                      'Your wishlist is empty',
                      textAlign: TextAlign.center,

                      style: TextStyles.medium20.copyWith(fontSize: 26),
                    ),
                  ),
                );
              }
              return SliverList.builder(
                itemCount: state.products.length,
                itemBuilder: (context, index) {
                  final product = state.products[index];
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 16),
                    child: WishlistListItem(product: product),
                  );
                },
              );
            } else if (state is WishlistFailure) {
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
                    S.current.something_went_wrong,
                    textAlign: TextAlign.center,

                    style: TextStyles.medium20.copyWith(fontSize: 26),
                  ),
                ),
              );
            }
          },
        ),
      ],
    );
  }
}
