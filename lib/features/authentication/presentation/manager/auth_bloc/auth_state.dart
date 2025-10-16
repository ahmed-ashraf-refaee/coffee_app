part of 'auth_bloc.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}

final class AuthLoading extends AuthState {}

final class AuthSuccess extends AuthState {}

final class AuthUsernameSuccess extends AuthState {
  final bool usernameCheck;

  AuthUsernameSuccess({required this.usernameCheck});
}

final class AuthForgotPasswordLoading extends AuthState {}

final class AuthVerifySuccess extends AuthState {}

final class AuthForgotPasswordSuccess extends AuthState {}

final class AuthCheckMailSuccess extends AuthState {}

final class AuthFailure extends AuthState {
  final String error;
  AuthFailure({required this.error});
}
