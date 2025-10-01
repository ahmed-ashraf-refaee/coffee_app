part of 'card_cubit.dart';

@immutable
class CardState {
  final PaymentMethodModel? defaultCard;
  final AddressModel? defaultAddress;

  const CardState({this.defaultCard, this.defaultAddress});

  CardState copyWith({
    PaymentMethodModel? defaultCard,
    AddressModel? defaultAddress,
  }) {
    return CardState(
      defaultCard: defaultCard ?? this.defaultCard,
      defaultAddress: defaultAddress ?? this.defaultAddress,
    );
  }
}

