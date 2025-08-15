// lib/presentation/menu/menu_management_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/bloc/menu/menu_mgmt_bloc.dart';
import 'package:restaurant_app/bloc/menu/menu_mgmt_event.dart';
import 'package:restaurant_app/bloc/menu/menu_mgmt_state.dart';
import 'package:restaurant_app/models/menu_item.dart';
import 'package:uuid/uuid.dart';

class MenuManagementScreen extends StatelessWidget {
  const MenuManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => MenuMgmtBloc()..add(LoadMenuRequested()),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Menu Management'),
          backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        body: BlocListener<MenuMgmtBloc, MenuMgmtState>(
          listener: (context, state) {
            if (state is MenuMgmtActionSuccess) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.message)));
            } else if (state is MenuMgmtError) {
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(state.error)));
            }
          },
          child: BlocBuilder<MenuMgmtBloc, MenuMgmtState>(
            builder: (context, state) {
              if (state is MenuMgmtLoading || state is MenuMgmtInitial) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is MenuMgmtLoaded ||
                  state is MenuMgmtActionSuccess) {
                final menuItems = (state is MenuMgmtLoaded)
                    ? state.menuItems
                    : (state as MenuMgmtActionSuccess).message.isEmpty
                    ? []
                    : []; // Resetting state logic
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: menuItems.length,
                        itemBuilder: (context, index) {
                          final item = menuItems[index];
                          return ListTile(
                            title: Text(item.name),
                            subtitle: Text(item.description),
                            trailing: Text(
                              '\$${item.price.toStringAsFixed(2)}',
                            ),
                            leading: IconButton(
                              icon: const Icon(Icons.edit),
                              onPressed: () => _showForm(context, item),
                            ),
                            onLongPress: () {
                              context.read<MenuMgmtBloc>().add(
                                DeleteMenuItemRequested(id: item.id),
                              );
                            },
                          );
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ElevatedButton(
                        onPressed: () => _showForm(context),
                        child: const Text('Add New Item'),
                      ),
                    ),
                  ],
                );
              } else if (state is MenuMgmtError) {
                return Center(child: Text(state.error));
              }
              return const Center(child: Text('No menu items to display.'));
            },
          ),
        ),
      ),
    );
  }

  void _showForm(BuildContext context, [MenuItem? menuItem]) {
    final isEditing = menuItem != null;
    final nameController = TextEditingController(
      text: isEditing ? menuItem.name : '',
    );
    final descController = TextEditingController(
      text: isEditing ? menuItem.description : '',
    );
    final priceController = TextEditingController(
      text: isEditing ? menuItem.price.toString() : '',
    );

    showDialog(
      context: context,
      builder: (ctx) {
        return AlertDialog(
          title: Text(isEditing ? 'Edit Item' : 'Add New Item'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: 'Name'),
              ),
              TextField(
                controller: descController,
                decoration: const InputDecoration(labelText: 'Description'),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: 'Price'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final newMenuItem = MenuItem(
                  id: isEditing ? menuItem.id : const Uuid().v4(),
                  name: nameController.text,
                  description: descController.text,
                  price: double.parse(priceController.text),
                );
                if (isEditing) {
                  context.read<MenuMgmtBloc>().add(
                    EditMenuItemRequested(menuItem: newMenuItem),
                  );
                } else {
                  context.read<MenuMgmtBloc>().add(
                    AddMenuItemRequested(menuItem: newMenuItem),
                  );
                }
                Navigator.of(ctx).pop();
              },
              child: Text(isEditing ? 'Save' : 'Add'),
            ),
          ],
        );
      },
    );
  }
}
