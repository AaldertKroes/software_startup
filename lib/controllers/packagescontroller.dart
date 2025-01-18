import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:software_startup/models/DeliveryPackageModel.dart';
import 'package:http/http.dart' as http;

class Packagescontroller {
  final String baseUrl;
  final storage = const FlutterSecureStorage();

  Packagescontroller({required this.baseUrl});

  Future<List<DeliveryPackageModel>> getPackages() async {
    String page = '0';
    String size = '50';
    String? authToken = await storage.read(key: 'jwt');

    var getPackagesHeaders = {
      'Content-Type' : 'application/json',
      'Accept' : '*/*',
      'Authorization' : 'Bearer $authToken'
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
