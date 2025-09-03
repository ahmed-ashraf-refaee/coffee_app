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
  LoginEvent({required this.email, required this.password});
}

class LogoutEvent extends AuthEvent {}

class UsernameCheckEvent extends AuthEvent {
  final String username;

  UsernameCheckEvent({required this.username});
}
