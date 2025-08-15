import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:user_app/bloc/menu/menu_event.dart';
import 'package:user_app/bloc/menu/menu_state.dart';
import 'package:user_app/data/repositories/restaurant_repository.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final RestaurantRepository _restaurantRepository;

  MenuBloc(this._restaurantRepository) : super(MenuInitial()) {
    on<FetchMenu>(_onFetchMenu);
  }

  Future<void> _onFetchMenu(FetchMenu event, Emitter<MenuState> emit) async {
    emit(MenuLoading());
    try {
      final menuItems = await _restaurantRepository.fetchMenu(
        event.restaurantId,
      );
      emit(MenuLoaded(menuItems: menuItems));
    } catch (e) {
      emit(const MenuError(message: 'Failed to fetch menu.'));
    }
  }
}
