import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

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

  Future<List<dynamic>> deliveredPackages() async {
    List allPackages = await fetchPackages();
    List delivered = [];

    for (var i in allPackages) {
      if (i['status'] == 'DELIVERED') {
        delivered.add(i);
      }
    }

    return delivered;
  }

  Future<List<dynamic>> notStartedPackages() async {
    List allPackages = await fetchPackages();
    List notStarted = [];

    for (var i in allPackages) {
      if (i['status'] == 'NOT_STARTED') {
        notStarted.add(i);
      }
    }

    return notStarted;
  }

  Future<List<dynamic>> underwayPackages() async {
    List allPackages = await fetchPackages();
    List underway = [];

    for (var i in allPackages) {
      if (i['status'] == 'UNDERWAY') {
        underway.add(i);
      }
    }

    return underway;
  }
}
