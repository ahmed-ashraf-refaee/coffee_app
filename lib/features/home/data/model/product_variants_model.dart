import 'dart:ffi';

class ProductVariantsModel {
  final Long id;
  final String size;
  final double price;
  final double quantity;
  final Long productId;

  ProductVariantsModel({
    required this.id,
    required this.size,
    required this.price,
    required this.quantity,
    required this.productId,
  });
  factory ProductVariantsModel.fromJson(Map<String, dynamic> json) {
    return ProductVariantsModel(
      id: json['id'],
      size: json['size'],
      price: (json['price'] as num).toDouble(),
      quantity: (json['quantity'] as num).toDouble(),
      productId: json['product_id'],
    );
  }
}
