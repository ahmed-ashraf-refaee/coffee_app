part of 'auth_bloc.dart';

@immutable
sealed class AuthEvent {}

class SignupEvent extends AuthEvent {
  final String email;
  final String password;
  final String username;
  final String firstName;
  final String lastName;
  SignupEvent({
    required this.email,
    required this.password,
    required this.username,
    required this.firstName,
    required this.lastName,
  });
}

class LoginEvent extends AuthEvent {
  final String email;
  final String password;
  final bool rememberMe;
  LoginEvent({
    required this.email,
    required this.password,
    required this.rememberMe,
  });
}

class UsernameCheckEvent extends AuthEvent {
  final String username;

  UsernameCheckEvent({required this.username});
}

class ResetPasswordEvent extends AuthEvent {
  final String email;

  ResetPasswordEvent({required this.email});
}

class UpdatePasswordEvent extends AuthEvent {
  final String password;
  UpdatePasswordEvent({required this.password});
}

class VerifyEmailEvent extends AuthEvent {
  final String token;
  VerifyEmailEvent({required this.token});
}
