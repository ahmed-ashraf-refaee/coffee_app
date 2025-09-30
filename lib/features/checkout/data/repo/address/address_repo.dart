import 'package:dartz/dartz.dart';

import '../../../../../core/errors/failures.dart';
import '../../models/address_model.dart';

abstract class AddressRepo {
  Future<Either<Failure, List<Address>>> fetchAddresses();
  Future<Either<Failure, List<Address>>> updateAddress({
    required int id,
    String? street,
    String? city,
    double? latitude,
    double? longitude,
    String? phoneNumber,
  });
  Future<Either<Failure, void>> addAddress({
    required String street,
    required String city,
    required double latitude,
    required double longitude,
    required String phoneNumber,
  });
}
