part of 'payment_cubit.dart';

@immutable
sealed class PaymentState {}

final class PaymentInitial extends PaymentState {}

class PaymentLoading extends PaymentState {}

class PaymentCardOverlayLoading extends PaymentState {}

class PaymentFailure extends PaymentState {
  final String error;
  PaymentFailure({required this.error});
}

class PaymentCardOverlayFailure extends PaymentState {
  final String error;

  PaymentCardOverlayFailure({required this.error});
}

class CardAddedSuccess extends PaymentState {}

class CardsLoadedSuccess extends PaymentState {
  final List<PaymentMethodModel> cards;
  CardsLoadedSuccess({required this.cards});
}

class PaymentCompletedSuccess extends PaymentState {}
