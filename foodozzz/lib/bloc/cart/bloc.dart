import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:foodozzz/bloc/cart/model.dart';
import 'package:foodozzz/bloc/cart/states.dart';
import 'event.dart';

class CartBloc extends Bloc<CartEvent, CartStates> {
  final Map<String, CartModel> _items = {};

  CartBloc() : super(CartInitial()) {
    on<AddToCart>(_onAddToCart);
    on<RemoveFromCart>(_onRemoveFromCart);
    on<ClearCart>(_onClearCart);
    on<IncrementQuantity>(_onIncrement);
    on<DecrementQuantity>(_onDecrement);
  }

  void _onAddToCart(AddToCart event, Emitter<CartStates> emit) {
    if (_items.containsKey(event.id)) {
      _items.update(
        event.id,
            (existing) => existing.copyWith(quantity: existing.quantity + 1),
      );
    } else {
      _items[event.id] = CartModel(
        id: event.id,
        dishName: event.dishName,
        price: event.price,
      );
    }

    emit(CartUpdated(
      items: Map.from(_items),
      totalPrice: _calculateTotal(),
    ));
  }

  void _onRemoveFromCart(RemoveFromCart event, Emitter<CartStates> emit) {
    _items.remove(event.id);

    emit(CartUpdated(
      items: Map.from(_items),
      totalPrice: _calculateTotal(),
    ));
  }

  void _onClearCart(ClearCart event, Emitter<CartStates> emit) {
    _items.clear();

    emit(CartUpdated(
      items: {},
      totalPrice: 0.0,
    ));
  }

  void _onIncrement(IncrementQuantity event, Emitter<CartStates> emit) {
    if (_items.containsKey(event.id)) {
      _items.update(
        event.id,
            (existing) => existing.copyWith(quantity: existing.quantity + 1),
      );
    }

    emit(CartUpdated(
      items: Map.from(_items),
      totalPrice: _calculateTotal(),
    ));
  }

  void _onDecrement(DecrementQuantity event, Emitter<CartStates> emit) {
    if (_items.containsKey(event.id)) {
      final current = _items[event.id]!;
      if (current.quantity > 1) {
        _items.update(
          event.id,
              (existing) => existing.copyWith(quantity: existing.quantity - 1),
        );
      } else {
        _items.remove(event.id);
      }
    }

    emit(CartUpdated(
      items: Map.from(_items),
      totalPrice: _calculateTotal(),
    ));
  }

  double _calculateTotal() {
    return _items.values
        .fold(0.0, (sum, item) => sum + (item.price * item.quantity));
  }
}

