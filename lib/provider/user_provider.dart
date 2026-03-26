import 'package:coffee_shop/network/apiclient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:coffee_shop/models/users.dart';

class UserProvider extends ChangeNotifier {
  final Apiclient apiclient = Apiclient();

  Users? currentUser;
  bool isLoading = false;

  //---login,bejelentkezo logika

  Future<bool> login(String email, String password) async {
    isLoading = true;
    notifyListeners();

    try {
      final response = await apiclient.sendApi(
        endpoint: 'users',
        method: ApiMethod.get,
      );

      List<dynamic> data = response;
      List<Users> allUsers = data.map((json) => Users.fromJson(json)).toList();

      final user = allUsers.firstWhere(
        (u) => u.email == email && u.password == password,
        orElse: () => throw Exception("Not valid login informations"),
      );
      currentUser = user;
      isLoading = false;
      notifyListeners();

      return true; // ha sikerult true
    } catch (e) {
      isLoading = false;
      notifyListeners();
      print("Error: $e");

      return false;
    }
  }
}
