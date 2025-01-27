import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class AuthController{
  final String baseUrl;
  final storage = const FlutterSecureStorage();

  AuthController({required this.baseUrl});

  Future<bool> login(String username, String password) async{
    var loginPayload = jsonEncode({
      'username': username,
      'password': password,
      'rememberMe': true,
    });

    var loginHeaders = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
    };

    var response = await http.post(
      Uri.parse('$baseUrl/api/authenticate'),
      body: loginPayload,
      headers: loginHeaders,
    );

    if(response.statusCode == 200){
      var jsonResponse = jsonDecode(response.body);
      await storage.write(key: 'jwt', value: jsonResponse['id_token']);
      return true;
    }else{
      return false;
    }
  }

  Future<bool> register(
    String login,
    String firstName,
    String lastName,
    String email,
    String password,
  ) async {
    final registerPayload = jsonEncode({
      'id': 0,
      'login': login,
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'password': password,
      'imageUrl': '',
      'activated': true,
      'langKey': 'en', 
      'createdBy': 'system',
      'createdDate': '2025-01-27T13:39:02.059Z',
      'lastModifiedBy': 'system',
      'lastModifiedDate': '2025-01-27T13:39:02.059Z',
      'authorities': ['ROLE_USER'] 
    });

    var registerHeaders = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
    };

    var response = await http.post(
      Uri.parse('$baseUrl/api/register'),
      body: registerPayload,
      headers: registerHeaders,
    );

    if (response.statusCode == 200) {
      return true;
    } else {
      print('Error during registration: ${response.body}');
      return false;
    }
  }
}