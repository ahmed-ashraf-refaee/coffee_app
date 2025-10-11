import 'package:coffee_app/features/authentication/data/services/auth_service.dart';
import 'package:coffee_app/features/profile/data/services/settings_service.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/error_handler.dart';
import '../../../../core/errors/failures.dart';
import '../../../cart/data/repo/cart_repo_impl.dart';
import '../../../wishlist/data/repo/wishlist_repo_impl.dart';
import 'profile_repo.dart';

class ProfileRepoImpl extends ProfileRepo {
  @override
  Future<Either<Failure, void>> logoutUser() {
    return guard(() async {
      final authResponse = await AuthService().logout();
      WishlistRepoImpl().clearCache();
      CartRepoImpl().clearCache();

      return authResponse;
    });
  }

  @override
  Future<Either<Failure, void>> launchPhoneDialer({required String phone}) {
    return guard(() async {
      final response = await SettingService().launchPhoneDialer(phone);
      return response;
    });
  }

  @override
  Future<Either<Failure, void>> launchWhatsApp({required String phone}) {
    return guard(() async {
      final response = await SettingService().launchWhatsApp(phone);
      return response;
    });
  }
}
