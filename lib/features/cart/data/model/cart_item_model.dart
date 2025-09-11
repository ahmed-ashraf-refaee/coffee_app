import '../../../../core/model/product_model.dart';
import '../../../../core/model/product_variants_model.dart';

class CartItemModel {
  final int id;
  final int cartId;
  final int productVariantId;
  final int quantity;
  final ProductVariantsModel? productVariant;
  final ProductModel? product;

  CartItemModel({
    required this.id,
    required this.cartId,
    required this.productVariantId,
    required this.quantity,
    this.productVariant,
    this.product,
  });

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    final productJson = json['product_variants']?['products'];
    final variantJson = json['product_variants'];

    final Map<String, dynamic> fullProductJson = {
      ...productJson ?? {},
      'product_variants': [variantJson],
    };

    return CartItemModel(
      id: json['id'],
      cartId: json['cart_id'],
      productVariantId: json['product_variant_id'],
      quantity: json['quantity'],
      productVariant: variantJson != null
          ? ProductVariantsModel.fromJson(variantJson)
          : null,
      product: productJson != null
          ? ProductModel.fromJson(fullProductJson)
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cart_id': cartId,
      'product_variant_id': productVariantId,
      'quantity': quantity,
    };
  }

  CartItemModel copyWith({
    int? id,
    int? cartId,
    int? productVariantId,
    int? quantity,
    DateTime? createdAt,
    ProductVariantsModel? productVariant,
    ProductModel? product,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      cartId: cartId ?? this.cartId,
      productVariantId: productVariantId ?? this.productVariantId,
      quantity: quantity ?? this.quantity,
      productVariant: productVariant ?? this.productVariant,
      product: product ?? this.product,
    );
  }
}
