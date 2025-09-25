part of 'card_cubit.dart';

@immutable
class CardState {
  final PaymentMethodModel? defaultCard;

  const CardState({this.defaultCard});

  CardState copyWith({PaymentMethodModel? defaultCard}) {
    return CardState(defaultCard: defaultCard ?? this.defaultCard);
  }
}
