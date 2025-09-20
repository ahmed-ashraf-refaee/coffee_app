import 'package:coffee_app/core/errors/error_handler.dart';
import 'package:coffee_app/core/errors/failures.dart';
import 'package:dartz/dartz.dart';

import '../service/stripe_payment_service.dart';
import 'payment_repo.dart';

class PaymentRepoImpl extends PaymentRepo {
  @override
  Future<Either<Failure, void>> makePayment({
    required double amount,
    String currency = "EGP",
  }) {
    return guard(() {
      return StripePaymentService.makePayment(
        amount: amount,
        currency: currency,
      );
    });
  }
}
