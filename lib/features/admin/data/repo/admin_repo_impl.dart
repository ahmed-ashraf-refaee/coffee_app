import 'dart:io';

import 'package:coffee_app/core/errors/error_handler.dart';
import 'package:coffee_app/core/errors/failures.dart';
import 'package:coffee_app/core/model/product_model.dart';
import 'package:coffee_app/features/admin/data/repo/admin_repo.dart';
import 'package:dartz/dartz.dart';

import '../services/admin_service.dart';

class AdminRepoImpl extends AdminRepo {
  AdminProductService service = AdminProductService();

  @override
  Future<Either<Failure, void>> createProduct(
    ProductModel product,
    File imageFile, {
    String languageCode = 'en',
  }) {
    return guard(() async {
      await service.createProduct(product, imageFile, languageCode);
    });
  }

  @override
  Future<Either<Failure, void>> updateProduct(
    ProductModel product, {
    String languageCode = 'en',
  }) {
    return guard(() async {
      await service.updateProduct(product, languageCode);
    });
  }
}
