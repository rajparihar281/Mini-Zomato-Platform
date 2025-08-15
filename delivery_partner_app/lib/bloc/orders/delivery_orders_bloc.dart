// lib/bloc/delivery_orders_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:delivery_partner_app/bloc/orders/delivery_orders_event.dart';
import 'package:delivery_partner_app/bloc/orders/delivery_orders_state.dart';
import 'package:delivery_partner_app/models/delivery_task.dart';

class DeliveryOrdersBloc
    extends Bloc<DeliveryOrdersEvent, DeliveryOrdersState> {
  DeliveryOrdersBloc() : super(DeliveryOrdersInitial()) {
    on<FetchOrdersRequested>(_onFetchOrdersRequested);
  }

  void _onFetchOrdersRequested(
    FetchOrdersRequested event,
    Emitter<DeliveryOrdersState> emit,
  ) async {
    emit(DeliveryOrdersLoading());
    try {
      // Simulate fetching data from an API
      await Future.delayed(const Duration(seconds: 1));

      final mockOrders = [
        DeliveryTask(
          id: 'task001',
          restaurantName: 'The Burger Joint',
          customerAddress: '123 Main St, Anytown',
          status: 'Assigned',
        ),
        DeliveryTask(
          id: 'task002',
          restaurantName: 'Pizza Palace',
          customerAddress: '456 Oak Ave, Anytown',
          status: 'Assigned',
        ),
      ];
      emit(DeliveryOrdersLoaded(orders: mockOrders));
    } catch (e) {
      emit(const DeliveryOrdersError(error: 'Failed to fetch orders.'));
    }
  }
}
