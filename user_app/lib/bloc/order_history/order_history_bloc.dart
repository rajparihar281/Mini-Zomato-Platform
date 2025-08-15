import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/bloc/order_history/order_history_event.dart';
import 'package:user_app/bloc/order_history/order_history_state.dart';
import 'package:user_app/data/repositories/restaurant_repository.dart';

class OrderHistoryBloc extends Bloc<OrderHistoryEvent, OrderHistoryState> {
  final RestaurantRepository _restaurantRepository;

  OrderHistoryBloc(this._restaurantRepository) : super(OrderHistoryInitial()) {
    on<FetchOrderHistory>(_onFetchOrderHistory);
  }

  Future<void> _onFetchOrderHistory(
    FetchOrderHistory event,
    Emitter<OrderHistoryState> emit,
  ) async {
    emit(OrderHistoryLoading());
    try {
      final orders = await _restaurantRepository.fetchOrderHistory();
      emit(OrderHistoryLoaded(orders: orders));
    } catch (e) {
      emit(const OrderHistoryError(message: 'Failed to fetch order history.'));
    }
  }
}
