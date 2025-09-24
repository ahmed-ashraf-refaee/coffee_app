import 'package:coffee_app/core/errors/error_handler.dart';
import 'package:coffee_app/core/errors/failures.dart';

import 'package:coffee_app/features/checkout/data/models/payment_method_model.dart';
import 'package:coffee_app/features/checkout/data/service/payment_method_service.dart';

import 'package:dartz/dartz.dart';

import 'payment_repo.dart';

class PaymentRepoImpl extends PaymentRepo {
  final PaymentMethodService _methodService = PaymentMethodService();
  @override
  Future<Either<Failure, void>> addPaymentCard({required String holderName}) {
    return guard(() async {
      await _methodService.saveCard(holderName: holderName);
    });
  }

  @override
  Future<Either<Failure, List<PaymentMethodModel>>> fetchPaymentCards() {
    return guard(() async {
      List<Map<String, dynamic>> cards = await _methodService
          .fetchPaymentMethods();
      return cards.map((e) => PaymentMethodModel.fromJson(e)).toList();
    });
  }

  @override
  Future<Either<Failure, void>> payWithCard({
    required double amount,
    required String paymentMethodId,
    required String customerId,
    required String cvc,
  }) {
    return guard(() async {
      await _methodService.payWithSavedCard(
        amount: amount,
        paymentMethodId: paymentMethodId,
        customerId: customerId,
        cvc: cvc,
      );
    });
  }
}
