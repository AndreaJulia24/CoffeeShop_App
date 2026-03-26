import 'package:flutter/material.dart';
import 'package:coffee_shop/models/products.dart';

class CartProvider extends ChangeNotifier {
  final List<Coffee> cartItems = [];
  final List<Coffee> favoriteItems = [];

  List<Coffee> get _cartItems => cartItems;

  void addToCart(Coffee coffee) {
    _cartItems.add(coffee);
    notifyListeners();
  }

  void removeFromCart(Coffee coffee) {
    _cartItems.remove(coffee);
    notifyListeners();
  }

  double get totalPrice => _cartItems.fold(0, (sum, item) => sum + item.price);
}
