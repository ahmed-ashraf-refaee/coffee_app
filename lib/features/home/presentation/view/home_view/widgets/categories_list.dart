import 'package:coffee_app/features/home/presentation/manager/cubit/home_data_cubit.dart';
import 'package:coffee_app/features/home/presentation/view/home_view/widgets/categories_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CategoriesList extends StatefulWidget {
  const CategoriesList({super.key});

  @override
  State<CategoriesList> createState() => _CategoriesListState();
}

class _CategoriesListState extends State<CategoriesList> {
  int selectedIndex = 0;
  void onSelected(index) {
    setState(() {
      selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 32,
      child: BlocBuilder<HomeDataCubit, HomeDataState>(
        builder: (context, state) {
          if (state is HomeProductCategoriesSuccess) {
            return ListView.builder(
              itemCount: 16,
              padding: const EdgeInsets.symmetric(horizontal: 8),
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => CategoriesListItem(
                category: state.catigories[index].name,
                selected: index == selectedIndex,
                onSelected: () => onSelected(index),
              ),
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
