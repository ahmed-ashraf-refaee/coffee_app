import 'package:coffee_app/core/model/product_model.dart';

abstract class FilterStrategy {
  final bool enabled;

  FilterStrategy({required this.enabled});
  List<ProductModel> filter(List<ProductModel> products);
}

class SearchFilter extends FilterStrategy {
  final String searchQuery;

  SearchFilter({required super.enabled, required this.searchQuery});

  @override
  List<ProductModel> filter(List<ProductModel> products) {
    if (enabled) {
      return products.where((product) {
        return product.name.toLowerCase().contains(
          searchQuery.toLowerCase().trim(),
        );
      }).toList();
    } else {
      return products;
    }
  }
}

class CategoryFilter extends FilterStrategy {
  final String categoryName;

  CategoryFilter({required super.enabled, required this.categoryName});

  @override
  List<ProductModel> filter(List<ProductModel> products) {
    if (enabled) {
      return products.where((product) {
        return product.category!.name.toLowerCase().contains(
          categoryName.toLowerCase().trim(),
        );
      }).toList();
    } else {
      return products;
    }
  }
}
