import 'package:equatable/equatable.dart';
import 'package:user_app/data/models/cart_model.dart';

class CartState extends Equatable {
  final Cart cart;

  const CartState({this.cart = const Cart()});

  @override
  List<Object> get props => [cart];
}
