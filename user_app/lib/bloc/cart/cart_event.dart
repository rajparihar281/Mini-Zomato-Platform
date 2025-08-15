import 'package:equatable/equatable.dart';
import 'package:user_app/data/models/menu_item_model.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();

  @override
  List<Object> get props => [];
}

class AddItemToCart extends CartEvent {
  final MenuItem item;

  const AddItemToCart(this.item);

  @override
  List<Object> get props => [item];
}

class RemoveItemFromCart extends CartEvent {
  final MenuItem item;

  const RemoveItemFromCart(this.item);

  @override
  List<Object> get props => [item];
}

// --- ADD THIS NEW EVENT ---
class ClearCart extends CartEvent {}
