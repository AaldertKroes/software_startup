import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:software_startup/controllers/apicontroller.dart';
import 'package:software_startup/models/DeliveryPackageModel.dart';
import 'package:software_startup/models/DeliveryPackageModel.dart';

class PackagesController {
  final ApiController apiController;
  final String baseUrl;
  final storage = const FlutterSecureStorage();

  PackagesController({required this.baseUrl, required this.apiController});

  Future<List<DeliveryPackageModel>> fetchPackages() async {
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
      List<dynamic> jsonResponse = jsonDecode(response.body);
      return jsonResponse
          .map((json) => DeliveryPackageModel.fromJson(json))
          .toList();
    } else {
      throw Exception("Kan pakketten niet ophalen: ${response.statusCode}");
    }
  }

  Future<List<DeliveryPackageModel>> deliveredPackages() async {
    List<DeliveryPackageModel> allPackages = await fetchPackages();
    return allPackages
        .where((package) => package.status == 'DELIVERED')
        .toList();
  }

  Future<List<DeliveryPackageModel>> notStartedPackages() async {
    List<DeliveryPackageModel> allPackages = await fetchPackages();
    return allPackages
        .where((package) => package.status == 'NOT_STARTED')
        .toList();
  }

  Future<List<DeliveryPackageModel>> underwayPackages() async {
    List<DeliveryPackageModel> allPackages = await fetchPackages();
    return allPackages
        .where((package) => package.status == 'UNDERWAY')
        .toList();
  }

  Future<bool> createReturnPackage(Map<String, dynamic> package) async {
    package['status'] = 'NOT_STARTED';
    package['originAddress'] = package['destinationAddress'];
    package['destinationAddress'] = package['originAddress'];
    package.remove('id');

    return await apiController.PostData('api/delivery-packages', package);
  }

  Future LocationAddress(int locationId) async {
    var startLocation =
        await apiController.GetData('/api/addresses/$locationId');
    if (startLocation is List && startLocation.isNotEmpty) {
      return startLocation[0];
    } else if (startLocation is Map) {
      return startLocation;
    } else {
      throw Exception('Invalid data format received from API');
    }
  }

  Future<bool> createReturnPackageV2(Map<String, dynamic> package) async {
    package['status'] = 'NOT_STARTED';
    var newStartLocation = package['endLocationId'];
    package['endLocationId'] = package['startLocationId'];
    package['startLocationId'] = newStartLocation;

    return await apiController.putData(
        'api/delivery-packages/${package['id']}', package);
  }

  Future<DeliveryPackageModel> getPackageById(int id) async {
    String? token = await storage.read(key: 'jwt');
    if (token == null) {
      throw Exception('JWT token niet gevonden. Log eerst in.');
    }
    var headers = {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    };
    var response = await http.get(
      Uri.parse('$baseUrl/api/delivery-packages/$id'),
      headers: headers,
    );
    if (response.statusCode == 200) {
      Map<String, dynamic> decodedJson = jsonDecode(response.body);
      return DeliveryPackageModel.fromJson(decodedJson);
    } else {
      throw Exception("Kan pakket niet ophalen: ${response.statusCode}");
    }
  }

  Future<bool> createReturnPackage(Map<String, dynamic> package) async {
    return await apiController.PostData('/api/delivery-packages', package);
  }
}
