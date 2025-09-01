import 'package:coffee_app/core/utils/auth_service.dart';
import 'package:coffee_app/features/authentication/repo/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepoImpl extends AuthRepo {
  final AuthService _authService = AuthService();

  @override
  Future<Either<String, AuthResponse>> signupUser({
    required String email,
    required String password,
    required String username,
    required String firstName,
    required String lastName,
  }) async {
    try {
      final AuthResponse authResponse = await _authService.signup(
        email,
        password,
        username,
        firstName,
        lastName,
      );
      return right(authResponse);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, AuthResponse>> loginUser({
    required String email,
    required String password,
  }) async {
    try {
      final AuthResponse authResponse = await _authService.login(
        email,
        password,
      );
      return right(authResponse);
    } catch (e) {
      return left(e.toString());
    }
  }

  @override
  Future<Either<String, void>> logoutUser() async {
    try {
      final authResponse = _authService.logout();
      return right(authResponse);
    } catch (e) {
      return left(e.toString());
    }
  }
}
