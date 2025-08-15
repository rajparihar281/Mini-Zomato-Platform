import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/bloc/cart/cart_bloc.dart';
import 'package:user_app/bloc/cart/cart_event.dart';
import 'package:user_app/bloc/cart/cart_state.dart';
import 'package:user_app/bloc/menu/menu_bloc.dart';
import 'package:user_app/bloc/menu/menu_event.dart';
import 'package:user_app/bloc/menu/menu_state.dart';
import 'package:user_app/data/models/restaurant_model.dart';
import 'package:user_app/data/repositories/restaurant_repository.dart';
import 'package:user_app/presentation/cart/cart_screen.dart';

class RestaurantDetailsScreen extends StatelessWidget {
  final Restaurant restaurant;

  const RestaurantDetailsScreen({super.key, required this.restaurant});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          MenuBloc(RepositoryProvider.of<RestaurantRepository>(context))
            ..add(FetchMenu(restaurantId: restaurant.id)),
      child: Scaffold(
        appBar: AppBar(
          title: Text(restaurant.name),
          actions: [
            BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                final itemCount = state.cart.items.length;
                return Stack(
                  alignment: Alignment.center,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.shopping_cart),
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(builder: (_) => const CartScreen()),
                        );
                      },
                    ),
                    if (itemCount > 0)
                      Positioned(
                        right: 8,
                        top: 8,
                        child: Container(
                          padding: const EdgeInsets.all(2),
                          decoration: BoxDecoration(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                          ),
                          constraints: const BoxConstraints(
                            minWidth: 16,
                            minHeight: 16,
                          ),
                          child: Text(
                            '$itemCount',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                  ],
                );
              },
            ),
          ],
        ),
        body: BlocBuilder<MenuBloc, MenuState>(
          builder: (context, state) {
            if (state is MenuLoading || state is MenuInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is MenuLoaded) {
              return ListView.builder(
                itemCount: state.menuItems.length,
                itemBuilder: (context, index) {
                  final menuItem = state.menuItems[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    child: ListTile(
                      leading: Image.network(
                        menuItem.imageUrl,
                        width: 60, // FIX: Reduced width
                        height: 60, // FIX: Adjusted height
                        fit: BoxFit.cover,
                      ),
                      title: Text(menuItem.name),
                      subtitle: Text(menuItem.description),
                      trailing: Row(
                        // FIX: Changed Column to Row
                        mainAxisSize: MainAxisSize
                            .min, // FIX: Important for Row in ListTile
                        children: [
                          Text('\$${menuItem.price.toStringAsFixed(2)}'),
                          IconButton(
                            icon: const Icon(Icons.add_shopping_cart),
                            onPressed: () {
                              context.read<CartBloc>().add(
                                AddItemToCart(menuItem),
                              );
                              ScaffoldMessenger.of(context)
                                ..hideCurrentSnackBar()
                                ..showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      '${menuItem.name} added to cart',
                                    ),
                                    duration: const Duration(seconds: 1),
                                  ),
                                );
                            },
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
            if (state is MenuError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text('Something went wrong.'));
          },
        ),
      ),
    );
  }
}
