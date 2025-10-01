import 'package:flutter_bloc/flutter_bloc.dart';
import 'event.dart';
import 'state.dart';
import 'services.dart';
import 'model.dart';

class MenuBloc extends Bloc<MenuEvent, MenuState> {
  final MenuServices menuServices;

  MenuBloc({required this.menuServices}) : super(MenuInitial()) {
    on<FetchMenu>(_onFetchMenu);
  }

  Future<void> _onFetchMenu(FetchMenu event, Emitter<MenuState> emit) async {
    emit(MenuLoading());

    try {
      final MenuModel? menu = await menuServices.getMenuByRestaurantId(event.restId);

      if (menu != null && menu.menu != null && menu.menu!.isNotEmpty) {
        emit(MenuSuccess([menu]));
      } else {
        emit(MenuError());
      }
    } catch (e) {
      print("Error in MenuBloc: $e");
      emit(MenuError());
    }
  }
}
