import 'package:flutter/material.dart';
import 'package:coffee_shop/constants/colors.dart';
import 'package:coffee_shop/models/products.dart';
import 'package:coffee_shop/provider/coffee_provider.dart';
import 'package:provider/provider.dart';

class OrderScreen extends StatefulWidget {
  final Coffee coffee;

  const OrderScreen({super.key, required this.coffee});

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  int quantity = 1;
  String selectedSize = 'M';
  late double currentSizePrice;

  final List<String> sizes = ['S', 'M', 'L'];

  @override
  void initState() {
    super.initState();
    currentSizePrice = widget.coffee.currentSizePrice;
  }

  void updateSizePrice(String size) {
    setState(() {
      selectedSize = size;

      // MAI JAVÍTÁS: Teánál és üdítőnél az ár fix marad, kávénál és sütinél változik
      if (widget.coffee.category.toLowerCase() == 'teas' ||
          widget.coffee.category.toLowerCase() == 'drinks') {
        currentSizePrice = widget.coffee.price;
      } else {
        switch (size) {
          case 'S':
            currentSizePrice = widget.coffee.price * 0.9;
            break;
          case 'M':
            currentSizePrice = widget.coffee.price;
            break;
          case 'L':
            // Süti esetén a Whole (L) nagyobb felár
            currentSizePrice = widget.coffee.category.toLowerCase() == 'cakes'
                ? widget.coffee.price * 1.5
                : widget.coffee.price * 1.2;
            break;
        }
      }
    });
  }

  double get totalPrice => currentSizePrice * quantity;

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<CoffeeProvider>();
    final isFavorite = provider.isFavorite(widget.coffee);
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
            icon: Icon(isFavorite ? Icons.favorite : Icons.favorite_border),
            color: isFavorite ? primaryRed : primaryWhite,
            onPressed: () {
              provider.toggleFavorite(widget.coffee);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(
                    isFavorite
                        ? "${widget.coffee.name} removed from favorites!"
                        : "${widget.coffee.name} added to favorites!",
                  ),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  widget.coffee.imageUrl,
                  height: 220,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  cacheWidth: 400,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25.0),
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
                  const Text(
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
                    style: const TextStyle(fontSize: 15, color: greyPrimary),
                  ),
                  const SizedBox(height: 25),
                  const Text(
                    "Options",
                    style: TextStyle(
                      fontSize: 30,
                      fontWeight: FontWeight.bold,
                      color: primaryWhite,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    // Dinamikus felirat a kategória alapján
                    widget.coffee.category.toLowerCase() == 'cakes'
                        ? "Choose your cake portion:"
                        : widget.coffee.category.toLowerCase() == 'teas'
                        ? "Choose your tea temperature:"
                        : widget.coffee.category.toLowerCase() == 'drinks'
                        ? "Choose your ice level:"
                        : "Choose your coffee size:",
                    style: const TextStyle(fontSize: 15, color: greyPrimary),
                  ),
                  const SizedBox(height: 15),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Logikai ágaztatás a gombokhoz
                      if (widget.coffee.category.toLowerCase() == 'cakes') ...[
                        buildCakeButton('S', '1 Slice'),
                        buildCakeButton('M', '2 Slices'),
                        buildCakeButton('L', 'Whole'),
                      ] else if (widget.coffee.category.toLowerCase() ==
                          'teas') ...[
                        buildTeaButton('Hot', 'Hot'),
                        buildTeaButton('Room', 'Room'),
                        buildTeaButton('Iced', 'Iced'),
                      ] else if (widget.coffee.category.toLowerCase() ==
                          'drinks') ...[
                        buildDrinksButton('S', 'No Ice'),
                        buildDrinksButton('M', 'Regular'),
                        buildDrinksButton('L', 'Extra Ice'),
                      ] else ...[
                        buildSizeButton('S'),
                        buildSizeButton('M'),
                        buildSizeButton('L'),
                      ],
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
                  "${currentSizePrice.toStringAsFixed(2)} lei",
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
                  borderRadius: BorderRadius.circular(20),
                ),
              ),
              onPressed: () {
                final coffeeToCart = Coffee(
                  name: widget.coffee.name,
                  description: widget.coffee.description,
                  price: widget.coffee.price,
                  imageUrl: widget.coffee.imageUrl,
                  rating: widget.coffee.rating,
                  category: widget.coffee.category,
                  selectedSize: selectedSize,
                  currentSizePrice: currentSizePrice,
                );
                provider.addToCart(coffeeToCart);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text("${widget.coffee.name} added to cart!"),
                    backgroundColor: secondaryBrown,
                    duration: const Duration(seconds: 1),
                  ),
                );
              },
              child: const Text(
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
    return buildGenericButton(size, size, isSelected);
  }

  Widget buildCakeButton(String value, String text) {
    bool isSelected = selectedSize == value;
    return buildGenericButton(value, text, isSelected);
  }

  Widget buildTeaButton(String value, String text) {
    bool isSelected = selectedSize == value;
    return buildGenericButton(value, text, isSelected);
  }

  Widget buildDrinksButton(String value, String text) {
    bool isSelected = selectedSize == value;
    return buildGenericButton(value, text, isSelected);
  }

  Widget buildGenericButton(String value, String text, bool isSelected) {
    return GestureDetector(
      onTap: () => updateSizePrice(value),
      child: Container(
        width: 100,
        padding: const EdgeInsets.symmetric(vertical: 15),
        decoration: BoxDecoration(
          color: isSelected
              ? lightBrown.withValues(alpha: 0.2)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? secondaryBrown
                : greyPrimary.withValues(alpha: 0.5),
            width: 1.5,
          ),
        ),
        child: Center(
          child: Text(
            text,
            style: TextStyle(
              color: isSelected ? secondaryBrown : primaryWhite,
              fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
            ),
          ),
        ),
      ),
    );
  }
}
