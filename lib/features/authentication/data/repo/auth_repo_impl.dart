import 'package:coffee_app/core/errors/failures.dart';
import 'package:coffee_app/features/authentication/data/services/auth_service.dart';
import 'package:coffee_app/features/authentication/data/repo/auth_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../../../core/errors/error_handler.dart';

class AuthRepoImpl extends AuthRepo {
  final AuthService _authService = AuthService();

  @override
  Future<Either<Failure, AuthResponse>> signupUser({
    required String email,
    required String password,
    required String username,
    required String firstName,
    required String lastName,
  }) {
    return guard(() async {
      final AuthResponse authResponse = await _authService.signup(
        email,
        password,
        username,
        firstName,
        lastName,
      );
      return authResponse;
    });
  }

  @override
  Future<Either<Failure, AuthResponse>> loginUser({
    required String email,
    required String password,
    required bool rememberMe,
  }) {
    return guard(() async {
      final AuthResponse authResponse = await _authService.login(
        email,
        password,
        rememberMe,
      );
      return authResponse;
    });
  }

  @override
  Future<Either<Failure, bool>> checkUsername({required String username}) {
    return guard(() async {
      final bool usernameTaken = await _authService.usernameTaken(username);
      return usernameTaken;
    });
  }

  @override
  Future<Either<Failure, void>> resetPassword({required String email}) {
    return guard(() async {
      final response = await _authService.resetPassword(email);
      return response;
    });
  }

  @override
  Future<Either<Failure, UserResponse>> setPassword({
    required String password,
  }) {
    return guard(() async {
      final UserResponse userResponse = await _authService.updatePassword(
        password,
      );
      return userResponse;
    });
  }

  @override
  Future<Either<Failure, AuthResponse>> verifyEmail({
    required String token,
    required String email,
  }) {
    return guard(() async {
      final AuthResponse authSessionUrlResponse = await _authService.verify(
        token,
        email,
      );
      return authSessionUrlResponse;
    });
  }
}
