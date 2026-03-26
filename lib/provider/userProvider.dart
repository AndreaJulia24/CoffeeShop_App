// ignore: file_names
// ignore_for_file: file_names

import 'package:coffee_shop/network/apiclient.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:coffee_shop/models/users.dart';

class UserProvider extends ChangeNotifier {
  final Apiclient apiclient = Apiclient(client: http.Client());

  Users? currentUser;
  bool isLoading = false;
  List<Users> allUsers = [];

  Users? get currUser => currentUser;
  bool get isLoad => isLoading;
  List<Users> get everyUsers => allUsers;

  //get - ossz user lekerese

  Future<void> loadUsers() async {
    isLoading = true;
    notifyListeners();

    try {
      allUsers = await apiclient.getUsers();
      notifyListeners();
    } catch (e) {
      print('Error loading users: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> registerUser(String name, String email, String password) async {
    isLoading = true;
    notifyListeners();
    try {
      await apiclient.registerUser(name, email, password);
      notifyListeners();
    } catch (e) {
      print('Error registering user: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }

  Future<void> updateProfile(String id, String name, String email) async {
    isLoading = true;
    notifyListeners();
    try {
      await apiclient.updateProfile(id, name, email);
      notifyListeners();
    } catch (e) {
      print('Error updating profile: $e');
    } finally {
      isLoading = false;
      notifyListeners();
    }
  }
}
