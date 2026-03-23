import 'package:flutter/material.dart';
import 'package:coffee_shop/constants/colors.dart';
import 'package:coffee_shop/models/products.dart';
import 'package:coffee_shop/widgets/coffee_card.dart';
import 'package:coffee_shop/screens/order_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool _isCoffeesSelected = true;
  bool _isTeasSelected = false;
  bool _isDrinksSelected = false;
  bool _isCakesSelected = false;

  void _selectCategory(String category) {
    setState(() {
      _isCoffeesSelected = category == 'Coffees';
      _isTeasSelected = category == 'Teas';
      _isDrinksSelected = category == 'Drinks';
      _isCakesSelected = category == 'Cakes';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: primaryBrown,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Icon(Icons.menu, color: primaryWhite),
                  const Text(
                    "Hello, Andrea Czellecz",
                    style: TextStyle(
                      fontFamily: 'Poppins',
                      fontSize: 20,
                      color: primaryWhite,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const Icon(Icons.search, color: primaryWhite),
                ],
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  buildCategoryItem(
                    'Coffees',
                    _isCoffeesSelected,
                    () => _selectCategory('Coffees'),
                  ),
                  buildCategoryItem(
                    'Teas',
                    _isTeasSelected,
                    () => _selectCategory('Teas'),
                  ),
                  buildCategoryItem(
                    'Drinks',
                    _isDrinksSelected,
                    () => _selectCategory('Drinks'),
                  ),
                  buildCategoryItem(
                    'Cakes',
                    _isCakesSelected,
                    () => _selectCategory('Cakes'),
                  ),
                ],
              ),
              const SizedBox(height: 40), //products card list ----
              SizedBox(
                height: 300,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  itemCount: allproducts.length,
                  itemBuilder: (context, index) {
                    return CoffeeCard(coffee: allproducts[index]);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: secondaryBrown,
        shape: const CircleBorder(),
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const OrderScreen()),
        ),
      ),
    );
  }
}

Widget buildCategoryItem(String name, bool isSelected, VoidCallback onTap) {
  return GestureDetector(
    onTap: onTap,
    child: Column(
      children: [
        Text(
          name,
          style: TextStyle(
            fontFamily: 'Poppins',
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: isSelected ? secondaryBrown : primaryWhite,
          ),
        ),
        if (isSelected)
          Container(
            margin: const EdgeInsets.only(top: 5),
            height: 2,
            width: 55,
            color: secondaryBrown,
          ),
      ],
    ),
  );
}
