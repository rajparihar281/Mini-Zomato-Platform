import 'package:equatable/equatable.dart';
import 'package:user_app/data/models/restaurant_model.dart';

abstract class RestaurantListState extends Equatable {
  const RestaurantListState();

  @override
  List<Object> get props => [];
}

class RestaurantListInitial extends RestaurantListState {}

class RestaurantListLoading extends RestaurantListState {}

class RestaurantListLoaded extends RestaurantListState {
  final List<Restaurant> restaurants;

  const RestaurantListLoaded({required this.restaurants});

  @override
  List<Object> get props => [restaurants];
}

class RestaurantListError extends RestaurantListState {
  final String message;

  const RestaurantListError({required this.message});

  @override
  List<Object> get props => [message];
}
