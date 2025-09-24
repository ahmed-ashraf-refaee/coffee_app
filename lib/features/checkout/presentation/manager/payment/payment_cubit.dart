import 'package:bloc/bloc.dart';
import 'package:coffee_app/features/checkout/data/repo/payment_repo_impl.dart';
import 'package:meta/meta.dart';

import '../../../data/models/payment_method_model.dart';

part 'payment_state.dart';

class PaymentCubit extends Cubit<PaymentState> {
  PaymentCubit() : super(PaymentInitial());

  final PaymentRepoImpl _paymentRepo = PaymentRepoImpl();

  void addCard({required String holderName}) async {
    emit(PaymentCardOverlayLoading());
    final result = await _paymentRepo.addPaymentCard(holderName: holderName);
    result.fold(
      (failure) => emit(PaymentCardOverlayFailure(error: failure.error)),
      (_) async {
        emit(CardAddedSuccess());
        final cardsResult = await _paymentRepo.fetchPaymentCards();
        cardsResult.fold(
          (failure) => emit(PaymentCardOverlayFailure(error: failure.error)),
          (cards) => emit(CardsLoadedSuccess(cards: cards)),
        );
      },
    );
  }

  void fetchCards() async {
    emit(PaymentLoading());
    final result = await _paymentRepo.fetchPaymentCards();
    result.fold(
      (failure) => emit(PaymentFailure(error: failure.error)),
      (cards) => emit(CardsLoadedSuccess(cards: cards)),
    );
  }

  void payWithCard({
    required double amount,
    required String paymentMethodId,
    required String customerId,
    required String cvc,
  }) async {
    emit(PaymentLoading());
    final result = await _paymentRepo.payWithCard(
      amount: amount,
      paymentMethodId: paymentMethodId,
      customerId: customerId,
      cvc: cvc,
    );
    result.fold(
      (failure) => emit(PaymentFailure(error: failure.error)),
      (_) => emit(PaymentCompletedSuccess()),
    );
  }
}
