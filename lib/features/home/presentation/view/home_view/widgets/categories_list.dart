import 'package:coffee_app/core/helper/ui_helpers.dart';
import 'package:coffee_app/core/model/categories_model.dart';
import 'package:coffee_app/features/home/presentation/manager/home_category_cubit/home_category_cubit.dart';
import 'package:coffee_app/features/home/presentation/manager/home_products_cubit/home_product_cubit.dart';
import 'package:coffee_app/features/home/presentation/view/home_view/widgets/categories_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key});

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  late ScrollController scrollController;
  late HomeCategoryCubit categoryCubit;

  @override
  void initState() {
    categoryCubit = context.read<HomeCategoryCubit>();
    scrollController = ScrollController(
      initialScrollOffset: categoryCubit.categoryListScrollOffset,
    );

    scrollController.addListener(() {
      categoryCubit.saveScrollOffset(scrollController.offset);
    });
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: BlocBuilder<HomeCategoryCubit, HomeCategoryState>(
        builder: (context, state) {
          if (state is ProductCategoriesSuccess) {
            return ListView.builder(
              controller: scrollController,
              itemCount: state.category.length,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CategoriesListItem(
                    category: state.category[index],
                    selected: categoryCubit.selectedCategoryIndex == index,
                    onSelected: () {
                      categoryCubit.updateSelectedIndex(index);
                      context.read<HomeProductCubit>().updateFilters(
                        category: state.category[index].name,
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is ProductCategoriesLoading) {
            return Skeletonizer(
              enabled: true,
              effect: UiHelpers.customShimmer(context),
              child: ListView.builder(
                itemCount: 6,
                padding: const EdgeInsets.symmetric(horizontal: 8),
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: CategoriesListItem(
                      category: CategoriesModel(id: 1, name: "Category"),
                      selected: categoryCubit.selectedCategoryIndex == index,
                      onSelected: () {},
                    ),
                  );
                },
              ),
            );
          } else if (state is ProductCategoriesFailure) {
            return ListView.builder(
              itemCount: 1,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: CategoriesListItem(
                    category: CategoriesModel(id: 0, name: "All"),
                    selected: categoryCubit.selectedCategoryIndex == index,
                    onSelected: () {},
                  ),
                );
              },
            );
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
