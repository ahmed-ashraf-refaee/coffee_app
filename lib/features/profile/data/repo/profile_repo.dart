import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract class ProfileRepo {
  Future<Either<Failure, void>> logoutUser();
  Future<Either<Failure, void>> launchPhoneDialer({required String phone});
  Future<Either<Failure, void>> launchWhatsApp({required String phone});
}
