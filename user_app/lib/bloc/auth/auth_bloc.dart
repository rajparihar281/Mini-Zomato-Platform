import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/bloc/auth/auth_event.dart';
import 'package:user_app/bloc/auth/auth_state.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
  }

  Future<void> _onLoginRequested(
    LoginRequested event,
    Emitter<AuthState> emit,
  ) async {
    emit(AuthLoading());
    try {
      // This is a mock authentication call.
      // We simulate a network delay.
      await Future.delayed(const Duration(seconds: 2));

      if (event.email == 'test@test.com' && event.password == 'password') {
        emit(AuthSuccess());
      } else {
        emit(const AuthFailure(error: 'Invalid email or password'));
      }
    } catch (e) {
      emit(const AuthFailure(error: 'An unexpected error occurred.'));
    }
  }
}
