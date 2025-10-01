import 'package:coffee_app/features/checkout/data/repo/address/address_repo_impl.dart';
import 'package:coffee_app/features/checkout/data/service/address_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'address_state.dart';

class AddressCubit extends Cubit<AddressState> {
  AddressCubit() : super(AddressInitial());

  final AddressRepoImpl _repo = AddressRepoImpl(AddressService());

  Future<void> fetchAddresses() async {
    emit(AddressLoading());
    final result = await _repo.fetchAddresses();
    result.fold(
      (failure) => emit(AddressError(message: failure.error)),
      (addresses) => emit(AddressLoaded(addresses: addresses)),
    );
  }

  Future<void> addAddress({
    required String address,
    required String city,
    required double latitude,
    required double longitude,
    required String phoneNumber,
    required String state,
    required String title,

    String? optionalPhoneNumber,
  }) async {
    emit(AddressLoading());
    final result = await _repo.addAddress(
      address: address,
      city: city,
      latitude: latitude,
      longitude: longitude,
      phoneNumber: phoneNumber,
      state: state,
      optionalPhoneNumber: optionalPhoneNumber,
      title: title,
    );
    result.fold((failure) => emit(AddressError(message: failure.error)), (
      _,
    ) async {
      emit(AddressAddedSuccess());
      await fetchAddresses();
    });
  }

  Future<void> updateAddress({
    required int id,
    String? address,
    String? city,
    double? latitude,
    double? longitude,
    String? phoneNumber,
    String? state,
    String? optionalPhoneNumber,
    String? title,
  }) async {
    emit(AddressLoading());
    final result = await _repo.updateAddress(
      id: id,
      address: address,
      city: city,
      latitude: latitude,
      longitude: longitude,
      phoneNumber: phoneNumber,
      state: state,
      optionalPhoneNumber: optionalPhoneNumber,
      title: title,
    );
    result.fold(
      (failure) => emit(AddressError(message: failure.error)),
      (addresses) => emit(AddressLoaded(addresses: addresses)),
    );
  }
}
