import 'package:flutter/material.dart';
import 'package:coffee_shop/constants/colors.dart';
import 'package:coffee_shop/models/products.dart';

class FavoritesScreen extends StatelessWidget {
  //final Coffee coffee;

  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBrown,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Favorites",
          style: TextStyle(
            color: primaryWhite,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: primaryWhite),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: Padding(
        padding: const EdgeInsetsGeometry.symmetric(horizontal: 25.0),
        child: favoritesCoffees.isEmpty
            ? const Center(
                child: Text(
                  "You don't have favorites!",
                  style: TextStyle(color: primaryWhite),
                ),
              )
            : Expanded(
                child: ListView.builder(
                  itemCount: favoritesCoffees.length,
                  itemBuilder: (context, index) {
                    return buildFavoriteCard(favoritesCoffees[index]);
                  },
                ),
              ),
      ),
    );
  }

  Widget buildFavoriteCard(Coffee coffee) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: brownforFav,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadiusGeometry.circular(12),
            child: Image.network(
              coffee.imageUrl,
              width: 80,
              height: 80,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 15),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  coffee.name,
                  style: const TextStyle(
                    color: primaryWhite,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  coffee.description,
                  style: TextStyle(color: greyPrimary, fontSize: 12),
                ),
                const SizedBox(height: 10),
                Text(
                  "${coffee.price.toStringAsFixed(2)} lei",
                  style: const TextStyle(
                    color: secondaryBrown,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.favorite,
              color: Color.fromARGB(255, 147, 31, 23),
            ),
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
