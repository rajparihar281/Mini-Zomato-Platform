import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/bloc/cart/cart_bloc.dart';
import 'package:user_app/bloc/cart/cart_event.dart';
import 'package:user_app/bloc/cart/cart_state.dart';
import 'package:user_app/bloc/order/order_bloc.dart';
import 'package:user_app/bloc/order/order_event.dart';
import 'package:user_app/bloc/order/order_state.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrderBloc(),
      child: Scaffold(
        appBar: AppBar(title: const Text('Your Cart')),
        body: BlocListener<OrderBloc, OrderState>(
          listener: (context, state) {
            if (state is OrderPlacementSuccess) {
              showDialog(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Order Placed!'),
                  content: const Text(
                    'Your order has been successfully placed.',
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        // Clear the cart
                        context.read<CartBloc>().add(ClearCart());
                        // Pop the dialog and the cart screen
                        Navigator.of(ctx).pop();
                        Navigator.of(context).pop();
                      },
                      child: const Text('OK'),
                    ),
                  ],
                ),
              );
            } else if (state is OrderPlacementFailure) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          child: BlocBuilder<CartBloc, CartState>(
            builder: (context, cartState) {
              if (cartState.cart.items.isEmpty) {
                return const Center(child: Text('Your cart is empty.'));
              }

              // Calculate total price
              final totalPrice = cartState.cart.items.fold(
                0.0,
                (sum, item) => sum + item.price,
              );

              return Column(
                children: [
                  Expanded(
                    child: ListView.builder(
                      itemCount: cartState.cart.items.length,
                      itemBuilder: (context, index) {
                        final item = cartState.cart.items[index];
                        return ListTile(
                          title: Text(item.name),
                          subtitle: Text('\$${item.price.toStringAsFixed(2)}'),
                          trailing: IconButton(
                            icon: const Icon(Icons.remove_shopping_cart),
                            onPressed: () {
                              context.read<CartBloc>().add(
                                RemoveItemFromCart(item),
                              );
                            },
                          ),
                        );
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Total: \$${totalPrice.toStringAsFixed(2)}',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        BlocBuilder<OrderBloc, OrderState>(
                          builder: (context, orderState) {
                            return ElevatedButton(
                              onPressed: orderState is OrderPlacementInProgress
                                  ? null // Disable button while loading
                                  : () {
                                      context.read<OrderBloc>().add(
                                        PlaceOrder(items: cartState.cart.items),
                                      );
                                    },
                              child: orderState is OrderPlacementInProgress
                                  ? const CircularProgressIndicator(
                                      color: Colors.white,
                                    )
                                  : const Text('Place Order'),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
