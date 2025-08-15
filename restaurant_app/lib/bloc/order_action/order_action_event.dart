// lib/bloc/order_action_event.dart

import 'package:equatable/equatable.dart';

abstract class OrderActionEvent extends Equatable {
  const OrderActionEvent();

  @override
  List<Object> get props => [];
}

class AcceptOrderRequested extends OrderActionEvent {
  final String orderId;

  const AcceptOrderRequested({required this.orderId});

  @override
  List<Object> get props => [orderId];
}

class RejectOrderRequested extends OrderActionEvent {
  final String orderId;

  const RejectOrderRequested({required this.orderId});

  @override
  List<Object> get props => [orderId];
}
