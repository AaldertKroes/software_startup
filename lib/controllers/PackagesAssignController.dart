import 'package:software_startup/models/AddressModel.dart';
import 'package:software_startup/models/DeliveryPackageModel.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class PackagesAssignController {
  final String baseUrl;
  final storage = const FlutterSecureStorage();

  PackagesAssignController({required this.baseUrl});

  Future<List<DeliveryPackageModel>> getPackages() async {
    String page = '0';
    String size = '50';

    String? authToken = await storage.read(key: 'jwt');
    if (authToken == null) {
      throw Exception("JWT token niet gevonden. Log eerst in.");
    }

    var getPackagesHeaders = {
      'Content-Type' : 'application/json',
      'Accept' : '*/*',
      'Authorization' : 'Bearer $authToken'
    };

    var response = await http.get(
      Uri.parse('$baseUrl/api/delivery-packages?page=$page&size=$size'),
      headers: getPackagesHeaders
    );

    if (response.statusCode == 200) {
      var jsonResponse = jsonDecode(response.body);
      List<DeliveryPackageModel> packages = [];
      for (Map<String, dynamic> jsonPackage in jsonResponse) {
        if (jsonPackage['status'] == "NOT_STARTED" && jsonPackage['deliveryDriverId'] == null) {
          DeliveryPackageModel curPackage = DeliveryPackageModel.fromJson(jsonPackage);
          curPackage.startLocation = await getLocationString(authToken, curPackage.startLocationId);
          curPackage.endLocation = await getLocationString(authToken, curPackage.endLocationId);
          packages.add(curPackage);
        }
      }
      return packages;
    } else {
      throw Exception("Kan pakketten niet ophalen: ${response.statusCode}");
    }
  }

  Future<String> getLocationString(String authToken, int id) async {
    var _headers = {
      'Content-Type' : 'application/json',
      'Accept' : '*/*',
      'Authorization' : 'Bearer $authToken'
    };

    var response = await http.get(
      Uri.parse('$baseUrl/api/addresses/$id'),
      headers: _headers,
    );

    if (response.statusCode == 200) {
      AddressModel curAddress = AddressModel.fromJson(jsonDecode(response.body));
      return "${curAddress.street} ${curAddress.postalCode}, ${curAddress.city}, ${curAddress.country}";
    } else {
      throw Exception("Can adres niet ophalen: ${response.statusCode}");
    }
  }

  Future<int> assignAsDriver(DeliveryPackageModel package) async {
    package.deliveryDriverId = 1; // admin user
    String? authToken = await storage.read(key: 'jwt');

    var _headers = {
      'Content-Type' : 'application/json',
      'Accept' : '*/*',
      'Authorization' : 'Bearer $authToken'
    };
    
    var response = await http.patch(
      Uri.parse('$baseUrl/api/delivery-packages/${package.id}'),
      headers: _headers,
      body: jsonEncode(package.toJson()),
    );

    if (response.statusCode == 200) {
      return 1;
    }
    return 0;
  }
}