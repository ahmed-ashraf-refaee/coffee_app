import 'package:coffee_app/core/widgets/custom_icon_button.dart';
import 'package:coffee_app/features/home/presentation/manager/home_top_products_cubit/home_top_products_cubit.dart';
import 'package:coffee_app/features/home/presentation/view/home_view/widgets/carousel_list_loading.dart';
import 'package:coffee_app/features/home/presentation/view/home_view/widgets/filter_overlay.dart';

import 'package:coffee_app/generated/l10n.dart';
import 'package:coffee_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ionicons/ionicons.dart';
import '../../../../../../core/utils/text_styles.dart';
import '../../../manager/home_filter_cubit/home_filter_cubit.dart';
import '../../../manager/home_products_cubit/home_product_cubit.dart';
import 'carousel_list.dart';
import 'categories_list.dart';
import 'home_list_item.dart';
import 'loading_home_list_item.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({super.key});

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  late TextEditingController searchController;

  @override
  void initState() {
    super.initState();
    searchController = TextEditingController();

    searchController = TextEditingController(
      text: context.read<HomeFilterCubit>().selectedQuery,
    );
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverPadding(
          padding: const EdgeInsets.only(top: 16),
          sliver: BlocBuilder<HomeTopProductsCubit, HomeTopProductsState>(
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
                    child: Icon(
                      Ionicons.menu,
                      color: context.colors.onSecondary,
                    ),
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
          ),
        ),
        SliverPersistentHeader(
          pinned: true,
          delegate: SearchDelegate(
            maxHeight: 128,
            minHeight: 128,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 16),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Row(
                      children: [
                        Expanded(
                          child: SizedBox(
                            height: 48,
                            child: TextField(
                              onSubmitted: (value) {},
                              textInputAction: TextInputAction.search,
                              keyboardType: TextInputType.text,
                              controller: searchController,
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
                                context.read<HomeFilterCubit>().selectedQuery =
                                    value;
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
                                color:
                                    context.read<HomeFilterCubit>().isFiltered()
                                    ? context.colors.primary
                                    : context.colors.onSecondary,
                              );
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const CategoriesList(),
                ],
              ),
            ),
          ),
        ),

        BlocBuilder<HomeProductCubit, HomeProductState>(
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
              return SliverToBoxAdapter(
                child: Center(child: Text(state.error)),
              );
            }
            return const SliverToBoxAdapter(child: Center(child: SizedBox()));
          },
        ),
      ],
    );
  }
}

class SearchDelegate extends SliverPersistentHeaderDelegate {
  SearchDelegate({
    required this.maxHeight,
    required this.minHeight,
    required this.child,
  });

  final double maxHeight;
  final double minHeight;
  final Widget child;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [context.colors.surface, context.colors.surface.withAlpha(0)],
          end: Alignment.bottomCenter,
          begin: Alignment.topCenter,
          stops: const [0.9, 1],
        ),
      ),
      child: SizedBox.expand(child: child),
    );
  }

  @override
  double get maxExtent => maxHeight;
  @override
  double get minExtent => minHeight;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) {
    return true;
  }
}
