// lib/bloc/delivery_auth_state.dart

import 'package:equatable/equatable.dart';

abstract class DeliveryAuthState extends Equatable {
  const DeliveryAuthState();

  @override
  List<Object> get props => [];
}

class DeliveryAuthInitial extends DeliveryAuthState {}

class DeliveryAuthLoading extends DeliveryAuthState {}

class DeliveryAuthSuccess extends DeliveryAuthState {}

class DeliveryAuthFailure extends DeliveryAuthState {
  final String error;

  const DeliveryAuthFailure({required this.error});

  @override
  List<Object> get props => [error];
}
