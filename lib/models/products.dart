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
    price: 5.50,
    imageUrl:
        'https://www.sharmispassions.com/wp-content/uploads/2012/07/espresso-coffee-recipe022.jpg',
  ),
  Coffee(
    name: 'Cappuccino',
    description: 'Espresso with steamed milk and foam.',
    price: 10.00,
    imageUrl:
        'https://images.ctfassets.net/0e6jqcgsrcye/6Dnzkf1ylG7IxDRG9Ez1Ia/0db4f0be1ff6199ae89afa4a0ae26687/How_to_make_a_perfect_cappuccino_at_home.jpg',
  ),
  Coffee(
    name: 'Latte Macchiato',
    description: 'Espresso with steamed milk.',
    price: 12.00,
    imageUrl:
        'https://podmkr.com/wp-content/uploads/2023/11/latte-macchiato.png',
  ),
  Coffee(
    name: 'Caramel Frappucino',
    description: 'Delicious caramel-flavored frappuccino.',
    price: 15.50,
    imageUrl:
        'https://images.immediate.co.uk/production/volatile/sites/30/2025/07/GoodFoodFrappe-8757348.jpg',
  ),
];
