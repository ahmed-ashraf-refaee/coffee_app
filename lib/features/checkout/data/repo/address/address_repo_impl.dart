import 'package:dartz/dartz.dart';
import '../../../../../core/errors/error_handler.dart';
import '../../../../../core/errors/failures.dart';
import '../../models/address_model.dart';
import '../../service/address_service.dart';
import 'address_repo.dart';

class AddressRepoImpl implements AddressRepo {
  final AddressService _service;

  AddressRepoImpl(this._service);

  @override
  Future<Either<Failure, List<Address>>> fetchAddresses() {
    return guard(() async {
      final data = await _service.fetchAddresses();
      return data.map((e) => Address.fromJson(e)).toList();
    });
  }

  @override
  Future<Either<Failure, void>> addAddress({
    required String address,
    required String city,
    required double latitude,
    required double longitude,
    required String phoneNumber,
    String? state,
    String? optionalPhoneNumber,
  }) {
    return guard(
      () => _service.addAddress(
        address: address,
        city: city,
        latitude: latitude,
        longitude: longitude,
        phoneNumber: phoneNumber,
        state: state,
        optionalPhoneNumber: optionalPhoneNumber,
      ),
    );
  }

  @override
  Future<Either<Failure, List<Address>>> updateAddress({
    required int id,
    String? address,
    String? city,
    double? latitude,
    double? longitude,
    String? phoneNumber,
    String? state,
    String? optionalPhoneNumber,
  }) {
    return guard(() async {
      await _service.updateAddress(
        id: id,
        address: address,
        city: city,
        latitude: latitude,
        longitude: longitude,
        phoneNumber: phoneNumber,
        state: state,
        optionalPhoneNumber: optionalPhoneNumber,
      );
      final data = await _service.fetchAddresses();
      return data.map((e) => Address.fromJson(e)).toList();
    });
  }

  @override
  Future<Either<Failure, void>> deleteAddress(int id) {
    return guard(() => _service.deleteAddress(id));
  }
}
