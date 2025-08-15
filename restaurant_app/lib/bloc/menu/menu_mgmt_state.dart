// lib/bloc/menu_mgmt_state.dart

import 'package:equatable/equatable.dart';
import 'package:restaurant_app/models/menu_item.dart';

abstract class MenuMgmtState extends Equatable {
  const MenuMgmtState();

  @override
  List<Object> get props => [];
}

class MenuMgmtInitial extends MenuMgmtState {}

class MenuMgmtLoading extends MenuMgmtState {}

class MenuMgmtLoaded extends MenuMgmtState {
  final List<MenuItem> menuItems;

  const MenuMgmtLoaded({required this.menuItems});

  @override
  List<Object> get props => [menuItems];
}

class MenuMgmtActionSuccess extends MenuMgmtState {
  final String message;

  const MenuMgmtActionSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

class MenuMgmtError extends MenuMgmtState {
  final String error;

  const MenuMgmtError({required this.error});

  @override
  List<Object> get props => [error];
}
