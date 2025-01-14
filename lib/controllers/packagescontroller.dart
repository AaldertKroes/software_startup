import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;

class PackagesController {
  final String baseUrl;
  final storage = const FlutterSecureStorage();

  PackagesController({required this.baseUrl});

  Future<List<dynamic>> fetchPackages() async {
    String? token = await storage.read(key: 'jwt');
    if (token == null) {
      throw Exception("JWT token niet gevonden. Log eerst in.");
    }

    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };

    
    var response = await http.get(
      Uri.parse('$baseUrl/api/delivery-packages'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      
      return jsonDecode(response.body);
    } else {
      throw Exception("Kan pakketten niet ophalen: ${response.statusCode}");
    }
  }
}
