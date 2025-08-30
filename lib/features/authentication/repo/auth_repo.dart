import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:dartz/dartz.dart';

abstract class AuthRepo {
  Future<Either<String, AuthResponse>> loginUser(String email, String password);
  Future<Either<String, AuthResponse>> signupUser(
    String email,
    String password,
    String username,
    String firstName,
    String lastName,
  );
  Future<Either<String, void>> logoutUser();
}
