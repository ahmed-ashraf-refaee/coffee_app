import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../../models/payment_method_model.dart';

abstract class PaymentRepo {
  Future<Either<Failure, List<PaymentMethodModel>>> fetchPaymentCards();
  Future<Either<Failure, void>> addPaymentCard({required String holderName});
  Future<Either<Failure, void>> payWithCard({
    required double amount,
    required String paymentMethodId,
    required String cvc,
  });
}
