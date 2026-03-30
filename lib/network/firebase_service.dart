import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/models/products.dart';

class FirebaseService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<Coffee>> getProductsByCategory(String category) async {
    try {
      QuerySnapshot snapshot = await db
          .collection(category.toLowerCase())
          .get();
      return snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        data['category'] = category.toLowerCase();
        return Coffee.fromMap(data);
      }).toList();
    } catch (e) {
      print("Error loading $category: $e");
      return [];
    }
  }

  Future<List<Coffee>> getAllProductsForSearch() async {
    List<String> categories = ['coffees', 'teas', 'drinks', 'cakes'];
    List<Coffee> allItems = [];
    for (String cat in categories) {
      List<Coffee> products = await getProductsByCategory(cat);
      allItems.addAll(products);
    }
    return allItems;
  }

  Future<List<Coffee>> getSpecialOffer() async {
    try {
      QuerySnapshot snapshot = await db.collection('special_offers').get();
      return snapshot.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        data['category'] = 'coffees';
        return Coffee.fromMap(data);
      }).toList();
    } catch (e) {
      return [];
    }
  }
}
