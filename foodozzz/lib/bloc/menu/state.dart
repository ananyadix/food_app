import 'package:foodozzz/bloc/menu/model.dart';

abstract class MenuState{}
class MenuInitial extends MenuState{}
class MenuLoading extends MenuState{}
class MenuSuccess extends MenuState{
  final List<MenuModel> menu;
  MenuSuccess(this.menu);
}
class MenuError extends MenuState{}

