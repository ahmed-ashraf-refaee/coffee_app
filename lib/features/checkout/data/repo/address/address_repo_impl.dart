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
    required String street,
    required String city,
    required double latitude,
    required double longitude,
    required String phoneNumber,
  }) {
    return guard(
      () => _service.addAddress(
        street: street,
        city: city,
        latitude: latitude,
        longitude: longitude,
        phoneNumber: phoneNumber,
      ),
    );
  }

  @override
  Future<Either<Failure, List<Address>>> updateAddress({
    required int id,
    String? street,
    String? city,
    double? latitude,
    double? longitude,
    String? phoneNumber,
  }) {
    return guard(() async {
      await _service.updateAddress(
        id: id,
        street: street,
        city: city,
        latitude: latitude,
        longitude: longitude,
        phoneNumber: phoneNumber,
      );
      final data = await _service.fetchAddresses();
      return data.map((e) => Address.fromJson(e)).toList();
    });
  }
}
