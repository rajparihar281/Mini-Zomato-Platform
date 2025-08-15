// lib/bloc/delivery_orders_state.dart

import 'package:equatable/equatable.dart';
import 'package:delivery_partner_app/models/delivery_task.dart';

abstract class DeliveryOrdersState extends Equatable {
  const DeliveryOrdersState();

  @override
  List<Object> get props => [];
}

class DeliveryOrdersInitial extends DeliveryOrdersState {}

class DeliveryOrdersLoading extends DeliveryOrdersState {}

class DeliveryOrdersLoaded extends DeliveryOrdersState {
  final List<DeliveryTask> orders;

  const DeliveryOrdersLoaded({required this.orders});

  @override
  List<Object> get props => [orders];
}

class DeliveryOrdersError extends DeliveryOrdersState {
  final String error;

  const DeliveryOrdersError({required this.error});

  @override
  List<Object> get props => [error];
}
