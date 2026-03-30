import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Apiclient {
  final String baseUrl = 'http://10.0.2.2:3000';

  Future<Map<String, dynamic>?> login(String email, String password) async {
    final url = Uri.parse('$baseUrl/users/login');

    try {
      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({'email': email, 'password': password}),
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body);
      } else {
        debugPrint("Server error statuscode: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      debugPrint("Connection error: $e");
      return null;
    }
  }

  Future<Map<String, dynamic>?> register(
    String name,
    String email,
    String password,
    String birthDate,
  ) async {
    final url = Uri.parse('$baseUrl/users/register');

    try {
      final response = await http
          .post(
            url,
            headers: {'Content-Type': 'application/json'},
            body: jsonEncode({
              'name': name,
              'email': email,
              'password': password,
              'birthDate': birthDate,
            }),
          )
          .timeout(const Duration(seconds: 15));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        return jsonDecode(response.body);
      } else {
        debugPrint("Server error statuscode: ${response.statusCode}");
        return null;
      }
    } catch (e) {
      debugPrint("Connection error: $e");
      return null;
    }
  }
}
