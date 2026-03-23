import 'package:flutter/material.dart';
import 'package:coffee_shop/constants/colors.dart';
//import 'package:coffee_shop/models/products.dart';
//import 'package:coffee_shop/widgets/coffee_card.dart';

class OrderScreen extends StatelessWidget {
  const OrderScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackBrown,
      body: Column(
        children: [
          Container(
            padding: const EdgeInsets.only(top: 15, bottom: 15),
            width: double.infinity,
            decoration: BoxDecoration(
              color: secondaryBrown,
              borderRadius: const BorderRadius.vertical(
                bottom: Radius.circular(25),
              ),
            ),
            child: Column(
              children: [
                Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: greyPrimary,
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Order',
                  style: TextStyle(
                    color: primaryWhite,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                    fontFamily: 'Poppins',
                  ),
                ),
              ],
            ),
          ),
          const Expanded(
            child: Center(
              child: Text(
                "There will be the products",
                style: TextStyle(color: greyPrimary),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
