class CartModel {
  final String id;
  final String dishName;
  final double price;
  final int quantity;

  CartModel({
    required this.id,
    required this.dishName,
    required this.price,
    this.quantity = 1,
  });

  CartModel copyWith({int? quantity}) {
    return CartModel(
      id: id,
      dishName: dishName,
      price: price,
      quantity: quantity ?? this.quantity,
    );
  }
}
