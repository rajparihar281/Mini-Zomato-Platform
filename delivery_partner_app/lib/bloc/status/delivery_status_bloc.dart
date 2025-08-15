// lib/bloc/delivery_status_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:delivery_partner_app/bloc/status/delivery_status_event.dart';
import 'package:delivery_partner_app/bloc/status/delivery_status_state.dart';

class DeliveryStatusBloc
    extends Bloc<DeliveryStatusEvent, DeliveryStatusState> {
  DeliveryStatusBloc() : super(DeliveryStatusInitial()) {
    on<PickedUpRequested>(_onPickedUpRequested);
    on<DeliveredRequested>(_onDeliveredRequested);
  }

  void _onPickedUpRequested(
    PickedUpRequested event,
    Emitter<DeliveryStatusState> emit,
  ) async {
    emit(DeliveryStatusLoading(taskId: event.taskId));
    try {
      // Simulate a network request to update the status
      await Future.delayed(const Duration(seconds: 1));
      emit(TaskPickedUp(taskId: event.taskId));
    } catch (e) {
      emit(
        DeliveryStatusError(
          taskId: event.taskId,
          error: 'Failed to update status.',
        ),
      );
    }
  }

  void _onDeliveredRequested(
    DeliveredRequested event,
    Emitter<DeliveryStatusState> emit,
  ) async {
    emit(DeliveryStatusLoading(taskId: event.taskId));
    try {
      // Simulate a network request to update the status
      await Future.delayed(const Duration(seconds: 1));
      emit(TaskDelivered(taskId: event.taskId));
    } catch (e) {
      emit(
        DeliveryStatusError(
          taskId: event.taskId,
          error: 'Failed to update status.',
        ),
      );
    }
  }
}
