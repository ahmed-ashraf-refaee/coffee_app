import 'package:coffee_app/features/home/presentation/view/home_view/widgets/categories_list_item.dart';
import 'package:flutter/material.dart';

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
      child: ListView.builder(
        itemCount: 16,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) => CategoriesListItem(
          category: "category",
          selected: index == selectedIndex,
          onSelected: () => onSelected(index),
        ),
      ),
    );
  }
}
