List<Coffee> favoritesCoffees = [];

class Coffee {
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final double rating;

  Coffee({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.rating,
  });

  factory Coffee.fromMap(Map<String, dynamic> map) {
    return Coffee(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      imageUrl: map['imageUrl'] ?? '',
      rating: (map['rating'] ?? 0).toDouble(),
    );
  }
}

List<Coffee> allproducts = [];
