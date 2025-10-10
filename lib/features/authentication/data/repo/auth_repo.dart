import 'package:coffee_app/core/errors/failures.dart';
import 'package:coffee_app/features/authentication/data/model/user_profile_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepo {
  Future<Either<Failure, UserProfileModel>> getUserData();
  Future<Either<Failure, void>> updateUserData({
    String? username,
    String? firstName,
    String? lastName,
    String? customerId,
    String? profileImageUrl,
  });
  Future<Either<Failure, bool>> checkIfAdmin();

  Future<Either<Failure, AuthResponse>> loginUser({
    required String email,
    required String password,
    required bool rememberMe,
  });
  Future<Either<Failure, AuthResponse>> signupUser({
    required String email,
    required String password,
    required String username,
    required String firstName,
    required String lastName,
  });
  Future<Either<Failure, bool>> checkUsername({required String username});
  Future<Either<Failure, void>> resetPassword({required String email});
  Future<Either<Failure, AuthResponse>> verifyEmail({
    required String token,
    required String email,
  });
  Future<Either<Failure, UserResponse>> setPassword({required String password});
  Future<Either<Failure, String?>> fetchCustomerId();
}
