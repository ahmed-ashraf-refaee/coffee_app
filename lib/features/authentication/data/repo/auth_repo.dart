import 'package:coffee_app/core/errors/failures.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepo {
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
  Future<Either<Failure, void>> logoutUser();
  Future<Either<Failure, bool>> checkUsername({required String username});
  Future<Either<Failure, void>> resetPassword({required String email});
  Future<Either<Failure, AuthSessionUrlResponse>> verifyEmail({
    required String token,
  });
  Future<Either<Failure, UserResponse>> setPassword({required String password});
}
