import 'package:flutter/material.dart';
import 'package:coffee_shop/constants/colors.dart';
import 'package:coffee_shop/models/products.dart';

class OrderScreen extends StatefulWidget {
  final Coffee coffee;
  final VoidCallback addingIntoCart;
  final VoidCallback invertFavorite;
  final bool isFavorite;

  const OrderScreen({
    super.key,
    required this.coffee,
    required this.addingIntoCart,
    required this.invertFavorite,
    required this.isFavorite,
  });

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int quantity = 1;
  bool isFavorite = false;
  String selectedSize = 'M';

  final List<String> sizes = ['S', 'M', 'L'];

  double get totalPrice => widget.coffee.price * quantity;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBrown,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: primaryWhite),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          "Details",
          style: TextStyle(fontWeight: FontWeight.w800, color: primaryWhite),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(
              widget.isFavorite ? Icons.favorite : Icons.favorite_border,
            ),
            color: widget.isFavorite ? primaryRed : primaryWhite,
            onPressed: () {
              widget.invertFavorite();

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text("${widget.coffee.name} added to favorites!"),
                ),
              );

              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            //----------a kep berakva hozza--------------
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: ClipRRect(
                borderRadius: BorderRadiusGeometry.circular(16),
                child: Image.network(
                  widget.coffee.imageUrl,
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            //--------------nev es leiras------------------
            Padding(
              padding: const EdgeInsetsGeometry.symmetric(horizontal: 25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.coffee.name,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: primaryWhite,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      const Icon(Icons.star, color: goldBrown, size: 20),
                      const SizedBox(width: 4),
                      Text(
                        widget.coffee.rating.toString(),
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: secondaryBrown,
                        ),
                      ),
                    ],
                  ),
                  const Divider(height: 40, thickness: 1.0, color: brownie),
                  const SizedBox(height: 10),
                  Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.w800,
                      color: primaryWhite,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    widget.coffee.description,
                    style: TextStyle(fontSize: 15, color: greyPrimary),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    "Size",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: primaryWhite,
                    ),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      buildSizeButton('S'),
                      buildSizeButton('M'),
                      buildSizeButton('L'),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        padding: const EdgeInsets.symmetric(horizontal: 25.0, vertical: 20),
        height: 110,
        decoration: BoxDecoration(
          color: darkBrown,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(30)),
          border: Border(
            top: BorderSide(color: lightBrown.withValues(alpha: 0.1)),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Price',
                  style: TextStyle(color: greyPrimary, fontSize: 15),
                ),
                const SizedBox(height: 4),
                Text(
                  "${widget.coffee.price.toStringAsFixed(2)} lei",
                  style: const TextStyle(
                    color: primaryWhite,
                    fontSize: 24,
                    fontWeight: FontWeight.w800,
                  ),
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: secondaryBrown,
                minimumSize: const Size(200, 60),
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadiusGeometry.circular(20),
                ),
              ),
              onPressed: () {
                widget.addingIntoCart();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("${widget.coffee.name} added to cart!"),
                    backgroundColor: secondaryBrown,
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              child: Text(
                "Add to cart",
                style: TextStyle(
                  color: primaryWhite,
                  fontSize: 18,
                  fontWeight: FontWeight.w900,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildSizeButton(String size) {
    bool isSelected = selectedSize == size;

    return TextButton(
      style: TextButton.styleFrom(
        side: BorderSide(
          color: isSelected ? secondaryBrown : greyPrimary.withOpacity(0.5),
          width: 1.5,
        ),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
        backgroundColor: isSelected
            ? lightBrown.withOpacity(0.1)
            : Colors.transparent,
      ),
      onPressed: () {
        setState(() {
          selectedSize = size;
        });
      },
      child: Text(
        size,
        style: TextStyle(
          color: isSelected ? secondaryBrown : primaryWhite,
          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
        ),
      ),
    );
  }
}
