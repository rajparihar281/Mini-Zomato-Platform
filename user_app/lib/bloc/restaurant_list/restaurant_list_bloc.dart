import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/bloc/restaurant_list/restaurant_list_event.dart';
import 'package:user_app/bloc/restaurant_list/restaurant_list_state.dart';
import 'package:user_app/data/repositories/restaurant_repository.dart';

class RestaurantListBloc
    extends Bloc<RestaurantListEvent, RestaurantListState> {
  final RestaurantRepository _restaurantRepository;

  RestaurantListBloc(this._restaurantRepository)
    : super(RestaurantListInitial()) {
    on<FetchRestaurants>(_onFetchRestaurants);
  }

  Future<void> _onFetchRestaurants(
    FetchRestaurants event,
    Emitter<RestaurantListState> emit,
  ) async {
    emit(RestaurantListLoading());
    try {
      final restaurants = await _restaurantRepository.fetchRestaurants();
      emit(RestaurantListLoaded(restaurants: restaurants));
    } catch (e) {
      emit(
        const RestaurantListError(
          message: 'Failed to fetch restaurants. Please try again.',
        ),
      );
    }
  }
}
