import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:coffee_shop/models/users.dart';
import 'dart:io';

enum ApiType { get, post, delete, put }

class Apiclient {
  final http.Client client;

  Apiclient({required this.client});

  final String url = 'https://69c33a76b780a9ba03e64c18.mockapi.io';

  final String userPath = '/users';

  Future<dynamic> sendApi({
    required String path,
    required ApiType apiType,
    Map<String, dynamic>? body,
  }) async {
    http.Response response;

    switch (apiType) {
      case ApiType.get:
        response = await client.get(Uri.parse(url + userPath));
      case ApiType.post:
        response = await client.post(Uri.parse(url + userPath));
      case ApiType.put:
        response = await client.put(Uri.parse(url + userPath));
      case ApiType.delete:
        response = await client.delete(Uri.parse(url + userPath));
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Error: ${response.body}");
    }
  }

  Future<List<Users>> getUsers() async {
    final response = await sendApi(
      path: userPath,
      apiType: ApiType.get,
    );
    return (response as List).map((user) => Users.fromJson(user)).toList();
  }

  Future<void> registerUser(String name, String email, String password) async {
    await sendApi(
      path: userPath,
      apiType: ApiType.post,
      body: {
        'name': name,
        'email': email,
        'password': password,
      },
    );
  }

  Future<void> updateProfile(String id, String name, String email) async {
    await sendApi(
      path: userPath,
      apiType: ApiType.put,     
      body: {
        'id': id,
        'name': name,
      },
    );
  }
}
