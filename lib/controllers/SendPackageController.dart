import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class SendPackageController {
  final storage = const FlutterSecureStorage();
  final String baseUrl = 'http://10.0.2.2:8080/api';
  final Map<String, dynamic> _packageFormData = {
    "packageSize": "",
    "weight": 0,
    "distance": 0,
    "status": "NOT_STARTED",
    "startLocationId": 0,
    "endLocationId": 0,
    "senderId": 0,
    "receiverId": 0,
    "deliveryDriverId": null,
  };
  final Map<String, dynamic> _recipientAddressFormData = {
    "street": "",
    "city": "",
    "postalCode": "",
    "county": "The Netherlands",
  };
  final Map<String, dynamic> _senderAddressFormData = {
    "street": "",
    "city": "",
    "postalCode": "",
    "county": "The Netherlands",
  };

  void addPackageSizeAndWeight(String packageSize, int weight) {
    _packageFormData["packageSize"] = packageSize;
    _packageFormData["weight"] = weight;
  }

  void addPackageAddresses(
      String recipientStreet,
      String recipientCity,
      String recipientPostal,
      String senderStreet,
      String senderCity,
      String senderPostal,
      ) {
    _recipientAddressFormData["street"] = recipientStreet;
    _recipientAddressFormData["city"] = recipientCity;
    _recipientAddressFormData["postalCode"] = recipientPostal;
    _senderAddressFormData["street"] = senderStreet;
    _senderAddressFormData["city"] = senderCity;
    _senderAddressFormData["postalCode"] = senderPostal;
  }

  // When confirming delivery: communicate everything with the backend.
  Future<bool> submitNewDelivery(Map<String, dynamic> packageData) async {
    addPackageSizeAndWeight(
        packageData['packageSize'],
        packageData['packageWeight'],
    );
    addPackageAddresses(
        packageData["recipientStreet"],
        packageData["recipientCity"],
        packageData["recipientPostalCode"],
        packageData["senderStreet"],
        packageData["senderCity"],
        packageData["senderPostalCode"],
    );
    
    int? recipientAddressId = await postRequest(_recipientAddressFormData, 'addresses');
    int? senderAddressId = await postRequest(_senderAddressFormData, 'addresses');

    if (recipientAddressId == null || senderAddressId == null) {
      return false;
    }

    //Set id's of start & stop locations
    _packageFormData['startLocationId'] = senderAddressId;
    _packageFormData['endLocationId'] = recipientAddressId;

    int? packageId = await postRequest(_packageFormData, 'delivery-packages');

    if (packageId == null) {
      return false;
    } else {
      return true;
    }
  }

  Future<dynamic> postRequest(Map<String, dynamic> data, String endPoint) async {
    var payload = jsonEncode(
      data,
    );

    var token = await storage.read(key: 'jwt');

    var headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $token',
    };

    var response = await http.post(
      Uri.parse('$baseUrl/$endPoint'),
      body: payload,
      headers: headers,
    );

    if (response.statusCode == 201) {
      var jsonResponse = jsonDecode(response.body);
      return jsonResponse['id'];
    } else {
      return null;
    }
  }

  Future<int?> getRequest(String endPoint) async {
    var token = await storage.read(key: 'jwt');

    var headers = {
      'Content-Type': 'application/json',
      'Accept': '*/*',
      'Authorization': 'Bearer $token',
    };

    var response = await http.post(
      Uri.parse('$baseUrl/$endPoint'),
      headers: headers,
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);;
    } else {
      return null;
    }
  }

}