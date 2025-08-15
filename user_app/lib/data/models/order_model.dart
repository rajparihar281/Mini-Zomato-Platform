import 'package:equatable/equatable.dart';
import 'package:user_app/data/models/menu_item_model.dart';

class OrderModel extends Equatable {
  final String id;
  final String restaurantName;
  final DateTime date;
  final double totalPrice;
  final List<MenuItem> items;

  const OrderModel({
    required this.id,
    required this.restaurantName,
    required this.date,
    required this.totalPrice,
    required this.items,
  });

  @override
  List<Object?> get props => [id, restaurantName, date, totalPrice, items];
}
