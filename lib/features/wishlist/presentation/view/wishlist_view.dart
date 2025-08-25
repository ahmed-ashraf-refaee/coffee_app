import 'package:coffee_app/features/wishlist/presentation/view/widgets/wishlist_view_body.dart';
import 'package:flutter/material.dart';

class WishlistView extends StatelessWidget {
  const WishlistView({super.key});

  @override
  Widget build(BuildContext context) {
    return const  SafeArea(
      child: Padding(
        padding: EdgeInsets.only(top: 16, left: 16, right: 16),
        child: WishListViewBody(),
      ),
    );
  }
}
