import 'package:coffee_app/core/helper/ui_helpers.dart';
import 'package:coffee_app/features/home/data/model/categories_model.dart';
import 'package:coffee_app/features/home/presentation/manager/cubit/home_data_cubit.dart';
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
      child: BlocBuilder<HomeDataCubit, HomeDataState>(
        builder: (context, state) {
          if (state is HomeProductsDataSuccess) {
            var categories = context.read<HomeDataCubit>().categories;
            return ListView.builder(
              itemCount: categories.length,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ValueListenableBuilder(
                    valueListenable: selectedIndex,
                    builder: (context, value, child) {
                      return CategoriesListItem(
                        category: categories[index],
                        selected: selectedIndex.value == index,
                        onSelected: () {
                          selectedIndex.value = index;
                          context.read<HomeDataCubit>().selectedCategoryName =
                              categories[index].name;
                        },
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is HomeProductCategoriesLoading) {
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
          } else if (state is HomeProductCategoriesFailure) {
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
          }
        },
      ),
    );
  }
}
