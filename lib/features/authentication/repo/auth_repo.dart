import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepo {
  Future<Either<String, AuthResponse>> loginUser({
    required String email,
    required String password,
  });
  Future<Either<String, AuthResponse>> signupUser({
    required String email,
    required String password,
    required String username,
    required String firstName,
    required String lastName,
  });
  Future<Either<String, void>> logoutUser();
}
