import 'package:equatable/equatable.dart';
import 'package:user_app/data/models/menu_item_model.dart';

abstract class OrderEvent extends Equatable {
  const OrderEvent();

  @override
  List<Object> get props => [];
}

class PlaceOrder extends OrderEvent {
  final List<MenuItem> items;

  const PlaceOrder({required this.items});

  @override
  List<Object> get props => [items];
}
