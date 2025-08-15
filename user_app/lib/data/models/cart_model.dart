import 'package:equatable/equatable.dart';
import 'package:user_app/data/models/menu_item_model.dart';

class Cart extends Equatable {
  final List<MenuItem> items;

  const Cart({this.items = const []});

  @override
  List<Object?> get props => [items];
}
