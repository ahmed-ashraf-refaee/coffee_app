import 'package:coffee_app/core/constants/filter_constants.dart';

import 'package:flutter/material.dart';

import '../../../../../core/model/product_model.dart';

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

class PriceRangeFilter extends FilterStrategy {
  final RangeValues priceRange;

  PriceRangeFilter({required super.enabled, required this.priceRange});

  @override
  List<ProductModel> filter(List<ProductModel> products) {
    if (enabled) {
      return products.where((product) {
        return product.productVariants[0].price >= priceRange.start &&
            product.productVariants[0].price <= priceRange.end;
      }).toList();
    } else {
      return products;
    }
  }
}

class RatingFilter extends FilterStrategy {
  final String rating;

  RatingFilter({required super.enabled, required this.rating});

  @override
  List<ProductModel> filter(List<ProductModel> products) {
    if (enabled) {
      return products.where((product) {
        return product.rating >= (double.tryParse(rating[0]) ?? 0);
      }).toList();
    } else {
      return products;
    }
  }
}

class SortingFilter extends FilterStrategy {
  final String sorting;

  SortingFilter({required super.enabled, required this.sorting});

  @override
  List<ProductModel> filter(List<ProductModel> products) {
    if (enabled) {
      List<String> sortOptions = FilterConstants.sortOptions;
      List<ProductModel> sorted = List<ProductModel>.from(products);

      if (sorting == sortOptions[0]) {
        sorted.sort((a, b) => a.rating.compareTo(b.rating));
      } else if (sorting == sortOptions[1]) {
        sorted.sort((a, b) => a.createdAt.compareTo(b.createdAt));
      } else if (sorting == sortOptions[2]) {
         sorted.sort((a, b) => b.createdAt.compareTo(a.createdAt));
      } else if (sorting == sortOptions[3]) {
        sorted.sort((a, b) => b.discount.compareTo(a.discount));
      } else if (sorting == sortOptions[4]) {
        sorted.sort(
          (a, b) =>
              a.productVariants[0].price.compareTo(b.productVariants[0].price),
        );
      } else if (sorting == sortOptions[5]) {
        sorted.sort(
          (a, b) =>
              b.productVariants[0].price.compareTo(a.productVariants[0].price),
        );
      }
      return sorted;
    } else {
      return products;
    }
  }
}
