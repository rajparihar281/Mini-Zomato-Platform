// lib/presentation/dashboard/order_dashboard_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/bloc/orders/incoming_orders_bloc.dart';
import 'package:restaurant_app/bloc/orders/incoming_orders_event.dart';
import 'package:restaurant_app/bloc/orders/incoming_orders_state.dart';
import 'package:restaurant_app/bloc/order_action/order_action_bloc.dart';
import 'package:restaurant_app/bloc/order_action/order_action_event.dart';
import 'package:restaurant_app/bloc/order_action/order_action_state.dart';
import 'package:restaurant_app/presentation/menu/menu_management_screen.dart';

class OrderDashboardScreen extends StatelessWidget {
  const OrderDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Order Dashboard'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        actions: [
          IconButton(
            icon: const Icon(Icons.restaurant_menu),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const MenuManagementScreen(),
                ),
              );
            },
            tooltip: 'Manage Menu',
          ),
        ],
      ),
      body: BlocProvider(
        create: (context) => IncomingOrdersBloc()..add(FetchOrdersRequested()),
        child: BlocBuilder<IncomingOrdersBloc, IncomingOrdersState>(
          builder: (context, state) {
            if (state is IncomingOrdersLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is IncomingOrdersLoaded) {
              return ListView.builder(
                itemCount: state.orders.length,
                itemBuilder: (context, index) {
                  final order = state.orders[index];
                  return BlocProvider(
                    create: (context) => OrderActionBloc(),
                    child: BlocListener<OrderActionBloc, OrderActionState>(
                      listener: (context, actionState) {
                        if (actionState is OrderAccepted) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Order #${actionState.orderId} Accepted',
                              ),
                            ),
                          );
                        } else if (actionState is OrderRejected) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Order #${actionState.orderId} Rejected',
                              ),
                            ),
                          );
                        } else if (actionState is OrderActionError) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text('Error: ${actionState.error}'),
                            ),
                          );
                        }
                      },
                      child: Card(
                        margin: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: ListTile(
                          title: Text('Order #${order.id}'),
                          subtitle: Text(
                            'Customer: ${order.customerName}\nItems: ${order.items.join(', ')}',
                          ),
                          trailing:
                              BlocBuilder<OrderActionBloc, OrderActionState>(
                                builder: (context, actionState) {
                                  if (actionState is OrderActionLoading &&
                                      actionState.orderId == order.id) {
                                    return const CircularProgressIndicator();
                                  }
                                  if (actionState is OrderAccepted &&
                                      actionState.orderId == order.id) {
                                    return const Icon(
                                      Icons.check,
                                      color: Colors.green,
                                    );
                                  }
                                  if (actionState is OrderRejected &&
                                      actionState.orderId == order.id) {
                                    return const Icon(
                                      Icons.close,
                                      color: Colors.red,
                                    );
                                  }
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(Icons.check),
                                        color: Colors.green,
                                        onPressed: () {
                                          context.read<OrderActionBloc>().add(
                                            AcceptOrderRequested(
                                              orderId: order.id,
                                            ),
                                          );
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(Icons.close),
                                        color: Colors.red,
                                        onPressed: () {
                                          context.read<OrderActionBloc>().add(
                                            RejectOrderRequested(
                                              orderId: order.id,
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  );
                                },
                              ),
                        ),
                      ),
                    ),
                  );
                },
              );
            } else if (state is IncomingOrdersError) {
              return Center(child: Text(state.error));
            }
            return const Center(child: Text('No orders to display.'));
          },
        ),
      ),
    );
  }
}
