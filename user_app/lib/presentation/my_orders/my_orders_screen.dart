import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:user_app/bloc/order_history/order_history_bloc.dart';
import 'package:user_app/bloc/order_history/order_history_event.dart';
import 'package:user_app/bloc/order_history/order_history_state.dart';
import 'package:user_app/data/repositories/restaurant_repository.dart';

class MyOrdersScreen extends StatelessWidget {
  const MyOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          OrderHistoryBloc(RepositoryProvider.of<RestaurantRepository>(context))
            ..add(FetchOrderHistory()),
      child: Scaffold(
        appBar: AppBar(title: const Text('My Orders')),
        body: BlocBuilder<OrderHistoryBloc, OrderHistoryState>(
          builder: (context, state) {
            if (state is OrderHistoryLoading || state is OrderHistoryInitial) {
              return const Center(child: CircularProgressIndicator());
            }
            if (state is OrderHistoryLoaded) {
              if (state.orders.isEmpty) {
                return const Center(child: Text('You have no past orders.'));
              }
              return ListView.builder(
                itemCount: state.orders.length,
                itemBuilder: (context, index) {
                  final order = state.orders[index];
                  return Card(
                    margin: const EdgeInsets.symmetric(
                      horizontal: 8.0,
                      vertical: 4.0,
                    ),
                    child: ExpansionTile(
                      title: Text(order.restaurantName),
                      subtitle: Text(DateFormat.yMMMd().format(order.date)),
                      trailing: Text(
                        '\$${order.totalPrice.toStringAsFixed(2)}',
                      ),
                      children: order.items.map((item) {
                        return ListTile(
                          title: Text(item.name),
                          trailing: Text('\$${item.price.toStringAsFixed(2)}'),
                        );
                      }).toList(),
                    ),
                  );
                },
              );
            }
            if (state is OrderHistoryError) {
              return Center(child: Text(state.message));
            }
            return const Center(child: Text('Something went wrong.'));
          },
        ),
      ),
    );
  }
}
