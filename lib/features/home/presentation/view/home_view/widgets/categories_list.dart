import 'package:coffee_app/core/helper/ui_helpers.dart';
import 'package:coffee_app/core/model/categories_model.dart';
import 'package:coffee_app/features/home/presentation/manager/home_category_cubit/home_category_cubit.dart';
import 'package:coffee_app/features/home/presentation/manager/home_products_cubit/home_product_cubit.dart';
import 'package:coffee_app/features/home/presentation/view/home_view/widgets/categories_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CategoriesList extends StatelessWidget {
  CategoriesList({super.key});

  final ValueNotifier<int> selectedIndex = ValueNotifier(0);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: BlocBuilder<HomeCategoryCubit, HomeCategoryState>(
        builder: (context, state) {
          if (state is ProductCategoriesSuccess) {
            return ListView.builder(
              itemCount: state.category.length,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ValueListenableBuilder(
                    valueListenable: selectedIndex,
                    builder: (context, value, child) {
                      return CategoriesListItem(
                        category: state.category[index],
                        selected: selectedIndex.value == index,
                        onSelected: () {
                          selectedIndex.value = index;
                          context.read<HomeProductCubit>().updateFilters(
                            category: state.category[index].name,
                          );
                        },
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
                    child: ValueListenableBuilder(
                      valueListenable: selectedIndex,
                      builder: (context, value, child) {
                        return CategoriesListItem(
                          category: CategoriesModel(id: 1, name: "Category"),
                          selected: selectedIndex.value == index,
                          onSelected: () {},
                        );
                      },
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
                  child: ValueListenableBuilder(
                    valueListenable: selectedIndex,
                    builder: (context, value, child) {
                      return CategoriesListItem(
                        category: CategoriesModel(id: 0, name: "All"),
                        selected: selectedIndex.value == index,
                        onSelected: () {},
                      );
                    },
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
