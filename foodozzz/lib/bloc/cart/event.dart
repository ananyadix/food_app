abstract class CartEvent {}

class AddToCart extends CartEvent {
  final String id;
  final String dishName;
  final double price;

  AddToCart({
    required this.id,
    required this.dishName,
    required this.price,
  });
}

class RemoveFromCart extends CartEvent {
  final String id;

  RemoveFromCart({required this.id});
}

class ClearCart extends CartEvent {}

class IncrementQuantity extends CartEvent {
  final String id;

  IncrementQuantity(this.id);
}

class DecrementQuantity extends CartEvent {
  final String id;

  DecrementQuantity(this.id);
}
