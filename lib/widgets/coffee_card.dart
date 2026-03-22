import 'package:coffee_shop/constants/colors.dart';
import 'package:flutter/material.dart';
import 'package:coffee_shop/models/products.dart';

class CoffeeCard extends StatelessWidget {
  final Coffee coffee;

  const CoffeeCard({super.key, required this.coffee});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(right: 20),
      width: 180,
      height: 250,
      decoration: BoxDecoration(
        color: darkBrown,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
            child: Image.asset(
              coffee.imageUrl,
              width: 180,
              height: 140,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  width: 180,
                  height: 120,
                  color: Colors.grey,
                  child: const Icon(Icons.broken_image, color: Colors.white),
                );
              },
            ),
          ),
          const SizedBox(height: 20),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 13),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  coffee.name,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: primaryWhite,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  coffee.description,
                  style: const TextStyle(
                    fontFamily: 'Poppins',
                    fontSize: 12,
                    color: greyPrimary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
