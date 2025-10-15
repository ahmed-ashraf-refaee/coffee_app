import 'package:coffee_app/core/widgets/custom_icon_button.dart';
import 'package:coffee_app/features/home/presentation/manager/home_top_products_cubit/home_top_products_cubit.dart';
import 'package:coffee_app/features/home/presentation/view/home_view/widgets/carousel_list.dart';
import 'package:coffee_app/features/home/presentation/view/home_view/widgets/carousel_list_loading.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeTopProductsCubit, HomeTopProductsState>(
      builder: (context, state) {
        final noData = state is TopProductsFailure;
        FlexibleSpaceBar? flexibleSpace;

        if (state is TopProductsLoading) {
          flexibleSpace = const FlexibleSpaceBar(
            background: Padding(
              padding: EdgeInsets.only(top: 64),
              child: CarouselListLoading(),
            ),
          );
        } else if (state is TopProductsSuccess) {
          flexibleSpace = FlexibleSpaceBar(
            background: Padding(
              padding: const EdgeInsets.only(top: 64),
              child: CarouselList(topProducts: state.products),
            ),
          );
        }
        return SliverAppBar(
          collapsedHeight: 48,
          expandedHeight: noData ? 0 : 224,
          toolbarHeight: 48,
          forceMaterialTransparency: true,
          pinned: false,
          backgroundColor: Colors.transparent,
          leadingWidth: 48 + 32,
          actionsPadding: const EdgeInsets.symmetric(horizontal: 16),
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: CustomIconButton(
              padding: 8,
              onPressed: () {},
              child: Icon(Ionicons.menu, color: context.colors.onSecondary),
            ),
          ),
          actions: [
            CustomIconButton(
              width: 48,
              padding: 8,
              onPressed: () {},
              child: Icon(
                Ionicons.notifications_outline,
                color: context.colors.primary,
              ),
            ),
          ],
          flexibleSpace: noData ? null : flexibleSpace,

          forceElevated: false,
        );
      },
    );
  }
}
