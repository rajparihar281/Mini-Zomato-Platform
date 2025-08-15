// lib/bloc/delivery_auth_event.dart

import 'package:equatable/equatable.dart';

abstract class DeliveryAuthEvent extends Equatable {
  const DeliveryAuthEvent();

  @override
  List<Object> get props => [];
}

class LoginRequested extends DeliveryAuthEvent {
  final String email;
  final String password;

  const LoginRequested({required this.email, required this.password});

  @override
  List<Object> get props => [email, password];
}
