class PaymentMethodModel {
  final int id;
  final String? userId;
  final int? last4;
  final String? brand;
  final int? expMonth;
  final int? expYear;
  final DateTime createdAt;
  final String? holderName;
  final String? paymentMethodId;

  PaymentMethodModel({
    required this.id,
    this.userId,
    this.last4,
    this.brand,
    this.expMonth,
    this.expYear,
    required this.createdAt,
    this.holderName,
    this.paymentMethodId,
  });

  factory PaymentMethodModel.fromJson(Map<String, dynamic> json) {
    return PaymentMethodModel(
      id: json['id'] as int,
      userId: json['user_id'] as String?,
      last4: json['last4'] as int?,
      brand: json['brand'] as String?,
      expMonth: json['exp_month'] as int?,
      expYear: json['exp_year'] as int?,
      createdAt: DateTime.parse(json['created_at'] as String),
      holderName: json['holder_name'] as String?,
      paymentMethodId: json['payment_method_id'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user_id': userId,
      'last4': last4,
      'brand': brand,
      'exp_month': expMonth,
      'exp_year': expYear,
      'created_at': createdAt.toIso8601String(),
      'holder_name': holderName,
      'payment_method_id': paymentMethodId,
    };
  }
}
