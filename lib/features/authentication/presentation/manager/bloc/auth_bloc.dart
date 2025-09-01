import 'package:bloc/bloc.dart';
import 'package:coffee_app/features/authentication/repo/auth_repo_impl.dart';
import 'package:meta/meta.dart';

part 'auth_event.dart';
part 'auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final AuthRepoImpl _authRepoImpl = AuthRepoImpl();
  AuthBloc() : super(AuthInitial()) {
    on<AuthEvent>((event, emit) {
      if (event is SignupEvent) {
        emit(AuthLoading());
        try {
          _authRepoImpl.signupUser(
            email: event.email,
            password: event.password,
            username: event.username,
            firstName: event.firstName,
            lastName: event.lastName,
          );
          emit(AuthSuccess());
        } catch (e) {
          emit(AuthFailure(e.toString()));
        }
      } else if (event is LoginEvent) {
        emit(AuthLoading());

        try {
          _authRepoImpl.loginUser(email: event.email, password: event.password);
          emit(AuthSuccess());
        } catch (e) {
          emit(AuthFailure(e.toString()));
        }
      } else if (event is LogoutEvent) {
        emit(AuthLoading());
        try {
          _authRepoImpl.logoutUser();
          emit(AuthSuccess());
        } catch (e) {
          emit(AuthFailure(e.toString()));
        }
      }
    });
  }
}
