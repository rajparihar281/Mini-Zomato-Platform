// lib/bloc/incoming_orders_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/bloc/orders/incoming_orders_event.dart';
import 'package:restaurant_app/bloc/orders/incoming_orders_state.dart';
import 'package:restaurant_app/models/order.dart';

class IncomingOrdersBloc
    extends Bloc<IncomingOrdersEvent, IncomingOrdersState> {
  IncomingOrdersBloc() : super(IncomingOrdersInitial()) {
    on<FetchOrdersRequested>(_onFetchOrdersRequested);
  }

  void _onFetchOrdersRequested(
    FetchOrdersRequested event,
    Emitter<IncomingOrdersState> emit,
  ) async {
    emit(IncomingOrdersLoading());
    try {
      // Simulate fetching data from a repository or API
      await Future.delayed(const Duration(seconds: 1));

      final mockOrders = [
        Order(
          id: '101',
          customerName: 'John Doe',
          items: ['Burger', 'Fries'],
          total: 15.50,
          orderTime: DateTime.now().subtract(const Duration(minutes: 5)),
        ),
        Order(
          id: '102',
          customerName: 'Jane Smith',
          items: ['Pizza', 'Coke'],
          total: 22.00,
          orderTime: DateTime.now().subtract(const Duration(minutes: 10)),
        ),
      ];
      emit(IncomingOrdersLoaded(orders: mockOrders));
    } catch (e) {
      emit(const IncomingOrdersError(error: 'Failed to fetch orders.'));
    }
  }
}
