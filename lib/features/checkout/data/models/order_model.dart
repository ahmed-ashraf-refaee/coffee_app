class OrderModel {
  final int? id;
  final int shippingAddressId;
  final int paymentId;
  final String userId;
  final double totalPrice;
  final double shippingPrice;
  final String status;
  final DateTime? createdAt;

  OrderModel({
    this.id,
    required this.shippingAddressId,
    required this.paymentId,
    required this.userId,
    required this.totalPrice,
    required this.shippingPrice,
    required this.status,
    this.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'] as int?,
      shippingAddressId: json['shipping_address_id'] as int,
      paymentId: json['payment_id'] as int,
      userId: json['user_id'] as String,
      totalPrice: double.parse(json['total_price'].toString()),
      shippingPrice: double.parse(json['shipping_price'].toString()),
      status: json['status'] as String,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'shipping_address_id': shippingAddressId,
      'payment_id': paymentId,
      'user_id': userId,
      'total_price': totalPrice,
      'shipping_price': shippingPrice,
      'status': status,
    };
  }
}
