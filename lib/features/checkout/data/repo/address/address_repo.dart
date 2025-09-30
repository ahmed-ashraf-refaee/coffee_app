import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../../models/address_model.dart';

abstract class AddressRepo {
  Future<Either<Failure, List<Address>>> fetchAddresses();

  Future<Either<Failure, List<Address>>> updateAddress({
    required int id,
    String? address,
    String? city,
    double? latitude,
    double? longitude,
    String? phoneNumber,
    String? state,
    String? optionalPhoneNumber,
  });

  Future<Either<Failure, void>> addAddress({
    required String address,
    required String city,
    required double latitude,
    required double longitude,
    required String phoneNumber,
    String? state,
    String? optionalPhoneNumber,
  });

  Future<Either<Failure, void>> deleteAddress(int id);
}
