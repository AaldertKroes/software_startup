import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class ApiController {
  final String baseUrl;
  final storage = const FlutterSecureStorage();
  ApiController({required this.baseUrl});

  Future GetData(extension) async{
    String? token = await storage.read(key: 'jwt');
    var response = await http.get(
      Uri.parse('$baseUrl/$extension'),
      headers: {
        'Content-Type': 'application/json',
        'Accept': '*/*',
        'Authorization': 'Bearer $token',
      },
    );
    if(response.statusCode == 200){
      return jsonDecode(response.body);
    }else{
      throw Exception('Failed to load data: $response');
    }
  }

  Future<bool> PostData(extension, data) async{
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
    if(response.statusCode == 200 || response.statusCode == 201){
      return true;
    }else{
      return false;
    }
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