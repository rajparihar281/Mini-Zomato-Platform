// lib/bloc/order_action_state.dart

import 'package:equatable/equatable.dart';

abstract class OrderActionState extends Equatable {
  const OrderActionState();

  @override
  List<Object> get props => [];
}

class OrderActionInitial extends OrderActionState {}

class OrderActionLoading extends OrderActionState {
  final String orderId;

  const OrderActionLoading({required this.orderId});

  @override
  List<Object> get props => [orderId];
}

class OrderAccepted extends OrderActionState {
  final String orderId;

  const OrderAccepted({required this.orderId});

  @override
  List<Object> get props => [orderId];
}

class OrderRejected extends OrderActionState {
  final String orderId;

  const OrderRejected({required this.orderId});

  @override
  List<Object> get props => [orderId];
}

class OrderActionError extends OrderActionState {
  final String orderId;
  final String error;

  const OrderActionError({required this.orderId, required this.error});

  @override
  List<Object> get props => [orderId, error];
}
