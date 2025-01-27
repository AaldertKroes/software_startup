import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class ApiController {
  final String baseUrl;
  final storage = const FlutterSecureStorage();
  ApiController({required this.baseUrl});

  // Method to retrieve data in a list
  Future<List<dynamic>> getData(String extension) async {
    String? token = await storage.read(key: 'jwt');
    var response = await http.get(
      Uri.parse('$baseUrl/$extension'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data: $response');
    }
  }

  // Method to retrieve data as a single map
  Future<dynamic> getRecord(String extension) async {
    String? token = await storage.read(key: 'jwt');
    var response = await http.get(
      Uri.parse('$baseUrl/$extension'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to load data: $response');
    }
  }

  // Method to post data with a body
  Future<bool> postData(String extension, Object data) async {
    String? token = await storage.read(key: 'jwt');
    var response = await http.post(
      Uri.parse('$baseUrl/$extension'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(data),
    );
    return response.statusCode == 200 || response.statusCode == 201;
  }

  Future<bool> putData(extension, data) async{
    String? token = await storage.read(key: 'jwt');
    var response = await http.put(
      Uri.parse('$baseUrl/$extension'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer $token',
      },
      body: json.encode(data),
    );
    return response.statusCode == 200 || response.statusCode == 204;
  }
}