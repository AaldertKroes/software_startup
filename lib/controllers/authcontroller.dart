import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

import 'package:software_startup/models/DeliveryPackageModel.dart';

// Write value
class Authcontroller{
  final String baseUrl;
  final storage = const FlutterSecureStorage();

  Authcontroller({required this.baseUrl});

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
      Uri.parse('$baseUrl/authenticate'),
      body: loginPayload,
      headers: loginHeaders,
    );

    if(response.statusCode == 200){
      var jsonResponse = jsonDecode(response.body);
      await storage.write(key: 'jwt', value: jsonResponse['id_token']);
    //TODO: Retrofit gebruiken en speciale klasse voor JWT token aanmaken
      return true;
    }else{
      return false;
    }
  }

  Future<List<DeliveryPackageModel>> getPackages() async {
    String page = '0';
    String size = '50';

    var getPackagesHeaders = {
      'Content-Type' : 'application/json',
      'Accept' : '*/*',
      'Authorization' : 'Bearer ${storage.read(key: 'jwt')}'
    };

    var response = await http.get(
      Uri.parse('/delivery-packages?page=$page&size=$size'),
      headers: getPackagesHeaders
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      List<DeliveryPackageModel> packages = [];
      for (Map<String, dynamic> jsonPackage in jsonResponse) {
        packages.add(DeliveryPackageModel.fromJson(jsonPackage));
      }
      return packages;
    } else {
      return [];
    }
  }
}
