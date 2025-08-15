// lib/bloc/menu_mgmt_bloc.dart

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:restaurant_app/bloc/menu/menu_mgmt_event.dart';
import 'package:restaurant_app/bloc/menu/menu_mgmt_state.dart';
import 'package:restaurant_app/models/menu_item.dart';

class MenuMgmtBloc extends Bloc<MenuMgmtEvent, MenuMgmtState> {
  final List<MenuItem> _menuItems = [
    const MenuItem(
      id: 'item1',
      name: 'Burger',
      description: 'Classic beef burger',
      price: 8.99,
    ),
    const MenuItem(
      id: 'item2',
      name: 'Pizza',
      description: 'Pepperoni pizza',
      price: 12.50,
    ),
  ];

  MenuMgmtBloc() : super(MenuMgmtInitial()) {
    on<LoadMenuRequested>(_onLoadMenuRequested);
    on<AddMenuItemRequested>(_onAddMenuItemRequested);
    on<EditMenuItemRequested>(_onEditMenuItemRequested);
    on<DeleteMenuItemRequested>(_onDeleteMenuItemRequested);
  }

  void _onLoadMenuRequested(
    LoadMenuRequested event,
    Emitter<MenuMgmtState> emit,
  ) {
    emit(MenuMgmtLoading());
    try {
      emit(MenuMgmtLoaded(menuItems: _menuItems));
    } catch (e) {
      emit(const MenuMgmtError(error: 'Failed to load menu items.'));
    }
  }

  void _onAddMenuItemRequested(
    AddMenuItemRequested event,
    Emitter<MenuMgmtState> emit,
  ) {
    _menuItems.add(event.menuItem);
    emit(MenuMgmtActionSuccess(message: '${event.menuItem.name} added.'));
    emit(MenuMgmtLoaded(menuItems: _menuItems));
  }

  void _onEditMenuItemRequested(
    EditMenuItemRequested event,
    Emitter<MenuMgmtState> emit,
  ) {
    final index = _menuItems.indexWhere((item) => item.id == event.menuItem.id);
    if (index != -1) {
      _menuItems[index] = event.menuItem;
      emit(MenuMgmtActionSuccess(message: '${event.menuItem.name} updated.'));
      emit(MenuMgmtLoaded(menuItems: _menuItems));
    } else {
      emit(const MenuMgmtError(error: 'Item not found.'));
    }
  }

  void _onDeleteMenuItemRequested(
    DeleteMenuItemRequested event,
    Emitter<MenuMgmtState> emit,
  ) {
    _menuItems.removeWhere((item) => item.id == event.id);
    emit(const MenuMgmtActionSuccess(message: 'Item deleted.'));
    emit(MenuMgmtLoaded(menuItems: _menuItems));
  }
}
