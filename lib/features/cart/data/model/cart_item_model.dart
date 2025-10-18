import 'package:coffee_app/core/model/product_variants_model.dart';

import '../../../../core/model/product_model.dart';
import '../../../checkout/data/models/order_item.dart';

class CartItemModel {
  final int id;
  final int cartId;
  final int selectedVariantIndex;
  final int quantity;
  final ProductModel product;

  const CartItemModel({
    required this.id,
    required this.cartId,
    required this.product,
    required this.selectedVariantIndex,
    required this.quantity,
  });

  ProductVariantsModel get selectedVariant =>
      product.productVariants[selectedVariantIndex];

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'],
      cartId: json['cart_id'],
      selectedVariantIndex: json['variant_index'] ?? 0,
      quantity: json['quantity'],
      product: ProductModel.fromJson(json['products']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'cart_id': cartId,
      'selected_variant_index': selectedVariantIndex,
      'quantity': quantity,
      'product': product.toJson(),
    };
  }

  CartItemModel copyWith({
    int? id,
    int? cartId,
    int? selectedVariantIndex,
    int? quantity,
    ProductModel? product,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      cartId: cartId ?? this.cartId,
      selectedVariantIndex: selectedVariantIndex ?? this.selectedVariantIndex,
      quantity: quantity ?? this.quantity,
      product: product ?? this.product,
    );
  }

  OrderItemModel toOrderItem() {
    final variant = selectedVariant;
    return OrderItemModel(
      variantId: variant.id,
      quantity: quantity,
      unitPrice: variant.price.toDouble(),
      productName: product.name,
      categoryId: product.category?.id ?? 0,
    );
  }
}
