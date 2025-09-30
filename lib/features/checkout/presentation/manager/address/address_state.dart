import '../../../data/models/address_model.dart';

sealed class AddressState {}

final class AddressesInitial extends AddressState {}

final class AddressInitial extends AddressState {}

final class AddressLoading extends AddressState {}

final class AddressAddedSuccess extends AddressState {}

final class AddressLoaded extends AddressState {
  final List<Address> addresses;

  AddressLoaded({required this.addresses});
}

final class AddressError extends AddressState {
  final String message;

  AddressError({required this.message});
}
