import 'dart:convert';
import 'package:http/http.dart' as http;

enum ApiMethod { get, post, delete, put }

class Apiclient {
  final String baseUrl = 'https://69c33a76b780a9ba03e64c18.mockapi.io';

  Future<dynamic> sendApi({
    required String endpoint,
    required ApiMethod method,
    Map<String, dynamic>? body,
  }) async {
    final url = Uri.parse('$baseUrl/$endpoint');
    late http.Response response;

    switch (method) {
      case ApiMethod.get:
        response = await http.get(url);
        break;
      case ApiMethod.post:
        response = await http.post(
          url,
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'},
        );
        break;
      case ApiMethod.put:
        response = await http.put(
          url,
          body: jsonEncode(body),
          headers: {'Content-Type': 'application/json'},
        );
        break;
      case ApiMethod.delete:
        response = await http.delete(url);
        break;
    }

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Error: ${response.statusCode}");
    }
  }
}
