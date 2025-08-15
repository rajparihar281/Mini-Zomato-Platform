// lib/bloc/restaurant_auth_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/bloc/auth/auth_event.dart';
import 'package:restaurant_app/bloc/auth/auth_state.dart';
class RestaurantAuthBloc extends Bloc<AuthEvent, AuthState> {
  RestaurantAuthBloc() : super(AuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
  }

  void _onLoginRequested(LoginRequested event, Emitter<AuthState> emit) async {
    emit(AuthLoading());
    try {
      // Simulate a network request with a delay
      await Future.delayed(const Duration(seconds: 2));

      // Mock authentication logic
      if (event.email == 'test@restaurant.com' &&
          event.password == 'password123') {
        emit(AuthSuccess());
      } else {
        emit(const AuthFailure(error: 'Invalid email or password.'));
      }
    } catch (e) {
      emit(AuthFailure(error: e.toString()));
    }
  }
}
