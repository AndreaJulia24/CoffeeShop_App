import 'package:coffee_shop/network/apiclient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier {
  final Apiclient apiclient = Apiclient();

  Map<String, dynamic>? user; //user adatainak tarolasa

  Map<String, dynamic>? get _user => user;
  bool get isLoggedIn => _user != null;

  //login - bejelentkezes
  Future<bool> login(String email, String password) async {
    print("1. Login is starting...");

    try {
      final userData = await apiclient.login(email, password);

      print("2. Server is communicated: $userData");

      if (userData != null) {
        user = userData;
        notifyListeners();
        return true;
      }
    } catch (e) {
      print("3. Error in the provider: $e");
    }
    print("4. Login is unsuccessful.");

    return false;
  }

  void logout() {
    user = null;
    notifyListeners();
  }
}
