import 'package:coffee_app/core/errors/failures.dart';
import 'package:coffee_app/features/authentication/data/services/auth_service.dart';
import 'package:coffee_app/features/authentication/data/repo/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepoImpl extends AuthRepo {
  final AuthService _authService = AuthService();

  @override
  Future<Either<Failure, AuthResponse>> signupUser({
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
      if (e is AuthApiException) {
        return left(Failure.fromAuthException(e));
      } else if (e is PostgrestException) {
        return left(Failure.fromSqlException(e));
      } else {
        return left(Failure(error: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, AuthResponse>> loginUser({
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
      if (e is AuthApiException) {
        return left(Failure.fromAuthException(e));
      } else if (e is PostgrestException) {
        return left(Failure.fromSqlException(e));
      } else {
        return left(Failure(error: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, void>> logoutUser() async {
    try {
      final authResponse = _authService.logout();
      return right(authResponse);
    } catch (e) {
      if (e is AuthApiException) {
        return left(Failure.fromAuthException(e));
      } else if (e is PostgrestException) {
        return left(Failure.fromSqlException(e));
      } else {
        return left(Failure(error: e.toString()));
      }
    }
  }

  @override
  Future<Either<Failure, bool>> checkUsername({
    required String username,
  }) async {
    try {
      final bool usernameTaken = await _authService.usernameTaken(username);
      return right(usernameTaken);
    } catch (e) {
      if (e is AuthApiException) {
        return left(Failure.fromAuthException(e));
      } else if (e is PostgrestException) {
        return left(Failure.fromSqlException(e));
      } else {
        return left(Failure(error: e.toString()));
      }
    }
  }
}
