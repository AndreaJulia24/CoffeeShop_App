import 'package:coffee_shop/provider/cart_provider.dart';
import 'package:coffee_shop/screens/favorites_screen.dart';
import 'package:coffee_shop/screens/order_screen.dart';
import 'package:coffee_shop/widgets/coffee_card.dart';
import 'package:flutter/material.dart';
import 'package:coffee_shop/constants/colors.dart';
import 'package:coffee_shop/models/products.dart';
import 'package:coffee_shop/models/users.dart';
import 'package:coffee_shop/screens/shoppingcart_screen.dart';
import 'package:coffee_shop/screens/profile_screen.dart';
import 'package:coffee_shop/network/firebase_service.dart';
import 'dart:math';

import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  final Users users;
  const HomeScreen({super.key, required this.users});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex = 0;
  // List<Coffee> cartItems = [];
  List<Coffee> favoritesItems = [];
  final Random random = Random();

  void loadDailySpecial() async {
    List<Coffee> offers = await firebaseService.getSpecialOffer();
    if (offers.isNotEmpty) {
      setState(() {
        specialOffer = offers[random.nextInt(offers.length)];
      });
    }
  }

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
  final FirebaseService firebaseService = FirebaseService();
  late Future<List<Coffee>> coffeesFuture;
  Coffee? specialOffer;

  @override
  void initState() {
    super.initState();
    //filteredProducts = allproducts;
    coffeesFuture = firebaseService
        .getCoffees(); //itt inditja el a lekerest a firebasebol
    loadDailySpecial();
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

  void addToCart(Coffee coffee) {
    context.read<CartProvider>().addToCart(coffee);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("${coffee.name} added to cart."),
        duration: const Duration(seconds: 1),
        backgroundColor: secondaryBrown,
      ),
    );
  }

  void invertFavorite(Coffee coffee) {
    setState(() {
      if (favoritesItems.contains(coffee)) {
        favoritesItems.remove(coffee);
      } else {
        favoritesItems.add(coffee);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final List<Widget> screens = [
      buildHomeContent(), //0. index -homescreen
      FavoritesScreen(favoriteItems: favoritesItems), //1.index
      const CartScreen(), //2. index
      ProfileScreen(users: widget.users), //3. index profilee
    ];

    return Scaffold(
      body: SafeArea(child: screens[selectedIndex]),
      backgroundColor: primaryBrown,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        backgroundColor: darkBrown,
        selectedItemColor: secondaryBrown,
        unselectedItemColor: greyPrimary,
        currentIndex: selectedIndex,
        onTap: (index) => setState(() => selectedIndex = index),
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
    );
  }

  Widget buildHomeContent() {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsetsGeometry.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 30),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Hello, ${widget.users.name}",
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
            if (specialOffer != null) buildSpecialOfferCard(specialOffer!),
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
              child: FutureBuilder(
                future: coffeesFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: secondaryBrown),
                    );
                  }
                  if (snapshot.hasError) {
                    return const Center(
                      child: Text(
                        "Error loading coffees",
                        style: TextStyle(color: primaryWhite),
                      ),
                    );
                  }
                  final coffees = snapshot.data ?? [];

                  if (allproducts.isEmpty && coffees.isNotEmpty) {
                    allproducts.addAll(coffees);
                    filteredProducts = allproducts;
                  }

                  if (coffees.isEmpty) {
                    return const Center(
                      child: Text(
                        "There is none available coffees.",
                        style: TextStyle(color: primaryWhite),
                      ),
                    );
                  }
                  return ListView.builder(
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    itemCount: filteredProducts.length,
                    itemBuilder: (context, index) {
                      return CoffeeCard(
                        coffee: filteredProducts[index],
                        onAddTap: () => addToCart(filteredProducts[index]),
                        onDetailsTap: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => OrderScreen(
                                coffee: filteredProducts[index],
                                addingIntoCart: () =>
                                    addToCart(filteredProducts[index]),
                                invertFavorite: () =>
                                    invertFavorite(filteredProducts[index]),
                                isFavorite: favoritesItems.contains(
                                  filteredProducts[index],
                                ),
                              ),
                            ),
                          );
                          setState(() {});
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget buildSpecialOfferCard(Coffee offer) {
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
            offer.imageUrl,
            width: 120,
            height: 110,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(width: 20),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              //speciall offer
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: primaryRed,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Text(
                  "Today's special offer",
                  style: TextStyle(
                    color: primaryWhite,
                    fontWeight: FontWeight.w800,
                    fontSize: 10,
                  ),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                offer.name,
                style: const TextStyle(
                  color: primaryWhite,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
                ),
              ),
              const Spacer(),
              Text(
                "${offer.price.toStringAsFixed(2)} lei",
                style: const TextStyle(
                  color: primaryWhite,
                  fontSize: 16,
                  fontWeight: FontWeight.w800,
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
