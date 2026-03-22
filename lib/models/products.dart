class Coffee {
  final String name;
  final String description;
  final double price;
  final String imageUrl;

  Coffee({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
  });
}

List<Coffee> allproducts = [
  Coffee(
    name: 'Espresso Brown Coffee ',
    description: 'Strong and bold coffee shot.',
    price: 2.99,
    imageUrl: 'assets/images/espresso.jpg',
  ),
  Coffee(
    name: 'Cappuccino',
    description: 'Espresso with steamed milk and foam.',
    price: 3.99,
    imageUrl: 'assets/images/cappuccino.jpg',
  ),
  Coffee(
    name: 'Latte',
    description: 'Espresso with steamed milk.',
    price: 3.49,
    imageUrl: 'assets/images/latte.jpg',
  ),
  Coffee(
    name: 'Caramel Frappucino',
    description: 'Delicious caramel-flavored frappuccino.',
    price: 4.99,
    imageUrl: 'assets/images/caramel_frappucino.jpg',
  ),
];
