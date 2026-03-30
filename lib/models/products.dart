List<Coffee> favoritesCoffees = [];

class Coffee {
  final String name;
  final String description;
  final double price;
  final String imageUrl;
  final double rating;
  final String category;
  String selectedSize;
  double currentSizePrice;

  Coffee({
    required this.name,
    required this.description,
    required this.price,
    required this.imageUrl,
    required this.rating,
    required this.category,
    this.selectedSize = 'M',
    double? currentSizePrice,
  }) : currentSizePrice = currentSizePrice ?? price;

  factory Coffee.fromMap(Map<String, dynamic> map) {
    return Coffee(
      name: map['name'] ?? '',
      description: map['description'] ?? '',
      price: (map['price'] ?? 0).toDouble(),
      imageUrl: map['imageUrl'] ?? '',
      rating: (map['rating'] ?? 0).toDouble(),
      category: map['category'] ?? '',
      selectedSize: map['selectedSize'] ?? 'M',
      currentSizePrice: (map['currentSizePrice'] != null)
          ? (map['currentSizePrice'] as num).toDouble()
          : (map['price'] != null)
          ? (map['price'] as num).toDouble()
          : 0.0,
    );
  }
}

List<Coffee> allproducts = [];
