// lib/presentation/orders/assigned_orders_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:delivery_partner_app/bloc/orders/delivery_orders_bloc.dart';
import 'package:delivery_partner_app/bloc/orders/delivery_orders_event.dart';
import 'package:delivery_partner_app/bloc/orders/delivery_orders_state.dart';
import 'package:delivery_partner_app/bloc/status/delivery_status_bloc.dart';
import 'package:delivery_partner_app/bloc/status/delivery_status_event.dart';
import 'package:delivery_partner_app/bloc/status/delivery_status_state.dart';

class AssignedOrdersScreen extends StatelessWidget {
  const AssignedOrdersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Assigned Orders'),
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      body: BlocProvider(
        create: (context) => DeliveryOrdersBloc()..add(FetchOrdersRequested()),
        child: BlocBuilder<DeliveryOrdersBloc, DeliveryOrdersState>(
          builder: (context, state) {
            if (state is DeliveryOrdersLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is DeliveryOrdersLoaded) {
              return ListView.builder(
                itemCount: state.orders.length,
                itemBuilder: (context, index) {
                  final order = state.orders[index];
                  return BlocProvider(
                    create: (context) => DeliveryStatusBloc(),
                    child: BlocListener<DeliveryStatusBloc, DeliveryStatusState>(
                      listener: (context, actionState) {
                        if (actionState is TaskPickedUp) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Task #${actionState.taskId} Picked Up',
                              ),
                            ),
                          );
                        } else if (actionState is TaskDelivered) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Task #${actionState.taskId} Delivered',
                              ),
                            ),
                          );
                        } else if (actionState is DeliveryStatusError) {
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
                          title: Text('Task #${order.id}'),
                          subtitle: Text(
                            'Restaurant: ${order.restaurantName}\nAddress: ${order.customerAddress}',
                          ),
                          trailing:
                              BlocBuilder<
                                DeliveryStatusBloc,
                                DeliveryStatusState
                              >(
                                builder: (context, actionState) {
                                  if (actionState is DeliveryStatusLoading &&
                                      actionState.taskId == order.id) {
                                    return const CircularProgressIndicator();
                                  }
                                  if (actionState is TaskPickedUp &&
                                      actionState.taskId == order.id) {
                                    return const Text('Picked Up');
                                  }
                                  if (actionState is TaskDelivered &&
                                      actionState.taskId == order.id) {
                                    return const Text('Delivered');
                                  }
                                  return Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      IconButton(
                                        icon: const Icon(
                                          Icons.shopping_bag_outlined,
                                        ),
                                        tooltip: 'Picked Up',
                                        onPressed: () {
                                          context
                                              .read<DeliveryStatusBloc>()
                                              .add(
                                                PickedUpRequested(
                                                  taskId: order.id,
                                                ),
                                              );
                                        },
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.check_circle_outline,
                                        ),
                                        tooltip: 'Delivered',
                                        onPressed: () {
                                          context
                                              .read<DeliveryStatusBloc>()
                                              .add(
                                                DeliveredRequested(
                                                  taskId: order.id,
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
            } else if (state is DeliveryOrdersError) {
              return Center(child: Text(state.error));
            }
            return const Center(child: Text('No assigned orders.'));
          },
        ),
      ),
    );
  }
}
