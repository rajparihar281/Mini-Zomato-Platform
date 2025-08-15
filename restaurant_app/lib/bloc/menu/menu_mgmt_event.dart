// lib/bloc/menu_mgmt_event.dart

import 'package:equatable/equatable.dart';
import 'package:restaurant_app/models/menu_item.dart';

abstract class MenuMgmtEvent extends Equatable {
  const MenuMgmtEvent();

  @override
  List<Object> get props => [];
}

class LoadMenuRequested extends MenuMgmtEvent {}

class AddMenuItemRequested extends MenuMgmtEvent {
  final MenuItem menuItem;

  const AddMenuItemRequested({required this.menuItem});

  @override
  List<Object> get props => [menuItem];
}

class EditMenuItemRequested extends MenuMgmtEvent {
  final MenuItem menuItem;

  const EditMenuItemRequested({required this.menuItem});

  @override
  List<Object> get props => [menuItem];
}

class DeleteMenuItemRequested extends MenuMgmtEvent {
  final String id;

  const DeleteMenuItemRequested({required this.id});

  @override
  List<Object> get props => [id];
}
