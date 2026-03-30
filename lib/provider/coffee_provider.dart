import 'package:flutter/material.dart';
import 'package:coffee_shop/models/products.dart';

class CoffeeProvider extends ChangeNotifier {
  final List<Coffee> cartItems = [];
  final List<Coffee> _favorites = [];

  List<Coffee> get _cartItems => cartItems;
  List<Coffee> get favorites => _favorites;

  // KOSÁR KEZELÉS
  void addToCart(Coffee coffee) {
    _cartItems.add(coffee);
    notifyListeners();
  }

  void clearCart() {
    _cartItems.clear();
    notifyListeners();
  }

  double get totalPrice =>
      _cartItems.fold(0, (sum, item) => sum + item.currentSizePrice);

  void toggleFavorite(Coffee coffee) {
    final isExist = _favorites.any((item) => item.name == coffee.name);

    if (isExist) {
      _favorites.removeWhere((item) => item.name == coffee.name);
    } else {
      _favorites.add(coffee);
    }
    notifyListeners();
  }

  bool isFavorite(Coffee coffee) {
    return _favorites.any((item) => item.name == coffee.name);
  }
}
