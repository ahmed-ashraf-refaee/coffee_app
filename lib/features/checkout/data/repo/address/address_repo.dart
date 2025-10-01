import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../../models/address_model.dart';

abstract class AddressRepo {
  Future<Either<Failure, List<AddressModel>>> fetchAddresses();

  Future<Either<Failure, List<AddressModel>>> updateAddress({
    required int id,
    String? address,
    String? city,
    double? latitude,
    double? longitude,
    String? phoneNumber,
    String? state,
    String? optionalPhoneNumber,
    String? title,
  });

  Future<Either<Failure, void>> addAddress({
    required String address,
    required String city,
    required double latitude,
    required double longitude,
    required String phoneNumber,
    required String state,
    required String title,

    String? optionalPhoneNumber,
  });

  Future<Either<Failure, void>> deleteAddress(int id);
}
