// lib/bloc/delivery_auth_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:delivery_partner_app/bloc/auth/delivery_auth_event.dart';
import 'package:delivery_partner_app/bloc/auth/delivery_auth_state.dart';

class DeliveryAuthBloc extends Bloc<DeliveryAuthEvent, DeliveryAuthState> {
  DeliveryAuthBloc() : super(DeliveryAuthInitial()) {
    on<LoginRequested>(_onLoginRequested);
  }

  void _onLoginRequested(
    LoginRequested event,
    Emitter<DeliveryAuthState> emit,
  ) async {
    emit(DeliveryAuthLoading());
    try {
      // Simulate a network request with a delay
      await Future.delayed(const Duration(seconds: 2));

      // Mock authentication logic
      if (event.email == 'delivery@partner.com' &&
          event.password == 'delivery123') {
        emit(DeliveryAuthSuccess());
      } else {
        emit(const DeliveryAuthFailure(error: 'Invalid email or password.'));
      }
    } catch (e) {
      emit(DeliveryAuthFailure(error: e.toString()));
    }
  }
}
