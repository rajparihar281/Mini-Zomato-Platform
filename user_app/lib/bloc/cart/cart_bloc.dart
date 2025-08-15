import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/bloc/cart/cart_event.dart';
import 'package:user_app/bloc/cart/cart_state.dart';
import 'package:user_app/data/models/cart_model.dart';
import 'package:user_app/data/models/menu_item_model.dart'; // Add this import

class CartBloc extends Bloc<CartEvent, CartState> {
  CartBloc() : super(const CartState()) {
    on<AddItemToCart>(_onAddItemToCart);
    on<RemoveItemFromCart>(_onRemoveItemFromCart);
    on<ClearCart>(_onClearCart); // --- ADD THIS HANDLER ---
  }

  void _onAddItemToCart(AddItemToCart event, Emitter<CartState> emit) {
    final updatedList = List<MenuItem>.from(state.cart.items)..add(event.item);
    emit(CartState(cart: Cart(items: updatedList)));
  }

  void _onRemoveItemFromCart(
    RemoveItemFromCart event,
    Emitter<CartState> emit,
  ) {
    final updatedList = List<MenuItem>.from(state.cart.items)
      ..remove(event.item);
    emit(CartState(cart: Cart(items: updatedList)));
  }

  // --- ADD THIS METHOD ---
  void _onClearCart(ClearCart event, Emitter<CartState> emit) {
    // Emit a new, empty CartState
    emit(const CartState());
  }
}
