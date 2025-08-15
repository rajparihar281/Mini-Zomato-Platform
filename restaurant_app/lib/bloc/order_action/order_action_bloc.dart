// lib/bloc/order_action_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/bloc/order_action/order_action_event.dart';
import 'package:restaurant_app/bloc/order_action/order_action_state.dart';
class OrderActionBloc extends Bloc<OrderActionEvent, OrderActionState> {
  OrderActionBloc() : super(OrderActionInitial()) {
    on<AcceptOrderRequested>(_onAcceptOrderRequested);
    on<RejectOrderRequested>(_onRejectOrderRequested);
  }

  void _onAcceptOrderRequested(
    AcceptOrderRequested event,
    Emitter<OrderActionState> emit,
  ) async {
    emit(OrderActionLoading(orderId: event.orderId));
    try {
      // Simulate a successful API call to accept the order
      await Future.delayed(const Duration(seconds: 1));
      emit(OrderAccepted(orderId: event.orderId));
    } catch (e) {
      emit(
        OrderActionError(
          orderId: event.orderId,
          error: 'Failed to accept order.',
        ),
      );
    }
  }

  void _onRejectOrderRequested(
    RejectOrderRequested event,
    Emitter<OrderActionState> emit,
  ) async {
    emit(OrderActionLoading(orderId: event.orderId));
    try {
      // Simulate a successful API call to reject the order
      await Future.delayed(const Duration(seconds: 1));
      emit(OrderRejected(orderId: event.orderId));
    } catch (e) {
      emit(
        OrderActionError(
          orderId: event.orderId,
          error: 'Failed to reject order.',
        ),
      );
    }
  }
}
