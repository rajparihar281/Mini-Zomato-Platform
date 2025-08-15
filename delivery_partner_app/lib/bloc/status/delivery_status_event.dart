// lib/bloc/delivery_status_event.dart

import 'package:equatable/equatable.dart';

abstract class DeliveryStatusEvent extends Equatable {
  const DeliveryStatusEvent();

  @override
  List<Object> get props => [];
}

class PickedUpRequested extends DeliveryStatusEvent {
  final String taskId;

  const PickedUpRequested({required this.taskId});

  @override
  List<Object> get props => [taskId];
}

class DeliveredRequested extends DeliveryStatusEvent {
  final String taskId;

  const DeliveredRequested({required this.taskId});

  @override
  List<Object> get props => [taskId];
}
