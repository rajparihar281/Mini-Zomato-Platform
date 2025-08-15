import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/bloc/order/order_event.dart';
import 'package:user_app/bloc/order/order_state.dart';
class OrderBloc extends Bloc<OrderEvent, OrderState> {
  OrderBloc() : super(OrderInitial()) {
    on<PlaceOrder>(_onPlaceOrder);
  }

  Future<void> _onPlaceOrder(PlaceOrder event, Emitter<OrderState> emit) async {
    emit(OrderPlacementInProgress());
    try {
      // Simulate a network call to a backend
      await Future.delayed(const Duration(seconds: 2));

      // In a real app, you would handle the response here.
      // For this project, we'll just assume it's always successful.
      emit(OrderPlacementSuccess());
    } catch (e) {
      emit(const OrderPlacementFailure(error: 'Failed to place order.'));
    }
  }
}
