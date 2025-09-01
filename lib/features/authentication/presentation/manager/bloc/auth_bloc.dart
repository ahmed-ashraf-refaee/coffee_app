import 'package:bloc/bloc.dart';
import 'package:coffee_app/features/authentication/repo/auth_repo_impl.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepoImpl _authRepoImpl = AuthRepoImpl();
  AuthBloc() : super(AuthInitial()) {
    on<SignupEvent>((event, emit) async {
      emit(AuthLoading());
      final result = await _authRepoImpl.signupUser(
        email: event.email,
        password: event.password,
        username: event.username,
        firstName: event.firstName,
        lastName: event.lastName,
      );

      result.fold(
        (failure) => emit(AuthFailure(error: failure)),
        (response) => emit(AuthSuccess()),
      );
    });
    on<LoginEvent>((event, emit) async {
      emit(AuthLoading());
      var result = await _authRepoImpl.loginUser(
        email: event.email,
        password: event.password,
      );
      result.fold(
        (failure) => emit(AuthFailure(error: failure)),
        (response) => emit(AuthSuccess()),
      );
    });

    on<LogoutEvent>((event, emit) async {
      emit(AuthLoading());
      var result = await _authRepoImpl.logoutUser();
      emit(AuthSuccess());
      result.fold(
        (failure) => emit(AuthFailure(error: failure)),
        (response) => emit(AuthSuccess()),
      );
    });
  }
}
