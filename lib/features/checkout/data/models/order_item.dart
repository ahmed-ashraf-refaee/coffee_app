class OrderItemModel {
  final int? id;
  final int variantId;
  final int? orderId;
  final int quantity;
  final double unitPrice;
  final String productName;
  final int categoryId;

  OrderItemModel({
    this.id,
    this.orderId,
    required this.variantId,
    required this.quantity,
    required this.unitPrice,
    required this.productName,
    required this.categoryId,
  });

  OrderItemModel copyWith({int? orderId}) => OrderItemModel(
    id: id,
    variantId: variantId,
    orderId: orderId ?? this.orderId,
    quantity: quantity,
    unitPrice: unitPrice,
    productName: productName,
    categoryId: categoryId,
  );
  factory OrderItemModel.fromJson(Map<String, dynamic> json) {
    return OrderItemModel(
      id: json['id'] as int?,
      variantId: json['variant_id'] as int,
      orderId: json['order_id'] as int?,
      quantity: json['quantity'] as int,
      unitPrice: double.parse(json['unit_price'].toString()),
      productName: json['product_name'] as String,
      categoryId: json['category_id'] as int,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'variant_id': variantId,
      'order_id': orderId,
      'quantity': quantity,
      'unit_price': unitPrice,
      'product_name': productName,
      'category_id': categoryId,
    };
  }
}
