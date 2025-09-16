import 'package:coffee_app/core/services/app_locale.dart';

class ProductVariantsModel {
  final int id;
  final String size;
  final double price;
  final int quantity;
  final int productId;

  ProductVariantsModel({
    required this.id,
    required this.size,
    required this.price,
    required this.quantity,
    required this.productId,
  });
  factory ProductVariantsModel.fromJson(Map<String, dynamic> json) {
    return ProductVariantsModel(
      id: json['id'] as int,
      size: json['size_${AppLocale.current.languageCode}'] as String, 
      price: (json['price'] as num).toDouble(),
      quantity: (json['quantity'] as num).toInt(),
      productId: json['product_id'] as int,
    );
  }
}
