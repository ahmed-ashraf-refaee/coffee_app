import 'package:bloc/bloc.dart';
import 'package:coffee_app/features/payment/data/repo/payment_repo_impl.dart';
import 'package:meta/meta.dart';

part 'stripe_payment_state.dart';

class StripePaymentCubit extends Cubit<StripePaymentState> {
  StripePaymentCubit() : super(StripePaymentInitial());
  final PaymentRepoImpl _paymentRepo = PaymentRepoImpl();
  Future<void> payment({
    required double amount,
    required String currency,
  }) async {
    emit(StripePaymentLoading());
    final result = await _paymentRepo.makePayment(
      amount: amount,
      currency: currency,
    );
    result.fold(
      (failure) => emit(StripePaymentFailure(error: failure.error)),
      (success) => emit(StripePaymentSuccess()),
    );
  }
}
