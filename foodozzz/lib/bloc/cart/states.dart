import 'package:foodozzz/bloc/cart/model.dart';

abstract class CartStates {
  const CartStates();
}

class CartInitial extends CartStates {}

class CartUpdated extends CartStates {
  final Map<String, CartModel> items;
  final double totalPrice;

  const CartUpdated({
    required this.items,
    required this.totalPrice,
  });
}
