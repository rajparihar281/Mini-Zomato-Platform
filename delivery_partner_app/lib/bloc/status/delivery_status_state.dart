// lib/bloc/delivery_status_state.dart

import 'package:equatable/equatable.dart';

abstract class DeliveryStatusState extends Equatable {
  const DeliveryStatusState();

  @override
  List<Object> get props => [];
}

class DeliveryStatusInitial extends DeliveryStatusState {}

class DeliveryStatusLoading extends DeliveryStatusState {
  final String taskId;

  const DeliveryStatusLoading({required this.taskId});

  @override
  List<Object> get props => [taskId];
}

class TaskPickedUp extends DeliveryStatusState {
  final String taskId;

  const TaskPickedUp({required this.taskId});

  @override
  List<Object> get props => [taskId];
}

class TaskDelivered extends DeliveryStatusState {
  final String taskId;

  const TaskDelivered({required this.taskId});

  @override
  List<Object> get props => [taskId];
}

class DeliveryStatusError extends DeliveryStatusState {
  final String taskId;
  final String error;

  const DeliveryStatusError({required this.taskId, required this.error});

  @override
  List<Object> get props => [taskId, error];
}
