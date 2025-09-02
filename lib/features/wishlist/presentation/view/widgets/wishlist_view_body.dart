import 'package:coffee_app/features/wishlist/presentation/view/widgets/wishlist_list_item.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../core/widgets/custom_icon_button.dart';

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
            onPressed: GoRouter.of(context).pop,
            child: Icon(
              Ionicons.chevron_back,
              color: context.colors.onSecondary,
            ),
          ),
          actions: [
            CustomIconButton(
              padding: 8,
              onPressed: () {},
              child: Icon(
                Ionicons.heart_dislike_outline,
                color: context.colors.primary,
              ),
            ),
          ],
        ),
        SliverList.builder(
          itemBuilder: (context, index) => const Padding(
            padding: EdgeInsets.only(bottom: 16),
            child: WishlistListItem(),
          ),
          itemCount: 20,
        ),
      ],
    );
  }
}
