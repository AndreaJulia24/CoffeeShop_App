import 'package:flutter/material.dart';
import 'package:coffee_shop/constants/colors.dart';
import 'package:coffee_shop/models/products.dart';
import 'package:coffee_shop/provider/coffee_provider.dart';
import 'package:provider/provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final cartProvider = context.watch<CoffeeProvider>();
    final cartItems = cartProvider.cartItems;

    return Scaffold(
      backgroundColor: primaryBrown,
      appBar: AppBar(
        title: const Text(
          "Shopping Cart",
          style: TextStyle(color: primaryWhite, fontWeight: FontWeight.w800),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
      ),
      body: cartItems.isEmpty
          ? buildEmptyState()
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      return buildCartItem(cartItems[index], cartProvider);
                    },
                  ),
                ),
                buildTotalPrice(cartProvider, context),
              ],
            ),
    );
  }

  Widget buildCartItem(Coffee item, CoffeeProvider provider) {
    return Container(
      height: 110,
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: darkBrown,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          const SizedBox(width: 15),
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(12),
            child: Image.network(
              item.imageUrl,
              width: 100,
              height: 90,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    item.name,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w800,
                      color: primaryWhite,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    "${item.price.toStringAsFixed(2)} lei",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: primaryWhite,
                    ),
                  ),
                ],
              ),
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.delete_outline, color: primaryWhite),
          ),
        ],
      ),
    );
  }

  Widget buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 80, color: greyPrimary),
          const SizedBox(height: 20),
          const Text(
            "Your cart is empty",
            style: TextStyle(color: greyPrimary, fontSize: 18),
          ),
        ],
      ),
    );
  }

  Widget buildTotalPrice(CoffeeProvider provider, BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: BoxDecoration(
        color: primaryWhite,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
        boxShadow: [BoxShadow(color: Colors.black, blurRadius: 10)],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Total Price",
                style: TextStyle(fontSize: 16, color: greyPrimary),
              ),
              Text(
                "${provider.totalPrice.toStringAsFixed(2)} lei",
                style: TextStyle(
                  fontWeight: FontWeight.w800,
                  color: primaryBrown,
                ),
              ),
            ],
          ),
          SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text(
                      "Successful ordering! Thank you for your purchase.",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    backgroundColor: Colors.green,
                    duration: Duration(seconds: 2),
                  ),
                );
                provider.clearCart();
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: lightBrown,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(15),
                ),
              ),
              child: const Text(
                "Buy now",
                style: TextStyle(color: darkBrown, fontSize: 18),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
