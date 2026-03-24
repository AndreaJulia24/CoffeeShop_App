import 'package:flutter/material.dart';
import 'package:coffee_shop/constants/colors.dart';
import 'package:coffee_shop/models/products.dart';

class CartScreen extends StatelessWidget {
  final List<Coffee> cartItems;

  const CartScreen({super.key, required this.cartItems});

  double get totalPrice {
    return cartItems.fold(0, (sum, item) => sum + item.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBrown,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.shopping_cart_outlined,
              size: 80,
              color: primaryWhite,
            ),
            const SizedBox(height: 20),
            Text(
              " ${cartItems.length} in your cart",
              style: TextStyle(
                color: primaryWhite,
                fontSize: 22,
                fontWeight: FontWeight.w800,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              "Total: ${totalPrice.toStringAsFixed(1)} lei",
              style: const TextStyle(
                color: primaryWhite,
                fontSize: 24,
                fontWeight: FontWeight.w900,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
