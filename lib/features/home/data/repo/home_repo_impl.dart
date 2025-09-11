import 'package:coffee_app/core/errors/failures.dart';
import 'package:coffee_app/core/model/categories_model.dart';
import 'package:coffee_app/core/model/product_model.dart';
import 'package:coffee_app/features/home/data/service/home_service.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/error_handler.dart';
import 'home_repo.dart';

class HomeRepoImpl extends HomeRepo {
  final HomeService _homeService = HomeService();

  @override
  Future<Either<Failure, List<ProductModel>>> fetchProducts() {
    return guard(() async {
      final List<Map<String, dynamic>> productList = await _homeService
          .getProducts();
      List<ProductModel> products = productList
          .map((product) => ProductModel.fromJson(product))
          .toList();

      return products;
    });
  }

  @override
  Future<Either<Failure, List<ProductModel>>> fetchTopPicks() {
    return guard(() async {
      final List<Map<String, dynamic>> productList = await _homeService
          .getTop5RatedProducts();
      List<ProductModel> products = productList
          .map((product) => ProductModel.fromJson(product))
          .toList();

      return products;
    });
  }

  @override
  Future<Either<Failure, List<CategoriesModel>>> fetchCategories() {
    return guard(() async {
      final List<Map<String, dynamic>> categoryList = await _homeService
          .getCategories();
      List<CategoriesModel> category = categoryList
          .map((category) => CategoriesModel.fromJson(category))
          .toList();
      return category;
    });
  }
}
