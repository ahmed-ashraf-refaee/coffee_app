import 'package:coffee_app/core/errors/failures.dart';
import 'package:coffee_app/core/model/product_model.dart';
import 'package:coffee_app/features/cart/data/model/cart_item_model.dart';
import 'package:dartz/dartz.dart';

abstract class CartRepo {
  Future<Either<Failure, List<CartItemModel>>> getCartItem();
  Future<Either<Failure, void>> addItemToCart({
    required int productVariantId,
    required int quantity,
  });
  Future<Either<Failure, void>> updateItemQuantity({
    required int productVariantId,
    required int newQuantity,
  });
  Future<Either<Failure, void>> removeItem({required int productVariantId});
  Future<Either<Failure, void>> removeAll();
}
