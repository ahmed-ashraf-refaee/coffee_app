import 'package:coffee_app/features/home/presentation/manager/cubit/home_data_cubit.dart';
import 'package:coffee_app/features/home/presentation/view/home_view/widgets/categories_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesList extends StatelessWidget {
  CategoriesList({super.key});

  final ValueNotifier<int> selectedIndex = ValueNotifier(0);

  void onSelected(index) {
    selectedIndex.value = index;
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: BlocBuilder<HomeDataCubit, HomeDataState>(
        builder: (context, state) {
          if (state is HomeProductsDataSuccess) {
            var catigories = context.read<HomeDataCubit>().categories;
            return ListView.builder(
              itemCount: catigories.length,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) {
                final category = catigories[index];
                return Padding(
                  padding: const EdgeInsets.only(right: 8.0),
                  child: ValueListenableBuilder(
                    valueListenable: selectedIndex,
                    builder: (context, value, child) {
                      return CategoriesListItem(
                        category: category,
                        selected: selectedIndex.value == index,
                        onSelected: () => onSelected(index),
                      );
                    },
                  ),
                );
              },
            );
          } else if (state is HomeProductCategoriesLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeProductCategoriesFailure) {
            return Center(child: Text(state.error));
          } else {
            return const SizedBox();
          }
        },
      ),
    );
  }
}
