import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract class ProfileRepo {
  Future<Either<Failure, void>> logoutUser();
}
