import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:coffee_shop/models/products.dart';

class FirebaseService {
  final FirebaseFirestore db = FirebaseFirestore.instance;

  Future<List<Coffee>> getCoffees() async {
    try {
      QuerySnapshot snapshot = await db.collection('coffees').get();

      return snapshot.docs.map((doc) {
        return Coffee.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      // ignore: avoid_print
      print("Error loading the coffees. $e");
      return [];
    }
  }

  Future<List<Coffee>> getSpecialOffer() async {
    try {
      QuerySnapshot snapshot = await db.collection('special_offers').get();

      return snapshot.docs.map((doc) {
        return Coffee.fromMap(doc.data() as Map<String, dynamic>);
      }).toList();
    } catch (e) {
      // ignore: avoid_print
      print("Error loading special offers. $e");
      return [];
    }
  }
}
