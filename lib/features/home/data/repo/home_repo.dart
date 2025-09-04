import 'package:coffee_app/core/errors/failures.dart';
import 'package:coffee_app/features/home/data/model/categories_model.dart';
import 'package:coffee_app/features/home/data/model/product_model.dart';
import 'package:dartz/dartz.dart';

abstract class HomeRepo {
  Future<Either<Failure, List<ProductModel>>> fetchProducts();
  Future<Either<Failure, List<ProductModel>>> fetchTopPicks();
  Future<Either<Failure, List<CategoriesModel>>> fetchCategories();
}
