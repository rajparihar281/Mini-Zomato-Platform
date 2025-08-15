// lib/bloc/incoming_orders_state.dart

import 'package:equatable/equatable.dart';
import 'package:restaurant_app/models/order.dart';

abstract class IncomingOrdersState extends Equatable {
  const IncomingOrdersState();

  @override
  List<Object> get props => [];
}

class IncomingOrdersInitial extends IncomingOrdersState {}

class IncomingOrdersLoading extends IncomingOrdersState {}

class IncomingOrdersLoaded extends IncomingOrdersState {
  final List<Order> orders;

  const IncomingOrdersLoaded({required this.orders});

  @override
  List<Object> get props => [orders];
}

class IncomingOrdersError extends IncomingOrdersState {
  final String error;

  const IncomingOrdersError({required this.error});

  @override
  List<Object> get props => [error];
}
