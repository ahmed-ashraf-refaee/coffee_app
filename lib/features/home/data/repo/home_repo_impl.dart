import 'package:coffee_app/core/errors/failures.dart';
import 'package:coffee_app/features/home/data/model/categories_model.dart';

import 'package:coffee_app/features/home/data/model/product_model.dart';
import 'package:coffee_app/features/home/data/service/home_service.dart';

import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'home_repo.dart';

class HomeRepoImpl extends HomeRepo {
  final HomeService _homeService = HomeService();
  @override
  Future<Either<Failure, List<ProductModel>>> fetchProducts() async {
    try {
      final List<Map<String, dynamic>> productList = await _homeService
          .getProducts();
      List<ProductModel> products = productList
          .map((product) => ProductModel.fromJson(product))
          .toList();

      return right(products);
    } catch (e) {
      if (e is PostgrestException) {
        return left(Failure.fromSqlException(e));
      } else {
        return left(Failure(error: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<ProductModel>>> fetchTopPicks() async {
    try {
      final List<Map<String, dynamic>> productList = await _homeService
          .getTop5RatedProducts();
      List<ProductModel> products = productList
          .map((product) => ProductModel.fromJson(product))
          .toList();

      return right(products);
    } catch (e) {
      if (e is PostgrestException) {
        return left(Failure.fromSqlException(e));
      } else {
        return left(Failure(error: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, List<CategoriesModel>>> fetchCategories() async {
    try {
      final List<Map<String, dynamic>> categoryList = await _homeService
          .getCategories();
      List<CategoriesModel> category = categoryList
          .map((category) => CategoriesModel.fromJson(category))
          .toList();
      return right(category);
    } catch (e) {
      if (e is PostgrestException) {
        return left(Failure.fromSqlException(e));
      } else {
        return left(Failure(error: e.toString()));
      }
    }
  }
}
