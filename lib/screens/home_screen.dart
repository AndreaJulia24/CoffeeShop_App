import 'package:flutter/material.dart';
import 'package:coffee_shop/constants/colors.dart';
import 'package:coffee_shop/models/products.dart';
import 'package:coffee_shop/widgets/coffee_card.dart';
//import 'package:coffee_shop/screens/order_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;

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

  List<Coffee> filteredProducts = [];

  @override
  void initState() {
    super.initState();
    filteredProducts = allproducts;
  }

  void runFilter(String enteredKeyword) {
    List<Coffee> results = [];
    if (enteredKeyword.isEmpty) {
      results = allproducts;
    } else {
      results = allproducts
          .where(
            (coffee) => coffee.name.toLowerCase().contains(
              enteredKeyword.toLowerCase(),
            ),
          )
          .toList();
    }
    setState(() {
      filteredProducts = results;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryBrown,
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: darkBrown,
        selectedItemColor: secondaryBrown,
        unselectedItemColor: greyPrimary,
        currentIndex: _selectedIndex,
        onTap: (index) => setState(() => _selectedIndex = index),
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: ''),
          BottomNavigationBarItem(icon: Icon(Icons.favorite_border), label: ''),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag_outlined),
            label: '',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: ''),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsetsGeometry.symmetric(horizontal: 20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Hello, Andrea Czellecz",
                      style: TextStyle(
                        fontFamily: 'Poppins',
                        fontSize: 20,
                        color: primaryWhite,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsetsGeometry.symmetric(horizontal: 20.0),
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      color: blueGrey,
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: TextField(
                      onChanged: (value) => runFilter(value),
                      style: TextStyle(color: primaryWhite),
                      decoration: InputDecoration(
                        hintText: "Search coffee...",
                        hintStyle: TextStyle(color: greyPrimary),
                        prefixIcon: Icon(Icons.search, color: greyPrimary),
                        suffixIcon: Icon(Icons.tune, color: greyPrimary),
                        border: InputBorder.none,
                        contentPadding: EdgeInsets.symmetric(vertical: 20),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                buildSpecialOfferCard(),
                const SizedBox(height: 25),
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
                const SizedBox(height: 30), //products card list ----
                SizedBox(
                  height: 300,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      return CoffeeCard(coffee: filteredProducts[index]);
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget buildSpecialOfferCard() {
  return Container(
    margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
    padding: const EdgeInsets.all(15),
    height: 140,
    decoration: BoxDecoration(
      color: darkBrown,
      borderRadius: BorderRadius.circular(20),
    ),
    child: Row(
      children: [
        ClipRRect(
          borderRadius: BorderRadiusGeometry.circular(15),
          child: Image.network(
            'https://cdn.loveandlemons.com/wp-content/uploads/2023/06/iced-matcha-latte.jpg',
            width: 120,
            height: 110,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              //speciall offer
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 5,
                ),
                decoration: BoxDecoration(
                  color: primaryRed,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Text(
                  "Today's special offer",
                  style: TextStyle(
                    color: primaryWhite,
                    fontWeight: FontWeight.w800,
                    fontSize: 12,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
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
