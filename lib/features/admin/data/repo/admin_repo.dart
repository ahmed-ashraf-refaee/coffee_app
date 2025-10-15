import 'dart:io';

import 'package:coffee_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/model/product_model.dart';

abstract class AdminRepo {
  Future<Either<Failure, void>> updateProduct(
    ProductModel product, {
    String languageCode = 'en',
  });
  Future<Either<Failure, void>> createProduct(
    ProductModel product,
    File imageFile, {
    String languageCode = 'en',
  });
}
